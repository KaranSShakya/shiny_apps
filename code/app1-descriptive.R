# Library ----
library(tidyverse)
library(shiny)
library(readr)
library(readxl)

# Import File ----
#Name the file 'data.set'
data.set <- read_excel("data/crop_sales_2017.xlsx", 
                              col_types = c("text", "numeric", "text", 
                                            "numeric", "text", "numeric", "text", 
                                            "numeric"))

# ui ----
ui <- shinyUI(fluidPage(
  titlePanel("Descriptive Statistics"),
  sidebarLayout(
    sidebarPanel(
      selectInput("Col", "Column",
                  choices = colnames(data.set)),
      selectInput("Plot", "Plot Type",
                  choices = c("Boxplot", "Distribution Plot", "Q-Q Plot")),
    ),
    mainPanel(
      plotOutput("Descriptive")
    )
  )
))

# server ----
server <- shinyServer(function(input, output){
  output$Descriptive <- renderPlot({
    
    plotdata <- data.set %>% 
      select(input$Col)
    
    if (input$Plot == "Boxplot"){
      ggplot(plotdata, aes(y=input$Col))+
        geom_boxplot()
    } else if (input$Plot == "Distribution Plot"){
      ggplot(plotdata, aes(x=input$Col))+
        geom_density()
    } else if (input$Plot == "Q-Q Plot"){
      ggplot(plotdata, aes(sample=input$Col))+
        stat_qq()
    }
  })
})

# App Run ----
shinyApp(ui = ui, server = server)
