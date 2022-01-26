randomforest_tab<-argonTabItem(
  tabName =
    "rfalert",
  uiOutput("info_box_rfalert"),
  argonRow(
    argonCard(
      width = 6,
      src = NULL,
      title = "Fraud Transactions",
      shadow = TRUE,
      border_level = 2,
      hover_shadow = TRUE,
      DTOutput("rf_datatable",
               height = 500
      ) %>% withSpinner()
    ),
    argonCard(
      width = 6,
      title = "LIME Model Interpretation",
      src = NULL,
      shadow = TRUE,
      border_level = 2,
      hover_shadow = TRUE,
      plotOutput("rf_limeplot",
                 height = 500
      ) %>% withSpinner()
    )
  ),
  argonRow(
    argonCard(
      width = 6,
      src = NULL,
      title = "Risk Transaction",
      shadow = TRUE,
      border_level = 2,
      hover_shadow = TRUE,
      highchartOutput("rf_plot",
                      height = 500
      ) %>% withSpinner()
    ),
    argonCard(
      title = "Timeline Transaction",
      width = 6,
      src = NULL,
      shadow = TRUE,
      border_level = 2,
      hover_shadow = TRUE,
      highchartOutput("rf_barplot",
                      height = 500
      ) %>% withSpinner()
    )
  )
)
