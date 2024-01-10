#20240103(07.42)
#SPUND.corpusLX.stefanowitsch.HA
################################
#study replication Q.1
Q.1<-"Mehl, S. orcid.org/0000-0003-3036-8132 (2018) What we talk about when we talk about corpus frequency: The example of polysemous verbs with light and concrete senses. 
Corpus Linguistics and Linguistic Theory. ISSN 1613-7027 https://doi.org/10.1515/cllt-2017-0039"
R.p23<-"If onomasiological frequency measurements do indeed correlate with elicitation tests, 
potential impact would be immense. Researchers would be able to examine onomasiological frequencies in spoken corpora 
rather than performing elicitation tests. That possibility would facilitate cognitive research into languages and 
varieties around the world, without the necessity of in situ psycholinguistic testing, 
and would also encourage the creation of more spoken corpora. "
###############################################################
### this script runs without local files, all data fetched from online sources.
###############################################################################
R.1<-"https://www.linguistics.ucsb.edu/research/santa-barbara-corpus"
Q.2<-"https://www.linguistics.ucsb.edu/sites/secure.lsit.ucsb.edu.ling.d7/files/sitefiles/research/SBC/SBCorpus.zip"
Q.3<-"https://www.linguistics.ucsb.edu/sites/secure.lsit.ucsb.edu.ling.d7/files/sitefiles/research/SBC/SBCSAE_chat.zip"
library(utils)
getwd()
#setwd("~/boxHKW/21S/DH/local/SPUND/corpuslx/stefanowitsch/HA")
#tempdir()
#dir.create("data")
sbctemp<-tempfile("SBCtemp.zip")
sbctempdir<-tempdir()
#download.file(Q.2,"SBC.zip")
download.file(Q.2,sbctemp)
#unzip("SBC.zip",exdir = "data")
unzip(sbctemp,exdir = sbctempdir)
#regx<-".([0-9]{1,7}_[0-9]{1,7})."

library(readr)
# # SBC001 <- read_delim("data/TRN/SBC001.trn", 
# #                      delim = "\t", escape_double = FALSE, 
# #                      trim_ws = TRUE,col_names = c("id","spk","text"))
# View(SBC001)
#filestrn<-list.files("data/TRN")
# SBC015 <- read_delim("data/TRN/SBC015.trn", 
#                      delim = "\t", escape_double = FALSE, 
#                      trim_ws = F,col_names = c("id","spk","text"))
# View(SBC014)
sbctrn<-paste0(sbctempdir,"/TRN/")
filestrn<-list.files(sbctrn)
filestrn
#trnlist<-list()
trndf<-data.frame(scb=NA,id=NA,text=NA)
for(k in 1:length(filestrn)){
  cat(k,"\n")
# trnlist[[k]]<-read_delim(paste0("data/TRN/",filestrn[k]), 
#                          delim = "\t", escape_double = FALSE, 
#                          trim_ws = TRUE,col_names = c("id","spk","text"))
trntemp<-read_delim(paste0(sbctrn,filestrn[k]), 
                         delim = "\t", escape_double = FALSE, 
                         trim_ws = TRUE,col_names = c("id","spk","text"))
l1<-length(trntemp)
trntext<-trntemp[,l1]
colnames(trntext)<-"text"
trntemp.2<-data.frame(scb=k,id=1:length(trntext$text),text=trntext)
  
trndf<-rbind(trndf,trntemp.2)

}
trndf$lfd<-1:length(trndf$scb)
#save(trndf,file = "~/boxHKW/21S/DH/local/SPUND/corpuslx/stefanowitsch/HA/data/SCB-df.cpt.RData")
m1<-grep("tak|took",trndf$text) #take:415,tak:478 obs.
trn.take<-cbind(trndf[m1,],"concrete"=0,"light"=1)
m2<-grep("made|make|making",trndf$text) #take:415,tak:478 obs. #mak
trn.make.2<-cbind(trndf[m2,],"concrete"=0,"light"=1) #430
m3<-grep("give|gave|giving",trndf$text) #take:415,tak:478 obs.
trn.give<-cbind(trndf[m3,],"concrete"=0,"light"=1) #235
### wks., wonderful. now annotate for concrete/light use
#trn.make.a<-fix(trn.make)
#trn.make.a$lfd<-trn.make$lfd
#trndf$lfd<-1:length(trndf$scb)
#save(trn.make.a,file = "~/boxHKW/21S/DH/local/SPUND/corpuslx/stefanowitsch/HA/data/make.annotated.RData")
#save(trndf,file = "~/boxHKW/21S/DH/local/SPUND/corpuslx/stefanowitsch/HA/data/SCB-df.cpt.RData")
#write_csv(trn.make.a,"~/boxHKW/21S/DH/local/SPUND/corpuslx/stefanowitsch/HA/data/make.ann.csv")
#write_csv(trndf,"~/boxHKW/21S/DH/local/SPUND/corpuslx/stefanowitsch/HA/data/scb-raw.csv")
#load("~/Documents/GitHub/SPUND-LX/corpusLX/14015-HA/data/trn.make.cpt.RData")
#load("~/Documents/GitHub/SPUND-LX/corpusLX/14015-HA/data/make.df-cpt.RData") # complete /make/ annotated df

