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

### 15493.
rgdf<-data.frame()
rgdf[1,1]<-"!1!"
m<-grep(rgdf[1,1],comments$comments)  
length(comments$comments)  
head(comments$comments$comment)  
length(comments$comments$comment)  
# no occurence in subreddit r/unpopularopinion
##############################################
# check
### r/de <!1!>
library(RedditExtractoR)
library(dplyr)
#Replace with the URL of the Reddit post you want to scrape
#url <- "https://www.reddit.com/r/unpopularopinion/"
#url <- "https://www.reddit.com/r/de"

# Extract comments
#comments <- get_reddit(url)
#comments <- get_thread_content(url)
#scrape.comments<-function(){
  url.df<-find_thread_urls(subreddit = "de")
  save(url.df,file = "/Users/guhl/boxHKW/21S/DH/local/SPUND/intLX/reddit_url.df.RData")
  
  #url.df<-urls
  for (k in 1:1){
  comments.100 <- get_thread_content(url.df$url[1:100])
  save(comments.100,file = "/Users/guhl/boxHKW/21S/DH/local/SPUND/intLX/reddit_15493.com100.RData")
  print(100)
  comments.200 <- get_thread_content(url.df$url[101:200])
  save(comments.200,file = "/Users/guhl/boxHKW/21S/DH/local/SPUND/intLX/reddit_15493.com200.RData")
  print(200)
  comments.300 <- get_thread_content(url.df$url[201:300])
  save(comments.300,file = "/Users/guhl/boxHKW/21S/DH/local/SPUND/intLX/reddit_15493.com300.RData")
  print(300)
  
  comments.400 <- get_thread_content(url.df$url[301:400])
  save(comments.400,file = "/Users/guhl/boxHKW/21S/DH/local/SPUND/intLX/reddit_15493.com400.RData")
  print(400)
  k
  comments.5<-data.frame()
  for(k in 402:500){
  comments.5.l <- get_thread_content(url.df$url[k])
  #comments.5<-data.frame(comments.5.l$comments)
  comments.5<-rbind(comments.5,comments.5.l$comments)
  print(k)
  }
  comments.500<-comments.5
  save(comments.500,file = "/Users/guhl/boxHKW/21S/DH/local/SPUND/intLX/reddit_15493.com500.df.RData")
  print(500)
  #comments.6<-data.frame()
  get.comm<-function(run){
  for(k in 1:100){
    f<-run*100
    p<-k+f
    comments.5.l <- get_thread_content(url.df$url[p])
    if(k==1)
      comments.5<-data.frame(comments.5.l$comments)
    comments.5<-rbind(comments.5,comments.5.l$comments)
    print(p)
  }
    return(comments.5)
  }
  comments.600<-get.comm(5)
 # comments.600 <- get_thread_content(url.df$url[501:600])
  save(comments.600,file = "/Users/guhl/boxHKW/21S/DH/local/SPUND/intLX/reddit_15493.com600.df.RData")
  print(600)
  comments.700<-get.comm(6)
  #
#  comments.700 <- get_thread_content(url.df$url[601:700])
  save(comments.700,file = "/Users/guhl/boxHKW/21S/DH/local/SPUND/intLX/reddit_15493.com700.df.RData")
  print(700)
  comments.800<-get.comm(7)
  
  #comments.800 <- get_thread_content(url.df$url[701:800])
  save(comments.800,file = "/Users/guhl/boxHKW/21S/DH/local/SPUND/intLX/reddit_15493.com800.df.RData")
  print(800)
  comments.900<-get.comm(8)
#  comments.9.x <- get_thread_content(url.df$url[1001])
  
#  comments.900 <- get_thread_content(url.df$url[801:900])
  save(comments.900,file = "/Users/guhl/boxHKW/21S/DH/local/SPUND/intLX/reddit_15493.com900.df.RData")
  print(900)
  comments.1000<-get.comm(9)
  
  #comments.1000 <- get_thread_content(url.df$url[901:1000])
  save(comments.1000,file = "/Users/guhl/boxHKW/21S/DH/local/SPUND/intLX/reddit_15493.com1000.RData")
  print(1000)
  
  }
  #save(comments,file = "/Users/guhl/boxHKW/21S/DH/local/SPUND/intLX/reddit_15493.df.RData")
#}
#scrape.comments()
com.df<-data.frame(comments.100$comments)
com.df<-rbind(com.df,comments.200$comments)
com.df<-rbind(com.df,comments.300$comments)
com.df<-rbind(com.df,comments.400$comments)
com.df<-rbind(com.df,comments.500)
com.df<-rbind(com.df,comments.600)
com.df<-rbind(com.df,comments.700)
com.df<-rbind(com.df,comments.800)
com.df<-rbind(com.df,comments.900)
com.df<-rbind(com.df,comments.1000)
com.df<-rbind(com.df,comments.9.x$comments)

head(comments.300$comments)
save(com.df,file = "/Users/guhl/boxHKW/21S/DH/local/SPUND/intLX/reddit_15494.df.RData")
write.csv(com.df,"/Users/guhl/boxHKW/21S/DH/local/SPUND/intLX/reddit_15494.df.RData")
getwd()
writeLines("test123","test.txt")
library(clipr)

