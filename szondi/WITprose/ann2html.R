library(RSQLite)
d<-dbDriver("SQLite")
d
library(DBI)
con<-dbConnect(d)
con
dbListTables(con <- dbConnect(RSQLite::SQLite(), ":memory:"))
con<-dbConnect(d,"/Users/guhl/boxHKW/21S/DH/local/AVL/2024/WIT/2025-01-21_FolioFF.sqlite")
con<-dbConnect(d,"/Users/guhl/Documents/GitHub/SPUND-LX/szondi/WITprose/2025-01-23_FolioFF.sqlite3")
highlights<-dbGetQuery(con, "SELECT * FROM highlights")
highlights<-highlights[highlights$document_id==2,]
highlight_tags<-dbGetQuery(con, "SELECT * FROM highlight_tags")
dbGetQuery(con, "SELECT name FROM sqlite_master WHERE type='table';")
# SELECT name FROM sqlite_master WHERE type='table';
tags<-dbGetQuery(con, "SELECT * FROM tags")
highlights
txtsrc<-"/Users/guhl/boxHKW/21S/DH/local/AVL/2024/WIT/wiki/ff.exb.txt"
t<-readLines(txtsrc)
t
#library(stringi)
# tw<-strsplit(t," ")
# tw<-unlist(tw)
# tw

### t chunks
# l.df<-length(tw)
# vector <- 1:l.df
# chunk_size <- 10  # Example chunk size
# split_into_chunks <- function(vec, chunk_size) {
#   split(vec, ceiling(seq_along(vec) / chunk_size))
# }
# chunks <- split_into_chunks(vector, chunk_size)
# chunks[1]
# chunk<-chunks[[1]]
# chunk
#range<-3:40
#tag<-tags$id[1]
#ann<-highlight_tags$highlight_id[1]
#####################################
i<-7
highlight<-highlights[i,]
highlight

get.ann<-function(i){
  highlight<-highlights[i,]
  print(highlight)
m<-highlight_tags$highlight_id==highlight$id
sum(m)
#anns<-highlights$id
tag.p<-highlight_tags$tag_id[m]
#highlight_tags.p<-highlight_tags[highlight_tags$tag_id%in%tag.p$tag_id,]
#highlight_tags.p<-highlight_tags[highlight_tags$highlight_id%in%anns,]
tag<-tags[tag.p,]
tag
#ann<-highlight_tags$highlight_id
#ann.tag.id<-highlight_tags$tag_id[highlight_tags$tag_id==tag]
#tags.e<-tags[tags$id%in%tag.p$tag_id,]
#ann
#ann.id<-highlight_tags.p$highlight_id
#ann.id<-unique(ann.id)
#ann.t<-highlights$snippet
tag.t<-tag$path
tag.range.s<-highlight$start_offset
tag.range.e<-highlight$end_offset
#tag.range.e<-highlights$end_offset[ann.id]
tag.range<-c(tag.range.s,tag.range.e)
print(tag.range)
ann.t<-paste0(tc.m[tag.range[1]:tag.range[2]],collapse = "")
ann.t<-gsub("<p>|</p>","",highlight$snippet)
print(ann.t)
# ann.t<-lapply(tag.range,function(x){
#   ann.t<-paste0(tc.m[tag.range[[1]]:tag.range[[2]]],collapse = "")
#   print(ann.t)
#   return(data.frame(abind(ann.t,along = 1)))
#   
# })
#ann.t<-""

# return(list(ann.id=ann.id,ann.t=ann.t,tag.t=tag.t,range.s=tag.range.s,range.e=tag.range.e))
return(list(ann.t=ann.t,tag.t=tag.t,range=tag.range))
}
get.chunk.df<-function(chunk){
  
tw.ex<-tw[chunk]
ann<-get.ext(tw.ex,chunk)#,tag.range.s:tag.range.e)
ann
}
#########################
i<-2
rm(i)
?apply
#apply.ann.df<-function(){
ann.l<-lapply(seq_along(1:length(highlights$id)),function(i){
  get.ann(i)
  })