#load("~/Documents/GitHub/SPUND-LX/corpusLX/14015-HA/data/make.df-cpt.RData")

#eval1.m<-(trn.make.a$concrete==1)
#eval2.m<-(trn.make.a$light==1&trn.make.a$concrete==0)
#eval3.m<-(trn.make.a$concrete==0&trn.make.a$light==0|trn.make.a$concrete==-9)
#eval1<-sum(eval1.m)
#eval2<-sum(eval2.m)
#eval3<-sum(eval3.m)
#eval4<-length(trn.make.a$scb)-eval3
#p.light<-eval2/eval4 #89.4%
#p.concrete<-eval1/eval4 #10.6%
#eval1+eval2
# load("~/boxHKW/21S/DH/local/SPUND/corpuslx/stefanowitsch/HA/data/SCB-df.cpt.RData")
#trndf<-trndf[2:length(trndf$scb),]
#trndf$lfd<-1:length(trndf$scb)
#library(readr)
library(stringi)
trn.split<-stri_split_boundaries(trndf$text,type="word",simplify = T)
get.mfw<-function(t.array){
  m1<-grepl("[^A-Za-z ]",t.array)
  sum(m1)
  t.array<-t.array[!m1]
  t1<-table(t.array)
  t1<-sort(t1,decreasing = T)
}
df<-trn.split
k<-6
cleandf<-function(df){
  for(k in 2:length(df[,1])){
  t.array<-df[k,]
  m1<-grepl("[^A-Za-z ]",t.array)
  t.array
  sum(m1)
  t.array<-t.array[!m1]
  t.array
  m2<-t.array!=""
  sum(m2)
  t.array
  t.array<-t.array[m2]
  t.array
  m3<-t.array!=" "
  sum(m3)
  t.array
  t.array<-t.array[m3]
  t.array
  length(t.array)
  df[k,]<-NA
  if(length(t.array)>0)
    df[k,1:length(t.array)]<-t.array
  }
  return(df)
}
k
df[3,]
cleantrn<-cleandf(trn.split) # token df
tna<-!is.na(cleantrn)
token.sum.all<-sum(tna)
cleantrn[4,]
#t.con<-get.mfw(trn.split[trn.make.a$lfd[eval1.m],]) #gets most frequent words for selection
#t.con
#t.array<-trn.split[trn.make.a$lfd[eval1.m],]
### PoS tagging
pos.temp<-function(){
  load("~/boxHKW/21S/DH/local/SPUND/corpuslx/stefanowitsch/HA/data/SCB-df.cpt.RData")
library(udpipe)
library(stringr)
library(stringi)
#udpipe_download_model("english",udpipe_model_repo = "jwijffels/udpipe.models.ud.2.5")
udpipepath<-"~/boxHKW/21S/DH/local/SPUND/corpuslx/english-ewt-ud-2.5-191206.udpipe"
md<-udpipe_load_model(udpipepath)
#an1<-udpipe_annotate(md,cleantrn[7,])                
#an1                      
#an2<-as.data.frame(an1)      
tna<-is.na(trndf$text)
sum(tna)
trndf<-trndf[!tna,]
an3<-udpipe_annotate(md,x=trndf$text,tagger = "default",parser = "none")
#save(an4,file="~/Documents/GitHub/R-essais/SPUND/corpusLX/14015-HA/SCB-df.PoS.RData")
#save(trndf,file="~/Documents/GitHub/R-essais/SPUND/corpusLX/14015-HA/SCB-df.cpt.RData")
an2<-udpipe_annotate(md,x=trndf$text[40001:length(trndf$text)],tagger = "default",parser = "none")

an4<-list(docid=an3$x,pos=an3$conllu)
load("~/boxHKW/21S/DH/local/SPUND/corpuslx/stefanowitsch/HA/data/SCB-df.ann.RData")
an5<-as.data.frame(an3$x,an3$conllu)
an6<-as.data.frame(an2)
an5[5,]
# R crashes
### df too large
### created corpus in sketchengine
library(readr)
dmake<-read.csv("~/Documents/GitHub/R-essais/SPUND/corpusLX/14015-HA/make+objects_of_make.csv",skip = 4) # sketchengine export
library(stringi)
stri_extract_all_regex(dmake$Right,"(.*<coll>.*</coll>.+?[0-9]{1,3}\\.)")
coll.make<-stri_extract_all_regex(dmake$Right,"(.*<coll>.*</coll>.+?[0-9]{1,3}\\.)")
coll.make
dmake.conc<-data.frame(kwic=dmake$KWIC,coll=unlist(coll.make))
dmake.conc$concrete<-1
dmake.conc$light<-1
dmake.conc$synonyme<-NA
dmake.conc$n.alt<-NA
dmake.conc$n.0<-NA
dmake.fix<-fix(dmake.conc)
dmake.fix$left<-dmake$Left
colnames(dmake.fix.2)
dmake.fix.2<-dmake.fix[,c(8,1,2,3,4,5,6,7)]
stri_extract_all_regex(dmake$Left,"((.){30}$)")
dmake.fix.2$left<-unlist(stri_extract_all_regex(dmake$Left,"((.){30}$)"))
dmake.fix.3<-fix(dmake.fix.2)
dmake.fix.3$coll<-unlist(coll.make)
dmake.fix.4<-fix(dmake.fix.3)
m<-dmake.fix.4$light==1
dmake.fix.4$concrete[m]<-1
dmake.fix.4$coll[!m]
save(dmake.fix.4,file = "~/Documents/GitHub/R-essais/SPUND/corpusLX/14015-HA/make.annotated(SkE-coll).RData") # 238 obs.
}
#load("~/Documents/GitHub/R-essais/SPUND/corpusLX/14015-HA/make.annotated.RData") # 430 obs.
#####
get.ann.df<-function(trn.make.a){
trn.make.a$coll<-NA
trn.make.a$concrete<-1
trn.make.a$light<-1
trn.make.a$synonyme<-NA
trn.make.a$n.alt<-NA
trn.make.a$n.0<-NA
mode(trn.make.a$coll)<-"character" # !!!!important: if not, then fix() will not save string input
mode(trn.make.a$synonyme)<-"character"
return(trn.make.a)
}
temp.ann<-function(){
colnames(trn.make.light)
trn.make.a<-trn.make.a[,c(1,2,3,6,4,5,7,8,9)]
trn.make.light<-trn.make.a[trn.make.a$concrete==0&trn.make.a$light==1,] #321 obs
mode(trn.make.light$coll)<-"character" # !!!!important: if not, then fix() will not save string input
mode(trn.make.light$synonyme)<-"character"
make.l.3<-fix(trn.make.light)
save(make.l.4,file = "~/Documents/GitHub/R-essais/SPUND/corpusLX/14015-HA/make.annotated.light.RData") # 238 obs.
m<-make.l.1$concrete==1
sum(m)
make.l.2<-make.l.1[!m,]
make.l.2[!is.na(make.l.2$synonyme),]
mode(make.l.2$coll)<-"character" # !!!!important: if not, then fix() will not save string input
mode(make.l.2$synonyme)<-"character"
make.l.4<-fix(make.l.3)
make.a.made<-get.ann.df(trn.make.2)
make.a.made.l.2<-fix(make.a.made.l)
m1<-is.na(make.a.made.l.2$light)
m<-make.a.made.l$light==1
m
make.a.made.l.2<-make.a.made.l[m,]
m2<-!is.na(make.a.made.l.2$light)
make.a.made.l.2<-make.a.made.l.2[m2,]
make.a.made.l.3<-fix(make.a.made.l.2)
m<-!is.na(make.a.made.l.3$light)
make.a.made.l.4<-make.a.made.l.3[m,]
make.a.made.l.4$lfd<-rownames(make.a.made.l.4)
make.l.4$lfd<-rownames(make.l.4)
colnames(make.l.4)
colnames(make.a.made.l.4)
light.ann.make<-rbind(make.a.made.l.4,make.l.4)
light.ann.make$concrete<-1
trn.make.a.2$lfd<-rownames(trn.make.a.2)
trn.make.cpt<-rbind(trn.make.a.2,make.a.made)
save(light.ann.make,file = "~/Documents/GitHub/SPUND-LX/corpusLX/14015-HA/make.annotated.light.RData") # 366 obs.
save(trn.make.cpt,file = "~/Documents/GitHub/SPUND-LX/corpusLX/14015-HA/make.df-cpt.RData") # 561 obs.
}
######################################
### count instances concrete vs. light
### Q.1: (Mehl 2021)
i.make.w<-c(concrete=68,light=321) #17% vs. 83% written ICE 
i.make.s<-c(concrete=96,light=353) #spoken ICE
i.take<-c(con=62,light=85) 
i.give<-c(con=52,light=167) 
###########################
#m.ns<-make.l.1$id
getwd()
trndf_sf<-trndf # save created, load from github next, same df
dtemp<-tempfile()
download.file("https://github.com/esteeschwarz/SPUND-LX/raw/main/corpusLX/14015-HA/data/trn.make.cpt.RData",dtemp)
load(dtemp)
download.file("https://github.com/esteeschwarz/SPUND-LX/raw/main/corpusLX/14015-HA/data/SCB-df.cpt.RData",dtemp)
load(dtemp)
#load(dtemp)
download.file("https://github.com/esteeschwarz/SPUND-LX/raw/main/corpusLX/14015-HA/data/light.ann.make.RData",dtemp)
load(dtemp)

