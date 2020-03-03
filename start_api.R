library(plumber)
library(readr)
library(dplyr)

serializer_csv <- function(){
  function(val, req, res, errorHandler){
    tryCatch({
      res$setHeader("Content-Type", "text/csv")
      res$setHeader("Content-Disposition", 'attachment; filename=data.csv')

      res$body <- capture.output(write.csv(val, stdout(), row.names = FALSE)) %>% 
                  paste0(collapse="\n")

      return(res$toResponse())
    }, error=function(e){
      errorHandler(req, res, e)
    })
  }
}

try({
    addSerializer("csv", serializer_csv)
})

api <- plumb('./api.R')
api$run(port = 8000)
