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
                  choices = c("Boxplot", "Density Distribution", "Q-Q Plot")),
    ),
    mainPanel(
      plotOutput("Descriptive"),
      plotOutput("Table")
    )
  )
))

# server ----
server <- shinyServer(function(input, output){
  output$Descriptive <- renderPlot({
    data.plot <- data.set %>% 
      select(input$Col)
    names(data.plot)[1] <- "Col_name"
    
  if (input$Plot == "Boxplot"){
    ggplot(data.plot, aes(x=Col_name))+
      geom_boxplot()+
      labs(x=input$Col)
    } 
  else if (input$Plot == "Density Distribution"){
    ggplot(data.plot, aes(x=Col_name))+
      geom_density()+
      labs(x=input$Col)
    }
  else if (input$Plot == "Q-Q Plot"){
    ggplot(data.plot, aes(sample=Col_name))+
      stat_qq()+
      labs(x=input$Col)
    }
    })
  
  output$Table <- renderTable({
    data.table <- data.set %>% 
      select(input$Col)
    names(data.table)[1] <- "Col_name"
    
    as.array(summary(data.table$Col_name))
   
  })
})

# App Run ----
shinyApp(ui = ui, server = server)

