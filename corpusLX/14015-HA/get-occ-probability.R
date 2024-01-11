#20240108(14.43)
#get probability of occurence of make + semantic alternates in corpus
##############################################################
#cf. (Mehl, 2021:14)
##############################################################
library(stats)
#load("https://github.com/esteeschwarz/SPUND-LX/raw/main/corpusLX/14015-HA/data/trndf.lm.RData") # no direct load!
dtemp<-tempfile()
download.file("https://github.com/esteeschwarz/SPUND-LX/raw/main/corpusLX/14015-HA/data/trndf.lm.cpt.RData",dtemp)
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
### see bottom paragraph for question precised.
#########################################################################################################
lm.temp<-function(){
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
}
###
# 2nd approach, percentage:
verbfr<-array()

td<-table(trndf.lm$alt[trndf.lm$light==0])
td
td<-td[names(td)!="other"&names(td)!="0-intercept"]
td
barplot(td/sum(td))
#k<-2
# tdlm<-data.frame(alt=td)
# tdlm$p<-0
# tdlm$p[tdlm$alt.Var1=="make"]<-1
# trndf.lm.3<-trndf.lm[trndf.lm$alt!="other",]
# lm2<-lm(light~alt,trndf.lm.3)
# lms<-summary(lm2)
# lms
#barplot(lms$coefficients[,1])
#trndf.lm[trndf.lm$alt=="make",]
################################
### this is not exactly where my question was directed to, i think the percentage plot depicts the relation in the right way. i try this again with a model, to show where i saw my problem with intercept and p-values.

mdf<-data.frame(letters=letters,cat=rep(sample(LETTERS[1:5],5),26),var=sample(0:1,length(letters),replace = T))
lm1<-lm(var~cat,mdf)
lms<-summary(lm1)
lms
mdf[1,]<-c("a","0-int",0) # insert intercept
lm1<-lm(var~cat,mdf)
lms<-summary(lm1)
lms # this would be a random (0/1) distribution at the var-column
### now modify one cat and set var
mdf$var[mdf$cat=="A"]<-1
lm1<-lm(var~cat,mdf)
lms<-summary(lm1)
lms
### now chg intercept again:
mdf[1,]<-c("a","0-int",1) # insert intercept
lm1<-lm(var~cat,mdf)
lms<-summary(lm1)
lms
### as function:
get.lm<-function(cat.mod.var,int.var){
  mdf[1,]<-c("a","0-int",int.var) # insert intercept
  mdf$var[mdf$cat=="A"]<-cat.mod.var # set var of cat
  lm1<-lm(var~cat,mdf)
  lms<-summary(lm1)
  print(lms)
  par(las=3)
  barplot(lms$coefficients[,4])
}
get.lm(cat.mod.var=1,int.var=0) # here play with cat and intercept modifications
get.lm(cat.mod.var=1,int.var=1)
get.lm(cat.mod.var=0,int.var=0)
get.lm(cat.mod.var=0,int.var=1)
############################################################################
### to tutor:
### maybe you have now an idea what i was trying to ask and can help out with a clearance about what exactly the
### regression model is showing in the different configurations of var for intercept and category.
### since this way of getting to p-values is heavily used in statistic computations, i wanted to get deeper into what 
### the coefficients are showing at the end. as far as i understood i get here an answer to what extend the var-value is
### responsible for the category-value, that is a probability of of a cat if var=1 or var=0. i thought setting this resp. 
### calculating a p-value by setting var to 0/1 and using this as dependent variable would give a direct p-adressing within
### the dataframe. surely normally the var-column would contain real values and the estimate then show a real estimate for that 
### value under the given conditions. but with this way i set up the model i wanted to try if i directly can gain a p-value for
### each category under 0 or 1 hypothesis i.e. against a 0 or 1 hypothetical value.


