#meetup extracts

#load("data/trn.make.cpt.RData")
#load("data/light.ann.make.RData")
dtemp<-tempfile()
### B
download.file("https://github.com/esteeschwarz/SPUND-LX/raw/main/corpusLX/14015-HA/data/SBC.ann.df.RData",dtemp)
load(dtemp)
download.file("https://github.com/esteeschwarz/SPUND-LX/raw/main/corpusLX/14015-HA/data/SBC.20-sample.RData",dtemp)
load(dtemp)
# ifelse(exists("trndf.lm",-1),fetch<-"given",fetch<-"rerun")
# if(fetch=="rerun")
#    source("14015.concrete-abstract_HA.R")
download.file("https://github.com/esteeschwarz/SPUND-LX/raw/main/corpusLX/14015-HA/data/plotlist.RData",dtemp)
load(dtemp)
# load("data/plotlist.RData")
download.file("https://github.com/esteeschwarz/SPUND-LX/raw/main/corpusLX/14015-HA/data/collex.eval.RData",dtemp)
load(dtemp)


load("~/boxHKW/21S/DH/local/SPUND/corpuslx/stefanowitsch/HA/data/trndf.lm.cpt.RData")
#load("data/SBC.20-sample.RData")
knitr::kable(smdf[c(4,11,1,2,6,5,19),])

mna<-trndf.lm[!is.na(trndf.lm$light),]
mnc<-mna[mna$light==0,]
mnc.s<-mnc[sample(1:length(mnc$scb),20),]
#mnl.s<-mna
mnl<-mna[mna$light==1,]
mnl.s<-mnl[sample(1:length(mnl$scb),20),]
mnl.s
table(mnc$alt)
table(mnl$alt)

corpus.na<-corpus.df.deprel[!is.na(corpus.df.deprel$light),]
c.light<-corpus.na[corpus.na$light==1,]
c.concrete<-corpus.na[corpus.na$light==0,]
table(c.light$lemma)
source("functions.R")
