#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

#library(shiny)

# Define UI for application that draws a histogram
ui <- 
fluidPage(
  
  # Application title
  titlePanel("germanic samples: yiddish"),
  
  # Sidebar with a slider input for number of bins
  # sidebarLayout(
  #     sidebarPanel(
  #         sliderInput("bins",
  #                     "Number of bins:",
  #                     min = 1,
  #                     max = 30,
  #                     value = 10)
  #     ),
  
  # Show a plot of the generated distribution
  mainPanel(
    sliderInput("bins",
                "Number of samples:",
                min = 1,
                max = 30,
                value = 10)
    ,
    
    tableOutput("showsamples")
  )
  
)


# Define server logic required to draw a histogram
server <-   
  function(input, output, session) {
    output$showsamples <- renderTable({
      n<-input$bins
      df<-get.sample(n,k6)
      print(df)
      cns<-c("paradigm_he","paradigm_lat","kwic","art","adj","noun")
      df<-df[,colnames(df)%in%cns]
      
    },width = "100%"
    
    
    
    )
    
  }


# # Run the application 
# shinyApp(ui = ui, server = server)
