#20240601(06.12)
#14231.vs-auer.nietzsche.response
#################################
# library(gutenbergr)
# works<-gutenberg_works(languages = "de")
# m<-grep("Nietzsche",works$author)
# works$title[m]
# no.
#####
library(httr)
x<-GET("https://www.projekt-gutenberg.org/nietzsch/essays/wahrheit.html")
r<-content(x,"text")
library(xml2)
htm<-read_html(r)
# allp<-xml_find_all(htm,"/html/body/p")
# text<-xml_text(allp)
body<-xml_find_all(htm,"/html/body/*")
text<-xml_text(body[3:26])
text
### wks.
########
# content analysis
library(quanteda)
library(collostructions)
stext<-text
swords<-stopwords("de")
t1<-tokenize_word1(stext)
topic.func<-function(){
  # m<-t1%in%swords
  # t2<-t1[!m]
  frf<-function(x)freq.list(x)
  fr1<-lapply(t1, frf)
  f1<-freq.list(unlist(t1))
  m<-f1$WORD%in%swords
  f2<-f1[!m,]
  
  #f2<-f1
  return(f2)
}
flist<-topic.func()
flist
#####
# plot keywords
t2<-unlist(t1)
library(syuzhet)
source("~/Documents/GitHub/SPUND-LX/szondi/plotkeywords.R")
key.plot<-function(t,tok){
  m<-grepl(tok,t)
  m2<-m-1+1
  m3<-get_percentage_values(m2)
  plot(m3,type="h",main="keyword over text",xlab="tokens")
  #scatter.smooth(m3)
  plotkeywords(m2,title = paste0("plot keyword -",tok,"- over text"))
}
key.plot(t2,"Lüge")
#?scatter.smooth
#simple_plot(m)
#edit(simple_plot)
#####
