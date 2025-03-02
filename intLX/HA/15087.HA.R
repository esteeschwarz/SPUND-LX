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
