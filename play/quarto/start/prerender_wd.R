setwd(paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/play/quarto/start"))

dep1<-function(){
  load("margindb.RData")
  q<-"LFG"
  ds<-margindb$dbsub
  unique(ds$study)
  
  unique(cnote$ZCURRENTTOPICID)
   length(unique(tabd$ZTOPICID))
  length(unique(tabd$ZCURRENTTOPICID))
  ### random walk
  rw<-lapply(td,function(x){
    m<-is.na(x)
    print(sum(m),na.rm=T)
    d<-x[!m]
    cat("--- length ---\n")
    print(l<-length(d))
    sl<-20
    if(l<sl)
      return(NA)
    s<-sample(length(d),sl)
    s<-d[s]
  })
  library(abind)
  rw<-rw[!is.na(rw)]
  d<-data.frame(abind(rw,along=2))
  length(unique(td$ZEVERNOTEID))
  length(unique(td$ZTOPICID))
 length(unique(td$ZCURRENTTOPICID))
length(unique(td$ZTITLE))
  tid<-unique(td$ZTOPICID)
  z<-unique(td$ZTITLE)
ss<-margindb$dbsub[margindb$dbsub$study=="nietzsche",]
  ss$notes[!is.na(ss$notes)]
  unique(ss$doc)
  ss$notes[ss$doc[grep("genealogie",ss$doc)]]
  m<-grepl("genealogie",ss$doc)
  sum(m)
  ss$notes[m]
}