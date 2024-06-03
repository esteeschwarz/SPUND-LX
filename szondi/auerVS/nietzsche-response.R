#20240601(06.12)
#14231.vs-auer.nietzsche.response
#################################
# library(gutenbergr)
# works<-gutenberg_works(languages = "de")
# m<-grep("Nietzsche",works$author)
# works$title[m]
# title not in db.
##################
# get text
library(httr)
library(xml2)
x<-GET("https://www.projekt-gutenberg.org/nietzsch/essays/wahrheit.html")
### TODO: try KGA scrape from >
src.kga<-"http://www.nietzschesource.org/?#eKGWB/WL-Titel"
get.kga<-function(src=src.kga){
x<-GET(src)  
r<-content(x,"text")
htm<-read_html(r)
body<-xml_find_all(htm,"/html/body//*",flatten=T)
body
allp<-xml_find_all(htm,'//*[@class id="eKGWB/WL-1"]/div[1]/p') #xpath safari
allp<-xml_find_all(htm,'.//p') #xpath safari
allx<-xml_find_all(htm,'//*[id="page_ext"]')
'#eKGWB\/WL-1 > div:nth-child(8) > p' #selektor path
allp<-xml_find_all(htm,'//html/body/div')
allp
text<-xml_text(body[3:26])
text
}
r<-content(x,"text")
htm<-read_html(r)
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
  frf<-function(x)freq.list(x)
  fr1<-lapply(t1, frf)
  f1<-freq.list(unlist(t1))
  m<-f1$WORD%in%swords
  f2<-f1[!m,]
  return(f2)
}
flist<-topic.func()
flist
head(flist,20)
m<-grep("gott",text)
text[m]
m<-grep("[a-zA-Z]",flist$WORD)
flist.r<-flist[m,][1:20,]
head(flist.r,20)
# plural duplicates
m<-grep("mensch",flist.r$WORD)
flist.r$WORD[m]<-"mensch"
flist.r$FREQ[m]<-sum(flist.r$FREQ[m])
m<-grep("begriff",flist.r$WORD)
flist.r$WORD[m]<-"begriff"
flist.r$FREQ[m]<-sum(flist.r$FREQ[m])
m<-duplicated(flist.r$WORD[])
flist.r<-flist.r[!m,]
par(las=3)
barplot(flist.r$FREQ,names.arg = flist.r$WORD)
#####
# plot keywords
t2<-unlist(t1)
library(syuzhet)
source("https://github.com/esteeschwarz/SPUND-LX/raw/main/szondi/plotkeywords.R")
key.plot<-function(t,tok){
  m<-grepl(tok,t)
  m2<-m-1+1
  m3<-get_percentage_values(m2)
  plot(m3,type="h",main=paste0("keyword -",tok,"- over text"),xlab="tokens",ylab="scaled occurences")
  plotkeywords(m2,title = paste0("plot keyword -",tok,"- over text"))
}
key.plot(t2,"Wahrheit")
###################