regdf<-data.frame()
regdf[1,1]<-"!1!"
m<-grep(regdf[1,1],com.df$comment)
com.df[m,]
head(com.df)
url.df.2<-url.df
url.df$url[grep(".json",url.df$url)]
url.df.2$url<-gsub("\\.json?limit=500","",url.df$url)
url.df$url[510:600]

com.df[10:20,]

### create vertical corpus
library(quanteda)
com.vrt.s<-tokenize_sentence(com.df$comment)
head(com.vrt.s)
#com.vrt.t<-tokenize_word1(com.vrt.s)
library(udpipe)
model<-udpipe::udpipe_load_model("../corpuslx/german-gsd-ud-2.5-191206.udpipe")
com.vrt.t<-udpipe::udpipe_annotate(model,com.vrt.s)
unlist(head(com.vrt.s,20))
x<-com.vrt.s
cor.tok<-udpipe::udpipe_annotate(model,x[[24]])
??udpipe_annotate
as.data.frame(cor.tok)
cat(cor.tok$conllu)
get.ann.df<-function(x){
  cor.tok<-udpipe::udpipe_annotate(model,x)
  return(as.data.frame(cor.tok))
}
##########################################
##########################################
## 2nd annotation essai>
########################
clean<-c("\034","\035","&gt;","\036","&amp","\031","\023","\030","\005","\004","\024","\002","/u","&lt","&lt;","&gt")
x<-com.df[3,]
get.ann.df_ann<-function(x,clean){
  # t.out<-c("\034","\035","&gt;","\036","&amp","\031","\023","\030","\005","\004","\024","\002","/u","&lt","&lt;","&gt")
  #t.out<-paste0(clean,collapse = "|")
  t.out<-clean
  comment<-gsub(t.out," ",x$comment)
  
  cor.tok<-udpipe::udpipe_annotate(model,comment)
 # cor.tok$conllu<-paste0("# timestamp = ",x$timestamp,"\n",cor.tok$conllu)
  df<-as.data.frame(cor.tok)
  df.se<-df[1,]
  df.se[1,]<-""
  df.se$token<-"<s>"
  df.s.end<-df.se
  df.s.end$token<-'</s>'
    cor.tok$conllu
  sent.u<-unique(df$sentence_id)
  sent.u<-sent.u[!is.na(sent.u)]
  s<-1
  df.e<-rbind(df.se,df[df$sentence_id==s,],df.s.end)
  
  for(s in sent.u[2:length(sent.u)]){
    df.es<-df[df$sentence_id==s,]
    if(length(sent.u)>1)
      df.e<-rbind(df.e,df.se,df.es,df.s.end)
  }
  #df.2<-rbind(df.se,df,df.s.end)
  #sent.p<-rbind()
  df<-df.e
  df$timestamp<-x$timestamp
  df$com_id<-x$comment_id
  df$author<-x$author
  df$url<-x$url
  df$date<-x$date
  df$votes<-x$upvotes
  # write.table(cor.tok$conllu,"/Users/guhl/boxHKW/21S/DH/local/SPUND/intLX/cor.tok.csv",sep = "\t",row.names = F,col.names = F,quote = F)
  #l.cor<-length(cor.tok)
  return(df)
}
# length(cor.tok$conllu)
# #com.vrt.t<-get.ann.df(com.vrt.s)
# com.vrt.t.1<-get.ann.df(com.vrt.s[[1]])
# com.vrt.df<-com.vrt.t.1
# for(k in 2:length(com.vrt.s)){
# com.vrt.df<-rbind(com.vrt.df,get.ann.df(com.vrt.s[[k]]))  
# print(k)  
#   
# }
# com.vrt.es.1<-get.ann.df(com.df$comment[1:1000])
# write.csv(com.vrt.es.1[1:1000,],"com.vrt.es-1000.csv")
# save(com.vrt.df,file = "reddit.com.vrt-19502.RData")
# ### 2nd with annotation
# library(pbapply)

