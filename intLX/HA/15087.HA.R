# 20250221(10.30)
# 15087.SPUND.intLX.HA
# A:figurative language and style correlation
#############################################
# RQ: how do the use of figurative language in internet speech and style/register
# correlate?
############
# Q: r/de
fun.out<-function(){
load("~/boxHKW/21S/DH/local/SPUND/intLX/url.comment.df.15086.RData")

# chunk df in subsets of containing not more than 120.000 chars in df$comments for further analysing in MAXQDA
# where this is the limit for AI assisted coding (recognition of figurative language)

t1<-url.comment.df$comment
t1c<-strsplit(t1,"")
tc<-unlist(t1c) # 13.445.500
margin<-119995
########
# chunks
l.df<-length(tc)
# Create the vector
vector <- 1:l.df

# Define the chunk size
chunk_size <- margin  # Example chunk size

# Function to split the vector into chunks of equal length
split_into_chunks <- function(vec, chunk_size) {
  split(vec, ceiling(seq_along(vec) / chunk_size))
}

# Split the vector into chunks
chunks <- split_into_chunks(vector, chunk_size)
###############################################
margin.end<-tail(1:margin,40)
gm<-paste0(tc[chunks[[1]][margin.end]],collapse = "")
gms<-strsplit(gm,"[?.!]")
gms<-unlist(gms)
gms<-gsub("[*)?(\\[\\]]",".",gms)
gms
m<-grep(gms[1],url.comment.df$comment)
#m<-grep("*alle*",url.comment.df$comment)
url.comment.df[m,]

### chunk
# chunks
l.df<-length(url.comment.df$url)
# Create the vector
vector <- 1:l.df
margin<-420
# Define the chunk size
chunk_size <- margin  # Example chunk size

# Function to split the vector into chunks of equal length
split_into_chunks <- function(vec, chunk_size) {
  split(vec, ceiling(seq_along(vec) / chunk_size))
}

# Split the vector into chunks
chunks <- split_into_chunks(vector, chunk_size)
k<-1
library(writexl)
for(k in 1:length(chunks)){
  subdf<-url.comment.df[chunks[[k]][1]:chunks[[k]][length(chunks[[k]])],]
  subdf$sub<-k
  xlns<-paste0("~/boxHKW/21S/DH/local/SPUND/intLX/HA/comments.subdf.",k,".xlsx")
  write_xlsx(subdf,xlns)
  t<-paste(subdf$url,subdf$author,subdf$comment)
  t<-paste(paste0("@",subdf$author,"\t"),subdf$comment)
  #  t<-c(paste0("@author: ",subdf$author),paste0("@url: ",subdf$url),t)
  tns<-paste0("~/boxHKW/21S/DH/local/SPUND/intLX/HA/comments.subtx.",k,".txt")

  writeLines(t,tns)
  
}
}
########
# 15102.
# B: logbooks in the digital age
################################
# RQ: speech in logbook entries, diachrone betrachtung
# Q: weblogs
######################################################
library(httr)
library(xml2)
q1<-"https://sailing-mahananda.com" #/2025/01/dd"
y<-2025
m<-01
d<-28
url<-paste(q1,y,m,d,sep = "/")
r<-GET(url)
x<-content(r,"text")
thtm<-read_html(x)
xml_text(thtm)

logfolder<-"/Users/guhl/boxHKW/21S/DH/local/SPUND/intLX/HA/scrape"
fl<-list.files(logfolder)
fns<-paste(logfolder,fl,sep="/")
n<-3
#############################
get.content<-function(fns,n){
t<-read_html(fns[n])
main<-xml_find_all(t,'//*[@id="main"]')
t1<-xml_text(main)
ttemp<-tempfile("temptx.txt")
writeLines(t1,ttemp)
t2<-readLines(ttemp)
t2
m1<-grep("ATA.cmd.push",t2)
m2<-grep("\t.+sagt:",t2)
m3<-m2[m2>m1][1]
m4<-m3-1
m5<-grep("document.getElementById",t2)
m6<-m5[length(m5)]
if(is.na(m4))
  m4<-m6
m.out<-c(m1:m4,m6:length(t2))
m.out<-1:length(t2)%in%m.out
sum(m.out)
t2<-t2[!m.out]
t2
txml<-xml_find_all(t,'//*[@id="primary-header"]/div[2]')
xml_text(txml)
txml
tth1<-xml_find_all(txml,".//h1")
ttx<-xml_text(tth1)
tttime<-xml_find_all(txml,".//time")
titx<-xml_text(tttime)
t2<-c(ttx,titx,t2)
t2
m7<-t2==""
t2<-t2[!m7]
t2
return(list(df=data.frame(date=titx,text=paste0(t2,collapse = "\n"))))
}
############
#wks.
t1<-get.content(fns,1)
t2<-get.content(fns,2)
t3<-get.content(fns,3)
t4<-get.content(fns,4)
t5<-get.content(fns,5)

