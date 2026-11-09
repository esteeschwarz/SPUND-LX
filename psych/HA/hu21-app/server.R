source("compute.R")
library(knitr)

mdsrc_legende<-"https://raw.githubusercontent.com/esteeschwarz/DH_essais/main/sections/hux2021/hux_ha_shiny_legende.md"
legende<-HTML(mark(text = readLines(mdsrc_legende)))

source("eval-003.R")

server <- function(input, output,session) {
 rv <- reactiveValues(
    dfa = NULL,
    eval.1 = NULL,
    anova.form = "",
    lme.form = "",
    caption.ext = "",
    ceiling = ""
   
 )
  observeEvent(input$submit, {
    # req(input$id_select, input$id_select != "new")
    rv$dfa<-get.dist.norm(qltdf,input$limit)

  rv$ceiling <- ifelse(sum(limit)>0,"outliers removed","outliers not removed")
  
  rv$eval.1 <- get.anovas.e(dfa,c("obs","ref"),con,input$det.t,input$norm_target,input$lemma,input$author,input$url,input$range,input$embed,input$lme)
  rv$anova.form<-eval.1$anova.form
  rv$lme.form<-eval.1$lme.form
# caption.ext<-ifelse(rel,paste0(", normalised to ",ref_target,", distance ceiling =  ",ceiling),paste0("not normalised, distance ceiling =",ceiling))
# dfe<-eval.1$plot.md
caption.ext<-ifelse(rel,paste0(", normalised to ",ref_target,", distance ceiling =  ",ceiling),paste0(", not normalised, distance ceiling =",ceiling))
  })

  #### outputs:
  #output$legende <- renderText({HTML(mark(text=readLines(mdsrc_legende),format = "html"))})
  output$info <- renderPrint({
    br()
    print("datenset according to selection")
    dset<-now.data(dta,y)     
    cat("dataset:",dim(rv$dfa)[1],"observations")
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
   s1<-eval.1$anova.plain
p.select<-c("target|target:q")
p.an<-s1[grep(p.select,rownames(s1)),]
#p.an
#cat("anova plain, formula: `",anova.form.l$pre.det,"`\n")
print(s1)
    
   # kable(plot_desc_compare(dsetvso,x,"All")[,2:4])
  })
  # output$daten<-renderPrint({
  #     y<-mydata()
  #     dset<-now.data(dta,y)
  #     print(dset[1:10,1:30])
  #   })
  # #})
  #y<-mydata()
  # dset<-now.data(dta,y)
  #   output$daten<-renderPrint({
     
  #   kable(now.data(dta,mydata())[1:10,1:28])
  # #  print(dset[1:10,1:30])
  # })
  
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
  output$boxplot1<-renderPlot({
  d.sel<-paste0("dist",input$norm_target)
Y<-dfa[[d.sel]]
boxplot(Y~target,dfa,outline=F,notch=T,varwidth=T,ylab = d.sel)

  })
  output$barplot.mean<-renderPlot({
   dfe<-eval.1$plot.md
m1<-which(colnames(dfe)%in%c("mean","median"))
dfe[,m1]<-round(dfe[,m1],0)
# m2<-m1[length(m1):1]
# m3<-c(1:(m1[1]-1),m2)
# dfe<-dfe[,m3]
plot.dist(dfe,"mean")
  })
}