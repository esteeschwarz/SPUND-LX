############################
### new nosketch vrt essai
#source("~/Documents/GitHub/SPUND-LX/intLX/createcorp/functions.R")
### embed script function
library(udpipe)
model.dir<-"./modeldir"
source("rlog.R")
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
  df.es$pid<-paste0("pid:",df.es$uid,".",id,".",n)
  
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
  cat("\nrundoc:",run,id,".",n,"of",length(url.sub.df$url),"doc elements\n")
  #m<-doc.u==p
  # doc.here<-which(m)
  #m
  df.es<-df[m,c(6,2:5,7:length(df))]
  # m2<-colnames(df.ex)=="misc"|colnames(df.ex)=="deps"
  # which(m2)
  #sum(m)
  #    m2<-colnames(df.es)=="misc"|colnames(df.es)=="deps"
  #    m3<-c(1:length(m2))[!m2]
  #    m3
  #    df.es<-df.es[,m3]
  # #   df.es$doc_id<-paste0(id,".",df.es$doc_id)
  
  sent.id<-df.es$sentence_id
  sent.id.u<-unique(sent.id)
  sent.df<-pblapply(seq_along(sent.id.u), function(i) {
    get.sent.div(df.es,sent.id.u[[i]], i)
  })
  df.es<-data.frame(abind(sent.df,along = 1))
  ####### > inserts <text> element, obsolete
  # df.start<-df.es[1,]
  # df.start[1,]<-""
  # # s.tag<-paste0('<s timestamp="',x$timestamp,'" sent_id ="',paste0(chunk,'.',x$comment_id),'.',s.id,'" author="',x$author,'" url="',x$url,'" url_id="',chunk,'" date="',x$date,'" upvotes="',x$upvotes,'">')
  #rownames raw: "doc_id" "paragraph_id" "sentence_id" "sentence" "token_id" "token" "lemma" "upos" "xpos" "feats" "head_token_id" "dep_rel" "deps" "misc"
  # s.tag<-paste0('<text id="',id,'">')
  # t.u<-unique(s.tag)
  # s.tag.s<-s.tag[1]
  # s.tag.s
  # df.start[,1]<-s.tag.s
  # df.end<-df.start
  # df.end[,1]<-'</text>'
  # df.out<-rbind(df.start,df.es,df.end)
  ### end insert <text>, the following line to be removed if inserted above routine again
  df.out<-df.es  
  # write.table(df.out,paste0("~/Documents/GitHub/SPUND-LX/intLX/createcorp/testout/vrt-",n,".csv"),sep = "\t",quote = F,row.names = F)
  # 
  return(data.frame(df.out))
}
fetch.pos<-function(file,i,data){
  # t<-readLines(file)
  t<-file
  fn<-i
  pos.df<-get.ann.df(model.dir = model.dir,input = t,output = F)
  author<-data[[1]]
  cat("\ndata:",fn,"author:",author,"timestamp:",data[[2]],"\n")
  #print(author)
  print(data)
  print(timestamp<-data[[2]])
  #pos.df$doc_id<-paste0(i,".",gsub("doc","",pos.df$doc_id))
  pos.df$uid<-paste0("run",run,"-url",i)
  pos.df$doc_id<-i
  #pos.df$author<-author
  pos.df$timestamp<-timestamp
  pos.df$date<-data$date
  url<-data$url
  pos.df$score<-data$score
  pos.df$com_id<-data$com_id
  
  doc.id<-pos.df$doc_id
  doc.id.u<-unique(doc.id)
  df.ex.l<-pblapply(seq_along(doc.id.u), function(i) {
    get.doc.div(pos.df,doc.id.u[[i]], i)
  })
  df.write<-as.data.frame(abind(df.ex.l,along = 1))
  # mna<-is.na(df.write$sentence)
  # df.ex.l<-df.write[!mna,]
  df.write<-rbind(c(paste0('<doc id="',run,'-',fn,'" url="',url,'" author="',author,'">'),
                    rep("",length(df.write)-1)),df.write,
                  c('</doc>',rep("",length(df.write)-1)))
  ### > this to write vrt for each url
  # write.table(df.write,paste0("~/Documents/GitHub/SPUND-LX/intLX/createcorp/testout/vrt.f-",fn,".csv"),sep = "\t",quote = F,row.names = F,col.names = F,na="")
  ###
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
### now with reddit dataframe
wd<-"~/docker/ske"
load(paste(wd,"reddit_15494.df.RData",sep = "/"))
urls<-com.df$url
url.u<-unique(urls)
out.dir<-paste(getwd(),"corpora/reddit/vertical/vrt6",sep="/")
out.ns<-paste(out.dir,"source",sep="/")
#file.create(out.ns)
# url.sub<-url.u[1:200] # 1:10:411 obs
# url.sub.df<-com.df[com.df$url%in%url.sub,]
# stopped after finishing 23, new start from 24!
# next,start from: 
# 30:74
# wt log: 89. wks.
# 101:120
for (run in 115:125){
  
  #for (run in 1:length(url.u)){
  url.sub<-url.u[run] # 1:10:411 obs
  url.sub.df<-com.df[com.df$url%in%url.sub,]
  # df.ex.l<-pblapply(seq_along(fns), function(i) {
  #   fetch.pos(fns[[i]], i)
  # })
  ##################################################################
  ### > here adapt change to length of url.sub.df to get all url pos
  # df.ex.url<-pblapply(seq_along(1:2),function(i){
  #   cat("url:",url,"\n")
  df.ex.l<-pblapply(seq_along(url.sub.df$url), function(i) {
    #  df.ex.l<-pblapply(seq_along(1:length(url.sub)), function(i) {
    #comments<-url.sub.df$comment[url.sub.df$url==url.sub[i]]
    comments<-url.sub.df[i,]
    #print(length(comments))
    #  author<-url.sub.df$author[url.sub.df$url==url.sub[i]]
    # timestamp<-url.sub.df$timestamp[url.sub.df$url==url.sub[i]]
    print(author<-comments$author)
    print(timestamp<-comments$timestamp)
    print(score<-comments$score)
    print(com_id<-comments$comment_id)
    print(url<-comments$url)
    print(date<-comments$date)
    
    print(comment<-comments$comment)
    # print(i)
    #print(comment)
    com.x<-fetch.pos(comment, i,data=list(author=author,timestamp=timestamp,date=date,url=url,score=score,com_id=com_id))
    return(com.x)
  })
  #})
  #df.ex<-abind::abind(df.ex.l[[1]],along = 1)
  df.ex<-abind::abind(df.ex.l,along = 1)
  
  df.ex<-data.frame(df.ex)
  m2<-colnames(df.ex)=="misc"|colnames(df.ex)=="deps"|colnames(df.ex)=="sentence"
  m3<-c(1:length(m2))[!m2]
  m3
  df.ex<-df.ex[,m3]
  # out.dir<-paste(getwd(),"corpora/reddit/vertical/vrt6",sep="/")
  # out.ns<-paste(out.dir,"source",sep="/")
  
  write.table(df.ex,out.ns,sep = "\t",quote = F,
              row.names = F,col.names = F,na="",append=T)
  ### wks.
  #}) #end url lapply
  # save to http:
  cloud<-"~/box.dh-index.org/httpdocs/cloud"
  #save(df.ex.l,file=paste(cloud,"red_df.ex.el.RData",sep="/"))
  # write to logfile
  writelog(c(run,"url"),"rlog.csv")
} # end url/run loop
################################################
# command: make execute CMD="compilecorp --no-ske testvrt"
call.noske<-'make execute CMD="compilecorp --no-ske --recompile-corpus reddit4"'
#system(call.noske)
print("process finished.")

# shellstart: nohup Rscript getcompilecorp.R &> rscript.log &


