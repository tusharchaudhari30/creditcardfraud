output$info_box_rfalert <- renderUI({
  fraud <- predict_fraudrf() %>%
    group_by(predict) %>%
    tally(name = "count") %>%
    filter(predict == 1)
  real <- predict_fraudrf() %>%
    group_by(predict) %>%
    tally(name = "count") %>%
    filter(predict == 0)
  argonRow(
    argonInfoCard(
      value = paste0(count(sampled_data())), 
      title = "TRANSACTION", 
      icon = argonIcon("planet"), 
      icon_background = "primary",
      hover_lift = TRUE,
      shadow = TRUE
    ),
    argonInfoCard(
      value = paste0(sum(sampled_data()$Amount)), 
      title = "AMOUNT",
      hover_lift = TRUE,
      icon = argonIcon("money-coins"), 
      icon_background = "info",
      shadow = TRUE
    ),
    argonInfoCard(
      value = paste0(fraud$count), 
      title = "RF Alerts", 
      hover_lift = TRUE,
      icon = argonIcon("bell-55"), 
      icon_background = "danger",
      shadow = TRUE
    ),
    argonInfoCard(
      value = paste0(real$count), 
      hover_lift = TRUE,
      title = "Genuine",
      icon = argonIcon("check-bold"), 
      icon_background = "success",
      shadow = TRUE
    )
  )
})
output$rf_datatable <- renderDataTable({
  data <-
    predict_fraudrf() %>%
    group_by(predict) %>%
    filter(predict == 1)
  data <- mutate(data, risk = case_when(
    data$p1 <= .50 ~ "Low",
    data$p1 <= .90 ~ "Medium",
    data$p1 > .90 ~ "High"
  ))
  fwrite(data, "./fraud/random_forest.csv", row.names = FALSE)
  DT::datatable(data,
    selection = "single",
    options = list(searching = FALSE, scrollX = TRUE)
  ) %>% formatStyle(
    "risk",
    target = "row",
    backgroundColor = styleEqual(c("Low", "Medium", "High"), c("#91ea73", "#fba132", "#f35f5f"))
  )
})

output$rf_limeplot <- renderPlot({
  validate(
    need(input$rf_datatable_rows_selected, "Click on a Row from the Table")
  )

  index <- input$rf_datatable_rows_selected
  data <-
    predict_fraudrf() %>%
    group_by(predict) %>%
    filter(predict == 1)
  plot_features(explain(
    data[index, 1:32],
    explainer_rf,
    n_features = 10, labels = 1, n_permutations = 5000,
    dist_fun = "gower",
    kernel_width = .25, feature_select = "lasso_path"
  )) + ggtitle("Model Explanation")
})

output$rf_plot <- renderHighchart({
  data <-
    predict_fraudrf() %>%
    group_by(predict) %>%
    filter(predict == 1)
  data <- mutate(data, Risk = case_when(
    data$p1 <= .50 ~ "Low",
    data$p1 <= .90 ~ "Medium",
    data$p1 > .90 ~ "High"
  ))

  hchart(data$Risk, colorByPoint = TRUE, name = "Risk") %>%  hc_legend(enabled = F)
})

output$rf_barplot <- renderHighchart({
  data <-
    predict_fraudrf() %>%
    group_by(predict) %>%
    filter(predict == 1)
  hchart(
    data %>% group_by(Time_hr) %>% tally(),
    "column",
    color = "#B71C1C",
    hcaes(x = Time_hr, y = n),
    name = "No of Fraud Transactions"
  ) %>%
    hc_yAxis(title = list(text = "No of Transaction")) %>%
    hc_xAxis(title = list(text = "Time in Hours")) %>%
    hc_title(text = "Fraud Transaction Every Hour")
})