cleancomments<-c("\034","\035","&gt;","\036","&amp","\031","\023","\030","\005","\004","\024","\002","/u","&lt","&lt;","&gt","<")
cleancomments<-paste0(cleancomments,collapse = "|")
cleancomments
gsub(cleancomments,"#","try<weg")
k<-2
com.vrt.es.1<-get.ann.df_ann(com.df[1,],cleancomments)
com.vrt.es.1<-rbind("",com.vrt.es.1,"")
com.vrt.es.1$token[1]<-'<text id="doc1">'
com.vrt.es.1$token[length(com.vrt.es.1$token)]<-"</text>"
com.vrt.es.1<-com.vrt.es.1[,df.ns]
colnames(com.vrt.es.1)<-names(df.ns)
#head.doc<-com.vrt.es.1[1,]
k<-3
for(k in 2:1000){
  com.ann<-get.ann.df_ann(com.df[k,],cleancomments)
  com.ex<-rbind("",com.ann,"")
  m<-colnames(com.ex)=="token"
 # com.ex[1,m]<-"<s>"
  #com.ex[length(com.ex$doc_id),m]<-"</s>"
  # reorder
  df.ns<-c(token=6,lemma=7,tag=8,feats=10,sentence=4,tok_id=5,head_tok_id=11,dep_rel=12,doc_id=1,par_id=2,sent_id=3,timestamp=15,date=19,com_id=16,author=17,votes=20,url=18)
  mode(df.ns)
  com.ann<-com.ex[,df.ns]
  colnames(com.ann)<-names(df.ns)
  head.doc<-com.ann[1,]
  #head.doc[1,]<-NA
  head.doc[1,]
  foot.doc<-head.doc
  head.doc$token<-paste0('<text id="doc',k,'">')
  foot.doc$token<-'</text>'
  #head.doc<-head.doc[1,df.ns]
  #colnames(head.d)<-names(df.ns)
  #foot.doc<-foot.doc[,df.ns]
  #colnames(foot.doc)<-names(df.ns)
  doc.ann<-rbind(head.doc,com.ann,foot.doc)
  #head.doc
  #com.ann<-rbind(head())
  com.vrt.es.1<-rbind(com.vrt.es.1,doc.ann)  
  print(k)  
  
}
# chk unique tokens:
com.vrt.es.2<-com.vrt.es.1[!is.na(com.vrt.es.1$token),]
com.vrt.es.2<-com.vrt.es.2[com.vrt.es.2$token!="",]
m<-grepl("<text id",com.vrt.es.2$token)
com.vrt.es.2[m,2:length(com.vrt.es.2)]<-""
m2<-com.vrt.es.2$token=="<s>"|com.vrt.es.2$token=="</s>"
com.vrt.es.2[m2,2:length(com.vrt.es.2)]<-""
sum(m2)
com.vrt.es.3<-rbind("<doc>",com.vrt.es.2,"</doc>")
com.vrt.es.3[1,2:length(com.vrt.es.3)]<-""
com.vrt.es.3[length(com.vrt.es.3$token),2:length(com.vrt.es.3)]<-""
#com.vrt.es.3<-com.vrt.es.3[!m2,]
length(unique(com.vrt.es.2$token)) # 1:1000:9433."".9270." ".9272
length(unique(com.vrt.es.2$lemma)) # 1:1000:7707.7540.7543
ttb<-table(com.vrt.es.1$token)
ttb
#?write.table
write.table(com.vrt.es.2,paste0("/Users/guhl/boxHKW/21S/DH/local/SPUND/intLX/com.vrt.1-1000.txt"),sep = "\t",row.names = F,col.names = F,quote = F)
########################################################
########################################################
# clean up comments before tagging
com.vrt.es.10<-pblapply(com.df[1:10,],get.ann.df_ann)
write.csv(com.vrt.es.1[1:1000,],"com.vrt.es-1000.csv")
save(com.vrt.df,file = "reddit.com.vrt-19502.RData")

###

com.vrt.t.1<-get.ann.df(com.vrt.s[[19503]])
com.vrt.df<-com.vrt.t.1
for(k in 19504:30000){
  com.vrt.df<-rbind(com.vrt.df,get.ann.df(com.vrt.s[[k]]))  
  print(k)  
  
}
save(com.vrt.df,file = "reddit.com.vrt-30000.RData")

com.vrt.t.1<-get.ann.df(com.vrt.s[[30001]])
com.vrt.df<-com.vrt.t.1
for(k in 30002:50000){
  com.vrt.df<-rbind(com.vrt.df,get.ann.df(com.vrt.s[[k]]))  
  print(k)  
  
}
save(com.vrt.df,file = "reddit.com.vrt-50000.RData")

com.vrt.t.1<-get.ann.df(com.vrt.s[[50001]])
com.vrt.df<-com.vrt.t.1
for(k in 50002:70000){
  com.vrt.df<-rbind(com.vrt.df,get.ann.df(com.vrt.s[[k]]))  
  print(k)  
  
}
save(com.vrt.df,file = "reddit.com.vrt-70000.RData")

com.vrt.t.1<-get.ann.df(com.vrt.s[[70001]])
com.vrt.df<-com.vrt.t.1
for(k in 70002:90000){
  com.vrt.df<-rbind(com.vrt.df,get.ann.df(com.vrt.s[[k]]))  
  print(k)  
  
}
save(com.vrt.df,file = "reddit.com.vrt-90000.RData")

com.vrt.t.1<-get.ann.df(com.vrt.s[[90001]])
com.vrt.df<-com.vrt.t.1
for(k in 90002:length(com.df$url)){
  com.vrt.df<-rbind(com.vrt.df,get.ann.df(com.vrt.s[[k]]))  
  print(k)  
  
}
save(com.vrt.df,file = "reddit.com.vrt-end.RData")
save(com.vrt.s,file = "reddit.com.sent.RData")
write.csv(com.vrt.df[1:1000,],"com.vrt.df-1000.csv")
com.sub<-com.vrt.df[1:1000,]

# red.corpus.notes
15497.30.19521 # sentence too long

# local sql
library(RSQLite)
library(RMySQL)
library(DBI)
?DBI::s
db <- dbConnect(SQLite(), "~/boxHKW/21S/DH/local/SPUND/intLX/reddit_comments.sqlite")
chk.db<-function(){
  sql_query<-"SELECT * FROM `reddit.comments`"
  results <- dbGetQuery(db, sql_query)
  sql_query<-"SHOW TABLES;"
  #sql_query<-"START TRANSACTION;"
  results <- RSQLite::dbSendQuery(db, sql_query)
  #results
}
# Read the .sql file
sql_file <- readLines("~/boxHKW/21S/DH/local/SPUND/intLX/reddit_comments.sql")
head(sql_file,70)
# Execute the SQL commands
for (query in sql_file) {
  RSQLite::dbSendQuery(db, query)
}

results<-chk.db()

