# 20260309(13.58)
# 16113.germanic.pos-tagging
############################

#library(reticulate)
# 
# #reticulate::py_install("stanza")
# reticulate::py_require(c("stanza","numpy"))
# stanza <- import("stanza")
# import("numpy")
# import("torch")
# reticulate::py_config()
#install.packages("reticulate")
#sudo apt install libpng-dev
#install.packages("png")
library(reticulate)
#reticulate::py_exe()

#reticulate::install_python("3.10:latest") #!not on mini! (via apt)
# sudo apt update
# sudo apt install software-properties-common

# sudo add-apt-repository ppa:deadsnakes/ppa
# sudo apt update
#sudo apt install python3.10 python3.10-venv python3.10-dev
#no use_python("/usr/bin/python3.10", required = TRUE)

#virtualenv_create("stanza-env-3.10",python = "3.10")
#install
#wks.
use_virtualenv("stanza-env-3.10", required = TRUE)
py_config()
#py_install(c("stanza", "torch", "numpy<2"), pip = TRUE)
#.rs.restartR() #no.
# restart with new numpy!
stanza <- import("stanza")
#stanza$download("de")
nlp <- stanza$Pipeline(lang="de",processors="tokenize,pos,lemma",use_gpu=TRUE)

fun1<-function(){
  doc <- nlp(c("In der Linguistik\n\nuntersuchen wir neben Reichtumsberichten\n\nauch die Sprache."))
docl<-list(doc)
docls<-docl[[1]]$sentences
x<-docdf[[1]]
docdf<-fromJSON(as.character(doc),flatten = T)
docli<-lapply(seq_along(docdf), function(i){
#  d<-fromJSON(as.character(x),flatten = T)
  d<-data.frame(docdf[[i]])
  d<-d[,c(1,2,3,4,5)]
  d$sent<-i
  return(d)
})
docldf<-data.frame(abind(docli,along = 1))
library(jsonlite)
docdf<-fromJSON(as.character(doc),flatten = T)
for (sentence in doc$sentences) {
  for (word in sentence$words) {
    print(c(word$text, word$upos, word$lemma))
  }
}
ddf<-data.frame(abind(docdf,along = 1))
df$summary<-gsub("\n","\n\n",df$summary)
td<-btt.summaries[1,]
}
library(abind)
  library(jsonlite)
td<-df2[1,]
get.pos<-function(td){
  tx<-td$text
  tl<-unlist(strsplit(tx,"\n"))
#  tx<-gsub("\n","\n\n",tx)
  print("apply nlp...")
  i<-1:2
  doc <- lapply(seq_along(tl),function(i){
    cat("nlp...:",i,"of",length(tl),"lines...\t\r")
    doc<-nlp(tl[i])
  })
  #doc
#  install.packages("abind")
  
 # docdf<-data.frame(abind(doc,along = 1))
  ii<-3
  docli<-lapply(seq_along(doc), function(ii){
  # docdf<-data.frame(abind(doc,along = 1))
   docdf<-fromJSON(as.character(doc[[ii]]),flatten = T)
  #docdf<-data.frame(bind_rows(docdf,along = 1))
  df<-lapply(docdf, function(x) {
  x$id <-ii
  
  return(x)
  })
    df <- dplyr::bind_rows(df)
    if(length(docdf)==0)
    return(NA)
    docdf<-df
    df
    docdf$id<-as.character(docdf$id)
    docdf$id<-gsub(",","-",docdf$id)
  cat("\t\t\t\t, apply nlp doc to df -",ii,"of",length(docdf),"\r")
    #  d<-fromJSON(as.character(x),flatten = T)
    d<-data.frame(docdf)
    d$text<-gsub("\n","",d$text)
    d$lemma<-gsub("\n","",d$lemma)
    d$id<-as.character(d$id)
    d<-d[,c(1,2,3,4,5)]
    d$sent<-ii
    d
    return(d)
  })
   docli
  # ?abind
  # sapply(docli, ncol)
  # dim(abind(docli,along = 1))
  # docldf<-rbind(docli)
#   docldf<-dplyr::bind_rows(docli)

#  doc
  docli<-docli[!is.na(docli)]
  docldf<-data.frame(abind(docli,along = 1))
  # docldf
  docldf$date<-td$date
  cat("\nget.pos() finished...\n")
  return(docldf)
}

# load(paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/huening/btt.summaries.RData")) # protocols + gpt summary texts 
# load(paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/huening/ptdf_btt03.RData")) # protocols all
# df<-btt.summaries
# colnames(btt.summaries)
# colnames(ptdf.2)
# btt.summaries<-btt.summaries[,c(1,3)]
# colnames(btt.summaries)<-c("date","text")
# range<-1:3
# pos.btt<-lapply(seq_along(range), function(i){
#   p<-get.pos(btt.summaries[i,])
# })
# pos.bt.df<-data.frame(abind(pos.btt,along = 1))
### wks.