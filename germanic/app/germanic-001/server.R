#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
load(paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/germanic/K6.RData"))
# Define server logic required to draw a histogram
get.sample<-function(n,k5){
  # m<-k5$chk_ann=="1"
  # sum(m)
  #  sum(k6$art=="der"&!is.na(k6$chk_ann))
  get.d<-function(n,k5){
    sub1<-k5[k5$pos=="NOUN"&!is.na(k5$chk_ann),]
    sub3<-k5[k5$pos=="NOUN"&!is.na(k5$chk_ann)&k5$art=="der",]
    #sub1<-rbind(sub3,sub1)
    sa.N<-sub1[sample(1:length(sub1$id),n-1),]
    ifelse(length(sub3$id)>2,sa.d<-sub3[sample(1:length(sub3$id),3),],sa.d<-sub3)
    sa.N<-rbind(sa.N,sa.d)
    sub2<-k5[k5$pos=="ADJ"&!is.na(k5$chk_ann),]
    sa.A<-sub2[sample(1:length(sub2$id),n-1),]
    sa.AN<-rbind(sa.A,sa.N)
  }
  sa.AN<-get.d(n,k5)
  #chk.d<-sa.AN$art=="der"
  # while(sum(chk.d)<3)
  #    sa.AN<-get.d(5,k5)
  
  return(sa.AN)
}

  
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
