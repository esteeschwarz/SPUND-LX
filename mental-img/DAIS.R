# 20251203(16.21)
# 16495.process.DAIS
####################
dais.top<-"/Users/guhl/boxHKW/UNIhkw/21S/DH/local/SPUND/2025/hux/DAIS-C-Annotated - Upload"
########
dais.top<-"mydesktop/daiscorpusdirectory"
## adapt to the filesources on your desktop and comment out the following line
dais.top<-paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/hux/DAIS-C-Annotated - Upload")
d1<-list.dirs(dais.top)
m<-grep("Only_Raw",d1)
spk.raw<-d1[m]
m<-grep("-CL",spk.raw)
cl.raw<-spk.raw[m]
m<-grep("-CO",spk.raw)
co.raw<-spk.raw[m]
fcl<-list.files(cl.raw)
fco<-list.files(co.raw)
library(udpipe)
#udpipe::udpipe_download_model("english-ewt")
##udpipe::udpipe_load_model()
model<-udpipe::udpipe_load_model(paste0(Sys.getenv("HKW_TOP"),"/SPUND/english-ewt-ud-2.5-191206.udpipe"))
## also adapt to whre the model is saved
#filestrn<-list.files(sbctrn)
filestrn<-fcl
#trnlist<-list()
trndf<-data.frame(scb=NA,id=NA,text=NA)
k<-1
for(k in 1:length(filestrn)){
  cat(k,"\n")
  trntemp<-readLines(paste(cl.raw,filestrn[k],sep = "/"))
#  l1<-length(trntemp)
  trntext<-trntemp
#  colnames(trntext)<-"text"
  trntemp.2<-data.frame(scb=k,id=1:length(trntext),text=trntext)
  trndf<-rbind(trndf,trntemp.2)
}
trndf<-trndf[2:length(trndf$scb),]
df.cl<-trndf
trndf<-data.frame(scb=NA,id=NA,text=NA)
filestrn<-fco
for(k in 1:length(filestrn)){
  cat(k,"\n")
  trntemp<-readLines(paste(co.raw,filestrn[k],sep = "/"))
  #  l1<-length(trntemp)
  trntext<-trntemp
  #  colnames(trntext)<-"text"
  trntemp.2<-data.frame(scb=k,id=1:length(trntext),text=trntext)
  trndf<-rbind(trndf,trntemp.2)
}
df.co<-trndf[2:length(trndf$scb),]

library(quanteda)
#dfco.split<-tokens(df.co$text,remove_numbers = T,remove_punct = T,remove_symbols = T,remove_separators = T,include_docvars = T)
sbc.sub.c<-corpus(df.co,docid_field = 'scb',text_field = 'text',unique_docnames = F)
dfco.pos<-udpipe::udpipe_annotate(model,sbc.sub.c)  
#dfcl.split<-tokens(df.cl$text,remove_numbers = T,remove_punct = T,remove_symbols = T,remove_separators = T,include_docvars = T)
sbc.sub.c<-corpus(df.cl,docid_field = 'scb',text_field = 'text',unique_docnames = F)
dfcl.pos<-udpipe::udpipe_annotate(model,sbc.sub.c)  

dfcl.pos<-data.frame(dfcl.pos)
dfco.pos<-data.frame(dfco.pos)
dfcl.pos$target<-"CL"
dfco.pos$target<-"CO"
df.pos<-list(co=dfco.pos,cl=dfcl.pos)
#save(df.pos,file = paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/hux/df.pos.RData"))

# fcl.df<-lapply(fcl, function(x){
#   #f<-paste(cl.raw,x,sep="/")
#   t<-readLines(f)
#   df<-udpipe::udpipe_annotate(model,t)  
#   #df<-data.frame(df)
# })
# fco.df<-lapply(fco, function(x){
#   f<-paste(co.raw,x,sep="/")
#   t<-readLines(f)
#   df<-udpipe::udpipe_annotate(model,t)  
# })
# 
# df.pos<-list(co=fco.df,cl=fcl.df)
# #save(df.pos,file = paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/hux/df.pos.RData"))
# 
# #load(paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/hux/df.pos.RData"))
# # library(abind)
# # df.cl<-lapply(df.pos$cl,function(x){
# #   #l<-abind(data.frame(x$conllu),along = 1)
# #   return(data.frame(x$conllu))
# # })
# # df.cl[[1]]
# # df.cl<-data.frame(abind(df.cl,along = 1)
# # 
# # 
spacymodel<-"en_core_web_lg"
spacy.stopwords<-read.csv("spacy-stopwords.csv")
stopw<-c("er","erm","oh","yeah","mm","mhm","y")
stopwords<-c(spacy.stopwords$stopword,stopw)
# chunks of 10
vector <- 1:length(dfcl.pos$doc_id)
chunk_size <- 10  # Example chunk size

# Function to split the vector into chunks of equal length
split_into_chunks <- function(vec, chunk_size) {
  split(vec, ceiling(seq_along(vec) / chunk_size))
}

# Split the vector into chunks
chunks <- split_into_chunks(vector, chunk_size)


load( paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/hux/df.pos.RData"))

dfcl.pos<-df.pos$cl
dfco.pos<-df.pos$co

t1<-table(dfcl.pos$token)
t2<-table(dfco.pos$token)
tdf2<-data.frame(t2,target="co")
tdf1<-data.frame(t1,target="cl")
tdf<-rbind(tdf1,tdf2)
colnames(tdf)<-c("token","freq","target")
m<-duplicated(tdf$token)
tdf$unique<-1
m2<-tdf$token%in%tdf$token[m]
sum(m2)
tdf$unique[m2]<-0
sum(m)
m<-tdf$token%in%stopwords
sum(m)
tdf$stopword<-0
tdf$stopword[m]<-1
tdf<-tdf[order(tdf$token),]
m<-tdf$unique&!tdf$stopword&tdf$freq>6
sum(m)
tdf[m,]
# tdf.cl<-tdf[!m,]
# tdf.co<-tdf[!m,]
# tdf.cpt<-rbind(tdf.cl,tdf.co)
# tdf.cpt<-tdf.cpt[!duplicated()]
# m<-tdf.cl$token%in%tdf.co$token
write.csv(tdf,"tokenlist_DAIS-cpt.csv")

