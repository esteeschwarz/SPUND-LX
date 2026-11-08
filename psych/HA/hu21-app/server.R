source("compute.R")
library(knitr)

mdsrc_legende<-"https://raw.githubusercontent.com/esteeschwarz/DH_essais/main/sections/hux2021/hux_ha_shiny_legende.md"
legende<-HTML(mark(text = readLines(mdsrc_legende)))

server <- function(input, output) {
  
  mydata <- reactive({
    draw.data(c(input$tm1,input$t0,input$t1,input$out,input$gilt,input$ctrl),dta)
  })
  mydata_2<-reactive({
    draw.setvso(input$groups)
  })
  #### outputs:
  #output$legende <- renderText({HTML(mark(text=readLines(mdsrc_legende),format = "html"))})
  output$info <- renderPrint({
    br()
    print("datenset according to selection")
    y<-mydata()
    dset<-now.data(dta,y)     
    cat("dataset:",dim(dset)[1],"observations",dim(dset)[2],"variables")
  }) # x<-proof_desc(mydata) #nur mit glt=1 (x,1,x)
  # ####
  output$plot<- renderPlot({
    y<-mydata()
    dset<-now.data(dta,y)     
    bar_df<-plot_desc(dset)
    ggplot(data=bar_df,mapping=aes(x=group,y=LZ,fill=RT)) + geom_col(position = "dodge")
  })
  # output$eval<-renderPrint({
  #   y<-mydata()
  #   dset<-now.data(dta,y)
  #   cat("mean reading times (LZ) in ms per category\n")
  #   print(bar_df<-plot_desc(dset)[,2:4])
  #   x<-mydata_2()
  #   #print(x)
  #   y<-mydata()
  #   dset<-now.data(dta,y)
  #   #print(dim(dset))
  #   dsetvso<-setvsx(dset,x,"Other")
  #   #print(dim(dsetvso))
  #   cat("comparing categories:",unique(dsetvso$category),"\n")
  #   print(plot_desc_compare(dsetvso,x,"All")[,2:4])
  # })
  output$eval<-renderPrint({
    y<-mydata()
    dset<-now.data(dta,y)
    cat("mean reading times (LZ) in ms per category\n")
  bar_df<-plot_desc(dset)[,2:4]
  #kable(plot_desc(dset)[,2:4])
  #kable(bar_df)
  print(bar_df)
     x<-mydata_2()
    #print(x)
    y<-mydata()
    dset<-now.data(dta,y)
    #print(dim(dset))
    dsetvso<-setvsx(dset,x,"Other")
    #print(dim(dsetvso))
    cat("comparing categories:",unique(dsetvso$category),"\n")
    cat("\nsnc:14273.2\n")
    
    kable(plot_desc_compare(dsetvso,x,"All")[,2:4])
  })
  # output$daten<-renderPrint({
  #     y<-mydata()
  #     dset<-now.data(dta,y)
  #     print(dset[1:10,1:30])
  #   })
  # #})
  #y<-mydata()
  # dset<-now.data(dta,y)
    output$daten<-renderPrint({
     
    kable(now.data(dta,mydata())[1:10,1:28])
  #  print(dset[1:10,1:30])
  })
  
  # output$compare<-renderPrint({
  #   x<-mydata_2()
  #   print(x)
  #   y<-mydata()
  #   dset<-now.data(dta,y)
  #   print(dim(dset))
  #   dsetvso<-setvsx(dset,x,"Other")
  #   print(dim(dsetvso))
  #   print(unique(dsetvso$category))
  #   print(plot_desc_compare(dsetvso,x,"All"))
  #     })
  output$box<-renderPlot({
    x<-mydata_2()
    print(x)
    other<-"Other"
    y<-mydata()
    dset<-now.data(dta,y)
    print(dim(dset))
    dsetvso<-setvsx(dset,x,other)
    print(dim(dsetvso))
    print(unique(dsetvso$category))
    print(plot_desc_compare(dsetvso,x,"All"))
     bar_df<-cbind(dsetvso$timeinterval[group!=other],dsetvso$timeinterval[group==other])
    boxplot(dset$timeinterval~group)
  })
  output$bars<-renderPlot({
    x<-mydata_2()
    print(x)
    other<-"Other"
    y<-mydata()
    dset<-now.data(dta,y)
    print(dim(dset))
    dsetvso<-setvsx(dset,x,other)
    print(dim(dsetvso))
    print(unique(dsetvso$category))
    print(plot_desc_compare(dsetvso,x,"All"))
    bar_df<-(plot_desc_compare(dsetvso,x,"All"))
    ggplot(data=bar_df,mapping=aes(x=group,y=LZ,fill=RT)) + geom_col(position = "dodge")
    
  })
}