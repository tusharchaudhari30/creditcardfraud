output$info_box_dash <- renderUI({
  argonRow(
    argonInfoCard(
      value = paste0(count({sampled_data()})), 
      title = "TRANSACTION", 
      icon = argonIcon("planet"), 
      icon_background = "danger",
      hover_lift = TRUE,
      shadow = TRUE
    ),
    argonInfoCard(
      #id="amount_box",
      value = paste0(sum(sampled_data()$Amount)), 
      title = "AMOUNT",
      icon = argonIcon("money-coins"), 
      hover_lift = TRUE,
      icon_background = "warning",
      shadow = TRUE
    )
  )
})
output$alert_box <- renderInfoBox({
  real_data <-
    predict_fraudxg() %>%
    group_by(predict) %>%
    tally(name = "count") %>%
    filter(predict == 1)
  infoBox(
    "Alerts",
    paste0(real_data$count),
    icon = icon("bell", lib = "glyphicon"),
    color = "red",
    fill = TRUE
  )
})


output$plot1 <- renderHighchart({
  hchart(
    sampled_data() %>% group_by(Time_hr) %>% tally(),
    "column",
    hcaes(x = Time_hr, y = n),
    name = "No of Transaction"
  ) %>%
    hc_yAxis(title = list(text = "No of Transaction")) %>%
    hc_xAxis(title = list(text = "Time in Hours")) %>%
    hc_title(text = "No of Transaction Every Hour")
})


output$plot2 <- renderHighchart({
  hchart(
    sampled_data() %>% group_by(Time_hr) %>% summarise(Total = sum(Amount)),
    "column",
    hcaes(x = Time_hr, y = Total),
    color = "#85bb65",
    name = "Amount $"
  ) %>%
    hc_yAxis(title = list(text = "Amount of Transaction")) %>%
    hc_xAxis(title = list(text = "Time in Hours")) %>%
    hc_title(text = "Amount of  Transaction Every Hour")
})
