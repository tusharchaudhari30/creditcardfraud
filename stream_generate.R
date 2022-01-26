

library(dplyr)
library(readr)
library(data.table)

data <-
  read_csv(
    "data/test_data.csv"
  )

i = 1
while (i <= 600) {
  temp = head(data, i * sample(85:100, 1))
  i = i + sample(25:40, 1)
  fwrite(temp, "stream.csv", row.names = FALSE)
  Sys.sleep(10)
  
}
