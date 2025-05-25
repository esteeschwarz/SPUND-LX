library(epubr)
library(stringi)
library(quanteda)
# ha_dir<-"~/Library/Containers/QReader.MarginStudy.easy/Data/Documents/spund"
# year<-"2022"
# #datadir<-paste(ha_dir,paste("zeit",year,sep="/"),sep = "/")
# datadir<-paste(ha_dir,paste("zeit/compiled"),sep = "/")
# datadir
# f<-list.files(datadir)
# m<-grep(".epub",f)
# # duplicates
# #f[m2]
# f.m<-f[m]
# m2<-grepl("[)(]",f.m)
# f.m<-f.m[!m2]
# text.list<-list()
# #k<-"2012-03-15"
# #k<-3
# for (k in 1:length(f.m)){
#   ep<-epub(paste(datadir,f.m[k],sep = "/"))
#   k.ns<-ep$date
#   text.list[[k.ns]][["content"]]<-ep$data
#   print(k)  
# }
# text.list.s<-text.list[order(names(text.list))]
#save(text.list.s,file=paste(ha_dir,paste0("text.list-",year,".Rdata"),sep = "/"))
#save(text.list.s,file=paste(ha_dir,paste0("text.list-cpt.Rdata"),sep = "/"))
load("/Users/guhl/boxHKW/21S/DH/local/SPUND/DA/14363-HA/text.list-cpt.Rdata")
issues<-names(text.list.s)
issues
2025-2013
12*52 #624
11*52+(52-(52-42)) #614
#load(paste(ha_dir,paste0("text.list-",year,".Rdata"),sep = "/"))
#text.list<-text.list.s
#m<-names(text.list)%in%names(text.list.s)
m<-grepl("2022",issues)
sum(m)
m1<-!m
m1<-m
text.list<-text.list.s[m1]
#text.list.cpt<-c(text.list.s,text.list)
text.list.year<-text.list
#save(text.list.cpt,file=paste(ha_dir,paste0("text.list-","12-13-14",".Rdata"),sep = "/"))
#x<-text.list[[9]]
#?grep
#x$content[[1]]$section

grep.af.c.kwic<-grep.af<-function(x,keywords,connect=F,window){
#  regx<-keyword
  t<-x$content[[1]]$text
  
  regx<-paste0("(",paste0(keywords,collapse = "|"),")")
  regx<-paste0("(",paste0(paste0(keywords,"\\b"),collapse = "|"),")")
  m.1<-grep(regx,t)
  if(connect)
    m.1 <- sapply(t, function(x) all(sapply(keywords, function(k) grepl(k, x, ignore.case = TRUE))))
  
#  m.1<-grepl(regx,x$content[[1]]$text)
 # sum(m.1)
  #m.1<-regexpr(regx,x$content[[1]]$text)
  #m.1
#  regmatches(x$content[[1]]$text,m.1)
  m.2<-stri_count_regex(x$content[[1]]$text[m.1],regx)
  m.3<-x$content[[1]]$text[m.1]
  
  print(length(m.1))
  if(length(m.1>0)){
    c.af<-corpus(x$content[[1]]$text[m.1])
    c.af.t<-tokens(c.af)
    return(m.af.kwic<-kwic(c.af.t,regx,valuetype = "regex",window))
  }
  af.corp.extract<-m.3
  
}
#t<-x$content[[1]]$text
#connect<-T
grep.af.c.corp<-grep.af<-function(x,keywords,connect=F,window,date){
  #  regx<-keyword
  t<-x$content[[1]]$text
  regx<-paste0("(",paste0(keywords,collapse = "|"),")")
  regx<-paste0("(",paste0(paste0(keywords,"\\b"),collapse = "|"),")")
  
  m.1<-grep(regx,x$content[[1]]$text)
  if(connect)
    m.1 <- sapply(t, function(x) all(sapply(keywords, function(k) grepl(k, x, ignore.case = TRUE))))
  #  m.1<-grepl(regx,x$content[[1]]$text)
  # sum(m.1)
  #m.1<-regexpr(regx,x$content[[1]]$text)
  #m.1
  #  regmatches(x$content[[1]]$text,m.1)
  m.2<-stri_count_regex(x$content[[1]]$text[m.1],regx)
  m.3<-x$content[[1]]$text[m.1]
  print(date)  
  print(length(m.1))
  m.1
  m.1<-unlist(m.1)
  if(sum(m.1)>0){
#    c.af<-corpus(x$content[[1]]$text[m.1])
    c.af<-data.frame(date=date,article=t[m.1])
 #   c.af<-append(c.af,date,after = length(c.af))
    #c.af.t<-tokens(c.af)
    return(c.af)
  }
  af.corp.extract<-m.3
  
}
scribble<-function(){
  keywords=c("Musk","Elon","Twitter")
  t<-c("random text containing Musk, Musk ,Elon,Twitter and Twitter","and other random like muskles and Twittern or","twittern eg", "or Muskles and nothing")
  regx<-paste0("(",paste0(paste0(keywords,"\\b"),collapse = ".+"),")")
  print(regx)
  m.1<-grep(regx,t)
  m.1<-grepl(regx,t)
  sum(m.1)
  m.1<-regexpr(regx,t)
  m.1
  regmatches(t,m.1)
}
#kwic
#m.af.corpus.kwic<-lapply(text.list.cpt, grep.af.c)
m.af.corpus.kwic<-lapply(seq_along(text.list.year), function(i){
  grep.af.c.kwic(text.list.year[[i]],keywords=c("Musk","Elon","Twitter","Übernahme"),connect=F,35)
})
#i<-1
m.af.corpus.corp<-lapply(seq_along(text.list.year), function(i){
  grep.af.c.corp(text.list.year[[i]],keywords=c("Musk","Elon","Twitter","Übernahme|Kauf"),connect=T,35,date = names(text.list.year)[[i]])
})
#m.af.corpus.extract$`2014-05-08`
# make csv
#load("data/af.corpus.kwic.Rdata")
#m.af.corpus.kwic<-m.af.corpus.extract
#df1<-data.frame(m.af.corpus.kwic[[1]])
#df1<-data.frame(m.af.corpus.extract[[1]])

