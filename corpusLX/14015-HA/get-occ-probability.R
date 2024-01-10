#20240108(14.43)
#get probability of occurence of make + semantic alternates in corpus
##############################################################
#cf. (Mehl, 2021:14)
##############################################################
library(stats)
#load("https://github.com/esteeschwarz/SPUND-LX/raw/main/corpusLX/14015-HA/data/trndf.lm.RData") # no direct load!
dtemp<-tempfile()
download.file("https://github.com/esteeschwarz/SPUND-LX/raw/main/corpusLX/14015-HA/data/trndf.lm.RData",dtemp)
load(dtemp)
head(trndf.lm)
### >
### the dataset consists of the complete SBC corpus with annotation of light/concrete use for /make/ in token areas.
### one row in the df is one speakerline from the spoken data corpus, extracted in script: <14015.concrete-abstract_HA.R>
### the lemma make was annotated manually for concrete/light use in column <light> which can be [0] (FALSE) for concrete,
### and [1] for light use (TRUE).
### > aim is to compute the probability of occurence of make AND 5 semantic alternates in the corpus with respective
### to the concrete/light variant of make. all alternates are considered [concrete] per se.
### I try to apply the stats-package lm() function to get a p-value for each of the alt-categories (make+alternate verbs)
### that i assume to describe the probability of occurence (cf. Mehl 2021:14) of each verb (lemma).
### session: I am not sure how to work with the intercept of the dataset i.e. against which value the several
### instances of [0] and [1] in the dataset are to be evaluated to get a realistic p-value for each form.
#########################################################################################################
lm1<-lm(light~alt,trndf.lm)
summary(lm1)
df.int<-c(NA,NA,NA,NA,alt="0-intercept",0) # if here set intercept-obs to 0 or 1 changes the p-value per category (verb)
trndf.lm.2<-rbind(df.int,trndf.lm)
sum(is.na(trndf.lm.2$light)) #0
sum(trndf.lm.2$alt!="make")
m<-trndf.lm.2$alt!="make" # all alternate obs to make
sum(m)
#sum(trndf.lm.2$light[m]==0)
#trndf.lm.2$light[m]<-0 # set all alternates to [light]
lm1<-lm(light~alt,trndf.lm.2)
lms<-summary(lm1)
lms
par(las=3)
barplot(lms$coefficients[,1])
###
# 2nd approach, percentage:
verbfr<-array()
td<-table(trndf.lm.2$alt)
td<-td[names(td)!="other"&names(td)!="0-intercept"]
barplot(td/sum(td))
k<-2
tdlm<-data.frame(alt=td)
tdlm$p<-0
tdlm$p[tdlm$alt.Var1=="make"]<-1
trndf.lm.3<-trndf.lm.2[trndf.lm.2$alt!="other",]
lm2<-lm(light~alt,trndf.lm.3)
lms<-summary(lm2)
lms
barplot(lms$coefficients[,1])
trndf.lm[trndf.lm$alt=="make",]
