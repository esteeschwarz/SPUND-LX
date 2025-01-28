
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
k<-1
i<-1
rm(i)
target.l<-strsplit(d1$Segment," ")
}
### from here
######################################################################
txtsrc<-"/Users/guhl/boxHKW/21S/DH/local/AVL/2024/WIT/wiki/ff.exb.txt"
t<-readLines(txtsrc)
window<-18
library(readxl)
library(stringdist)
library(purrr)
library(abind)

d1<-read_xlsx("/Users/guhl/Documents/GitHub/SPUND-LX/szondi/WITprose/ff_Codierte Segmente.xlsx")
### set 15054
d1<-read_xlsx("/Users/guhl/Documents/GitHub/SPUND-LX/szondi/WITprose/ff-codes_2.xlsx")
# alte pdf annotations, will be merged in script
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

#########################
library(tidytext)
get.ngrams<-function(ann,i,out){
   text<-ann
   ann
ann.single<-find.single.ann(ann)
out<-3
      print(text)
   print(length(text))
   print("get.ngrams...")
   text_df <- data.frame(line = 1, text = "#NO TEXT#", stringsAsFactors = FALSE)
     text_df <- data.frame(line = 1:length(text), text = text, stringsAsFactors = FALSE)
  
  # Tokenize the text into n-grams (2-5 grams)
     ngrams_df.1 <- text_df %>%
       unnest_tokens(ngram, text, token = "ngrams", n = 1)
     if(length(ann.single)>0){
       out<-1
   m<-grepl(ann.single,ngrams_df.1$ngram)
   ngrams_df.1
   ngrams_df.1<-ngrams_df.1[m,]
}
   ngrams_df.2 <- text_df %>%
     unnest_tokens(ngram, text, token = "ngrams", n = 2)
   ngrams_df.3 <- text_df %>%
     unnest_tokens(ngram, text, token = "ngrams", n = 3)
   ngrams_df.4 <- text_df %>%
     unnest_tokens(ngram, text, token = "ngrams", n = 4)
   ngrams_df.5 <- text_df %>%
     unnest_tokens(ngram, text, token = "ngrams", n = 5)
   ngrams_df.6 <- text_df %>%
     unnest_tokens(ngram, text, token = "ngrams", n = 6)
   # no.
   ifelse(out==1,ngrams_df<-rbind(ngrams_df.1,ngrams_df.2,ngrams_df.3,ngrams_df.4,ngrams_df.5,ngrams_df.6),
          ngrams_df<-rbind(ngrams_df.2,ngrams_df.3,ngrams_df.4,ngrams_df.5,ngrams_df.6))
   mn<-is.na(ngrams_df$ngram)
   ngrams_df.out<-ngrams_df[!mn,]
   
   print("finished...")
   return(ngrams_df.out)
}
#########################
get.ann.match<-function(t.line,ann.gna.l,k){
  ann.gna.l
   t.line
   print("get.ann.match...")
   print("ann.gna.l:")
   print(ann.gna.l)
   ma.l<-lapply(seq_along(1:length(ann.gna.l)),function(i){
     ann.i<-ann.gna.l[[i]]
     ma.l<-apply(ann.i,MARGIN=1,FUN=function(x)grepl(x[2],t.line))
     mw<-which(ma.l)
     print(ann.i[mw,])
     #m<-ma.l==T
     set<-data.frame(m=mw,ann=ann.i[mw,])
     print(set)
     print("ma.l...")
     return(set)
     })
  print("ma.l set...")
  print(ma.l)
  ma.length<-lapply(ma.l,unlist)
  ma.len<-lapply(ma.length,length)
  ma.len<-which(ma.len>0)
  ma.len
  ma.t<-ma.l[ma.len]
  #ma.t<-ma.len
  ma.t
  ma.b<-data.frame(abind(ma.t,along = 1))
  ma.b
  ### TODO 15052.1
  ma<-ma.b
#  ma<-data.frame(ma.t)
  print("ma...")
  print(ma)
  if(print(length(ma)>0))
    ma$text<-k
  ma
  ma[is.na(ma)]<-F
  ma
  ann.gna.lm<-ma
  ann.ng<-ann.gna.lm$ann.ngram
  ann.ng
  print("finished...")
  return(list(ann.ng=ann.gna.lm))
}
get.ann.gna.l<-function(ann.gna){
  print("get.ann.gna.l...")
  ann.gna.l<-lapply(seq_along(1:length(unique(ann.gna$line))),function(i){
    l<-ann.gna[ann.gna$line==i,]
  })
  print("finished...")
return(ann.gna.l)  
}
#######################################
post.ann<-function(t.line,ann.gna,s,k,single){
  print("post.ann...")
  t.line
  ann.gna
  ann.gna.l<-get.ann.gna.l(ann.gna)
  ann.gna.l
  s
  k
  ### critical #############################
  ann.match<-get.ann.match(t.line,ann.gna.l,k)
  ann.match
  ### NO >
  ann.row<-ann.match$ann.ng$ann.d1.line
  ann.row<-as.double(unique(ann.row))
  d1$Segment[ann.row] #chk
  ann.ng<-ann.match$ann.ng$ann.ngram
  ann.ng
  ann.gsub<-paste0("(",paste0(ann.ng,collapse = "|"),")")
  ann.gsub
  ann.row
  ann.coded<-d1$Segment[ann.row]
  ############################
  ann.coded<-unique(ann.coded)
  ############################
  t.line
  ### replace ngrams
  ifelse(output.rmd=="html",
  msub<-gsub(ann.gsub,paste0('<span style="background-color:#ff0;">','\\1','</span>'),t.line),msub<-gsub(ann.gsub,'\\\\colorbox{yellow}{\\1}',t.line))
  
  msub
  ### replace whole annotation
  for(ac in ann.coded){
    
    m<-grep(ac,t.line)
 # ac<-"test"
  if(length(m)>0)
    ifelse(output.rmd=="html",
           msub<-gsub(ac,paste0('<span style="background-color:#ff0;">',ac,'</span>'),t.line)
           ,msub<-gsub(ac,paste0('\\\\colorbox{yellow}{',ac,'}'),t.line))
#    msub<-gsub(ac,paste0('<span style="background-color:#ff0;">',ac,'</span>'),t.line)
  
}
  msub
  ann.com<-d1$Kommentar
  mcom<-ann.com[ann.row]
  mcom[is.na(mcom)]<-""
  #mcom<-unique(mcom)
  mcom
  Column1 = c('Text with \\textcolor{red}{ red}',
              'Text in \\textbf{boldit}',
              'Text on \\textit{\\colorbox{yellow}{yellow background}}')
#  mcom<-paste0('<span style="font-style:oblique;color:',obliq.color,';">',mcom,'</span>')
  ifelse(output.rmd=="pdf",mcom<-paste0('\\textcolor{red}{\\textit{',mcom,'}}'),
         mcom<-paste0('<span style="font-style:oblique;color:red;">',mcom,'</span>'))
  mtag<-d1$Code[ann.row]
  mtag[is.na(mtag)]<-""
#  mtag<-unique(mtag)
  mdf<-data.frame(TNr=k,line=s,text=msub)
  for(t in 1:length(mtag)){
    code<-paste0('<b><i>',mtag[t],'</i></b>')
    mdf<-rbind(mdf,c(TNr=k,line=code,text=mcom[t]))
  }
  print("finished post")
  return(list(df=mdf,ann.row=ann.row))
  # mdf$line<-d1$Code[ma]
} # post.ann()