library(quanteda)
c1<-corpus(data.frame(t1$df,t2$df,t3$df,t4$df,t5$df))
summary(c1)
?keywords_collocation
toks<-tokens(c1)
ng4<-tokens_ngrams(toks,n=4,concatenator = " ")
tng<-table(ng4)
m<-grepl("[^a-zA-Z,;.?!]",tng)
tng<-tng[!m]
table(toks)
################################################
# back to reddit, corpus 11/24-03/25
library(utils)
dest<-"~/boxHKW/21S/DH/local/SPUND/intLX/reddit.com.df.cpt.15102.RData"
download.file("https://box.dh-index.org/estee/cloud/reddit.com.df-20250302(18.03).RData",dest)
load(dest)
# 1st scrape
load("~/boxHKW/21S/DH/local/SPUND/intLX/reddit_15494.df.RData")
url.com.df<-rbind(com.df,url.comment.df)
url.time.d<-duplicated(url.com.df$timestamp)
sum(unlist(url.time.d))
url.com.u<-url.com.df[!url.time.d,]
min(url.com.u$date)
max(url.com.u$date)
#t1<-url.com.df$comment
#t1c<-strsplit(t1,"")
tc<-length(unlist(strsplit(url.com.u$comment,""))) # 13.445.500 #15103:17.317.356 chars #
rm(url.com.df)
url.comment.df<-url.com.u
rm(url.com.u)
margin<-116000
########
# chunks
l.df<-tc
# Create the vector
vector <- 1:l.df

# Define the chunk size
chunk_size <- margin  # Example chunk size

# Function to split the vector into chunks of equal length
split_into_chunks <- function(vec, chunk_size) {
  split(vec, ceiling(seq_along(vec) / chunk_size))
}

# Split the vector into chunks
chunks <- split_into_chunks(vector, chunk_size)
k<-2
check.length<-function(tx){
  ltx<-length(unlist(strsplit(tx,"")))
}
# com<-url.comment.df$comment
# author<-url.comment.df$author
# date<-url.comment.df$date
# rm(com)
# rm(date)
# rm(author)
e.ns<-colnames(url.comment.df)%in%c("date","author","comment")
tx.e<-url.comment.df[,e.ns]
tx.e.s<-tx.e[order(tx.e$date,decreasing = F),]
tx.s<-tx.e.s[1,]
tx.s[1,]<-"startdf"
tx.s
k<-1
c.act<-1
c<-1
c
c.act
tx.list<-list()
k
for(k in 1:length(chunks)){
  limit<-chunks[[k]][length(chunks[[k]])]
  tx.list[[k]]<-tx.s
  #print(length(unlist(strsplit(tx.list[[k]]$comment,""))))
  print(c.act<-c-1)
  for(c in c.act:margin){
  tx.list[[k]]<-rbind(tx.list[[k]],tx.e[c,])
  #print(length(unlist(strsplit(tx.list[[k]]$comment,""))))
  l.act<-length(unlist(strsplit(tx.list[[k]]$comment,"")))
  l.df<-length(tx.list[[k]]$author)
  l.df1<-l.df-1
  if(l.act>=margin){
    tx.list[[k]]<-tx.list[[k]][1:l.df1,]
    l.lim<-length(unlist(strsplit(tx.list[[k]]$comment,"")))
    cat("k= ",k,"/ c= ",c,"/ l= ",l.lim,"\n")
    break()
  }
#  cat("k= ",k,"/ c= ",c,"/ l= ",l.lim,"\n")
  
}
}
ex<-tx.list[[1]]
l.x<-length(unlist(strsplit(ex$comment,"")))
save(tx.list,file = "~/boxHKW/21S/DH/local/SPUND/intLX/txlist116k.RData")
# 334 comment dataframes of < 120k chars 
library(writexl)
load("~/boxHKW/21S/DH/local/SPUND/intLX/txlist120k.RData")
i<-1
txdf<-df
txdf$docname<-1
txdf$group<-1
txdf<-lapply(seq_along(1:length(tx.list)), function(i){
  df<-tx.list[[i]]
  df$group<-paste0("reddit-txel")
  df$docname<-i
  df$id<-1:length(df$author)
  com<-c("@group: reddit-docs",paste0(df$docname,".",df$id,"\t",df$comment,collapse = "\n"))
  writeLines(com,paste0("~/boxHKW/21S/DH/local/SPUND/intLX/HA/txdoc/reddit.tx-",i,".txt"))
  
#  doc<-data.frame(group="reddit-txel",docname=i,doc=com)
 # txdf<-rbind(txdf,df)
 # write_xlsx(doc,paste0("~/boxHKW/21S/DH/local/SPUND/intLX/HA/txel/reddit.txdf-",i,".xlsx"))
  return(com)
})
txdf.a<-data.frame(abind(txdf,along = 1))
write_xlsx(txdf.a,paste0("~/boxHKW/21S/DH/local/SPUND/intLX/HA/txel/reddit.txdf.xlsx"))
