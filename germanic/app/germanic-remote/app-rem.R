#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#
library(DT)

#library(shiny)
r1<-'/\\{([^}]+)\\}/g'
load("dfo.RData")
q<-dfo$Left[3]
# Define UI for application that draws a histogram
ui <- 
fluidPage(
  tags$head(
    tags$style(HTML(".highlight { color: blue; font-weight: bold; }")),
    tags$script(HTML("
      // Run whenever new content appears
    /*  Shiny.addCustomMessageHandler('highlightBraces', function(id) {
        const el = document.getElementById('showsamples');
        if (el) {
       el.innerHTML = el.textContent.replace(/\\{([^}]+)\\}/g, '<span class=\"highlight\">{$1}</span>');
        }
        const para = document.createElement('p');
        para.innerText = 'This is a {par}agraph';
        para.innerHTML = para.textContent.replace(/\\{([^}]+)\\}/g, 'dumm<a href=\"link\">{$1}</a>');
        //document.body.appendChild(para);
        const test = document.createElement('p');
        test.innerHTML = el.textContent;
        */
       // document.body.appendChild(test);
        

      });
    "))
  ),
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
    # sliderInput("bins",
    #             "Number of samples:",
    #             min = 1,
    #             max = 30,
    #             value = 10)
    # ,
    # actionButton("refresh", "reload", class = "btn-primary btn-sm"),
    #
    HTML('<p>Q: <a href="https://ske.li/germanic_yid_002">sketchengine</a><p>'),
    verbatimTextOutput("query"),
    DTOutput("showsamples"),
    hr(),
    textInput("id","input row ID to show complete sample"),
    tableOutput("row")
    
    
    #tableOutput("showsamples")
  )
  
)


# Define server logic required to draw a histogram
server <-   
  function(input, output, session) {
    rv <- reactiveValues(
      n = 5,
    )
      output$query<-renderText(q)
      #observeEvent(input$refresh, {
     # rv$n <- input$bins
      #df<-k6[sample(length(k6$id),length(k6$id)),]
      df<-k6
      cns<-c("id","paradigm_he","paradigm_lat","kwic","art","adj","noun")
      df<-df[,colnames(df)%in%cns]
      output$showsamples<-renderDT({
        datatable(
          df,
          options = list(
            pageLength = 10,          # Number of rows per page
            lengthMenu = c(5, 10, 25, 50)  # Dropdown to select number of rows
            #order = list(list(1, 'asc'))    # Default sorting by 2nd column
          ),
          filter = "top",  # Adds a filter box at the top of each column
          rownames = FALSE
        )
      })
      output$row<-renderTable({
        id<-input$id
        dfo[id,2:length(dfo)]
      },width = "100%")
    #   output$showsamples <- renderTable({
    #     n<-rv$n
    #     df<-get.sample(n,k6)
    #     print(df)
    #     cns<-c("paradigm_he","paradigm_lat","kwic","art","adj","noun")
    #     df<-df[,colnames(df)%in%cns]
    #     
    #   },width = "100%"
    #   
    #   
    #   
    #   )
    # })
    observe({
      session$sendCustomMessage("highlightBraces", "showsamples")
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
