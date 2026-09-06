src<-paste0(Sys.getenv("GIT_TOP"),"/benjaminfeldkraft/corpus/benjaminfeldkraft.vert")
c<-read.csv(src,skip=4,sep="\t")
colnames(c)<-c("token","pos","lemma")
m1<-grepl("ich",c$token)
setwd(paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/play/ada"))
sum(m1)
#install.packages("clipr")
# library(clipr)
# write_clip(which(m1))
15 %% 12
16 %% 12
16 %% 35
17 %% 35
36 %% 35

notes = c("C", "C#", "D", "Eb", "E", "F", "F#", "G", "Ab", "A", "Bb", "B")
ncpt<-rep(notes,3)
ncpt
l<-length(ncpt)
mmod<-which(m1) %% l
head(mmod,20)
head(ncpt[mmod],20)

mid1<-read.csv("fi01.csv")
midh<-mid1[1:11,]
midh
colnames(midh)
s1<-ncpt[mmod[1:256]]
s1<-mmod[1:256]
s1<-s1+60-10
256*2+11
s2<-rep(s1,each=2)
s2
s3<-mmod
h1<-mid1[1:11,]
f1<-mid1[(length(mid1$Header)-1):length(mid1$Header),]
f1
h1
l<-length(mmod)
l
p<-function(x){x+192}
pr<-0:l
lp<-1:l
for(k in 2:l){

lp[k]<-p(pr[k])
}
head(lp,100)
head(k)
pr<-unlist(lapply(pr,function(x){
  p0<-p(x)
}))
pr
mid1[12:20,]
mid1$X2[12:(length(s2)+11)]<-s2
fns<-"fiben01.csv"
fout<-"fiben-ich.mid"
colnames(mid1)<-c(0,0,"Header",1,2,480)

write.csv(mid1,fns,row.names=F,quote=F)
mid2<-readLines(fns)
mid2
mid2[1]<-"0,0,Header,1,2,480"
writeLines(mid2,fns)
system(sprintf("csvmidi %s %s",fns,fout))
# mmod<- paste(mmod,collapse = " ")

#write_clip(mmod)

