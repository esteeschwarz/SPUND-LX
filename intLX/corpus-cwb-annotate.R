# 20241224(13.42)
# 15524.reddit.cwb.corpus.annotation
####################################
wd<-"~/boxHKW/21S/DH/local/SPUND/intLX"
load(paste(wd,"reddit_15494.df.RData",sep = "/"))

library(udpipe)
model<-udpipe::udpipe_load_model(paste(wd,"../corpuslx/german-gsd-ud-2.5-191206.udpipe",sep = "/"))
##################################
## test
#x<-com.df[3,]
#clean<-cleancomments
##
get.ann.df_ann<-function(x,clean){
  t.out<-clean
  comment<-gsub(t.out," ",x$comment)
  cor.tok<-udpipe::udpipe_annotate(model,comment)
  df<-as.data.frame(cor.tok)
  df.se<-df[1,]
  df.se[1,]<-""
  df.se$token<-"<s>"
  df.s.end<-df.se
  df.s.end$token<-'</s>'
  sent.u<-unique(df$sentence_id)
  sent.u<-sent.u[!is.na(sent.u)]
  sent.u
  df.e<-rbind(df.se,df[df$sentence_id==sent.u[1],],df.s.end)
  for(s in sent.u[2:length(sent.u)]){
    df.es<-df[df$sentence_id==s,]
    if(length(sent.u)>1)
      df.e<-rbind(df.e,df.se,df.es,df.s.end)
  }
  df<-df.e
  df$timestamp<-x$timestamp
  df$com_id<-x$comment_id
  df$author<-x$author
  df$url<-x$url
  df$date<-x$date
  df$votes<-x$upvotes
  return(df)
}
l.df<-length(com.df$url)
chunks<-ceiling(l.df/1000)
# Create the vector
vector <- 1:l.df

# Define the chunk size
chunk_size <- 1000  # Example chunk size

# Function to split the vector into chunks of equal length
split_into_chunks <- function(vec, chunk_size) {
  split(vec, ceiling(seq_along(vec) / chunk_size))
}

# Split the vector into chunks
chunks <- split_into_chunks(vector, chunk_size)

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
chunk<-1
head(chunks[1])
#for(k in 2:1000){
### > TODO: loop redo, saves false
for(chunk in 1:length(chunks)){
  for(k in 2:length(chunk.range)){
  
  chunk.range<-chunks[[chunk]]
  for(k in 1:length(chunk.range)){
    chunk.df<-com.df[chunk.range[k],]
    df.ns<-c(token=6,pos=8,lemma=7,feats=10,sentence=4,tok_id=5,head_tok_id=11,dep_rel=12,doc_id=1,par_id=2,sent_id=3,timestamp=15,date=19,com_id=16,author=17,votes=20,url=18)
  mode(df.ns)
  
  com.vrt.es.1<-get.ann.df_ann(chunk.df[1,],cleancomments)
  com.vrt.es.1<-rbind("",com.vrt.es.1,"")
  com.vrt.es.1$token[1]<-'<com id="1">'
  com.vrt.es.1$token[length(com.vrt.es.1$token)]<-"</com>"
  com.vrt.es.1<-com.vrt.es.1[,df.ns]
  colnames(com.vrt.es.1)<-names(df.ns)
  #k<-2
  com.ann<-get.ann.df_ann(chunk.df[k,],cleancomments)
  com.ex<-rbind("",com.ann,"")
  m<-colnames(com.ex)=="token"
  com.ann<-com.ex[,df.ns]
  colnames(com.ann)<-names(df.ns)
  head.doc<-com.ann[1,]
  #head.doc[1,]<-NA
  head.doc[1,]
  foot.doc<-head.doc
  head.doc$token<-paste0('<com id="',k,'">')
  foot.doc$token<-'</com>'
  doc.ann<-rbind(head.doc,com.ann,foot.doc)
  com.vrt.es.1<-rbind(com.vrt.es.1,doc.ann)
  for(na in 1:length(com.vrt.es.1)){
  m<-is.na(com.vrt.es.1[,na])
  com.vrt.es.1[m,na]<-""
  }
  cat("processing:",chunk,".",k,"\n")  
#}
# chk unique tokens:
com.vrt.es.2<-com.vrt.es.1[!is.na(com.vrt.es.1$token),]
com.vrt.es.2<-com.vrt.es.2[com.vrt.es.2$token!="",]
m<-grepl("<com id",com.vrt.es.2$token)
com.vrt.es.2[m,2:length(com.vrt.es.2)]<-""
m2<-com.vrt.es.2$token=="<s>"|com.vrt.es.2$token=="</s>"
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
 vrt.ns<-paste0(vrt.dir,"/com.vrt3.c",chunk,".vrt")
 #dir.create(vrt.dir)
write.table(com.vrt.es.3,vrt.ns,sep = "\t",row.names = F,append=T,col.names = F,quote = F)
  }
xml<-readLines(vrt.ns)
xml<-c('<?xml version="1.0" encoding="UTF-8"?>',xml)
writeLines(xml,vrt.ns)

}
########################################################
########################################################