# load("~/Documents/GitHub/SPUND-LX/corpusLX/14015-HA/trn.make.cpt.RData") # lemma /make/ annotated DF
# load("~/Documents/GitHub/SPUND-LX/corpusLX/14015-HA/data/SCB-df.cpt.RData") # complete corpus, same as created on top
#lc<-sum(trn.make.cpt$concrete==1,na.rm = T)
# m2<-trn.make.cpt$concrete==0&trn.make.cpt$light==0
# sum(m2,na.rm = T)
# trn.make.cpt$light[m2]<-NA
# trn.make.cpt$concrete[m2]<-NA
k<-1
for(k in 1:length(light.ann.make$lfd)){
  lfd<-light.ann.make$lfd[k]
  txt<-light.ann.make$text[k]
  txt
  m<-trn.make.cpt$text%in%txt
  sum(m)
  trn.make.cpt[m,]
  if(is.na(trn.make.cpt$light[m]))
     trn.make.cpt$light[m]<-light.ann.make$light[k]
  if(is.na(trn.make.cpt$concrete[m]))
     trn.make.cpt$concrete[m]<-light.ann.make$concrete[k]
  
  
  }
m<-grep("Wilcox made his money",trn.make.cpt$text)
sum(m)
trn.make.cpt$light[m]<-1
trn.make.cpt$concrete[m]<-0
m<-grep("money",trn.make.cpt$text)
trn.make.cpt[m,]
trn.make.cpt['27225','concrete']<-0
trn.make.cpt['27225','light']<-1
#trndf.lm$light[m]
#m3<-trn.make.cpt$concrete==1
#m3<-trn.make.cpt$concrete==0
#m3<-trn.make.cpt$light==0
m3<-trn.make.cpt$light==1
sum(m3,na.rm = T)
trn.make.cpt$concrete[m3]<-0
sum(m3,na.rm = T)
l.light<-sum(m3,na.rm = T)
#trn.make.cpt[m3,]
#trn.make.cpt$light[m3]<-0
l.conc<-sum(trn.make.cpt$light==0,na.rm = T)
l.chk<-sum(trn.make.cpt$concrete==1,na.rm = T)
m5<-trn.make.cpt$light==0&trn.make.cpt$concrete==0
sum(m5,na.rm = T)
trn.make.cpt$concrete[m5]<-NA
trn.make.cpt$light[m5]<-NA
#save(trn.make.cpt,file = "~/Documents/GitHub/SPUND-LX/corpusLX/14015-HA/data/trn.make.cpt.RData") # lemma /make/ annotated DF
m4<-trn.make.cpt$light==1
sum(m4,na.rm = T)
l.light<-sum(m4,na.rm = T)
l.conc+l.light
i.make.m<-c(concrete=l.conc,light=l.light)
i.make.w[2]/(i.make.w[1]+i.make.w[2])
i.make.s[2]/(i.make.s[1]+i.make.s[2])
i.make.m[2]/(i.make.m[1]+i.make.m[2]) # 29 vs 71%
i.make.m
i.make.s
i.make.w
#barplot(i.make.m,main = "SBC / spoken")
#barplot(i.make,main="ICE-GB / written")
i.make.m
barplot(cbind(ICE.w=i.make.w,ICE.sp=i.make.s,SBC.sp=i.make.m),main="distribution: lemma /make/",beside=T,legend.text = c("concrete use","light use"))
### wks.
### semantic alternates of concrete /make/ (p.14)
###

