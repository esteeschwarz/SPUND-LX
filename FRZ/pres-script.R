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
  grep.af.c.corp(text.list.year[[i]],keywords=c("Musk","Elon","Twitter","Übernahme"),connect=T,35,date = names(text.list.year)[[i]])
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
df5<-data.frame(article=abind(m.af.corpus.corp,along = 1))
mnull<-df5$article
lc<-unlist(lapply(m.af.corpus.corp,length))
lcm<-lc>0
sum(lcm)
df4<-m.af.corpus.corp[lcm]
df5<-data.frame(abind(df4,along = 1))
rownames(df5)<-1:length(df5$date)
x<-df4[[1]]
lapply(seq_along(df4), function(x){
  writeLines(x[[i]],"")
})
writeLines(unlist(df4),paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/FRZ/devoir-02.txt"))
#df5$article[1]
df6<-df5[,1:2]
df5js<-list(df5$date)
#df1<-df1[2:length(df1$date),]
#df4$docname<-gsub(".+/(.+\\.xhtml)","\\1",df4$docname)
#write.csv(df1,"data/af_corpus-kwic.csv")
head(df1)

af.art.id<-unique(df1$docname) #191 articles
af.art.id
# get.af.texts
x<-text.list.cpt
#x$content[[1]]
#get.af.text<-function(x){
#x.t<-x$`2012-08-16`$content[[1]]
# library(tools)
# af.art.list<-list()
# for(k in 1:length(af.art.id)){
# m.grep<-af.art.id[k]
# m.out<-stri_split(m.grep,regex="_")
# #file_ext(f)
# 
# m.out.char<-grep("[a-zA-Z]",file_path_sans_ext(m.out[[1]][2]))
# if(!sum(m.out.char)>0){
# m<-grep(m.grep,text.list.cpt)
# #if(length(m)==1){
# m.date<-names(text.list.cpt[m])
# x.t<-text.list.cpt[[m]]$content[[1]]
# m2<-grep(gsub("[^0-9]","",m.grep),x.t$section)
# m.text<-x.t$text[m2]
# temp.text<-tempfile("m.text")
# writeLines(m.text,temp.text)
# m.text.lines<-readLines(temp.text)
# m.text.lines
# af.art.list[[m.date]]<-m.text.lines
# print(k)
# }
# }
#save(m.af.corpus.extract,file=paste(ha_dir,paste0("af.corpus.extract-","12-13-14",".Rdata"),sep = "/"))

#df1<-data.frame(m.af.corpus.extract[[1]])
#df1[1,1:length(df1)]<-NA
#df1<-cbind(date=NA,df1)
colnames(df1)<-c("date","text")

k<-41
for (k in 1:length(m.af.corpus.extract)){
  df2<-data.frame(text=m.af.corpus.extract[[k]])
  if(dim(df2)[1]!=0){
    #colnames(df2)<-c("date","text")
    
    df2<-cbind(date=names(m.af.corpus.extract[k]),df2)
    df1<-rbind(df1,df2)
  }
}
df1$text[41]
df1<-df1[2:length(df1$date),]
#df1$docname<-gsub(".+/(.+\\.xhtml)","\\1",df1$docname)
write.csv(df1,paste(ha_dir,paste0("af.corpus.extract-","12-13-14",".csv"),sep = "/"))
head(df1)

# get stopwords
c.af<-corpus(df1$text)
c.af.t<-tokens(c.af)
library(collostructions)
c.fr<-freq.list(unlist(c.af.t))
c.fr
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