###
############################################
### annotate DF:
wd<-"~/boxHKW/21S/DH/local/SPUND/intLX"
rcom.df<-read.csv(paste(wd,"reddit_comments1-32.csv",sep = "/"))
load(paste(wd,"reddit_15494.df.RData",sep = "/"))
head(rcom.df)
t.u<-unique(rcom.df$token)
t.tb<-table(rcom.df$token)
t.tb
m<-grep ("[^a-zA-ZäöüÄÖÜß.0-9\\*-\\'!]",t.u)
out.reg<-"[^a-zA-ZäöüÄÖÜß.0-9\\*-\\'!]"
m2<-grep(out.reg,rcom.df$token)
t.out<-c("\034","\035","&gt;","\036","&amp","\031","\023","\030","\005","\004","\024","\002","/u","&lt","&lt;","&gt","<")
t.out<-paste0(t.out,collapse = "|")
t.out
rcom.df$token[m2]<-gsub(t.out,"",rcom.df$token[m2])
t.u<-unique(rcom.df$token)
m<-grep ("[^a-zA-ZäöüÄÖÜß.0-9\\*-\\'!]",t.u)
t.u[m]
t.out<-c("\034","\035","&gt;","\036","\032","&amp","\031","\023","\030","\005","\001","\004","\024","\002","/u","&lt","&lt;","&gt","&20")

rcom.ns<-colnames(rcom.df)
rcom.ns
rcom.in<-c(1,2,3,4,5,6,7,8,10,11,12)
rcom.dff<-rcom.df[,rcom.in]
head(rcom.dff)
rm(rcom.df)

l.df<-length(com.df$url)
chunks<-ceiling(l.df/1000)
# Create the vector
vector <- 1:l.df

# Define the chunk size
chunk_size <- 500  # Example chunk size

# Function to split the vector into chunks of equal length
split_into_chunks <- function(vec, chunk_size) {
  split(vec, ceiling(seq_along(vec) / chunk_size))
}

# Split the vector into chunks
chunks <- split_into_chunks(vector, chunk_size)
k<-1
k
#pos
#pos<-chunk.range[1]
rcom.dff$df_id<-NA
rcom.dff$date<-NA
rcom.dff$author<-NA
rcom.dff$com_id<-NA
rcom.dff$url<-NA
###########################
for(k in 1:length(chunks)){
  chunk.range<-chunks[[k]]
  
  for(pos in 1:length(chunk.range)){
  chunk.ex<-com.df[chunk.range[pos],]
  chunk.pos<-paste0(k,".",pos)
  m<-rcom.dff$doc_id==chunk.pos
  sum(m)
  rcom.dff$date[m]<-chunk.ex$date
  rcom.dff$df_id[m]<-rownames(chunk.ex)
  rcom.dff$author[m]<-chunk.ex$author
  rcom.dff$com_id[m]<-chunk.ex$comment_id
  rcom.dff$url[m]<-chunk.ex$url
  print(chunk.pos)
  }
}
#save(rcom.dff,file = "rcom.dff-annotated.RData")
load("rcom.dff-annotated.RData")
getwd()
rcom.sub<-rcom.dff[!is.na(rcom.dff$date),]
rcom.sf<-rcom.dff
#rcom.dff<-rcom.sub
#rcom.dff<-rcom.sf
## create .vrt:
#rcom.dff$doc_id<-reddit_comments1_32$doc_id
id.u<-unique(rcom.dff$doc_id)
head(id.u,20)
rcom.dff$c_id<-gsub("\\.","_",as.character(rcom.dff$doc_id))
mode(rcom.dff$doc_id)<-"character"
#mode(rcom.sf$)
which(rcom.dff$c_id=="1_20")
id.u
mode(id.u)
id.u.c<-as.character(id.u)
id.u.s<-id.u[order(id.u)]
id.u.s[1:20]
which(id.u=="1.100")
colnames(rcom.dff)
library(clipr)
write_clip(paste("ATTRIBUTE",colnames(rcom.dff),sep = "\t"))
id.i<-3
#rcom.cols<-c()
###############################
library(readr)
 for (id.i in 2:length(id.u)){
#id.i<-2
#for (id.i in 2:12){
  #vrt.sample<-rcom.dff[rcom.dff$doc_id==ex[1],]
id<-id.u[id.i]
id
vrt.sample<-rcom.dff[rcom.dff$doc_id==id,]
vrt.sample.s<-unique(vrt.sample$sentence)
vrt.sample.s
#vrt.htm<-list()
k<-2
k
vrt.htm<-tempfile("vrthtm")
vrt.temp<-tempfile("vrtemp")
for(k in 1:length(vrt.sample.s)){
#  m<-rcom.dff$sentence==vrt.sample.s[k]
  m<-vrt.sample$sentence==vrt.sample.s[k]
  sum(m)
#vrt.htm[[k]]<-paste0("<s>",rcom.dff[m,],"</s>")
#rbind("<s>",rcom.dff[m,],"</s>")
# vrt.temp<-tempfile("vrtemp")
#library(readr)
r.ns<-colnames(vrt.sample)
m.2<-r.ns=="token"
r.ns[m.2]<-"word"
r.ns
#write.table(rcom.dff[m,],vrt.temp,sep = "\t",row.names = F,col.names = F,quote = F)
vrt.sample.m<-vrt.sample[m,c(6,7,1:3,8:15)]
write.table(vrt.sample.m,vrt.temp,sep = "\t",row.names = F,col.names = F,quote = F)
# writeLines(vrt.sample.m,paste0("/Users/guhl/boxHKW/21S/DH/local/SPUND/corpuslx/intLX/vrt4/com.df_",id,".txt"))
#?write.csv
head(vrt.sample.m)
vrt.get<-readLines(vrt.temp)
vrt.get<-vrt.sample.m
r.ns<-colnames(vrt.sample.m)
r.ns
m.2<-r.ns=="token"
r.ns[m.2]<-"word"
colnames(vrt.sample.m)<-r.ns
write_clip(paste("ATTRIBUTE",colnames(vrt.sample.m),sep = "\t"))
vrt.get<-paste0("<s>",vrt.get,"</s>")
head(vrt.get)
vrt.get
write.table(vrt.get,vrt.htm,sep = "\t",row.names = F,col.names = F,append = T,quote = F)
write.table(vrt.get,paste0("/Users/guhl/boxHKW/21S/DH/local/SPUND/corpuslx/intLX/vrt4/com.df_",id,".txt"),sep = "\t",row.names = F,col.names = F,append = T,quote = F)
write.table(vrt.get,paste0("/Users/guhl/boxHKW/21S/DH/local/SPUND/corpuslx/intLX/vrt4/com.df_",id,".txt"),sep = "\t",row.names = F,col.names = F,quote = F)
# writeLines(vrt.get,paste0("/Users/guhl/boxHKW/21S/DH/local/SPUND/corpuslx/intLX/vrt4/com.df_",id,".txt"))
#}
htm.get.l<-readLines(vrt.htm)
head(htm.get.l)
htm.get.l
htm.get.l<-gsub('"',' ',htm.get.l)
#tt.doc<-c(paste0('<doc id="',id,'">'),htm.get,'</doc>')
tt.doc<-htm.get.l
writeLines(tt.doc,paste0("/Users/guhl/boxHKW/21S/DH/local/SPUND/corpuslx/intLX/vrt3/com.df_",id,".txt"))
cat(id,mode(id),"\n")
}
}
id
### combine files:
f<-list.files("~/boxHKW/21S/DH/local/SPUND/corpuslx/intLX/vrt2")
f.p<-paste("~/boxHKW/21S/DH/local/SPUND/corpuslx/intLX/vrt2",f,sep = "/")
k<-1
f.list<-list()
for(k in 1:length(f.p)){
  t<-readLines(f.p[k])
  t<-c(paste0('<doc id="',k,'">'),t,"</doc>")
  t
  f.list[[f[k]]]<-t
  write.table(t,"/Users/guhl/boxHKW/21S/DH/local/SPUND/corpuslx/intLX/vrt5/source",sep = "\t",row.names = F,col.names = F,append = T,quote = F)
  
  print(k)
}
library(abind)
f.list.a<-abind(f.list,along=1)
write_clip(paste("ATTRIBUTE",colnames(rcom.sf),sep = "\t"))
save(f.list,file = "rcom.list.cpt.RData")

