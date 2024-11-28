#20241103(13.19)
#15452.interN-LX.corpus.essai
#############################
q<-"https://www.dwds.de/r/?q=plagiat&corpus=dwdsxl&date-start=1897&date-end=2024&sc=adg&sc=bz&sc=blogs&sc=bundestag&sc=ddr&sc=tsp&sc=kern&sc=kern21&sc=gesetze&sc=spk&sc=politische_reden&sc=untertitel&sc=wikibooks&sc=wikipedia&sc=wikivoyage&format=max&sort=date_asc&limit=3000&view=csv"
d1<-read.csv(q)
# TASK: corpus generation to explore metaphors for "plagiat"
date.range<-unique(d1$Date)
### metaphor extraction
# approach: 
# 1. tag for nouns
library(udpipe)
# corpus object
df<-data.frame(kwic=paste(d1$ContextBefore,d1$Hit,d1$ContextAfter))
head(df)
model.f<-"~/boxHKW/21S/DH/local/SPUND/corpuslx/german-gsd-ud-2.5-191206.udpipe"
#model.f<-udpipe_download_model("german")

model.g<-udpipe_load_model(model.f$file_model)
typeof(model.g)
model.g
d2<-udpipe_annotate(model.g,df$kwic)
d3<-as.data.frame(d2)
extract.metaphors<-function(d3){
  m1<-d3$lemma=="Plagiat"
  sum(m1,na.rm = T) # 2291
  m2<-d3$upos=="NOUN"
  p1<-which(m1)+10
  p2<-which(m1)-10
  head(m1)
  head(p2)
  r1<-mapply(seq,p2,p1) # range
  r1<-unlist(r1)
  m3<-which(m2)
  m4<-m3%in%r1
  n1<-unique(d3$lemma[m3[m4]])
  n1<-n1[order(n1)]
  n2<-data.frame(noun=n1,metaphor=0)
  #n3<-order(n2,n2$noun)
  #n3<-fix(n2)
  m6<-grep("plag|Plagiat",n3$noun)
  n3$metaphor[m6]<-0
  n4<-n3$noun[n3$metaphor==1]
  n4
  getwd()
  write.csv(n3,"data/plagiat-noun-range.csv")
  write.csv(n4,"data/plagiat-metaphor-range.csv")
  m5<-d3$lemma[m3[m4]]%in%n4
  d3$token[m3[m4]][m5]
  d5<-d3
  d5$token[m3[m4]][m5]<-paste0("<#>",d5$token[m3[m4]][m5],"<#>")
  d5$sentence[m3[m4]][m5]<-mapply(gsub,d3$token[m3[m4]][m5],d5$token[m3[m4]][m5],d5$sentence[m3[m4]][m5])
head(d5$sentence[m3[m4]][m5])
head(d5$token[m3[m4]][m5])
head(d3$token[m3[m4]][m5])
d6<-unique(d5$sentence[m3[m4]][m5])
d7<-strsplit(d6,"<#>")
d8<-lapply(d7,unlist)
d8<-matrix(unlist(d7),ncol = 3)
d9<-d5$date[m3[m4]][m5]
  head(d6)
  write.csv(d6,"data/plagiat-metaphor-sentence.csv")
}
length(unique(d5$doc_id))
d5$id<-gsub("doc","",d5$doc_id)
x<-d5$id[1]
get.date<-function(x){
  m<-x==d1$No.
  d1.date<-unique(d1$Date[m])
  d1.year<-strsplit(d1.date,"-")[[1]][1]
}

m6.date<-lapply(d5$id,get.date)
head(m6.date)
d5$date<-unlist(m6.date)
# plot over years
d9<-d5$date[m3[m4]][m5]
head(d9)
#d10<-strsplit(d5$date,"-")
head(d10)
save(d5,file = "d5.token-df.RData")

### sketchengine
d11<-read.csv("/Users/guhl/boxHKW/21S/DH/local/SPUND/corpuslx/intLX/ske_plagiat.csv",skip = 4)

### nexis
library(LexisNexisTools)
?lnt_read
d12<-lnt_read("/Users/guhl/boxHKW/21S/DH/local/SPUND/corpuslx/intLX/nexis-plagiat.DOCX")
head(d12)
d13<-lnt_convert(d12,"data.frame","articles")

### mastodon query

cred<-read.csv("~/boxHKW/21S/DH/local/R/cred_gener.csv")
m<-grep("mastodon",cred$q)
mkey<-cred$key[m]
server<-cred$url[m]
query<-"hamas"
output.csv<-paste0("~/boxHKW/21S/DH/local/SPUND/intLX/mastodon_query-",query,"-.csv")
arguments<-paste0(mkey,' ',server,' ',query,' ',output.csv)
arguments
system(paste0('python ~/boxHKW/21S/DH/local/SPUND/intLX/mastodon-query.py ',arguments))
dm<-read.csv(output.csv)

### reddit scrape
# install.packages("RedditExtractoR")
# install.packages("dplyr")
library(RedditExtractoR)
library(dplyr)
#Replace with the URL of the Reddit post you want to scrape
url <- "https://www.reddit.com/r/unpopularopinion/"