#df1[1,1:length(df1)]<-NA
#df1<-cbind(date=NA,df1)
#k<-41
#df3<-data.frame(m.af.corpus.kwic[[1]])
#k<-10
library(abind)
df3<-data.frame(abind(m.af.corpus.kwic,along = 1))
#df4<-cbind(date=NA,df3)
# df5<-data.frame(article=abind(m.af.corpus.corp,along = 1))
# mnull<-df5$article
lc<-unlist(lapply(m.af.corpus.corp,length))
lcm<-lc>0
sum(lcm)
df4<-m.af.corpus.corp[lcm]
df5<-data.frame(abind(df4,along = 1))
rownames(df5)<-1:length(df5$date)
x<-df4[[1]]
# lapply(seq_along(df4), function(x){
#   writeLines(x[[i]],"")
# })
writeLines(unlist(df4),paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/FRZ/devoir-02.txt"))

# 15222.twtr shares
library(xml2)
url<-"https://www.digrin.com/stocks/detail/TWTR/price"
library(httr)
r<-GET(url)
htm<-content(r,"text")
xhtm<-read_html(htm)
xp<-'/html/body/div[1]/div[2]/div[1]/div[3]/table'
table<-xml_find_all(xhtm,xp)
xt<-read_html("twtr-shares.html")
td<-xml_find_all(table,"//td")
tx<-xml_text(td)
tr<-xml_find_all(table,"//tr")
trx<-xml_text(tr)
#m<-grep("\\$",tx)
td<-strsplit(trx,"\n")
td[[2]]
mo<-unlist(lapply(td,function(x){
  mo<-strsplit(x[1]," ")
  mo<-lapply(mo, function(x){paste(x[1:2],collapse = " ")})
  
  
  }))
mo
mo<-mo[2:length(mo)]
tdn<-lapply(td,function(x){gsub(" ","",x[2:4])})
tdn<-data.frame(td)
tdn<-data.frame(t(tdn),row.names = 1:length(tr))
tdn<-tdn[grep("[0-9]",tdn$X1),1:2]
colnames(tdn)<-c("date","price")

tdn$price<-gsub("\\$","",tdn$price)
tdn<-tdn[length(tdn$date):1,1:2]
mode(tdn$price)<-"double"
rownames(tdn)<-tdn$date
tdn2<-tdn[,2]
#plot(tdn2,type = "h",names.arg=tdn$date)
tdn.s<-tdn[grep("2021|2022|2023",tdn$date),]
shift<-30
barplot(
  height = as.numeric(tdn.s$price-shift),
  offset = shift,
  names.arg = tdn.s$date,
  las = 2,                # make labels perpendicular to axis
  cex.names = 0.7,  # adjust label size if needed
  main = "share value",
  ylab = "price / USD",
)
?barplot
# months.Date(mo,"%B")
# format(month,"%b %Y ")
# ?Date
# (today <- Sys.Date())
# format(today, "%B %Y")  # with month as a word
# (tenweeks <- seq(today, length.out=10, by="1 week")) # next ten weeks
# weekdays(today)
# months(tenweeks)
# mo
# as.Date(mo,"%B %Y")
# format(mo,"%B %Y")
# mo
# ?as.Date
# x <- c("jan1960", "2jan1960", "31 mar1960", "30 jul1960")
# z <- as.Date(x, "%d%b%Y")
# z
# format(Sys.Date(), "%b %d")