### reorder table for cqp
rdf.5<-read.table("/Users/guhl/boxHKW/21S/DH/local/SPUND/corpuslx/intLX/vrt5/source")
rdf.5<-read.csv("/Users/guhl/boxHKW/21S/DH/local/SPUND/corpuslx/intLX/vrt5/source",sep = "\t",col.names = 1:16)
save(rdf.5,file = "~/boxHKW/21S/DH/local/SPUND/intLX/vrt/cqp.vrt.RData")
rdf.6<-rdf.5[c(6,7,8,1:5,9:length(rdf.5))]
write.table(rdf.6,"/Users/guhl/boxHKW/21S/DH/local/SPUND/corpuslx/intLX/vrt5/rdf6.cwb.vrt",col.names = F,row.names = F,quote = F)
head(rdf.5)
head(rdf.6)
tail(rdf.6)
rdf.7<-rbind('<doc id="1">',rdf.5[1:length(rdf.5$X1),])
head(rdf.7)
rdf.7[1,2:length(rdf.7)]<-""
rdf.8<-rdf.7[,c(6,7,8,1:5,9:length(rdf.7))]
write.table(rdf.8,"/Users/guhl/boxHKW/21S/DH/local/SPUND/corpuslx/intLX/vrt5/rdf5.cwb.vrt",col.names = F,row.names = F,quote = F)

###
load("~/boxHKW/21S/DH/local/SPUND/intLX/rcom.list.cpt.RData")
library(abind)
f.list.a<-data.frame(abind(f.list,along=1))

### combine files:
f<-list.files("~/boxHKW/21S/DH/local/SPUND/corpuslx/intLX/vrt2")
f.p<-paste("~/boxHKW/21S/DH/local/SPUND/corpuslx/intLX/vrt2",f,sep = "/")
k<-1
f.list.1<-list()
library(stringi)
ns<-stri_extract_all_regex(f.p,"_[0-9]*.[0-9]*.txt",simplify = T)
ns<-gsub("[_txt]","",ns)
ns<-gsub("\\.$","",ns)
head(ns)
ns.s<-stri_split(ns,regex = "\\.")
library(clipr)
write_clip(head(ns.s))
# Convert the character vectors to a data frame with numeric values
df <- do.call(rbind, lapply(ns.s, function(x) as.numeric(x)))
df <- as.data.frame(df)

