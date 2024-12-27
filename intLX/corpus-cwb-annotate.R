# 20241224(13.42)
# 15524.reddit.cwb.corpus.annotation
####################################
wd<-"~/boxHKW/21S/DH/local/SPUND/intLX"
load(paste(wd,"reddit_15494.df.RData",sep = "/"))

library(udpipe)
model<-udpipe::udpipe_load_model(paste(wd,"../corpuslx/german-gsd-ud-2.5-191206.udpipe",sep = "/"))
##################################
## test
x<-com.df[1,]
clean<-cleancomments
##
chunk
get.ann.df_ann<-function(x,clean,chunk){
  t.out<-clean
  comment<-gsub(t.out," ",x$comment)
  cor.tok<-udpipe::udpipe_annotate(model,comment)
  df<-as.data.frame(cor.tok)
  df.se<-df[1,]
  df.se[1,]<-""
  # df.se$token<-"<s>"
   df.se$token<-s.tag
  df.s.end<-df.se
  df.s.end$token<-'</s>'
  sent.u<-unique(df$sentence_id)
  sent.u<-sent.u[!is.na(sent.u)]
  sent.u
  df.ex<-df[df$sentence_id==sent.u[1],]
  s.tag<-paste0('<s timestamp="',x$timestamp,'" sent_id ="',paste0(chunk,'.',x$comment_id),'.',x$sentence_id,'" author="',x$author,'" url="',x$url,'" url_id="',chunk,'" date="',x$date,'">')
  s.tag
  df.e<-rbind(df.se,,df.s.end)
#  for(s in sent.u[2:length(sent.u)]){
    df.es<-df[df$sentence_id==s,]
    if(length(sent.u)>1)
      df.e<-rbind(df.e,df.se,df.es,df.s.end)
 # }
  df<-df.e
#  df$timestamp<-x$timestamp
#  df$com_id<-x$comment_id
  #df$author<-x$author
  #df$url<-x$url
  df$url_id<-chunk
  #df$date<-x$date
  df$votes<-x$upvotes
  return(df)
}
#l.df<-length(com.df$url)
#chunks<-ceiling(l.df/1000)
# Create the vector
#vector <- 1:l.df

# Define the chunk size
#chunk_size <- 1000  # Example chunk size

# Function to split the vector into chunks of equal length
split_into_chunks <- function(vec, chunk_size) {
  split(vec, ceiling(seq_along(vec) / chunk_size))
}

# Split the vector into chunks
#chunks <- split_into_chunks(vector, chunk_size)

