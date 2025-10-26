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
    actionButton("refresh", "reload", class = "btn-primary btn-sm"),
    
    
    tableOutput("showsamples")
  )
  
)


# Define server logic required to draw a histogram
server <-   
  function(input, output, session) {
    rv <- reactiveValues(
      n = 5,
    )
    observeEvent(input$refresh, {
      rv$n <- input$bins
      output$showsamples <- renderTable({
        n<-rv$n
        df<-get.sample(n,k6)
        print(df)
        cns<-c("paradigm_he","paradigm_lat","kwic","art","adj","noun")
        df<-df[,colnames(df)%in%cns]
        
      },width = "100%"
      
      
      
      )
    })
    
    
  }

k6temp<-tempfile("tempk6.RData")
download.file("https://raw.githubusercontent.com/esteeschwarz/SPUND-LX/main/germanic/K6.Rdata",k6temp)
load(k6temp)
# Define server logic required to draw a histogram
get.sample<-function(n,k5){
  # m<-k5$chk_ann=="1"
  # sum(m)
  #  sum(k6$art=="der"&!is.na(k6$chk_ann))
  #n<-ceiling(n/2)
  get.d<-function(n,k5){
    sub1<-k5[k5$pos=="NOUN"&!is.na(k5$chk_ann),]
    sub3<-k5[k5$pos=="NOUN"&!is.na(k5$chk_ann)&k5$art=="der",]
    #sub1<-rbind(sub3,sub1)
    sa.N<-sub1[sample(1:length(sub1$id),n),]
    ifelse(length(sub3$id)>2,sa.d<-sub3[sample(1:length(sub3$id),1),],sa.d<-sub3)
    sa.N<-rbind(sa.N,sa.d)
    sub2<-k5[k5$pos=="ADJ"&!is.na(k5$chk_ann),]
    sa.A<-sub2[sample(1:length(sub2$id),n),]
    sa.AN<-rbind(sa.A,sa.N)
    sa.AN<-rbind(sub1,sub3,sub2)
    sa.AN<-sa.AN[sample(length(sa.AN$id),n),]
  }
  sa.AN<-get.d(n,k5)
  #chk.d<-sa.AN$art=="der"
  # while(sum(chk.d)<3)
  #    sa.AN<-get.d(5,k5)
  
  return(sa.AN)
}


# # Run the application 
# shinyApp(ui = ui, server = server)