get.alt<-function(altregex,alt){
m1<-grep(altregex,trndf$text)
trn.temp<-cbind(trndf[m1,],alt=alt,light=0)
trn.alt<-rbind(trn.alt,trn.temp)
}
m1<-c("(generat(e|ing|ed))[^generator]","generate")
m2<-c("(construct(ing|ed))[^constructor]","construct")
m3<-c("(produc(e|ing|ed))[^producer]","produce")
m4<-c("(creat(e|ing|ed))[^creator]","create")
m5<-c("(buil(d|ding|t))[^builder]","build")
m1.m<-grep(m1[1],trndf$text)
trn.temp<-cbind(trndf[m1.m,],alt=m1[2],light=0)
trn.alt<-trn.temp
trn.alt<-get.alt(m2[1],m2[2])
trn.alt<-get.alt(m3[1],m3[2])
trn.alt<-get.alt(m4[1],m4[2])
trn.alt<-get.alt(m5[1],m5[2])

trndf.all<-trndf
put.alt<-function(altregex,alt){
  m1<-grep(altregex,trndf$text)
  trndf.all$alt<-NA
  trndf.all$light<-NA
  trndf.all$alt[m1,]<-alt
}
table(trn.alt$alt)
#barplot(table(trn.alt$alt)/100)
colnames(trn.alt)
sum(trn.make.cpt$light!=1,na.rm = T)
sum(trn.make.cpt$light==1,na.rm = T)
sum(trn.make.cpt$concrete==1,na.rm = T)
trn.make.cpt$light[trn.make.cpt$light==-9]<-NA
trn.make.cpt$concrete[trn.make.cpt$concrete==-9]<-NA
sum(trn.make.cpt$concrete==1,na.rm = T)
trn.make.cpt$light[trn.make.cpt$concrete==1]<-0
trn.make.cpt$alt<-"make"
make.c<-cbind(trn.make.cpt[,c('scb','id','text','lfd','alt','light')])
trndf.all<-rbind(make.c,trn.alt)
#par(las=3,cex=0.5,pin=c("1.5","1.5"))
par(las=3)
alt.c.table<-table(trndf.all$alt[trndf.all$light==0])
alt.c.table
barplot(alt.c.table/sum(alt.c.table)*100,main = "SBC concrete /make/ vs. alternate",ylab = "% over verbforms")
#barplot(table(trn.all$alt)/sum(table(trn.$alt))*100,main = "SBC concrete /make/ vs. alternate",ylab = "% in corpus")
#table(trn.all$alt)/sum(table(trn.all$alt))
#table(trn.all$alt)/sum(table(trn.all$alt))
#library(stats)
#lm1<-lm(light~alt,trndf.all)
#par(new=T)
#par(page=T)
#plot.new()
#plot(lm1)
#lm1$coefficients
#summary(lm1)
#sum(is.na(trndf.all$light))
m<-is.na(trndf.all$light)
sum(m,na.rm = T)
trndf.all[m,] # obs annotated as -not to assign wether concrete or light-
#make.all<-cbind(trn.make.cpt[,c('scb','id','text','lfd','light')],alt="make")
make.all.alt<-trndf.all
#lm1<-lm(light~alt,make.all.alt)
make.int<-c(NA,NA,NA,NA,alt="0-intercept",1)
make.all.alt<-rbind(make.int,make.all.alt)
#lm1<-lm(light~alt,make.all.alt)
#summary(lm1)
#par(las=3)
#lms<-summary(lm1)
#lms
#barplot(lms$coefficients[,4])
#lms
#lms$coefficients[,3]
#boxplot(lm1$effects)
#m<-trndf$lfd%in%trn.alt$lfd
#w.m<-which(m)
trndf.lm<-trndf_sf
trndf.lm$light<-0
trndf.lm$alt<-"a-other"
trndf.lm$text[27245]
trndf.lm[14896,]
trndf.all[trndf.all$lfd==14896,]
trndf.all[166,]
#rownames(trndf.lm)<-trndf.lm$lfd
#trndf.lm$lfd<-trndf.lm$lfd+1
sum(trndf.all$alt=="make"&trndf.all$light==0,na.rm = T)
#trndf.lm$light[m]<-make.a.l.cpt$light[make.a.l.cpt$lfd==trndf.lm$lfd[m]]
k<-62077
for(k in 1:length(trndf.lm$lfd)){
  light<-0
  alt<-"a-other"
  lfd<-trndf.lm$lfd[k]
  trndf.lm[k,]
  trndf.lm[lfd,]
  text<-trndf.lm$text[k]
  m<-trndf.all$text%in%text
  wm<-which(m)
  trndf.all[wm,]
  light<-trndf.all$light[wm]
  if(length(light)==0)
    light<-NA
  alt<-trndf.all$alt[wm]
#  if(length(light)>0)
    trndf.lm$light[k]<-light
  ifelse(length(alt)>0,
    trndf.lm$alt[k]<-alt,
    trndf.lm$alt[k]<-"a-other")

  }

