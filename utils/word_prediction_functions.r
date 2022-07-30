process_text <- function(text) { # Function to process input text
  
  text <- as.character(text)
  text <- text %>% removeWords(words = Profanity) %>% removePunctuation() %>% removeNumbers() %>% stripWhitespace() %>% tolower()
  text <- paste0(text, " ") %>% stripWhitespace() 
  
}

word_prediction <- function(search = "thank you", number_of_predictions = 3) { 
  
  # search <- as.character(search)
  # search <- search %>% removeWords(words = Profanity) %>% removePunctuation() %>% removeNumbers() %>% stripWhitespace() %>% tolower()
  # search <- paste0(search, " ") %>% stripWhitespace() 
  
  search <- as.character(search)
  search <- search %>% removeWords(words = Profanity) %>% removePunctuation() %>% removeNumbers() %>% stripWhitespace() %>% tolower()
  search <- paste0(search, " ") %>% stripWhitespace() 
  
  word_number <- word_count(search)
  split_search <- strsplit(x = search, split = " ")[[1]]
  predictions <- as.vector(rep(NA, number_of_predictions))
  
  if (is.na(word_number) | search == " ") { # No words or blank search seach ------------------------------------------
    
    predictions <- TDM_1Gram_DF %>% filter(!Term %in% predictions) %>% arrange(desc(Frequency)) %>% .[,1] %>% .[1:number_of_predictions]
    
  } else if (word_number > 3) { # 4 or more word seach ------------------------------------------
    
    predictions <- TDM_4Gram_DF[grepl(pattern = paste0("^", str_c(split_search[(word_number-2):word_number], collapse = " ")), x = TDM_4Gram_DF$Term), ] %>% .[1:number_of_predictions, "Term"] %>% word(start = -1)
    
    if (sum(is.na(predictions)) >= 1) {
      
      total_NA <- sum(is.na(predictions))
      replacement_index <- which(is.na(predictions))
      extraction_index <- 1:total_NA
      
      interim_predictions <- TDM_3Gram_DF[grepl(pattern = paste0("^", str_c(split_search[(word_number-1):word_number], collapse = " ")), x = TDM_3Gram_DF$Term), ] %>% .[1:number_of_predictions, "Term"] %>% word(start = -1)
      
      # extract unique words from interim predictions
      unique_interim_predictions <- interim_predictions[!interim_predictions %in% predictions]
      # add unique predictions to predictions
      predictions[replacement_index] <- unique_interim_predictions[extraction_index]
    }
    
    if (sum(is.na(predictions)) >= 1) {
      
      total_NA <- sum(is.na(predictions))
      replacement_index <- which(is.na(predictions))
      extraction_index <- 1:total_NA
      
      interim_predictions <- TDM_2Gram_DF[grepl(pattern = paste0("^", str_c(split_search[(word_number-0):word_number], collapse = " ")), x = TDM_2Gram_DF$Term), ] %>% .[1:number_of_predictions, "Term"] %>% word(start = -1)
      
      # extract unique words from interim predictions
      unique_interim_predictions <- interim_predictions[!interim_predictions %in% predictions]
      # add unique predictions to predictions
      predictions[replacement_index] <- unique_interim_predictions[extraction_index]
    }
    
    if (sum(is.na(predictions)) >= 1) {
      
      total_NA <- sum(is.na(predictions))
      replacement_index <- which(is.na(predictions))
      extraction_index <- 1:total_NA
      
      interim_predictions <- TDM_1Gram_DF %>% filter(!Term %in% predictions) %>% arrange(desc(Frequency)) %>% .[,1]
      
      # extract unique words from interim predictions
      unique_interim_predictions <- interim_predictions[!interim_predictions %in% predictions]
      # add unique predictions to predictions
      predictions[replacement_index] <- unique_interim_predictions[extraction_index]
    }
  } else if (word_number == 3) { # 3 word seach ------------------------------------------
    
    # search = "i love the " #[EXAMPLE]
    
    predictions <- TDM_4Gram_DF[grepl(pattern = paste0("^", search), x = TDM_4Gram_DF$Term), ] %>% .[1:number_of_predictions, "Term"] %>% word(start = -1)
    
    if (sum(is.na(predictions)) >= 1) {
      
      total_NA <- sum(is.na(predictions))
      replacement_index <- which(is.na(predictions))
      extraction_index <- 1:total_NA
      
      interim_predictions <- TDM_3Gram_DF[grepl(pattern = paste0("^", str_c(split_search[(word_number-1):word_number], collapse = " ")), x = TDM_3Gram_DF$Term), ] %>% .[1:number_of_predictions, "Term"] %>% word(start = -1)
      
      # extract unique words from interim predictions
      unique_interim_predictions <- interim_predictions[!interim_predictions %in% predictions]
      # add unique predictions to predictions
      predictions[replacement_index] <- unique_interim_predictions[extraction_index]
    }
    
    if (sum(is.na(predictions)) >= 1) {
      
      total_NA <- sum(is.na(predictions))
      replacement_index <- which(is.na(predictions))
      extraction_index <- 1:total_NA
      
      interim_predictions <- TDM_2Gram_DF[grepl(pattern = paste0("^", str_c(split_search[(word_number-0):word_number], collapse = " ")), x = TDM_2Gram_DF$Term), ] %>% .[1:number_of_predictions, "Term"] %>% word(start = -1)
      
      # extract unique words from interim predictions
      unique_interim_predictions <- interim_predictions[!interim_predictions %in% predictions]
      # add unique predictions to predictions
      predictions[replacement_index] <- unique_interim_predictions[extraction_index]
    }
    
    if (sum(is.na(predictions)) >= 1) {
      
      total_NA <- sum(is.na(predictions))
      replacement_index <- which(is.na(predictions))
      extraction_index <- 1:total_NA
      
      interim_predictions <- TDM_1Gram_DF %>% filter(!Term %in% predictions) %>% arrange(desc(Frequency)) %>% .[,1]
      
      # extract unique words from interim predictions
      unique_interim_predictions <- interim_predictions[!interim_predictions %in% predictions]
      # add unique predictions to predictions
      predictions[replacement_index] <- unique_interim_predictions[extraction_index]
    }
  } else if (word_number == 2) { # 2 word seach ------------------------------------------
    
    predictions <- TDM_3Gram_DF[grepl(pattern = paste0("^", search), x = TDM_3Gram_DF$Term), ] %>% .[1:number_of_predictions, "Term"] %>% word(start = -1)
    
    if (sum(is.na(predictions)) >= 1) {
      
      total_NA <- sum(is.na(predictions))
      replacement_index <- which(is.na(predictions))
      extraction_index <- 1:total_NA
      
      interim_predictions <- TDM_2Gram_DF[grepl(pattern = paste0("^", str_c(split_search[word_number:word_number], collapse = " ")), x = TDM_2Gram_DF$Term), ] %>% .[1:number_of_predictions, "Term"] %>% word(start = -1)
      
      # extract unique words from interim predictions
      unique_interim_predictions <- interim_predictions[!interim_predictions %in% predictions]
      # add unique predictions to predictions
      predictions[replacement_index] <- unique_interim_predictions[extraction_index]
    }
    
    if (sum(is.na(predictions)) >= 1) {
      
      total_NA <- sum(is.na(predictions))
      replacement_index <- which(is.na(predictions))
      extraction_index <- 1:total_NA
      
      interim_predictions <- TDM_1Gram_DF %>% filter(!Term %in% predictions) %>% arrange(desc(Frequency)) %>% .[,1]
      
      # extract unique words from interim predictions
      unique_interim_predictions <- interim_predictions[!interim_predictions %in% predictions]
      # add unique predictions to predictions
      predictions[replacement_index] <- unique_interim_predictions[extraction_index]
    }
  } else if (word_number == 1) { # 1 word seach ------------------------------------------
    
    predictions <- TDM_2Gram_DF[grepl(pattern = paste0("^", search), x = TDM_2Gram_DF$Term), ] %>% .[1:number_of_predictions, "Term"] %>% word(start = -1)
    
    if (sum(is.na(predictions)) >= 1) {
      
      total_NA <- sum(is.na(predictions))
      replacement_index <- which(is.na(predictions))
      extraction_index <- 1:total_NA
      
      interim_predictions <- TDM_1Gram_DF %>% filter(!Term %in% predictions) %>% arrange(desc(Frequency)) %>% .[,1]
      
      # extract unique words from interim predictions
      unique_interim_predictions <- interim_predictions[!interim_predictions %in% predictions]
      # add unique predictions to predictions
      predictions[replacement_index] <- unique_interim_predictions[extraction_index]
    }
  } else message("No predictions found for these words. Please try an alternative spelling.")
  
  print(data.frame(Prediction = predictions, stringsAsFactors = FALSE)) 
  
  # rm(total_NA, replacement_index, extraction_index, unique_interim_predictions, predictions, search, word_number, split_search)
}