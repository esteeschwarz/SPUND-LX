#20250713(12.14)
#15292.psych.eval.cleaned
#########################
dataset<-7

read.db<-function(){
  
  
  library(DBI)
  library(RSQLite)
  #con <- dbConnect(RSQLite::SQLite(),"~/db/reddit_com.df.15242.sqlite")
  con <- dbConnect(RSQLite::SQLite(),"~/db/reddit_com.df.15276.sqlite")
  dbListTables(con)
  #tdb.pos<-dbGetQuery(con,"SELECT * FROM reddit_com_pos")
  tdbref<-dbGetQuery(con,"SELECT * FROM reddit_pos_ref")
  tdbcorp<-dbGetQuery(con,"SELECT * FROM reddit_com_pos")
  return(list(obs=tdbcorp,ref=tdbref))
}
tdb<-read.db()
n_obs<-length(tdb$obs$token)
n_ref<-length(tdb$ref$token)
rm(tdb)
eval.ns<-list.files(paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/psych/HA/"))
eval.ext<-c(".csv",".RData")
eval.f<-eval.ns[unlist(lapply(eval.ext,function(x){grep(paste0("eval-0..",x),eval.ns)}))]
eval.fs<-paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/psych/HA/",eval.f)
eval.fs
library(tools)
#dataset<-5
eval.n.hard<-dataset
dn<-dataset
read.eval<-function(dn){
  e<-new.env()
  ext<-file_ext(eval.fs[dn])
  f<-eval.fs[dn]
  f
  ifelse(ext=="csv",out<-read.csv(f),load(f,envir = e))
  ifelse(ext=="csv",out<-out,out<-e$qltdf)
  return(out)
  
}

#load(paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/stef_psych/eval-007.RData"))
ifelse(exists("eval.n"),qltdf<-read.eval(eval.n),qltdf<-read.eval(eval.n.hard))
dfa<-qltdf
#rm(qltdf)
Y <- dfa$dist           # Dependent variable
mean(Y[dfa$target=="obs"],na.rm = T)
mean(Y[dfa$target=="obs"])
mean(Y[dfa$target=="ref"])
###
anova_model <- aov(Y ~ target*q*det, data = dfa)
#anova_model <- aov(Y ~ target, data = dfsb)
#anova_model <- aov(Y ~ group*q, data = dfa)
anova.sum<-summary(anova_model)
anova.sum
library(lmerTest)
library(dplyr)
lme.form<-"dist~target*q+range+(1|lemma)"
lme.form<-"dist~target*q+range+(1|lemma)+(1|det)"
lm2<-lmer(eval(expr(lme.form)),dfa)
#lm2<-lmer(dist~target*q+range+(1|lemma),dfa)
#lm2<-lmer(dist~target*q+range+(1|lemma),dfa)
#lm2<-lm(dist~target*q+range,dfa) # without random effects
summary(lm2)
lm2.summ<-summary(lm2)
lm2.summ
anlm.summ<-anova(lm2)
anlm.summ
lm2.summ
anlm.summ
mean(dfa$dist[dfa$target=="obs"])
mean(dfa$dist[dfa$target=="ref"])
queries<-letters[1:6]
mno<-array()
mnr<-array()
for(q in seq_along(queries)){
  query<-queries[q]
  mno[q]<-mean(dfa$dist[dfa$target=="obs"&dfa$q==query])
  mnr[q]<-mean(dfa$dist[dfa$target=="ref"&dfa$q==query])
}
mno
mnr



