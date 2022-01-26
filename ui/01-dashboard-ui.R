dashboard_tab<-argonTabItem(
        tabName = "dashboard",
        uiOutput("info_box_dash"),
        argonRow(
          argonCard(
            width = 6,
            src = NULL,
            shadow = TRUE,
            border_level = 2,
            hover_shadow = TRUE,
            highchartOutput("plot1",
                            height = 500) %>% withSpinner()
          ),
          argonCard(
            width = 6,
            src = NULL,
            shadow = TRUE,
            border_level = 2,
            hover_shadow = TRUE,
            highchartOutput("plot2",
                            height = 500) %>% withSpinner()
          )
        )
        )
