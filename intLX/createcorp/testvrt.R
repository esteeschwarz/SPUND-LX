############################
### new nosketch vrt essai
source("~/Documents/GitHub/SPUND-LX/intLX/createcorp/functions.R")
text.dir<-"~/Documents/GitHub/SPUND-LX/play/data"
f<-list.files(text.dir)
fns<-paste(text.dir,f,sep = "/")
library(tools)
library(pbapply)
library(abind)
fns.e<-file_ext(fns)=="txt"
fns<-fns[fns.e]
get.sent.div<-function(x,id,n){
  df<-x
  m<-df$doc_id==id
  cat(id,".",n,"\n")
  #m<-doc.u==p
  doc.here<-which(m)
  m
  df.es<-df[m,c(6,2:length(df))]

  s.id<-df.es$sentence_id[1]
  df.start<-df.es[1,]
  df.start[1,]<-""
  # s.tag<-paste0('<s timestamp="',x$timestamp,'" sent_id ="',paste0(chunk,'.',x$comment_id),'.',s.id,'" author="',x$author,'" url="',x$url,'" url_id="',chunk,'" date="',x$date,'" upvotes="',x$upvotes,'">')
  #rownames raw: "doc_id" "paragraph_id" "sentence_id" "sentence" "token_id" "token" "lemma" "upos" "xpos" "feats" "head_token_id" "dep_rel" "deps" "misc"
  s.tag<-paste0('<doc id="',n,'">')
  t.u<-unique(s.tag)
  s.tag.s<-s.tag[1]
  s.tag.s
  df.start[,1]<-s.tag.s
  df.end<-df.start
  df.end[,1]<-'</doc>'
  df.out<-rbind(df.start,df.es,df.end)
  # write.table(df.out,paste0("~/Documents/GitHub/SPUND-LX/intLX/createcorp/testout/vrt-",n,".csv"),sep = "\t",quote = F,row.names = F)
  # 
  return(data.frame(df.out))
}
fetch.pos<-function(file,fn){
  t<-readLines(file)
  pos.df<-get.ann.df(model.dir = "~/Documents/GitHub/SPUND-LX/intLX/createcorp/modeldir",input = t,output = F)
  pos.df$doc_id<-paste0("url",fn,".",pos.df$doc_id)
  doc.id<-pos.df$doc_id
  doc.id.u<-unique(doc.id)
  df.ex.l<-pblapply(seq_along(doc.id.u), function(i) {
    get.sent.div(pos.df,doc.id.u[[i]], i)
  })
  write.table(as.data.frame(abind(df.ex.l,along = 1)),paste0("~/Documents/GitHub/SPUND-LX/intLX/createcorp/testout/vrt.f-",fn,".csv"),sep = "\t",quote = F,row.names = F,col.names = F)
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





