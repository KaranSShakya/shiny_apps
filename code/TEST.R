library(tidyverse)
library(shiny)
library(readr)
library(readxl)

data.set <- read_excel("data/crop_sales_2017.xlsx", 
                       col_types = c("text", "numeric", "text", 
                                     "numeric", "text", "numeric", "text", 
                                     "numeric"))

ggplot(data.set, aes(sample=Value_dollars))+
  stat_qq()

plotdata <- data.set %>% 
  select(Value_dollars)

