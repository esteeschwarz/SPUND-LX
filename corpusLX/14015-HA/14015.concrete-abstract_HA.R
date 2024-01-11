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

trndf.2<-trndf[2:length(trndf$scb),]
trndf.2$lfd<-1:length(trndf.2$scb)
rownames(trndf.2)<-trndf.2$lfd
trndf$lfd<-1:length(trndf$scb)
#save(trndf,file = "~/boxHKW/21S/DH/local/SPUND/corpuslx/stefanowitsch/HA/data/SCB-df.cpt.RData")
m1<-grep("tak|took",trndf$text) #take:415,tak:478 obs.
trn.take<-cbind(trndf[m1,],"concrete"=0,"light"=1)
m2<-grep("made|make|making",trndf$text) #take:415,tak:478 obs. #mak
trn.make.2<-cbind(trndf[m2,],"concrete"=0,"light"=1) #430
m3<-grep("give|gave|giving",trndf$text) #take:415,tak:478 obs.
trn.give<-cbind(trndf[m3,],"concrete"=0,"light"=1) #235
### wks., wonderful. now annotate for concrete/light use
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
trndf_sf<-trndf # save created, load only annotations from github
dtemp<-tempfile()
# download.file("https://github.com/esteeschwarz/SPUND-LX/raw/main/corpusLX/14015-HA/data/trn.make.cpt.RData",dtemp)
# load(dtemp)
# download.file("https://github.com/esteeschwarz/SPUND-LX/raw/main/corpusLX/14015-HA/data/SCB-df.cpt.RData",dtemp)
# load(dtemp)
# #load(dtemp)
# download.file("https://github.com/esteeschwarz/SPUND-LX/raw/main/corpusLX/14015-HA/data/light.ann.make.RData",dtemp)
# load(dtemp)
### B
download.file("https://github.com/esteeschwarz/SPUND-LX/raw/main/corpusLX/14015-HA/data/SBC.ann.df.RData",dtemp)
load(dtemp)
###
### B
get.ann.x<-function(scb,ann.df){
  trndf.lm<-cbind(scb,ann.df)
}
### B
trndf.lm<-get.ann.x(trndf.2,scb.ann.df)
###

### B
m4<-trndf.lm$light==1&trndf.lm$alt=="make"
sum(m4,na.rm = T)
l.light<-sum(m4,na.rm = T)
l.conc<-sum(trndf.lm$light==0&trndf.lm$alt=="make",na.rm = T)
i.make.m<-c(concrete=l.conc,light=l.light)
i.make.w[2]/(i.make.w[1]+i.make.w[2])
i.make.s[2]/(i.make.s[1]+i.make.s[2])
i.make.m[2]/(i.make.m[1]+i.make.m[2]) # 29 vs 71%
i.make.m
i.make.s
i.make.w
i.make.m
barplot(cbind(ICE.w=i.make.w,ICE.sp=i.make.s,SBC.sp=i.make.m),main="distribution: lemma /make/",beside=T,legend.text = c("concrete use","light use"))
### wks.
### semantic alternates of concrete /make/ (p.14)
###
### B >
trndf_sf<-trndf
trndf<-trndf.lm
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
table(trn.alt$alt)
### B <
### B >
par(las=3)
alt.c.table<-table(trndf.all$alt[trndf.all$light==0])
alt.c.table
barplot(alt.c.table/sum(alt.c.table)*100,main = "SBC concrete /make/ vs. alternate",ylab = "% over verbforms")
### B <
chk<-trndf.lm$alt=="make"
head(trndf.lm[chk,])
trndf.lm[chk,]
sum(trndf.lm$alt=="make"&trndf.lm$light==1,na.rm = T)
sum(trndf.lm$alt=="make"&(trndf.lm$light==1|trndf.lm$light==0),na.rm = T)
sum(trndf.lm$alt=="make"&(trndf.lm$concrete==1|trndf.lm$concrete==0),na.rm = T)
sum(is.na(trndf.lm$light))
sum(trndf.lm$light[trndf.lm$light==-9],na.rm = T)
sum(trndf.lm$light==-9,na.rm = T)
trntable<-table(trndf.lm$alt[trndf.lm$light==0])
trntable

#par(las=3,cex=0.5,pin=c("1.5","1.5"))
barplot(trntable[c(1,2,3,4,5,6,7)]/sum(table(trndf.lm$alt))*100,main = "SBC concrete /make/ vs. alternate",ylab = "% in corpus")

#save(trndf.lm,file = "~/Documents/GitHub/SPUND-LX/corpusLX/14015-HA/data/trndf.lm.cpt.RData")
#save(trn.make.cpt,file = "~/Documents/GitHub/SPUND-LX/corpusLX/14015-HA/data/trn.make.cpt.RData")
#save(light.ann.make,file = "~/Documents/GitHub/SPUND-LX/corpusLX/14015-HA/light.ann.make.RData")
#save(smdf,file = "~/Documents/GitHub/SPUND-LX/corpusLX/14015-HA/data/SBC.20-sample.RData")
#14023.class
### binäre logistische regression, anova, mehrdimensionale, nominale daten
### open american national corpus
