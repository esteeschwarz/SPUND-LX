#20241103(13.19)
#15452.interN-LX.corpus.essai
#############################
q<-"https://www.dwds.de/r/?q=plagiat&corpus=dwdsxl&date-start=1897&date-end=2024&sc=adg&sc=bz&sc=blogs&sc=bundestag&sc=ddr&sc=tsp&sc=kern&sc=kern21&sc=gesetze&sc=spk&sc=politische_reden&sc=untertitel&sc=wikibooks&sc=wikipedia&sc=wikivoyage&format=max&sort=date_asc&limit=3000&view=csv"
d1<-read.csv(q)
# TASK: corpus generation to explore metaphors for "plagiat"
date.range<-unique(d1$Date)
### metaphor extraction
# approach: 
# 1. tag for nouns
library(udpipe)
# corpus object
df<-data.frame(kwic=paste(d1$ContextBefore,d1$Hit,d1$ContextAfter))
head(df)
model.f<-"~/boxHKW/21S/DH/local/SPUND/corpuslx/german-gsd-ud-2.5-191206.udpipe"
#model.f<-udpipe_download_model("german")

model.g<-udpipe_load_model(model.f$file_model)
typeof(model.g)
model.g
d2<-udpipe_annotate(model.g,df$kwic)
d3<-as.data.frame(d2)
extract.metaphors<-function(d3){
  m1<-d3$lemma=="Plagiat"
  sum(m1,na.rm = T) # 2291
  m2<-d3$upos=="NOUN"
  p1<-which(m1)+10
  p2<-which(m1)-10
  head(m1)
  head(p2)
  r1<-mapply(seq,p2,p1) # range
  r1<-unlist(r1)
  m3<-which(m2)
  m4<-m3%in%r1
  n1<-unique(d3$lemma[m3[m4]])
  n1<-n1[order(n1)]
  n2<-data.frame(noun=n1,metaphor=0)
  #n3<-order(n2,n2$noun)
  #n3<-fix(n2)
  m6<-grep("plag|Plagiat",n3$noun)
  n3$metaphor[m6]<-0
  n4<-n3$noun[n3$metaphor==1]
  write.csv(n3,"plagiat-noun-range.csv")
  write.csv(n4,"plagiat-metaphor-range.csv")
  m5<-d3$lemma[m3[m4]]%in%n4
  d4<-unique(d3$sentence[m3[m4]][m5])
  head(d4)
  write.csv(d4,"plagiat-metaphor-sentence.csv")
}