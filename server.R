IsThereNewFile <-
  function() {
    filenames <- list.files(pattern = "*.csv", full.names = TRUE)
    length(filenames)
  }

ReadAllData <-
  function() {
    filenames <- list.files(pattern = "*.csv", full.names = TRUE)
    fread(filenames[length(filenames)])
  }

ReadData <- function(file) {
  ## Function that read file
  fread(file, fill = TRUE)
}

shinyServer(server <- function(input, output, session) {
  sampled_data <-
    reactiveFileReader(15000, session, "stream.csv", ReadData)

  predict_fraud <- reactive({
    data <- sampled_data() %>% select(-Time_hr)
    h2odata <- as.h2o(data)
    prediction <-
      bind_cols(data, h2o.predict(model, h2odata) %>% as.data.frame())
    return(prediction)
  })

  predict_fraudrf <- reactive({
    data <- sampled_data()
    h2odata <- as.h2o(data)
    prediction <-
      bind_cols(data, h2o.predict(modelrf, h2odata) %>% as.data.frame())
    return(prediction)
  })

  predict_fraudxg <- reactive({
    data <- sampled_data()
    h2odata <- as.h2o(data)
    prediction <-
      bind_cols(data, h2o.predict(modelxg, h2odata) %>% as.data.frame())
    return(prediction)
  })

  predict_fraudgb <- reactive({
    data <- sampled_data()
    h2odata <- as.h2o(data)
    prediction <-
      bind_cols(data, h2o.predict(modelgb, h2odata) %>% as.data.frame())
    return(prediction)
  })

  source("server/01-dashboard-srv.R", local = TRUE)
  source("server/02-alert-srv.R", local = TRUE)
  source("server/02-xgalert-srv.R", local = TRUE)
  source("server/02-gbmalert-srv.R", local = TRUE)
  source("server/02-rfalert-srv.R", local = TRUE)
})
