#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)

# Define UI for application that draws a histogram
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
