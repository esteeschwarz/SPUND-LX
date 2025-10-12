
#model<-model.list[[1]]

norm_target<-model$norm_target
#norm_target<-""
ref_target<-ifelse(norm_target=="",norm_target,gsub("_rel_","",norm_target))
ref<-norm_target
det.t<-model$det.t
limit<-model$limit
author<-model$author
url<-model$url
embed<-model$embed #.ti: if, if inverted # > if score is inverted, theres no intercept and targetobs/ref appear as single estimates
range<-model$range #.ti: if, if inverted in lmer.
#range<-T # no!
#range<-c(T,"f")
rel<-model$rel
lme<-model$lme
lemma<-model$lemma

ceiling<-ifelse(sum(limit)>0,"outliers removed","outliers not removed")

source(paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/psych/HA/eval-003.R"),echo = F)


dfa<-get.dist.norm(qltdf,limit)

#if(!exists("eval.1"))
  #  eval.1<-get.anovas(dfa,target,conditions,det,rel,ref_target,author)
  # eval.1<-get.anovas.e(dfa,target,conditions,det,rel,ref_target,author,embed)
  # get.anovas.e<-function(qltdf,target,con,det.t,ref,lemma,author,range.ti,embed.ti){
  
  eval.1<-get.anovas.e(dfa,c("obs","ref"),con,det.t,norm_target,lemma,author,url,range,embed,lme)

anova.form<-eval.1$anova.form
lme.form<-eval.1$lme.form
# caption.ext<-ifelse(rel,paste0(", normalised to ",ref_target,", distance ceiling =  ",ceiling),paste0("not normalised, distance ceiling =",ceiling))
# dfe<-eval.1$plot.md
caption.ext<-ifelse(rel,paste0(", normalised to ",ref_target,", distance ceiling =  ",ceiling),paste0(", not normalised, distance ceiling =",ceiling))