chk<-trndf.lm$alt=="make"
head(trndf.lm[chk,])
trndf.lm[chk,]
trndf.lm[2808,]
trndf[2808,]
trndf_sf[2808,]
make.int<-c(NA,NA,NA,NA,alt="0-intercept",0)
make.all.alt<-rbind(make.int,trndf.lm)
m<-is.na(trndf.lm$alt)
sum(m)
sum(trndf.lm$light==0,na.rm = T)
#trndf.lm$alt[m]<-"other"
lm1<-lm(light~alt,trndf.lm)
summary(lm1)
par(las=3)
lms<-summary(lm1)
#barplot(lms$coefficients[,4])
lms
sum(trndf.lm$alt=="make"&trndf.lm$light==1,na.rm = T)
sum(trndf.lm$alt=="make"&(trndf.lm$light==1|trndf.lm$light==0),na.rm = T)
sum(trndf.lm$alt=="make"&(trndf.lm$concrete==1|trndf.lm$concrete==0),na.rm = T)
sum(is.na(trndf.lm$light))
sum(trndf.lm$light[trndf.lm$light==-9],na.rm = T)
sum(trndf.lm$light==-9,na.rm = T)
trntable<-table(trndf.lm$alt[trndf.lm$light==0])
trntable
321+199
#par(las=3,cex=0.5,pin=c("1.5","1.5"))
barplot(trntable[c(1,2,3,4,5,6,7)]/sum(table(trndf.lm$alt))*100,main = "SBC concrete /make/ vs. alternate",ylab = "% in corpus")
#lms$coefficients[,3]
#trndf.lm$light[m]<-make.a.l.cpt$light
#head(trndf.lm[m,])

#save(trndf.lm,file = "~/Documents/GitHub/SPUND-LX/corpusLX/14015-HA/data/trndf.lm.cpt.RData")
#save(trn.make.cpt,file = "~/Documents/GitHub/SPUND-LX/corpusLX/14015-HA/data/trn.make.cpt.RData")
#save(light.ann.make,file = "~/Documents/GitHub/SPUND-LX/corpusLX/14015-HA/light.ann.make.RData")

#14023.class
### binäre logistische regression, anova, mehrdimensionale, nominale daten
### open american national corpus
