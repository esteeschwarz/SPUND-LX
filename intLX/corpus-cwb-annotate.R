# 20241224(13.42)
# 15524.reddit.cwb.corpus.annotation
####################################
wd<-"~/boxHKW/21S/DH/local/SPUND/intLX"
load(paste(wd,"reddit_15494.df.RData",sep = "/"))

library(udpipe)
model<-udpipe::udpipe_load_model(paste(wd,"../corpuslx/german-gsd-ud-2.5-191206.udpipe",sep = "/"))
##################################
## test
x<-com.df[com.df$url==url.u[556],]
cleancomments<-c("\034","\035","&gt;","\036","&amp","\031","\023","\030","\005","\004","\024","\002","/u","&lt","&lt;","&gt","<","Klapp' die Antworten auf diesen Kommentar auf, um zum Text des Artikels zu kommen.")
clean<-paste0(cleancomments,collapse = "|")
#clean<-cleancomments
##
chunk
cor.tok.empty<-udpipe::udpipe_annotate(model,"_NO_ANN_")
cor.tok.empty<-data.frame(cor.tok.empty)
m<-grepl("misc",colnames(cor.tok.empty))
cor.tok.empty<-cor.tok.empty[,!m]
#df<-cor.tok.empty
get.ann.df_ann<-function(x,clean,chunk){
  t.out<-clean
  t.out
  comment.raw<-x$comment
  comment.raw
  comment<-gsub(cleancomments[length(cleancomments)],"_NO_ANN_",comment.raw)
  comment<-gsub(t.out," ",comment)
  comment<-gsub("^ +$","_NO_ANN_",comment)
  comment<-gsub("^.\n\n.$","_NO_ANN_",comment)
  comment
  #ifelse (comment.raw!=cleancomments[length(cleancomments)],
    df<-as.data.frame(udpipe::udpipe_annotate(model,comment))#,df=cor.tok.empty)
  #df<-as.data.frame(cor.tok)
  ### critical column, maybe causing errors
  m<-grepl("misc",colnames(df))
  df<-df[,!m]
  doc.sent<-paste(df$doc_id,df$sentence_id,sep = ".")
  doc.sent.df<-df[,c(1,3)]
  doc.sent.u<-unique(doc.sent)
  #sent.u<-sent.u[!is.na(sent.u)]
  sent.u<-doc.sent.u
  doc.u<-unique(df$doc_id)
  #s<-2
  
 # for(s in sent.u[1:length(sent.u)]){
  ##########################  
  p<-doc.sent.df[3,]
  p<-doc.sent.u[6]
  doc.sent.u
  get.sent.div<-function(p){
    m<-doc.sent==p
  #m<-doc.u==p
      doc.here<-which(m)
      m
    df.es<-df[m,]
    s.id<-df.es$sentence_id[1]
    df.start<-df.es[1,]
    df.start[1,]<-""
    s.tag<-paste0('<s timestamp="',x$timestamp,'" sent_id ="',paste0(chunk,'.',x$comment_id),'.',s.id,'" author="',x$author,'" url="',x$url,'" url_id="',chunk,'" date="',x$date,'" upvotes="',x$upvotes,'">')
    t.u<-unique(s.tag)
    s.tag.s<-s.tag[1]
    s.tag.s
    df.start$token<-s.tag.s
    df.end<-df.start
    df.end$token<-'</s>'
    df.out<-rbind(df.start,df.es,df.end)
    return(data.frame(df.out))
  # df.se$token<-"<s>"
  # df.se$token<-s.tag
  #df.s.end<-df.se
 # df.ex<-df[df$sentence_id==sent.u[1],]
#  df.e<-rbind(df.se,df.s.end)
  }
  df.ex.l<-lapply(doc.sent.u, get.sent.div)
  df.ex<-abind::abind(df.ex.l,along = 1)
  df.ex<-data.frame(df.ex)
#  df$timestamp<-x$timestamp
#  df$com_id<-x$comment_id
  #df$author<-x$author
  #df$url<-x$url
  df.ex$url_id<-chunk
  #df$date<-x$date
  #df.ex$votes<-x$upvotes
  df.df<-data.frame(df.ex)
  return(df.df)
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

# cleancomments<-c("\034","\035","&gt;","\036","&amp","\031","\023","\030","\005","\004","\024","\002","/u","&lt","&lt;","&gt","<","Klapp' die Antworten auf diesen Kommentar auf, um zum Text des Artikels zu kommen.")
# clean.c<-paste0(cleancomments,collapse = "|")

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
#com.df$url_id<-""
k<-1
# df.ns<-c(token=6,pos=8,lemma=7,feats=10,sentence=4,tok_id=5,head_tok_id=11,dep_rel=12,url_id=19,par_id=2,sent_id=3,timestamp=15,date=20,com_id=16,author=17,votes=21,url=18)
df.ns<-c(token=6,pos=8,lemma=7,feats=10,sentence=4,tok_id=5,head_tok_id=11,dep_rel=12,par_id=2,sent_id=3)
for(k in 1:length(url.u)){
  url<-url.u[k]
  com.df$url_id[com.df$url==url]<-k
  
}
#for(chunk in 1:length(chunks)){
 # for(k in 2:length(chunk.range)){
#  k<-1
#  chunk.range<-chunks[[chunk]]
  url<-556
  #chunk
############## start loop ### >>>>>>>>>>>
   for(url in 1:length(url.u)){
    url.df<-com.df[com.df$url_id==url,]
    url.df
  k
  chunk.df<-url.df
  length(chunk.df)
  com<-30
  #com
  for(com in 1:length(chunk.df$url)){
    chunk.df
    chunk <- paste0(url,'.',com)
  chunk
    com.ann<-get.ann.df_ann(chunk.df[com,],clean,chunk)
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
com.vrt.es.2<-com.vrt.es.1[!is.na(com.vrt.es.1$token),]
#com.vrt.es.2<-com.vrt.es.1
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
  # } # url loop
xml<-readLines(vrt.ns)
xml<-c('<?xml version="1.0" encoding="UTF-8"?>',paste0('<doc id="url#',url,'">'),xml,'</doc>')
writeLines(xml,vrt.ns)
chunk
   }
  ?writeLines
  ?library
########################################################
########################################################
library(clipr)
write_clip(colnames(head.doc))  

### combine back vrt to single source file
wd<-"~/boxHKW/21S/DH/local/SPUND/intLX"

vrt.dir<-paste(wd,"vrt3",sep = "/")

vrt.ns<-paste0(vrt.dir,"/com.vrt.single.vrt")
vrt.ns
dir.create(vrt.dir)
f<-list.files(vrt.dir)
fns<-paste(vrt.dir,f,sep = "/")
get.vrt<-function(x){
  t<-readLines(x)
  t<-t[2:length(t)]
  return(t)
}
vrtdoc<-pblapply(fns,get.vrt)
head(vrtdoc[[1]])
vrt.dir<-paste(wd,"vrtsingle",sep = "/")

vrt.ns<-paste0(vrt.dir,"/source")
vrt.ns
dir.create(vrt.dir)
vrtwrite<-abind(vrtdoc,along = 1)
writeLines(vrtwrite,vrt.ns)
