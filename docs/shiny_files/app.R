library(shiny)

# make sure to set working directory 

source("app_ui.R")
source("app_server.R")

shinyApp(ui = ui, server = server)