# Sort the data frame by the first and second columns
sorted_df <- df[order(df$V1, df$V2), ]
ns.rowsort<-rownames(sorted_df)
head(ns.so)
# Convert the sorted data frame back to a list of character vectors
sorted_list <- apply(sorted_df, 1, function(x) as.character(x))
### files list sorted increasing number, not alphabetically
# Print the sorted list
print(head(sorted_list))
head(ns.o)
head(ns.s)
as.double(ns)
ns[order(as.double(ns))]
library(stringi)
f.p.s<-f.p[as.double(ns.rowsort)]
f.p.s[10]
k<-98
################
f.p.s[k]
df3<-read.table(f.p.s[1],skip = 1)
f.list.2<-list()
for(k in 1:length(f.p.s)){
  t<-readLines(f.p.s[k])
  ns<-stri_extract_all_regex(f.p.s[k],"_[0-9]*.[0-9]*.txt",simplify = T)
  ns<-gsub("[_txt]","",ns)
  ns<-gsub("\\.$","",ns)
  ns<-as.character(ns)
  t<-c(paste0('<doc id="',ns,'">'),t,"</doc>")
  #?read.csv
  t.df<-read.csv(f.p.s[k],sep = "\t",col.names = 1:16,flush = T,fill = T)
  #m<-grep("1.100",t.df$X1)
  #ml<-grepl("1.100",t.df$X1)
  m<-which(t.df$X1==ns)
  ml<-t.df$X1==ns
  ml1<-c(T,T,ml,T)
  sum(ml1)
  #m2<-m+2
  t.df$X14[ml]
  t.df$X14[m[1]]
  t2<-t[ml]
  df.ns<-c(token=6,lemma=7,tag=8,feats=9,sentence=4,tok_id=5,head_tok_id=10,ex=12,doc_id=1,
           par_id=2,sent_id=3,com_id=15,date=13,author=14,url=16)
  #t2[m]
  tail(t2)
  head(t2)
  t2<-t2[df.ns]
  f.list.2[[k]]<-t2
  dir.create("/Users/guhl/boxHKW/21S/DH/local/SPUND/corpuslx/intLX/vrt8/")
  write.table(t2,"/Users/guhl/boxHKW/21S/DH/local/SPUND/corpuslx/intLX/vrt8/source",sep = "\t",row.names = F,col.names = F,append = T,quote = F)

  print(k)
}

f.list.1[[2]]
save(f.list.2,file = "~/boxHKW/21S/DH/local/SPUND/intLX/flist2.RData")
###
# try reorder into dataframe
?read_clip_tbl
library(clipr)
df1<-data.frame(read_clip_tbl(write_clip(f.list.1[[1]][[4]]),header =F))
df1
get.df<-function(x){
  data.frame(read_clip_tbl(write_clip(x[[4]]),header =F,sep="\t"))
}
df2<-rbind(lapply(f.list.1, get.df))
f.list.r<-f.list.1
k<-2
df.order<-c(6,7,8,9,4,5,10,12,1,2,3,15,13,14,16)
df.ns<-c("token","lemma","tag","feats","sentence",)
df.ns<-c(token=6,lemma=7,tag=8,feats=9,sentence=4,tok_id=5,head_tok_id=10,ex=12,doc_id=1,
         par_id=2,sent_id=3,com_id=15,date=13,author=14,url=16)
for(k in 1:length(f.list.1)){
  df2<-data.frame(read_clip_tbl(write_clip(f.list.1[[k]]),skip=1,header =F,sep="\t"))
  df2<-df2[df.ns]
  colnames(df2)<-names(df.ns)
  f.list.r[[k]][[4]]<-df2
  doc<-df2$doc_id
  df3<-c
}
df2
### reorder table for cqp
rdf.5<-read.table("/Users/guhl/boxHKW/21S/DH/local/SPUND/corpuslx/intLX/vrt6/source")
rdf.5<-read.csv("/Users/guhl/boxHKW/21S/DH/local/SPUND/corpuslx/intLX/vrt5/source",sep = "\t",col.names = 1:16)
save(rdf.5,file = "~/boxHKW/21S/DH/local/SPUND/intLX/vrt/cqp.vrt.RData")
rdf.6<-rdf.5[c(6,7,8,1:5,9:length(rdf.5))]
write.table(rdf.6,"/Users/guhl/boxHKW/21S/DH/local/SPUND/corpuslx/intLX/vrt5/rdf6.cwb.vrt",col.names = F,row.names = F,quote = F)
head(rdf.5)
head(rdf.6)
tail(rdf.6)
rdf.7<-rbind('<doc id="1">',rdf.5[1:length(rdf.5$X1),])
head(rdf.7)
rdf.7[1,2:length(rdf.7)]<-""
rdf.8<-rdf.7[,c(6,7,8,1:5,9:length(rdf.7))]
write.table(rdf.8,"/Users/guhl/boxHKW/21S/DH/local/SPUND/corpuslx/intLX/vrt5/rdf5.cwb.vrt",col.names = F,row.names = F,quote = F)
f.p[1]
f[1]
f[order(f)]
f[order(f,method = "quick")]
?order
f[1]
t1<-read.table(f.p[1],col.names = 1:20,fill = T)

