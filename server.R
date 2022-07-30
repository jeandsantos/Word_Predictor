suppressPackageStartupMessages(library(pacman))
suppressMessages(p_load(tm, tidyverse, rebus, stringr, class, qdap, readtext, quanteda, stringi, shiny))

TDM_1Gram_DF <- readRDS(file = "data/TDM_1Gram_DF.rds")
TDM_2Gram_DF <- readRDS(file = "data/TDM_2Gram_DF.rds")
TDM_3Gram_DF <- readRDS(file = "data/TDM_3Gram_DF.rds")
TDM_4Gram_DF <- readRDS(file = "data/TDM_4Gram_DF.rds")
Profanity <- readLines("data/Profanity.txt")
source(file = "word_prediction_functions.R")

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