cleancomments<-c("\034","\035","&gt;","\036","&amp","\031","\023","\030","\005","\004","\024","\002","/u","&lt","&lt;","&gt","<")
cleancomments<-paste0(cleancomments,collapse = "|")
cleancomments
gsub(cleancomments,"#","try<weg")
k<-2
# com.vrt.es.1<-get.ann.df_ann(com.df[1,],cleancomments)
# com.vrt.es.1<-rbind("",com.vrt.es.1,"")
# com.vrt.es.1$token[1]<-'<com id="1">'
# com.vrt.es.1$token[length(com.vrt.es.1$token)]<-"</com>"
# com.vrt.es.1<-com.vrt.es.1[,df.ns]
# colnames(com.vrt.es.1)<-names(df.ns)
k<-1
#chunk<-1
head(chunks[1])
#for(k in 2:1000){
### > TODO: loop redo, saves false
url.u<-unique(com.df$url)
com.df$url_id<-""
k<-1
df.ns<-c(token=6,pos=8,lemma=7,feats=10,sentence=4,tok_id=5,head_tok_id=11,dep_rel=12,url_id=19,par_id=2,sent_id=3,timestamp=15,date=20,com_id=16,author=17,votes=21,url=18)
df.ns<-c(token=6,pos=8,lemma=7,feats=10,sentence=4,tok_id=5,head_tok_id=11,dep_rel=12,par_id=2,sent_id=3,votes=16)
for(k in 1:length(url.u)){
  url<-url.u[k]
  com.df$url_id[com.df$url==url]<-k
  
}
for(chunk in 1:length(chunks)){
 # for(k in 2:length(chunk.range)){
#  k<-1
  chunk.range<-chunks[[chunk]]
  url<-1
  chunk
   for(url in 1:length(url.u)){
    url.df<-com.df[com.df$url_id==url,]
    url.df
 # mode(df.ns)
  
  # com.vrt.es.1<-get.ann.df_ann(chunk.df[1,],cleancomments,chunk=url)
  # doc.id<-paste0('<com id="url-',com.vrt.es.1$url_id[1],'.',com.vrt.es.1$com_id[1],'">')
  # com.vrt.es.1<-rbind("",com.vrt.es.1,"")
  # 
  # com.vrt.es.1$token[1]<-doc.id
  # com.vrt.es.1$token[length(com.vrt.es.1$token)]<-"</com>"
  # com.vrt.es.1<-com.vrt.es.1[,df.ns]
  # colnames(com.vrt.es.1)<-names(df.ns)
  # k<-1
  k
  chunk.df<-url.df
  length(chunk.df)
  com<-1
  #com
  for(com in 1:length(chunk.df$url)){
    chunk.df
    chunk <- paste0(url,'.',com)
  chunk
    com.ann<-get.ann.df_ann(chunk.df[com,],cleancomments,chunk)
  com.ann
#  doc.id<-paste0('<com id="',com.ann$url_id[com],'">')
  doc.id<-paste0('<com id="',chunk,'">')
  com.ex<-rbind("",com.ann,"")
  length(df.ns)
  length(com.ann)
  
  #m<-colnames(com.ex)=="token"
  com.ann<-com.ex[,df.ns]
  colnames(com.ann)<-names(df.ns)
  com.ann$token[1]<-doc.id
  com.ann$token[length(com.ann$token)]<-'</com>'
  #head.doc<-com.ann[1,]
  #head.doc[1,]<-NA
  #head.doc[1,]
  #foot.doc<-head.doc
  #head.doc$token<-doc.id
  #foot.doc$token<-'</com>'
  #doc.ann<-rbind(head.doc,com.ann,foot.doc)
  #doc.ann
  #com.vrt.es.1<-rbind(com.vrt.es.1,doc.ann)
  com.vrt.es.1<-com.ann
    for(na in 1:length(com.vrt.es.1)){
  m<-is.na(com.vrt.es.1[,na])
  com.vrt.es.1[m,na]<-""
    }
  #com.vrt.es.1
  cat("processing, chunk:",chunk,"\n")  
#}
# chk unique tokens:
#com.vrt.es.2<-com.vrt.es.1[!is.na(com.vrt.es.1$token),]
com.vrt.es.2<-com.vrt.es.1
com.vrt.es.2<-com.vrt.es.2[com.vrt.es.2$token!="",]
m<-grepl("<com id|</com>",com.vrt.es.2$token)
sum(m)
com.vrt.es.2[m,2:length(com.vrt.es.2)]<-""
m2<-grepl("<s time|</s>",com.vrt.es.2$token)
sum(m2)
com.vrt.es.2[m2,2:length(com.vrt.es.2)]<-""
sum(m2)
com.vrt.es.3<-com.vrt.es.2
#com.vrt.es.3<-rbind('<?xml version="1.0" encoding="UTF-8"?>',com.vrt.es.2)
#com.vrt.es.3[1,2:length(com.vrt.es.3)]<-""
#com.vrt.es.3[length(com.vrt.es.3$token),2:length(com.vrt.es.3)]<-""
length(unique(com.vrt.es.2$token)) # 1:1000:9433."".9270." ".9272
length(unique(com.vrt.es.2$lemma)) # 1:1000:7707.7540.7543
# ttb<-table(com.vrt.es.1$token)
# ttb
#?write.table
 vrt.dir<-paste(wd,"vrt3",sep = "/")
 
 vrt.ns<-paste0(vrt.dir,"/com.vrt3.url",url,".vrt")
 vrt.ns
 dir.create(vrt.dir)
write.table(com.vrt.es.3,vrt.ns,sep = "\t",row.names = F,append=T,col.names = F,quote = F)
  } # comment loop
   } # url loop
xml<-readLines(vrt.ns)
xml<-c('<?xml version="1.0" encoding="UTF-8"?>',paste0('<doc id="chunk-',chunk,'">'),xml,'</doc>')
writeLines(xml,vrt.ns)
chunk
}
########################################################
########################################################
