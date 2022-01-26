gbm_tab<-argonTabItem(
  tabName =
    "gbmalert",
  uiOutput("info_box_gbmalert"),
  argonRow(
    argonCard(
      width = 6,
      src = NULL,
      title = "Fraud Transactions",
      shadow = TRUE,
      border_level = 2,
      hover_shadow = TRUE,
      DTOutput("gbm_datatable",
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
      plotOutput("gbm_limeplot",
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
      highchartOutput("gbm_plot",
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
      highchartOutput("gbm_barplot",
                      height = 500
      ) %>% withSpinner()
    )
  )
)
