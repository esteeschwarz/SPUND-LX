
tempfun<-function(){
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
t
library(readxl)
d1<-read_xlsx("/Users/guhl/Documents/GitHub/SPUND-LX/szondi/WITprose/ff_Codierte Segmente.xlsx")
d2<-read_xlsx("/Users/guhl/Documents/GitHub/SPUND-LX/szondi/WITprose/MAXQDA 24 Codierte Segmente.xlsx")

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
# i<-7
# highlight<-highlights[i,]
# highlight
# 
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
#i<-2
#rm(i)
#?apply
#apply.ann.df<-function(){
# ann.l<-lapply(seq_along(1:length(highlights$id)),function(i){
#   get.ann(i)
#   })
# ann.l
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

### new from MAXQDA coded segments
library(stringdist)
k<-1
i<-1
rm(i)
target.l<-strsplit(d1$Segment," ")
}
### from here
######################################################################
txtsrc<-"/Users/guhl/boxHKW/21S/DH/local/AVL/2024/WIT/wiki/ff.exb.txt"
t<-readLines(txtsrc)

library(readxl)
d1<-read_xlsx("/Users/guhl/Documents/GitHub/SPUND-LX/szondi/WITprose/ff_Codierte Segmente.xlsx")
d2<-read_xlsx("/Users/guhl/Documents/GitHub/SPUND-LX/szondi/WITprose/MAXQDA 24 Codierte Segmente.xlsx")
#m<-is.na(d1$Kommentar)
#m
### get annotations from 2nd essai to 1st table
put.ann<-function(){
for (k in 1:length(d2$Segment)){
  source<-d2$Segment[k]
  
  str.array<-strsplit(source," ")
  print(str.array)
  # tm<-lapply(target.l, function(i){
  #   strings<-unlist(str.array)
  #   #match(target.l[i],unlist(str.array))
  #   distances<-stringdist(target.l[i],strings)
  #   most_matching_string <- strings[most_matching_index]
  #   return(distances)
  # })
#  tm
  # m<-grep(d2$Segment[k],d1$Segment)
  strings<-d1$Segment
  strings.un<-lapply(strings,function(x){
    strsplit(x," ")})
  strings.un[[1]]
  strings.un
#  rm(x)
mmstring <- lapply(seq_along(1:length(strings.un)),function(i){
  strings.m<-strings.un[[i]][[1]]
  print(strings.m)
  distances<-stringdist(strings.m,d2$Segment[k] , method = "jw")
   # Jaro-Winkler method
#print(i)
  print(distances)
most_matching_index <- which.min(distances)
#print(most_matching_index)
most_matching_string <- strings.m[most_matching_index]
dist.min<-lapply(distances, min)
return(distances)
})
#x
mmstring
most_matching_index<-which.min(lapply(mmstring, min))
mmin<-min(unlist((lapply(mmstring, min))))
cat("d2:",k,"\n")
cat("match:",most_matching_index,"with",mmin,"\n")
#com<-""
if(length(most_matching_index)>0){
  if(is.na(d1$Kommentar[most_matching_index])&mmin<0.28)
    d1$Kommentar[most_matching_index]<-d2$Kommentar[k]
}

}
  d1$Anfang<-d1$Anfang-1
  d1$Ende<-d1$Ende-1
  
  return(d1)
}
d1<-put.ann()
### wks.
#t2
#t
#txtsrc<-"/Users/guhl/boxHKW/21S/DH/local/AVL/2024/WIT/wiki/ff.exb.txt"
#t<-readLines(txtsrc)
#tt<-readtext(txtsrc)$text
text<-t

split_at_n_words <- function(text, n) {
  # Split the text into words
  words <- unlist(strsplit(text, " "))
 # words<-strsplit(text, " ")
  
  # Initialize an empty list to store the result
  result <- list()
  
  # Loop through the words and group them into chunks of n words
#get.chunks<-function(words){  
  for (i in seq(1, length(words), by = n)) {
    chunk <- paste(words[i:min(i + n - 1, length(words))], collapse = " ")
    result <- c(result, chunk)
  }
  
  return(result)
}

# Split the text every 5 words
# split_text <- split_at_n_words(text, 20)
# split_text[[2]]
# split_text.l <- lapply(t,function(x)split_at_n_words(x, 20))

