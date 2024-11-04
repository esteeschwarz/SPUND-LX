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
  n4
  getwd()
  write.csv(n3,"data/plagiat-noun-range.csv")
  write.csv(n4,"data/plagiat-metaphor-range.csv")
  m5<-d3$lemma[m3[m4]]%in%n4
  d3$token[m3[m4]][m5]
  d5<-d3
  d5$token[m3[m4]][m5]<-paste0("<#>",d5$token[m3[m4]][m5],"<#>")
  d5$sentence[m3[m4]][m5]<-mapply(gsub,d3$token[m3[m4]][m5],d5$token[m3[m4]][m5],d5$sentence[m3[m4]][m5])
head(d5$sentence[m3[m4]][m5])
head(d5$token[m3[m4]][m5])
head(d3$token[m3[m4]][m5])
d6<-unique(d5$sentence[m3[m4]][m5])
d7<-strsplit(d6,"<#>")
d8<-lapply(d7,unlist)
d8<-matrix(unlist(d7),ncol = 3)
d9<-d5$date[m3[m4]][m5]
  head(d6)
  write.csv(d6,"data/plagiat-metaphor-sentence.csv")
}
length(unique(d5$doc_id))
d5$id<-gsub("doc","",d5$doc_id)
x<-d5$id[1]
get.date<-function(x){
  m<-x==d1$No.
  d1.date<-unique(d1$Date[m])
  d1.year<-strsplit(d1.date,"-")[[1]][1]
}

m6.date<-lapply(d5$id,get.date)
head(m6.date)
d5$date<-unlist(m6.date)
# plot over years
d9<-d5$date[m3[m4]][m5]
head(d9)
#d10<-strsplit(d5$date,"-")
head(d10)
save(d5,file = "d5.token-df.RData")

### sketchengine
d11<-read.csv("/Users/guhl/boxHKW/21S/DH/local/SPUND/corpuslx/intLX/ske_plagiat.csv",skip = 4)

### nexis
library(LexisNexisTools)
?lnt_read
d12<-lnt_read("/Users/guhl/boxHKW/21S/DH/local/SPUND/corpuslx/intLX/nexis-plagiat.DOCX")
head(d12)
d13<-lnt_convert(d12,"data.frame","articles")