install.packages("RcppCWB")
library(RcppCWB)
cwb_makeall("~/boxHKW/21S/DH/local/SPUND/intLX/com.vrt.1-1000.txt","word",paste(rg,"rdf1",sep = "/"))
Sys.getenv("CORPUS_REGISTRY")
write_clip(paste0("-P ",colnames(com.vrt.es.3),collapse = " "))

cqp_initialize()
cqp_list_corpora()
rg<-"/Users/guhl/pro/cwb/registry/"
cqp_reset_registry(rg)
cl<-cqp_load_corpus("RGRDF2",rg)
cl<-cqp_load_corpus("REDDIT",rg)
cqp_query(corpus="RGRDF2",query = '[word="dumm"];')
cqp_query(corpus="REDDIT",query = '[word="dumm"];')
cqp_subcorpus_size("REDDIT",subcorpus = "QUERY")
cqp_dump_subcorpus("REDDIT")
cqp_dump_subcorpus("RGRDF2")
# Get the number of matches
num_matches <- cqp_subcorpus_size("REDDIT","QUERY")

# Extract the matches
matches <- cqp_dump_subcorpus("REDDIT", "QUERY")

# Convert the matches to a data frame
results_df <- as.data.frame(matches, stringsAsFactors = FALSE)

# Extract the matches
matches <- cqp_dump_subcorpus(corpus, 0, num_matches - 1)
matches
#cpos_to_str("word",matches[1,])
# Initialize an empty list to store KWIC results
kwic_list <- list()

# Loop through each match to extract KWIC
for (i in 1:nrow(matches)) {
  match <- matches[i, ]
  left_context <- cqp_context("REDDIT", match[1], left_context_size, "left")
  right_context <- cqp_context("REDDIT", match[2], right_context_size, "right")
  keyword <- cqp_context("REDDIT", match[1], 0, "keyword")
  
  kwic_list[[i]] <- data.frame(
    left_context = paste(left_context, collapse = " "),
    keyword = paste(keyword, collapse = " "),
    right_context = paste(right_context, collapse = " "),
    stringsAsFactors = FALSE
  )
}

# Combine the list into a data frame
kwic_df <- do.call(rbind, kwic_list)

# Print the KWIC data frame
print(kwic_df)

com.vrt.es.3[47970,]

# cop
# Initialize the corpus
library(RcppCWB)
corpus <- "RGRDF2"
rg<-"/Users/guhl/pro/cwb/registry/"
registry <- rg

# Load the corpus
#cl <- corpus_load(corpus, registry)
cl<-cqp_load_corpus("RGRDF2",rg)
query = '[lemma="ich"][lemma="haben"&timestamp=".*"];'
# Perform a KWIC query
#query <- "your_query_term"
cqp_query(corpus,query)
#cqp_query(corpus,"set Context s;")
#cqp_query(corpus,query='show;')
cqp_subcorpus_size("RGRDF2",subcorpus = "QUERY")
#sc
ids<-cqp_dump_subcorpus("RGRDF2")
#ids<-cqp_dump_subcorpus("QUERY")
ids
#id2str("RGRDF2","word",rg,id=ids)
#kwic_results <- cl_kwic(cl, query, left = 5, right = 5)  # Adjust left and right context as needed

# Convert the results to a data frame
kwic_df <- data.table(
  left_context = sapply(kwic_results, function(x) paste(x$left, collapse = " ")),
  keyword = sapply(kwic_results, function(x) paste(x$node, collapse = " ")),
  right_context = sapply(kwic_results, function(x) paste(x$right, collapse = " "))
)

# Display the KWIC dataframe
print(kwic_df)

############################
### new nosketch vrt essai

text.dir<-"~/Documents/GitHub/SPUND-LX/play/data"
f<-list.files(text.dir)
fns<-paste(text.dir,f,sep = "/")
library(tools)
library(pbapply)
library(abind)
fns.e<-file_ext(fns)=="txt"
fns<-fns[fns.e]
get.sent.div<-function(id,n){
  df<-pos.df
  m<-df$doc_id==id
  cat(id,".",n,"\n")
  #m<-doc.u==p
  doc.here<-which(m)
  m
  df.es<-df[m,]
  s.id<-df.es$sentence_id[1]
  df.start<-df.es[1,]
  df.start[1,]<-""
  # s.tag<-paste0('<s timestamp="',x$timestamp,'" sent_id ="',paste0(chunk,'.',x$comment_id),'.',s.id,'" author="',x$author,'" url="',x$url,'" url_id="',chunk,'" date="',x$date,'" upvotes="',x$upvotes,'">')
  s.tag<-paste0('<doc id="',n,'">')
  t.u<-unique(s.tag)
  s.tag.s<-s.tag[1]
  s.tag.s
  df.start$token<-s.tag.s
  df.end<-df.start
  df.end$token<-'</doc>'
  df.out<-rbind(df.start,df.es,df.end)
  write.table(df.out,paste0("testout/vrt-",n,".csv"))
  
  return(data.frame(df.out))
}
  fetch.pos<-function(file,fn){
  t<-readLines(file)
  pos.l<-get.ann.df(model.dir = "~/Documents/GitHub/SPUND-LX/intLX/createcorp/modeldir",input = t,output = F)
  pos.df$doc_id<-paste0("url",fn,".",pos.l$doc_id)
  doc.id<-pos.df$doc_id
  doc.id.u<-unique(doc.id)
  df.ex.l<-pblapply(seq_along(doc.id.u), function(i) {
    get.sent.div(doc.id.u[[i]], i)
  })
  # write.table(as.data.frame(df.ex.l,paste0("testout-",fn,".csv")))
  return(df.ex.l)
  }