#print(split_text)
#t3<-split_text
#tx<-t3[[1]]
#tx
#rm(ann)
#########################
library(tidytext)
#library(dplyr)
#i<-13
get.ngrams<-function(ann,i,out){
 # ann<-unique(ann)
   text<-ann
   ann
   print(text)
   print(length(text))
   text_df <- data.frame(line = 1, text = "#NO TEXT#", stringsAsFactors = FALSE)
   if(length(text)>0)
     text_df <- data.frame(line = 1:length(text), text = text, stringsAsFactors = FALSE)
  
  # Tokenize the text into n-grams (2-5 grams)
   ngrams_df.1 <- text_df %>%
     unnest_tokens(ngram, text, token = "ngrams", n = 1)
   ngrams_df.2 <- text_df %>%
     unnest_tokens(ngram, text, token = "ngrams", n = 2)
   ngrams_df.3 <- text_df %>%
     unnest_tokens(ngram, text, token = "ngrams", n = 3)
   # no.
#   ngrams_df<-rbind(ngrams_df.1,ngrams_df.2,ngrams_df.3)
   ngrams_df<-rbind(ngrams_df.2,ngrams_df.3)
  # ngrams_df$d1.ann<-ann.which[i]
   ifelse(out==1,return(ngrams_df.1),return(ngrams_df))
   
}
#k<-17
#ann.gna
#ann.gna.l
#ann.gna<-ann.gna.l
#########################
get.ann.match<-function(t.line,ann.gna.l,k){
  ann.gna.l
   t.line
   x<-ann.gna.l
   i<-3
   x
   ma.l<-lapply(seq_along(1:length(ann.gna.l)),function(i){
     ann.i<-ann.gna.l[[i]]
     ma.l<-apply(ann.i,MARGIN=1,FUN=function(x)grepl(x[2],t.line))
     mw<-which(ma.l)
     print(ann.i[mw,])
     #m<-ma.l==T
     return(data.frame(m=mw,ann=ann.i[mw,]))
     })   
  ma.length<-lapply(ma.l,unlist)
  ma.len<-lapply(ma.length,length)
  ma.len<-which(ma.len>0)
  ma.len
  ma.t<-ma.l[ma.len]
  #ma.t<-ma.len
  ### TODO 15052.1
  ma<-data.frame(ma.t)
  ma
  ma$text<-k
  ma
  ma[is.na(ma)]<-F
  ma
  ann.gna.lm<-ma
  ann.ng<-ann.gna.lm$ann.ngram
  ann.ng
  return(list(ann.ng=ann.gna.lm))
}
get.ann.gna.l<-function(ann.gna){
  ann.gna.l<-lapply(seq_along(1:length(unique(ann.gna$line))),function(i){
    l<-ann.gna[ann.gna$line==i,]
  })
return(ann.gna.l)  
}
post.ann<-function(t.line,ann.gna,s,k){
  t.line
  ann.gna
  ann.gna.l<-get.ann.gna.l(ann.gna)
  s
  k
  #ann.gna.l<-list()
  # ann.gna.l<-lapply(seq_along(1:length(ann.gna$line))),function(i){
  #   l<-ann.gna[ann.gna$line==i,]
  # })
  # ann.gna.l
  ### critical #############################
  ann.match<-get.ann.match(t.line,ann.gna.l,k)
  ann.match
  #d1$Segment[ann.match$ann.row] #chk
  ### NO >
  ann.row<-ann.match$ann.ng$ann.d1.line
  ann.row<-unique(ann.row)
  d1$Segment[ann.row] #chk
  ann.ng<-ann.match$ann.ng$ann.ngram
  ann.ng
  #for (ma==T)
  #   msub<-gsub(ann[ma],paste0("<ann>",ann[ma],"</ann>"),t)
  ann.gsub<-paste0("(",paste0(ann.ng,collapse = "|"),")")
  ann.gsub
  ann.row
  ann.coded<-d1$Segment[ann.row]
  ann.coded
  t.line
  #msub<-gsub(ann[ma],paste0('<span style="background-color:#ff0;">',ann[ma],'</span>'),t)
  m<-grep(ann.coded,t.line)
  msub<-gsub(ann.gsub,paste0('<span style="background-color:#ff0;">','\\1','</span>'),t.line)
  if(length(m)>0)
    msub<-gsub(ann.coded,paste0('<span style="background-color:#ff0;">',ann.coded,'</span>'),t.line)
  # msub<-apply(ann.ng.df,MARGIN=1,FUN=function(x)gsub(x,paste0('<span style="background-color:#ff0;">',x,'</span>'),t))
  msub
  #dim(ann.ng.df)
  ann.com<-d1$Kommentar
  
  mcom<-ann.com[ann.row]
  mcom<-unique(mcom)
  mcom[is.na(mcom)]<-""
  mcom
  # mcom<-paste0('<span style="background-color:#fbb;">',mcom,'</span>')
  mcom<-paste0('<span style="font-style:oblique;color:red;">',mcom,'</span>')
  mtag<-d1$Code[ann.row]
  mtag<-unique(mtag)
  mdf<-data.frame(text.nr=k,line=s,text=msub)
  for(t in 1:length(mtag)){
    code<-paste0('<b><i>',mtag[t],'</i></b>')
    mdf<-rbind(mdf,c(text.nr=k,line=code,text=mcom[t]))
  }
  return(list(df=mdf,ann.row=ann.row))
  # mdf$line<-d1$Code[ma]
} # post.ann()

