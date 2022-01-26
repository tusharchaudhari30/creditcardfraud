source("ui/01-dashboard-ui.R")
source("ui/02-rfalert-ui.R")
source("ui/02-gbmalert-ui.R")
source("ui/02-xgalert-ui.R")
argonDashPage(
  title = "SBI Bank",
  header = argonDashHeader(
    gradient = TRUE,
    color = "primary",
    separator = TRUE,
    separator_color = "secondary",
  ),
  sidebar = argonDashSidebar(
    vertical = TRUE,
    skin = "light",
    background = "white",
    size = "md",
    side = "left",
    id = "my_sidebar",
    brand_url = "http://www.google.com",
    brand_logo = "http://www.logo-designer.co/wp-content/uploads/2017/04/2017-Design-Stack-new-logo-design-State-Bank-of-India.png",
    argonSidebarHeader(title = "Main Menu"),
    argonSidebarMenu(
      argonSidebarItem(
        tabName = "dashboard",
        icon = icon("dashboard"),
        "Dashboard"
      ),
      argonSidebarItem(
        tabName = "rfalert",
        icon = argonIcon(name = "bell-55", color = "grey"),
        "Random Forest"
      )
      ,
      argonSidebarItem(
        tabName = "gbmalert",
        icon = argonIcon(name = "bell-55", color = "grey"),
        "GBM"
      )
      ,
      argonSidebarItem(
        tabName = "xgbalert",
        icon = argonIcon(name = "bell-55", color = "grey"),
        "XGBoost"
      )
    )
  ),
  body = argonDashBody(
    argonTabItems(
      dashboard_tab,
      randomforest_tab,
      gbm_tab
      ,xgb_tab
    )
  ),
)
