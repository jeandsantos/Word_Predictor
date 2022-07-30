
library(shiny)

shinyUI(navbarPage("Text Predictor", theme = shinytheme("spacelab"),
  
# -------------------------------
# Prediction Tab
tabsetPanel(
 tabPanel("Text Predictions",

          fluidRow(
            column(3),
            column(4),
                   tags$div(textInput("input_text", 
                                      label = h3("Enter your text:"),
                                      value = "Thank you"),
                            tags$span(style="color:grey",("Only English text is supported.")),
                            tags$hr(),
                            sliderInput("prediction_number",  
                                      label = h3("Number of predictions:"),
                                      value = 3,
                                      min = 1,
                                      max = 10),
                            tags$span(style="color:grey",("Maximum 10 predictions allowed")),
                            tags$hr(),
                            h3(
                            tableOutput("dataframe")
                                        ),
                                      # ),
                            align="center"
                            ),
            column(3)
            
            )
          
 ),

tabPanel("Additional Information",

         wellPanel(
           fluidRow(
           p("Word predictions obtained by calculating term frequency for 4-, 3-, 2- and 1-Grams. Predictions are assisted with Back-off."),
           br(),
           p("Use the slider to set the number of words you would like to be predicted. Words will be presented from top to bottom based on their frequency score."),
           br(),
           ("For app documentation visit the "), a(href = "https://github.com/jeandsantos/Word_Predictor", "github page")
           )
         )
),

tags$hr(),
tags$br(),

# -------------------------------
# Footer

 tags$span(style="color:grey", 
           tags$footer(("Made by "),
                       tags$a(
                         href = "https://www.linkedin.com/in/jeandsantos/",
                         target = "_blank",
                         "Jean Dos Santos"),  
                       ("using"), tags$a(
                         href="http://www.r-project.org/",
                         target="_blank",
                         "R"),
                       ("and"), tags$a(
                         href="http://shiny.rstudio.com",
                         target="_blank",
                         "Shiny."),
                       align = "left")
           )
)
))