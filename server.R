library(tm)
library(ggplot2)
library(dplyr)
library(tidyr)
library(magrittr)
library(purrr)
library(tibble)
library(readr)
library(stringr)
library(rebus)
library(stringr)
library(class)
library(qdap)
library(readtext)
library(quanteda)
library(stringi)
library(shiny)

source(file = "utils/word_prediction_functions.R")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  # Make predictions
  predictions <- reactive({
    
    raw_text <- input$input_text # import input text
    search_text <- process_text(raw_text) # clean/Process raw text
    number_of_predictions <- input$prediction_number # save number of predictions
    
    
    word_prediction(search = search_text,
                    number_of_predictions = number_of_predictions # number of predictions
                    )
    })

  output$dataframe <- renderTable({data.frame(predictions())})

})
