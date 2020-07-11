#Library ----
library(readxl)
library(tidyverse)
library(shiny)
library(ggplot2)

#Data ----
test.shiny <- read_excel("data/crop_sales_2017.xlsx")
test.shiny$Value_dollars <- as.numeric(test.shiny$Value_dollars)

# Ui ----
ui <- shinyUI(fluidPage(
  #Application title
  titlePanel("Descriptive Statistics"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("Dataset", "State",
                  choices = test.shiny$State),
      selectInput("Plot", "Plot Type",
                  choices = c("Histogram", "Box Plot"))
      ),
  
  mainPanel(
    plotOutput("Descriptive")
  )
  )
))

# Server ----
server <- shinyServer(function(input, output){
  output$Descriptive <- renderPlot({
    plotdata <- test.shiny[ test.shiny$type == input$Dataset, input$Variable]
    
    if(input$Plot == "Histogram"){
      ggplot(plotdata, aes(x=plotdata))+
        geom_histogram()
    }
    else if (input$Plot == "Box Plot"){
      ggplot(plotdata, aes(x=plotdata))+
        geom_boxplot()
    }
  })
})

shinyApp(ui = ui, server = server)









