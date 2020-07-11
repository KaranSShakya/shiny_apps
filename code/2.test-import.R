# Library ----
library(tidyverse)
library(shiny)
library(readr)
library(readxl)

# ui ----
ui <- shinyUI(fluidPage(
  headerPanel(title = "Upload File"),
  sidebarLayout(
    sidebarPanel(
      fileInput("file", "Upload the File"),
      h5("File has to be CSV and pre-organized"),
    ),
    mainPanel(
      tableOutput("input_file")
    )
  )
))

# server ----
server <- shinyServer(function(input, output){
  
  output$input_file <- renderTable({
    file_to_read = input$file
    if (is.null(file_to_read)){
      return()
    }
    use.table <- read.table(file_to_read$datapath, sep=",", header=T)
    main.data <- as.data.frame(use.table) %>% 
      head(10)
  })
})

shinyApp(ui, server) 