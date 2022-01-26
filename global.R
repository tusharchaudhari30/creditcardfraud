library(shinydashboard)
library(shinythemes)
library(shinydashboardPlus)
library(shinycssloaders)
library(ggplot2)
library(readr)
library(dplyr)
library(shiny)
library(gridExtra)
library(h2o)
library(highcharter)
library(data.table)
library(DT)
library(lime)
library(dashboardthemes)
library(shinydashboardPlus)
library(argonDash)
library(argonR)

h2o.init()
model <- h2o.loadModel("model/GBM_model_R_1558482610633_2")
modelrf <- h2o.loadModel("model/improve/DRF_model_R_1561701961587_4087")
modelxg <- h2o.loadModel("model/improve/GBM_model_R_1561701961587_2817")
modelgb <- h2o.loadModel("model/GBM_model_R_1558482610633_2")


train <- fread("stream.csv")
explainer <- lime(train, model, n_bins = 5)
explainer_xg <- lime(train, modelxg, n_bins = 5)
explainer_gb <- lime(train, modelgb, n_bins = 5)
explainer_rf <- lime(train, modelrf, n_bins = 5)

highcharts_demo()

newtheme <- hc_theme_merge(
  getOption("highcharter.theme"),
  hc_theme(colors = c("red", "orange", "green"))
)

options(highcharter.theme = newtheme)
