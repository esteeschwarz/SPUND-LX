f<-paste0(Sys.getenv("HKW_TOP"),"/AVL/2025/nietzsche/corpus")
ff<-list.files(f,pattern="txt",full.names=T)
ff
library(readtext)
t2<-readtext(ff[2])$text
ra<-c("ii","ü","adk","ack","di ","ch ","fie([ rs])","ße\\1",
"Tur","Tür","fi ","ß ","horte","hörte","Rochel","Röchel",
"Manner","Männer","walder","wälder","Hohe ","Höhe ","Hande ","Hände ",
"Zartlichkeit","Zärtlichkeit","zartlich","zärtlich","Bose","Böse",
"Gotter ","Götter ","verachtlich","verächtlich")
rl<-length(ra)
sl1<-1:rl
sl2<-2:(rl)
sl1<-1:(rl-1)
slm<-matrix(1:length(ra),nrow=2)
sl1<-slm[1,]
sl2<-slm[2,]
length(sl1)
t3<-t2
for(k in 1:length(sl1)){
  
  t3<-gsub(ra[sl1[k]],ra[sl2[k]],t3)
}
ra[sl1]
writeLines(t3,ff[2])
