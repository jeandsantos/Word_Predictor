library(shiny)
library(shinythemes)

shinyUI(
  navbarPage(
    title = "Text Predictor", 
    theme = shinytheme("cerulean"),
    windowTitle = "Text Predictor",
    
    # -------------------------------
    # Prediction Tab
    tabsetPanel(
      tabPanel(
        title = "Text Predictions",
        
        fluidRow(
          column(3),
          column(4),
          textInput("input_text", 
                    label = h3("Enter your text:"),
                    value = "Thank you"),
          span(style="color:grey",("Only English text is supported")),
          hr(),
          sliderInput("prediction_number",  
                      label = h3("Number of predictions:"),
                      value = 3,
                      min = 1,
                      max = 10),
          span(style="color:grey",("Maximum 10 predictions allowed")),
          hr(),
          h3(
            tableOutput("dataframe")
          ),
          align="center"
        ),
        column(3)
        
      ),
      
      tabPanel(
        title = "Additional Information",
        
        wellPanel(
          fluidRow(
            p("Word predictions obtained by calculating term frequency for 4-, 3-, 2- and 1-Grams. Predictions are assisted with Back-off."),
            br(),
            p("Use the slider to set the number of words you would like to be predicted. Words will be presented from top to bottom based on their frequency score."),
            br(),
            ("For app documentation visit the "), a(href = "https://github.com/jeandsantos/Word_Predictor", "GitHub page")
          )
        )
      )
    ),
    br(),
    hr(),
    span(
      style="color:grey", 
      h4(("Made by "),strong(a(href = "https://www.linkedin.com/in/jeandsantos/", target = "_blank", "Jean Dos Santos"))),
      align = "center")
  )
)