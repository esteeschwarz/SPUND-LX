t<-read.csv(paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/kblh/letters.csv"))
########
wd<-"יצר"
wd<-"ברחמימ"
wd<-"לב"
wd<-"כבוד"
########
s<-unlist(strsplit(wd,""))
v<-lapply(s, function(x){
  m<-t$letter==x
  v<-t$numeric_value[m]
})          
v<-unlist(v)
vc<-sum(v)
vc