# Extract comments
#comments <- get_reddit(url)
#comments <- get_thread_content(url)
scrape.comments<-function(){
url.df<-find_thread_urls(subreddit = "unpopularopinion")
#url.df<-urls
comments <- get_thread_content(url.df$url)
save(comments,file = "/Users/guhl/boxHKW/21S/DH/local/SPUND/intLX/reddit.df.RData")
}
### > RUN >

load("/Users/guhl/boxHKW/21S/DH/local/SPUND/intLX/reddit.df.RData")
rgdf<-data.frame()
rgdf[1,1]<-"okay|\\boki\\b|\\boke\\b|\\bokey|\\bokee|okidoki|o\\.k\\.|\\bokk\\b|\\bokkk\\b"
# get.okay<-function(x){
#   m<-grep(rgdf[1,1],x$comment)
#   return(x$comment[m])
#   
# }
s<-c("smokedry and nuts","oke","okay")
grep("okay|oke\\b|dumm",s)
#com.m<-lapply(comments, get.okay)
#head(com.m$comments)
com.df<-data.frame(comments$comments,okay=0)
m<-grep(rgdf[1,1],com.df$comment)
#m<-grep("okay",com.df$com.comment)
com.ok.sub<-com.df[m,]
head(com.ok.sub$comment)
### wks.
# get [okay] at line start
library(quanteda)
#?tokenize
#library(purrr)
com.tok<-tokenize_word1(com.ok.sub$comment)
library(stringi)

#ok.pos<-stri_split(com.ok.sub$comment[1],regex=rgdf[1,1])
rgdf[2,1]<-"That|that|That's|that's|that\031s|I'm|It's|it's|Its|its"
limit.ok<-4
ok.get<-function(x){
  m<-grep(rgdf[1,1],x)[1]<=limit.ok
  m[is.na(m)]<-FALSE
  return(m)
}
ok.out<-function(x){
m<-grep(rgdf[2,1],x)[1]<=limit.ok
#m<-unlist(m)
m[is.na(m)]<-FALSE
return(m)
}
com.tok[3]
com.ok.sub$comment[7]
ok.no<-lapply(com.tok, ok.out)
ok.no<-unlist(ok.no)
com.tok.p<-com.tok[unlist(ok.no)]
ok.pos<-lapply(com.tok, ok.get)
ok.s<-unlist(ok.pos)
length(ok.s)
which(ok.s)
which(ok.no)
#ok.s<-unlist(ok.pos)<=limit.ok
com.ok.sub$okay[unlist(ok.s)]<-1
sum(unlist(ok.no))
which(ok.s)
which(ok.no)
com.ok.sub$comment[ok.s]
com.ok.sub$comment[ok.no]
#ok.no<-unlist(ok.no)
com.ok.pos<-which(ok.s)%in%which(ok.no)
which(com.ok.pos)
length(com.ok.pos)
sum(com.ok.pos)
ok.s[which(com.ok.pos)]
#ok.s[which(com.ok.pos)]<-F
com.ok.sub$comment[ok.s]
sum(ok.s)
com.ok.cl<-ok.s
#com.ok.cl<-which(unlist(ok.s)[!com.ok.pos])
com.ok.sub$okay<-0
com.ok.sub$okay[ok.s]<-1
com.ok.sub$okay[ok.no]<-0
com.ok.sub$comment[com.ok.sub$okay==1]
com.ok.cl<-com.ok.sub$comment[com.ok.pos]
com.ok.cl
com.ok.extract<-com.ok.sub$comment[com.ok.sub$okay==1]
head<-paste0("@comment extraction: ",url)
com.ok.extract.t<-c(head,"",paste(1:length(com.ok.extract),sep = ". ",com.ok.extract))
writeLines(com.ok.extract.t,"data/extract-comments.txt")
save(com.ok.extract,file = "data/com.ok.extract.RData")

### get preceding comment:
com.id<-as.double(row.names(com.ok.sub))
com.id.pre<-com.id-1
com.m<-com.ok.sub$okay
m<-row.names(com.df)%in%com.id.pre
which(m)
com.pre<-com.df$comment[which(m)]
com.ok.sub$comment.preceding<-com.pre
save(com.ok.sub,file = "data/com.df_wt_pre.RData")
# stri_ex
# stri_extract_all_regex(com.ok.sub$comment[1],"\\boke\\b")
#Filter comments containing the keyword "example"
# filtered_comments <- comments %>%
#   filter(grepl("okay", comment_body, ignore.case = TRUE))
# 
# # View the filtered comments
# head(filtered_comments)
# #Filter comments with more than 10 upvotes
# popular_comments <- comments %>%
#   filter(upvotes > 10)
# 
# # View the popular comments
# head(popular_comments)
# 
# #Filter by comment length:
# 
# # Filter comments longer than 100 characters
# long_comments <- comments %>%
#   filter(nchar(comment_body) > 100)
# 
# # View the long comments
# head(long_comments)
# 
# #–	Filter by username:
# # Filter comments by a specific user
# user_comments <- comments %>%
#   filter(author == "specific_username")
# 
# # View the user's comments
# head(user_comments)

### swiss chat corpus
library(readr)
d1<-read_delim("data/annis-export-20.csv", 
                              delim = "\t", escape_double = FALSE, 
                              col_names = c("id","label","msg"), trim_ws = TRUE)
d1.sm<-sample(d1$msg,100)
write.csv(d1.sm,"data/swisschat_sample.csv")
save(d1.sm,file="data/swisschat_sample.RData")

  
  
  
  