find.single.ann<-function(ann){
  ts<-strsplit(ann," ")
  ts.1<-ts[lapply(ts,length)==1]
  ts.1<-unlist(ts.1)
  ts.2<-ts[ts.1]
  return(ts.1)
}
#window<-20
get.ann.tx<-function(t){
  ann.df<-data.frame(TNr="",line="",text="")
  rdf<-ann.df
  t.annotated<-lapply(seq_along(1:length(t)), function(i){
  t3<-split_at_n_words(t[i],window)
  print(i)
  t4<-data.frame(id=i,text=unlist(t3))
  print(t4)
  return(t3)
  })
  t.annotated[[2]]
  t3<-t.annotated
  length(t3) # 6 texts
  length(unlist(t3)) # 24 lines
  t3
  #########################
  ### loop over texts
  k<-2
  d1$Anfang
  ### which texts are annotated?
  wk<-unique(d1$Anfang)
  for(k in wk){
    #for(k in 1:length(t3)){
    cat("run k=",k,"\n")
    tx<-t3[[k]]
    tx<-unlist(tx)
    tx
  ann.all<-d1$Segment
  ann.all
  ann<-d1$Segment[d1$Anfang==k]
  ann.coded<-ann # all coded segments content in text
  code<-d1$Code[d1$Anfang==k] # all codes assigned in text
  ### if there is annotation:
  if(length(ann)>0){
  ann.which<-data.frame(ann=1:length(ann),ann.which=which(ann.all%in%ann))
  ann.which<-data.frame(ann=1:length(ann),ann.which=which(ann.all%in%ann))
  ann.which
########################################
    # TODO: get 3-grams to match in line
  # get 3&2grams of segments
  ann
  ann.g<-lapply(seq_along(1),function(x){get.ngrams(ann,i,3)})
  ann.g
  ann.g1<-ann.g[[1]]
  if(length(ann)>1){
    m<-apply(ann.g1, MARGIN=1,FUN=function(x){
      m<-is.na(x[2])
      ann.g1$ngram[m]<-ann[2]
    })
  }
 ann.g 
  ann.g[[1]]
  ann.gna<-ann.g[[1]][!is.na(ann.g[[1]]$ngram),]
  ann.which
  ann.gna$d1.line<-apply(ann.gna,MARGIN = 1,FUN = function(x){
    m<-grep(x,ann.which$ann)
   # print(m)
    return(ann.which$ann.which[m])
  })
  ##
  ann.gna
########################################
  #######################
  } #end if annotation
  s<-2
  ### loop over textlines
 rdf.top<-data.frame(TNr=k,line="",text="")
 for(s in 1:length(tx)){
 line.ns<-paste0(k,".",s)
 cat("run s=",line.ns,"\n")
 t.line<-tx[s]
 t.line
 rdf<-data.frame(TNr=k,line=s,text=t.line)
 rdf
 msub<-"no ann"
 ann.ng<-NULL
 ann
 if(length(ann)>0){
 ann.gna.l<-get.ann.gna.l(ann.gna)
 ann.gna.l  
 ann.match<-get.ann.match(t.line,ann.gna.l,k)
 ann.match
 ann.ng<-ann.match$ann.ng
 ann.ng
 }
 ifelse(length(ann.ng)>0,
        rdf<-post.ann(t.line,ann.gna,s,k,single=F)$df,rdf)
 rdf
 rdf.top<-rbind(rdf.top,rdf)
 }
rdf.top 
  ann.df<-rbind(ann.df,rdf.top)
 ann.df
  }
  colnames(ann.df)<-c("n  ","line","text")
  m1<-ann.df$text==""
  ann.df<-ann.df[!m1,]
  m2<-grep("[0-9]",ann.df$line)
  ann.df[m2,1]<-paste0(ann.df[m2,1],"-")
  rownames(ann.df)<-paste0("L:",1:length(ann.df$line))
  ann.df<-cbind(id="\t",ann.df[,1:length(ann.df)])
    
  return(ann.df)
  }
####################
### RUN
ann.p<-get.ann.tx(t)
# m1<-ann.p$text==""
# sum(m1)
# ann.p<-ann.p[!m1,]
# m2<-grep("[0-9]",ann.p$line)
# ann.p[m2,1]<-paste0(ann.p[m2,1],"---")
####################
library(knitr)
writeLines(knitr::kable(ann.p),"~/Documents/GitHub/SPUND-LX/szondi/WITprose/ann.output.md")

#?render
# library(rmarkdown)
# render("14-wolf_handout.Rmd",output_format = "tufte::tufte_handout")
# render("tuftesample.Rmd",output_format = "tufte::tufte_handout")