get.ann.tx<-function(t){
  ann.df<-data.frame(text.nr="",line="",text="")
  rdf<-ann.df
  #split_text.l <- lapply(t,function(x)split_at_n_words(x, 20))
  t.annotated<-lapply(seq_along(1:length(t)), function(i){
  t3<-split_at_n_words(t[i],20)
  print(i)
  t4<-data.frame(id=i,text=unlist(t3))
  print(t4)
  return(t3)
  })
  t.annotated[[2]]
  #k<-1
  t3<-t.annotated
  length(t3) # 6 texts
  length(unlist(t3)) # 24 lines
  t3
  #########################
  ### loop over texts
  k<-1
  #t3[[5]]
  d1$Anfang
  # d1$Anfang<-d1$Anfang-1
  # d1$Ende<-d1$Ende-1
  for(k in 1:length(t3)){
    tx<-t3[[k]]
    tx<-unlist(tx)
    tx
   # m<-grep(tx,text)
   # t<-unlist(strsplit(tx," "))
#  ann<-strsplit(d1$Segment," ")
  ann.all<-d1$Segment
  ann.all
  ann<-d1$Segment[d1$Anfang==k]
  ann.coded<-ann # all coded segments content in text
  code<-d1$Code[d1$Anfang==k] # all codes assigned in text
  #t<-tx
  #t
  ### if there is annotation:
  if(length(ann)>0){
  ann.which<-data.frame(ann=1:length(ann),ann.which=which(ann.all%in%ann))
  ann.which<-data.frame(ann=1:length(ann),ann.which=which(ann.all%in%ann))
  ann.which
########################################
    # TODO: get 3-grams to match in line
  #i
  # get 3&2grams of segments
  ann
  ann.g<-lapply(seq_along(1),function(x){get.ngrams(ann,i,3)})
  ann.g.1<-lapply(seq_along(1),function(x){get.ngrams(ann,i,1)})
 ann.g 
  ann.g[[1]]
  ann.gna<-ann.g[[1]][!is.na(ann.g[[1]]$ngram),]
  ann.g.1[[1]]
  ann.which
  ann.gna$d1.line<-apply(ann.gna,MARGIN = 1,FUN = function(x){
    m<-grep(x,ann.which$ann)
   # print(m)
    return(ann.which$ann.which[m])
  })
  ##
  ann.gna
########################################
  #t
#  x<-ann.g[[1]]$ngram[19]
    #ma<-lapply(ann,function(x)grepl(x,t))
  #rm(x)
  ####################################
  #tx<-t.line
##########################
########################
 #t.line<-tx[s]
  #######################
  } #end if annotation
  s<-2
  ### loop over textlines
 rdf.top<-data.frame(text.nr=k,line="",text="")
 for(s in 1:length(tx)){
 line.ns<-paste0(k,".",s)
 t.line<-tx[s]
 t.line
 rdf<-data.frame(text.nr=k,line=s,text=t.line)
 rdf
 # ann.row<-unique(ann.row)
 # ann.com<-d1$Kommentar[ann.row]
 # ann.coded<-d1$Segment[ann.row]
 # ann.coded<-unique(ann.coded)
 
 msub<-"no ann"
 #ann.ng.df
 ann.ng<-NULL
 if(length(ann)>0){
 ann.gna.l<-get.ann.gna.l(ann.gna)
   
 ann.match<-get.ann.match(t.line,ann.gna.l,k)
 ann.match
 ann.ng<-ann.match$ann.ng
 ann.ng
 }
 #ifelse(length(ann[ma])>0,rdf<-rbind(ann.df,post.ann()),rdf<-rbind(ann.df,rdf))
 ifelse(length(ann.ng)>0,rdf<-post.ann(t.line,ann.gna,s,k)$df,rdf)
 rdf
 rdf.top<-rbind(rdf.top,rdf)
 }
rdf.top 
# ann.df
  ann.df<-rbind(ann.df,rdf.top)
# ann.df2<-rbind(ann.df[,1:2],rdf[,1:2],after = length(ann.df$line))
 ann.df
  }
  return(ann.df)
  
  }
ann.p<-get.ann.tx(t)

library(knitr)
writeLines(knitr::kable(ann.p),"~/Documents/GitHub/SPUND-LX/szondi/WITprose/ann.output.md")



