# 20251203(16.21)
# 16495.process.DAIS
####################
dais.top<-"/Users/guhl/boxHKW/UNIhkw/21S/DH/local/SPUND/2025/hux/DAIS-C-Annotated - Upload"
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
?udpipe::udpipe_load_model()
model<-udpipe::udpipe_load_model(paste0(Sys.getenv("HKW_TOP"),"/SPUND/english-ewt-ud-2.5-191206.udpipe"))
fcl.df<-lapply(fcl, function(x){
  f<-paste(cl.raw,x,sep="/")
  t<-readLines(f)
  df<-udpipe::udpipe_annotate(model,t)  
})
fco.df<-lapply(fco, function(x){
  f<-paste(co.raw,x,sep="/")
  t<-readLines(f)
  df<-udpipe::udpipe_annotate(model,t)  
})
df.pos<-list(co=fco.df,cl=fcl.df)
save(df.pos,file = paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/hux/df.pos.RData"))
