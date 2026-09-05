src<-paste0(Sys.getenv("GIT_TOP"),"/benjaminfeldkraft/corpus/benjaminfeldkraft.vert")
c<-read.csv(src,skip=4,sep="\t")
colnames(c)<-c("token","pos","lemma")
m1<-grepl("ich",c$token)
setwd(paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/play/ada"))
sum(m1)
#install.packages("clipr")
library(clipr)
write_clip(which(m1))
15 %% 12
16 %% 12
16 %% 35
17 %% 35
36 %% 35

notes = c("C", "C#", "D", "Eb", "E", "F", "F#", "G", "Ab", "A", "Bb", "B")
ncpt<-rep(notes,10)
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
s1
256*2+11
s2<-rep(s1,each=2)
s2
mid1$X2[12:(length(s2)+11)]<-s2
fns<-"fiben01.csv"
fout<-"fiben01.mid"
colnames(mid1)<-c(0,0,"Header",1,2,480)

write.csv(mid1,fns,row.names=F,quote=F)
mid2<-readLines(fns)
mid2
mid2[1]<-"0,0,Header,1,2,480"
writeLines(mid2,fns)
system(sprintf("csvmidi %s %s",fns,fout))
# mmod<- paste(mmod,collapse = " ")

write_clip(mmod)