ann.l
#ann.df[[2]]
# tw.df<-get.ext(1)
# tw.list<-lapply(seq_along(1:10), function(i){
#   get.ext(i)
# })
library(abind)
#?abind
# rmax<-max(sapply(tw.list,function(x)length(x)))
# tw.l2<-lapply(tw.list, function(x){cbind(x,matrix("",ncol = rmax-length(x),
#                                                   nrow = length(tags$id)+2))})
# tw.df<-abind(tw.l2,along = 1)
#tw.m<-matrix(tw.df[1,],nrow  = rmax)
# ann.df
# t.cl<-gsub("<p>|</p>","",ann.df[[1]]$tag.t)
# t.cl
# m1<-ann[1,]==t.cl
# sum(m1)
# ann[,1]<-ann.id
# ann[2,m1]<-t.cl
# return(ann.df)
# }
# ann.df<-apply.ann.df()
# ann.df<-lapply(seq_along(1:length(tags$id)), function(x){
#   ann.l<-get.ann(tags)
# })
# ann.l<-lapply(seq_along(1), function(x){
#   get.ann(tags)
# })
#}
ann.l
ann.df2<-data.frame(t(data.frame(abind(ann.l,along = 0))))
ann.df2$ann<-lapply(seq_along(1:length(ann.df2$ann.id)),function(i)paste0(tc.m[ann.df2[i,3]:ann.df2[i,4]],collapse = ""))
ann.df[[1]]
tw
chunk
i<-1
  chunk<-chunks[[1]]
library(readtext)
t2<-readtext(txtsrc)$text
tc.m<-unlist(strsplit(t2,""))
tc.m
x<-ann.df[[1]]
x<-ann.l
ann.l
tc.m[483:509]

ann.m<-lapply(ann.l, function(x){
  w<-list()
#  x<-x[[i]]
  w$w<-paste0(tc.m[x$range.s:x$range.e],collapse="")
  w$a<-x$tag.t
  return(w)
  # return(data.frame(abind(w,along = 1)))
})
w
ann.m[[1]]
get.ext<-function(i){
  chunk<-chunks[[i]]
  
  print(chunk)
  tw.ex<-tw[chunk]
  tw.c<-paste0(tw.ex,collapse = " ")
  tc.l<-strsplit(tw.c,"")
  tc.l
  tc<-unlist(tc.l)
  tc
  
  ltc<-length(tc)
 # cat(paste0(tc[range],collapse = ""))
  tdf<-matrix("",ncol = length(tc)+1,nrow = length(tags$id)+2)
  tdf<-matrix("",ncol = length(tc),nrow = length(tags$id)+2)
  #tdf<-matrix("",ncol = 2,nrow = length(tags$id))
  tdf<-data.frame(tdf)
  tdf[1,]<-tc
  tdf
  # print(tw.ex)
  # tdf[1,2:length(tdf)]<-chunk
  # tdf[2,2:length(tdf)]<-unlist(lapply(tc.l,length))
  # tdf[3,3:length(tdf)]<-as.double(tdf[2,2:length(tdf)])+as.double(tdf[2,2:length(tdf)])
  # +as.double(tdf[2,(2:length(tdf))-1])
  # tdf[3,2]<-1
  # tdf[4,2]<-as.double(tdf[3,2])+as.double(tdf[2,2])-as.double(tdf[3,2])
  # tdf[5,2]<-as.double(tdf[3,2])+as.double(tdf[2,2])
  # tdf[4,3:length(tdf)]<-as.double(tdf[5,2])+1+as.double(tdf[2,3:length(tdf)])
  # 
  # tdf[4,3:length(tdf)]<-as.double(tdf[3,3:length(tdf)])+as.double(tdf[2,3:length(tdf)])
  # tdf[5,2:length(tdf)]<-tw.ex
  # tdf
  #tdf[2,]<-tw
#  tdf$token
  return(tdf)
}
i<-2
#get.ext(tw,3:40)
lapply(seq_along(1:7), function(x){
  get.ann(tags,chunks)
})
