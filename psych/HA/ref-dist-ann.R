# 20250728(09.15)
# 15313.psych.anaphor annotation
################################
Q1<-"https://github.com/ottiram/MMAX2/tree/master"
Q2<-"https://catalog.ldc.upenn.edu/LDC2013T22" # ARRAU annotated corpus
#######################################################################
run<-15303
reload<-T
dataset<-11
limit<-F
source(paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/psych/HA/eval-init-vars.R"))
source(paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/psych/HA/eval-003.R"))
#tdb<-read.db(run = 15303)
#########################
# get url texts to annotate:
#load(paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/stef_psych/eval-011.RData"))
save.ns.list<-12
#load(paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/stef_psych/dist.df-",save.ns.list,".RData"))
# load complete corpus, sorted after url and timestamp
#load(paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/stef_psych/dcorpus.df.cpt-012.RData"))

# tdb4<-lapply(tdb3.l,function(x){
#   d<-dim(x)
#   ifelse(d[1]==0,return(NA),return(x))
# })
# tdb4<-tdb4[!is.na(tdb4)]
# library(abind)
#tdb4<-data.frame(abind(tdb4,along = 1))

#?filter
library(dplyr)
llength<-dfa$lemma%>%strsplit("")
llength<-unlist(lapply(llength, length))
dfa$l.length<-llength
filter.c<-"dist<500&l.length>5"
head(dplyr::filter(dfa,dist<500&l.length>5))
t.lim<-dplyr::filter(dfa,dist<500&l.length>5)
t.sample<-data.frame(t.lim[sample(length(t.lim),10),])
# creates text df from urls with the nouns where distance is measured
t.sample.tx<-lapply(t.sample$url, function(x){
  r<-tdba.1$url==x
  t<-paste0(tdba.1$token[r])
})
t.sample.tx[[1]]
tx.ns.dir<-paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/stef_psych/data/txt/",run)
dir.create(tx.ns.dir)
i<-1
f.ns
lapply(seq_along(t.sample.tx), function(i){
  t<-paste0(t.sample.tx[[i]],collapse = " ")
  f.ns<-paste0(tx.ns.dir,"/text-",i,".txt")
  writeLines(t,f.ns)
})
