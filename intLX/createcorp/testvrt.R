############################
### new nosketch vrt essai
#source("~/Documents/GitHub/SPUND-LX/intLX/createcorp/functions.R")
### embed script function
library(udpipe)
get.ann.df<-function(model.dir,input,output){
  t<-input
  #t<-readLines(text)
  #model.dir<-"./modeldir"
  #dir.create(model.dir)
  #udpipe::udpipe_download_model("german-gsd",model_dir = model.dir)
  model<-list.files(model.dir)
  model<-paste(model.dir,model[1],sep = "/")
  #print(model)
  model<-udpipe::udpipe_load_model(model)
  pos1<-udpipe_annotate(model,t)
  pos.df<-as.data.frame(pos1)
#  pos.df$timestamp<-unique(meta$timestamp)
  return(pos.df)
}
cat("function(model.dir,input(character),output(F))\n")
#get.ann.df
# library(readr)
# write_tsv(pos.df,output)
#?write_tsv
#}
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
  m<-df$sentence_id==id
  cat("\nsent:",id,".",n,"\n")
  df.es<-df[m,]
  df.es$doc_id<-paste0("pid:",id,".",df.es$doc_id)
  
  s.id<-id
  df.start<-df.es[1,]
  df.start[1,]<-""
  # s.tag<-paste0('<s timestamp="',x$timestamp,'" sent_id ="',paste0(chunk,'.',x$comment_id),'.',s.id,'" author="',x$author,'" url="',x$url,'" url_id="',chunk,'" date="',x$date,'" upvotes="',x$upvotes,'">')
  #rownames raw: "doc_id" "paragraph_id" "sentence_id" "sentence" "token_id" "token" "lemma" "upos" "xpos" "feats" "head_token_id" "dep_rel" "deps" "misc"
  s.tag<-paste0('<s id="',id,'">')
  print(s.tag)
  t.u<-unique(s.tag)
  s.tag.s<-s.tag[1]
  s.tag.s
  df.start[,1]<-s.tag.s
  df.end<-df.start
  df.end[,1]<-'</s>'
  df.out<-rbind(df.start,df.es,df.end)
  return(df.out)
}

get.doc.div<-function(x,id,n){
  df<-x
  m<-df$doc_id==id
  cat("\ndoc:",id,".",n,"\n")
  #m<-doc.u==p
  doc.here<-which(m)
  m
  df.es<-df[m,c(6,2:5,7:length(df))]
  df.es$doc_id<-paste0(id,".",df.es$doc_id)

  sent.id<-df.es$sentence_id
  sent.id.u<-unique(sent.id)
  sent.df<-pblapply(seq_along(sent.id.u), function(i) {
    get.sent.div(df.es,sent.id.u[[i]], i)
  })
  df.es<-data.frame(abind(sent.df,along = 1))
  df.start<-df.es[1,]
  df.start[1,]<-""
  # s.tag<-paste0('<s timestamp="',x$timestamp,'" sent_id ="',paste0(chunk,'.',x$comment_id),'.',s.id,'" author="',x$author,'" url="',x$url,'" url_id="',chunk,'" date="',x$date,'" upvotes="',x$upvotes,'">')
  #rownames raw: "doc_id" "paragraph_id" "sentence_id" "sentence" "token_id" "token" "lemma" "upos" "xpos" "feats" "head_token_id" "dep_rel" "deps" "misc"
  s.tag<-paste0('<text id="',id,'">')
  t.u<-unique(s.tag)
  s.tag.s<-s.tag[1]
  s.tag.s
  df.start[,1]<-s.tag.s
  df.end<-df.start
  df.end[,1]<-'</text>'
  df.out<-rbind(df.start,df.es,df.end)
  # write.table(df.out,paste0("~/Documents/GitHub/SPUND-LX/intLX/createcorp/testout/vrt-",n,".csv"),sep = "\t",quote = F,row.names = F)
  # 
  return(data.frame(df.out))
}
fetch.pos<-function(file,fn){
  t<-readLines(file)
  pos.df<-get.ann.df(model.dir = "~/Documents/GitHub/SPUND-LX/intLX/createcorp/modeldir",input = t,output = F)
  pos.df$doc_id<-paste0(fn,".",gsub("doc","",pos.df$doc_id))
  doc.id<-pos.df$doc_id
  doc.id.u<-unique(doc.id)
  df.ex.l<-pblapply(seq_along(doc.id.u), function(i) {
    get.doc.div(pos.df,doc.id.u[[i]], i)
  })
  df.write<-as.data.frame(abind(df.ex.l,along = 1))
  df.write<-rbind(c(paste0('<doc id="',fn,'">'),rep("",length(df.write)-1)),df.write,
                  c('</doc>',rep("",length(df.write)-1)))
  write.table(df.write,paste0("~/Documents/GitHub/SPUND-LX/intLX/createcorp/testout/vrt.f-",fn,".csv"),sep = "\t",quote = F,row.names = F,col.names = F,na="")
  return(abind(df.write,along = 1))
}
#?write.table
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
write.table(df.ex,"~/Documents/GitHub/SPUND-LX/intLX/createcorp/vertical/source/002",sep = "\t",quote = F,row.names = F,col.names = F,na="")
### wks.




