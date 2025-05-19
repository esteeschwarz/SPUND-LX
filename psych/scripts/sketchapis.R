#20250518(13.40)
#15212.stef_psych.reddit.corpus.essais
#no sketchengine api fetch
##########################

#d<-read.csv(paste(Sys.getenv("HKW_TOP"),Sys.getenv("CRED_GEN"),sep = "/"))
#12367.sketchenginge API request
library(httr)
library(jsonlite)
library(purrr)
# USERNAME = d$bn[d$q=="sketch"]
# API_KEY = d$key[d$q=="sketch"]
BASE_URL = 'https://api.sketchengine.eu/bonito/run.cgi'
BASE_URL <- "https://corp.dh-index.org/ske"
endpoint<-"/freqs?"
endpoint<-"/concordance?"
  skurl<-paste0(BASE_URL, endpoint)
  skurl
  window<-10
  cql<-'[lemma="language"]'
  cql<-'[word="mother"] [word="tongue"]'
 # cql<-'[word="I"] [word="have"]'
  query<-list(
    #corpname='user/st.schwarz/benjamin13',
   # corpname="preloaded/detenten20_rft3",
  #  corpname="preloaded/bnc2_tt31",
    corpname="reddit-psych",
    ###################################
    #q='q[lemma="shimmer" & tag="V.*"]',
   # q='q[word="language"] within <doc author="(.*)" />',
    q=paste0('q',cql),
    fcrit="author",
     attrs="word,pos,lemma",
     structs="s,doc",
     refs="doc.id,doc.author",
     ctxattrs="word,pos,lemma",
     context=paste0(window,"+",window),
     viewMode="json",
    ###################################
    pagesize=500,
    shorten_refs=0
    
#    refs='=doc.website,=doc.url,=doc.title'
#   view="kwic"
  #format="json"
  )
  # deeps
  # [word="your_target_word"] within <struct author="(.*)" />
#  skurl<-paste0(BASE_URL, "/extract_keywords?")
  # query<-list(
  #   attr='word',
  #   max_keywords=20,
  #   corpname='user/st.schwarz/benjamintest02',
  #   ref_corpname="preloaded/detenten20_rft3"
  #   #q='q[word=""]',
  #   #  tag='N.*',
  #   #pagesize=20,
  #   #shorten_refs=0,
  # 
  # #  refs='=doc.website,=doc.url,=doc.title'
  #   #   view="kwic"
  #   #format="json"
  # )
  # #d<-GET(url=skurl,authenticate(USERNAME,API_KEY),query=query)
  d<-GET(url=skurl,query=query)
  query
  

  # library(RCurl)
# curlUnescape("refs=%3Ddoc.website%2C%3Ddoc.url%2C%3Ddoc.title%2C")
x<-content(d,"text")
#x
xdf<-jsonlite::fromJSON(x)
gq<-xdf$Desc$tourl
gq
# library(clipr)
# write_clip(gq)
xdf.l<-xdf$Lines
auth<-unlist(xdf.l$Refs)
auth<-auth[grep("author",auth)]

aut.e<-t(data.frame(strsplit(auth,"=")))
xdf.l$author<-aut.e
#aut.e<-aut.e
#xdf.l$Refs
#xdf$keywords
#unlist(xdf.l["Left"])
# getq<-function(x)paste(unlist(x[,1]),collapse = " ")
#x<-xdf.l$Kwic
getk<-function(x){
  k<-unlist(x[[2]])
  k<-gsub(" ","",k)

  
  #k[,2]
  u<-k[[2]]
  u
  k
  u
  u<-paste0(unlist(k),collapse = " ")
  #u2<-u
}
unlist(lapply(xdf.l$Kwic, getk))
# xdf.e<-data.frame(left=lapply(xdf.l$Left, getq),kwic=lapply(xdf.l$Kwic, getk),right=lapply(xdf.l$Right, getq))
getq<-function(x){
  # 15213.messed up func, REDO, TODO: NA insert around target left-right; as of now right context NA+context (like left) instead context+NA / fiddle lapply to pass context dir
  l<-x[,1]
  #l<-ml$str
  l<-l[!is.na(l)]
  le.l<-length(l)
  ld<-window-le.l
  print(le.l)
  print(ld)
  if(le.l<window)
    l<-c(rep(NA,ld),l)
  # if(le.l<window&dir=="r") # how to get context if right/left?
  #   l<-c(l,rep(NA,ld))
  le.l<-length(l)
  ld<-le.l-window
  cat("2nd\n")
  print(le.l)
  print(ld)
  if(ld>=0)
    l<-l[(ld+1):le.l]
  return(l)
}
xdf.e<-data.frame(left=paste(unlist(xdf.l$Left),collapse = " "),kwic=paste0(xdf.l$Kwic$str,collapse = " "),right=paste(unlist(xdf.l$Right),collapse = " "))
#xdf.e<-list()
xdf.e.m<-matrix(NA,nrow = length(xdf.l$toknum),ncol = (window*2+1))
xdf.e.df<-data.frame(xdf.e.m,id=1:length(xdf.l$toknum))
i<-1
#ml<-lapply(xdf.e.df,FUN =getq(xdf.e.df,dir = "l"))
  
# ml<-lapply(seq_along(xdf.l$Left), function(x,i,dir){
#   l<-xdf.l$Left[i]$str
#   l
#   l<-l[!is.na(l)]
#   le.l<-length(l)
#   ld<-window-le.l
#   print(le.l)
#   print(ld)
#   if(le.l<window&dir=="l")
#     l<-c(rep(NA,ld),l)
#   if(le.l<window&dir=="r")
#     l<-c(l,rep(NA,ld))
#   le.l<-length(l)
#   ld<-le.l-window
#   cat("2nd\n")
#   print(le.l)
#   print(ld)
#   if(ld>=0)
#     l<-l[(ld+1):le.l]
#   return(l)
# })
library(abind)
mldf<-t(data.frame(lapply(xdf.l$Left, getq)))
xdf.e.df[,1:window]<-mldf
mr<-lapply(xdf.l$Reft, getq)
#library(abind)
mrdf<-t(data.frame(lapply(xdf.l$Right, getq)))
kwic.p<-window+1
xdf.e.df[,(window+2):(length(xdf.e.df)-1)]<-mrdf
xdf.e.df[,(kwic.p)]<-unlist(lapply(xdf.l$Kwic, getk))
xdf.e.df$author<-xdf.l$author[,2]
colnames(xdf.e.df)<-c(paste0("t-",window:1),"kwic",paste0("t+",1:window),"id","author")
xdf.e.df.2<-xdf.e.df
x.ns<-colnames(xdf.e.df)
m<-grep("id|author",x.ns)
ml<-grepl("id|author",x.ns)
#x.ns.p<-c(m)
xdf.e.df.2<-xdf.e.df[,c(m,which(!ml))]
kwic.df<-xdf.e.df.2
write.csv(kwic.df,paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/psych/data/q_lemma_language.csv"))



