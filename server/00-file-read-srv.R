IsThereNewFile=function(){  
  
  filenames <- list.files(pattern="*.csv", full.names=TRUE)
  length(filenames)
}
ReadAllData=function(){ # A function that calculates the underlying value
  filenames <- list.files(pattern="*.csv", full.names=TRUE)
  read_csv(filenames[length(filenames)])
}