#       return(pos.df)
# }
#?lapply
# Use lapply() with an anonymous function to pass both the element and its index
# my_function <- function(element, index) {
#   return(paste("Element:", element, "Index:", index))
# }
# 
# result <- lapply(seq_along(my_list), function(i) {
#   my_function(my_list[[i]], i)
# })
df.ex.l<-pblapply(seq_along(fns), function(i) {
    fetch.pos(fns[[i]], i)
  })
df.ex<-abind::abind(df.ex.l,along = 1)
df.ex<-data.frame(df.ex)

### nosketch corpus created in devbox
# read in corpus
red.vrt<-read.csv("https://box.dh-index.org/estee/cloud/reddit4.vrt.csv",sep = "\t",col.names = 1:16)
t<-readLines("https://box.dh-index.org/estee/test.txt")
t<-readLines("~/downloads/reddit4.sandbox.source.vrt")
teihead<-'<?xml version="1.0" encoding="UTF-8"?>'
t<-c(teihead,'<TEI>',t,'</TEI>')
t[86:95]
tg<-t[86:95]
tg
#gsub("(^&gt;?)|(^.&gt;?).*","",tg)
m<-grepl("(^&gt;?)|(^.&gt;?)",tg)
m<-grepl("&gt",tg)
m<-grepl("&gt",t)
sum(m)
t[!m]
#t2<-gsub("^&gt;?.*","",t)
t2<-t[!m]
t2<-gsub("\u001E","",t2)

#library(xml2)
#temp.xml<-tempfile("temp.xml")
writeLines(t2,temp.xml)
tei<-read_xml(temp.xml)
writeLines(t2,"~/boxHKW/21S/DH/local/SPUND/intLX/data/reddit4.vrt.xml")
tei<-read_xml("~/boxHKW/21S/DH/local/SPUND/intLX/data/reddit4.vrt.xml")
### too many xml mistakes, not possible...
tdf<-read.csv("~/downloads/reddit4.sandbox.source.vrt",sep = "\t",col.names = 1:16)
rm(tdf)
reddit.pos.df<-read.csv("~/downloads/reddit4.sandbox.source.vrt",sep = "\t",col.names = 1:16)
save(reddit.pos.df,file="reddit.pos.df.RData")
rdns<-"/volumes/ext/boxhkw/21s/dh/local/spund/intlx/data/reddit.pos.df.RData"
load(rdns)
file.size(rdns)/1000/1000
rdf<-reddit.pos.df
rm(reddit.pos.df)
rdf[1,]
head(rdf)
file.size()
rdf2<-rdf(,c(1:10,12:16))
library(utils)
object.size(rdf2)/1000/1000
rdf2<-rdf[,c(1:10,12:16)]
library(readr)
write.table(rdf2,"/volumes/ext/boxhkw/21s/dh/local/spund/intlx/data/reddit4.df.csv",sep = "\t",col.names = F,row.names = F,quote = F)

### corpus linguistic patterns (pos)

library(dplyr)
library(tidytext)
library(janeaustenr)
library(tibble)
d <- tibble(txt = prideprejudice)

ng<-d %>%
  unnest_ngrams(word, txt, n = 4)

ng<-d %>%
  unnest_skip_ngrams(word, txt, n = 4, k = 1)
ng<-d %>%
  unnest_skip_ngrams(word, txt, n = 3, k = 1)

ng<-d%>% unnest_tokens(output=ngram,input=txt,to_lower = T,token="ngrams",n=4)
ng.u<-unique(ng$ngram)
ngt<-table(ng$ngram)
ngt[max(ngt)]
#ng.df<-data.frame(ngram=names(ngt),count=ngt)
ngdf<-data.frame(ngt)
# wks.
# now for pos
?tibble
get.ann.df<-function(x,pos,stop){
  tdf<-x
  m<-tdf%in%stop
  tdf<-tdf[!m]
  d <- tibble(txt = paste0(tdf[pos],collapse = " "))
  
  m<-d
  ng<-d%>% unnest_tokens(output=ngram,input=txt,to_lower = F,token="ngrams",n=4)
  ng.u<-unique(ng$ngram)
  ngt<-table(ng$ngram)
  #ngt[max(ngt)]
  #ng.df<-data.frame(ngram=names(ngt),count=ngt)
  ngdf<-data.frame(ngt)
}
k<-1
loaddata<-function(k){
  load(paste0("~/boxHKW/21S/DH/local/AVL/2024/WIT/wolf/ldf",k,".RData"))
  ngdf<-get.ann.df(ldf)
}
ng1<-loaddata(1)  

### with reddit corpus
load("~/boxhkw/21s/dh/local/spund/intlx/data/reddit.pos.df.RData")
colnames(reddit.pos.df)
head(reddit.pos.df)

ng2<-get.ann.df(reddit.pos.df,"X1",st1)
ng2<-ng2[order(ng2$Freq,decreasing = T),]
head(ng2,20)

st1<-unlist(strsplit(as.character(ng2$Var1[1:3])," "))
length(stopwords)
st2<-strsplit(st1," ")
factor(ng2$Var1[1:3])
as.character(ng2$Var1[1:3])
unlist(st1)
