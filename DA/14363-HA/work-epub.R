# 20240907(10.56)
# 14371.zeit.epub-corpus.grep.afd.occurences
############################################

# get epub
init<-function(){
  library(RSelenium)
  #library(rvest)
  #library(httr)
 # library(xml2)
  library(netstat)
  library(wdman)
  library(binman)
  #library(utils)
  #library(stringi)
  #library(clipr)
  #library(jsonlite)
  rd<-rsDriver(browser = "firefox",port = free_port())
  remdr<-rd$client
  #remdr$navigate(site.art)
  #remdr$navigate("https://zeit.de")
  #remdr$navigate(page)
  return(remdr)
}

id1<-"year"
xp1<-"//option[. = '2015']"
css1<-"#year > option:nth-child(5)"
id2<-"issue"
xp2<-"//option[. = '02']"
css2<-"#issue > option:nth-child(3)"
css3<-".btn-default-when-collapsed"
css4<-".col-sm-1-5:nth-child(1) img"
css5<-".btn-link"
LINK_TEXT_1<- "EPUB FÜR E-READER LADEN"
# 'arg' should be one of “xpath”, “css selector”, 
# “id”, “name”, “tag name”, “class name”, “link text”, “partial link text”
art.comments<-read.csv("~/Documents/GitHub/SPUND-LX/DA/14363-HA/data/comments-links.csv")
page.navi<-art.comments$link[2]
remdr<-init()
#remdr$browserName
#remdr$userAgent
#remdr
remdr$navigate(page.navi)

for (k in 3:53){
  cat("solving issue",k,"\n")
  css2<-paste0("#issue > option:nth-child(",k,")")
  com_button<-remdr$findElement(using = "id",id1)
  com_button$clickElement()
  Sys.sleep(6)
  print(1)
  dropdown<-remdr$findElement(using = "id",id1)
  #dropdown
  com_button<-dropdown$findElement(using = "xpath", xp1)
  com_button$clickElement()
  Sys.sleep(7)
  print(2)
  com_button<-remdr$findElement(using = "css selector", css1)
  com_button$clickElement()
  dropdown<-remdr$findElement(using = "id", id2)
  #com_button<-dropdown$findElement
  com_button<-dropdown$findElement(using = "xpath", xp2)
  com_button$clickElement()
  Sys.sleep(6)
  print(3)
  com_button<-remdr$findElement(using = "css selector", css2)
  com_button$clickElement()
  Sys.sleep(6)
  print(4)
  com_button<-remdr$findElement(using = "css selector", css3)
  com_button$clickElement()
  Sys.sleep(6)
  print(5)
  
  com_button<-remdr$findElement(using = "css selector", css4)
  com_button$clickElement()
  Sys.sleep(6)
  print(6)
  #com_button_load<-remdr$findElement(using = "link text", LINK_TEXT_1)
  #com_button_load$clickElement()
  #com_button
  # get back
  #tryCatch(1,finally = print("hello"))
  #simpleError()
  e<-simpleError("testerror")
  #
  # always issue 43 no epub
  com_button_load<-tryCatch(remdr$findElement(using = "link text", LINK_TEXT_1),error=function(e)cat("no epub, moving forth\n"),finally = print("checked epub load"))
  #print("checked load epub button")
  if(!is.null(com_button_load))
    com_button_load$clickElement()
  com_button<-remdr$findElement(using = "css selector",".btn-link")
  #com_button$getElementAttribute("data-wt-click")
  #com_button$isElementEnabled()
  com_button$clickElement() #!!!
  Sys.sleep(10)
  print(7)
  
  #com_button$click()
  #com_button<-remdr$findElement(using = "xpath","/html/body/div[2]/div[2]/section/nav/ul/li/a")
  #com_button$click()
  cat(k,"finished\n")
}
###
library(epubr)
library(stringi)
library(quanteda)
ha_dir<-"~/boxHKW/21S/DH/local/SPUND/DA/14363-HA"
year<-"2014"
datadir<-paste(ha_dir,paste("zeit",year,sep="/"),sep = "/")
datadir
f<-list.files(datadir)
m<-grep(".epub",f)
f.m<-f[m]
text.list<-list()
#k<-"2012-03-15"
#k<-3
for (k in 1:length(f.m)){
  ep<-epub(paste(datadir,f.m[k],sep = "/"))
  k.ns<-ep$date
  text.list[[k.ns]][["content"]]<-ep$data
print(k)  
}
text.list.s<-text.list[order(names(text.list))]
#save(text.list.s,file=paste(ha_dir,paste0("text.list-",year,".Rdata"),sep = "/"))
load(paste(ha_dir,paste0("text.list-",2013,".Rdata"),sep = "/"))
text.list<-text.list.s
m<-names(text.list)%in%names(text.list.s)
m1<-!m
m1
text.list<-text.list[m1]
text.list.cpt<-c(text.list.s,text.list)
#save(text.list.cpt,file=paste(ha_dir,paste0("text.list-","12-13-14",".Rdata"),sep = "/"))

grep.af.c<-grep.af<-function(x){
  regx<-"AfD|AFD"
  m.1<-grep(regx,x$content[[1]]$text)
  m.2<-stri_count_regex(x$content[[1]]$text[m.1],regx)
 # m.3<-x$content[[1]]$text[m.1]
  c.af<-corpus(x$content[[1]]$text[m.1])
  c.af.t<-tokens(c.af)
  m.af.kwic<-kwic(c.af.t,regx,valuetype = "regex",35)
}
m.af.corpus.kwic<-lapply(text.list.cpt, grep.af.c)
# make csv
#load("data/af.corpus.kwic.Rdata")
df1<-data.frame(m.af.corpus.kwic[[1]])
df1[1,1:length(df1)]<-NA
df1<-cbind(date=NA,df1)
k<-41
for (k in 1:length(m.af.corpus.kwic)){
  df2<-data.frame(m.af.corpus.kwic[[k]])
  if(dim(df2)[1]!=0){
    df2<-cbind(date=names(m.af.corpus.kwic[k]),df2)
    df1<-rbind(df1,df2)
  }
}
df1<-df1[2:length(df1$date),]
df1$docname<-gsub(".+/(.+\\.xhtml)","\\1",df1$docname)
#write.csv(df1,"data/af_corpus-kwic.csv")
head(df1)

# m.true<-function(x)x$keyword!=""
# af.corpus.kwic.t<-lapply(m.af.corpus.kwic, m.true)
# af.corpus.exc<-m.af.corpus.kwic[unlist(af.corpus.kwic.t)]
#save(m.af.corpus.kwic,file="../af.corpus.kwic.Rdata")
#save(m.af.corpus.kwic,file="~/documents/github/spund-lx/DA/14363-HA/data/af.corpus.kwic.Rdata")
# outputs list with texts including keyword-in-25tokens-window-context

# library(clipr)
# library(knitr)
# output<-lapply(m.af.corpus.kwic,kable)
# write_clip(unlist(output))
# output<-lapply(m.af.corpus.kwic,unlist(kable))

