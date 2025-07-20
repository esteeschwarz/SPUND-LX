#20250713(12.14)
#15292.psych.eval.cleaned
#########################
#dataset<-7

read.db<-function(){
  
  
  library(DBI)
  library(RSQLite)
  #con <- dbConnect(RSQLite::SQLite(),"~/db/reddit_com.df.15242.sqlite")
  con <- dbConnect(RSQLite::SQLite(),"~/db/reddit_com.df.15276.sqlite")
  dbListTables(con)
  #tdb.pos<-dbGetQuery(con,"SELECT * FROM reddit_com_pos")
  tdbref<-dbGetQuery(con,"SELECT * FROM reddit_pos_ref")
  tdbcorp<-dbGetQuery(con,"SELECT * FROM reddit_com_pos")
  dbDisconnect(con)
  return(list(obs=tdbcorp,ref=tdbref))
}
if(!exists("tdb"))
  tdb<-read.db()
n_obs<-length(tdb$obs$token)
n_ref<-length(tdb$ref$token)
build.q<-function(){
  q0<-list(a=list(q=".*",det="DET"))
  q1<-list(b=list(q=c("this","that","these","those"),det="DET")) # mean distance: 76
  q2<-list(c=list(q=c("the"),det="DET")) # mean distance: 81
  q3<-list(d=list(q=c("a","an","some","any"),det="DET")) # mean distance: 63, lower
  q4<-list(e=list(q=c("my"),det=F)) # mean distance: 55, lower
  q5<-list(f=list(q=c("your","their","his","her"),det=F)) # mean distance: 100, higher
  
  return(list(q0,q1,q2,q3,q4,q5))
}
qs<-build.q()
qs
#rm(tdb)
eval.ns<-list.files(paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/psych/HA/"))
eval.ns
eval.ext<-c(".csv",".RData")
eval.f<-eval.ns[unlist(lapply(eval.ext,function(x){grep(paste0("eval-0..",x),eval.ns)}))]
eval.fs<-paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/psych/HA/",eval.f)
eval.fs
eval.ns<-list.files(paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/stef_psych/"))
eval.ns
eval.ext<-c(".csv",".RData")
eval.f<-eval.ns[unlist(lapply(eval.ext,function(x){grep(paste0("eval-0..",x),eval.ns)}))]
eval.fs.hkw<-paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/stef_psych/",eval.f)
eval.fs.hkw
eval.fs<-c(eval.fs,eval.fs.hkw)
eval.fs
library(tools)
#dataset<-5
#eval.n.hard<-ifelse(exists("dataset"),dataset,eval.n)
#dn<-dataset
#eval.n<-dn
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
if(!exists("dfa")){
ifelse(exists("eval.n"),qltdf<-read.eval(eval.n),qltdf<-read.eval(dataset))
dfa<-qltdf
}
create.sub<-function(dfa,target,con,det){
  sub1<-dfa[dfa$q%in%con&dfa$target%in%target&dfa$det%in%det,]
}
#dfa<-qltdf
get.mean.df<-function(dfa,dist){
  q.u<-unique(dfa$q)
  q.u<-q.u[!is.na(q.u)]
  ql<-unlist(lapply(seq_along(q.u),function(i){
    rep(q.u[i],2)
  }))
  ql
  c.u<-unique(dfa$target)
  c.u<-c.u[!is.na(c.u)]
#  dist<-c("dist","dist_rel)
  df.m<-data.frame(target=rep(c.u,length(q.u)),q=ql,n=NA,mean=NA,median=NA)
  for(k in 1:length(q.u)){
    qx<-q.u[k]
    m.q<-dfa$q==qx
    sum(m.q)
    for(c in 1:length(c.u)){
      cx<-c.u[c]
      m.c<-dfa$target[m.q]==cx
      l<-sum(m.c)
      df.m$n[df.m$target==cx&df.m$q==qx]<-l
      Y<-dfa[[dist]]
      df.m$mean[df.m$target==cx&df.m$q==qx]<-mean(Y[m.q][m.c],na.rm=T)
      df.m$median[df.m$target==cx&df.m$q==qx]<-median(Y[m.q][m.c],na.rm=T)
    }
  }
  #d.sel<-"dist"
  #mean(dfa[[d.sel]])
  #dfm$q <- factor(dfm$q, levels = c("a", "b", "c", "d", "e", "f"))
  
  return(df.m)
}
#dfe<-get.mean.df(tdb4)
rmd.plot.lme<-function(lm2.summ){
  coef<-lm2.summ$coefficients
  cats<-rownames(coef)
  mean.abs<-coef[,1]
  mean.abs[1]<-0
  par(las=2)
  bp <- barplot(mean.abs~cats,xlab = "",ylab="mean token distance",main="lmer estimate relations")
  y_intercept <- mean.abs[1]
  x_min <- min(bp)
  x_max <- max(bp)
  tx<-x_max+1
  ty<-2
  text(x = tx-4, y = ty+10, labels = paste0("Intercept (corpus=obs) = ",round(coef[1,1],0)), pos = 3, col = "black", cex = 0.8)
  return(bp)
}
get.dist.rel<-function(qltdf){
tdb6<-qltdf
mna<-is.na(tdb6$token)
tdb6<-tdb6[!mna,]
target<-unique(tdb6$target)
tdb6$range_f_within<-NA
tdb6$range_f_all<-mean(tdb6$range)/tdb6$range
tdb6$range_f_obs<-mean(tdb6$range[tdb6$target=="obs"])/tdb6$range
tdb6$range_f_ref<-mean(tdb6$range[tdb6$target=="ref"])/tdb6$range
for(k in target){
  r<-tdb6$target==k
  mr<-mean(tdb6$range[r])/tdb6$range[r]
  tdb6$range_f_within[r]<-mr
}
tdb6$dist_rel_within<-tdb6$dist_abs*tdb6$range_f_within
tdb6$dist_rel_all<-tdb6$dist_abs*tdb6$range_f_all
tdb6$dist_rel_obs<-tdb6$dist_abs*tdb6$range_f_obs
tdb6$dist_rel_ref<-tdb6$dist_abs*tdb6$range_f_ref
return(tdb6)
}
gplot.dist<-function(dfnorm,reference_target){
  library(ggplot2)
  library(tidyr)  
  selector<-c(obs="dist_rel_obs",ref="dist_rel_ref",all="dist_rel_all")  
  colselect<-colnames(dfnorm)%in%selector[reference_target]
  col.ns<-colnames(dfnorm)[which(colselect)]
  plot_data <- dfnorm %>%
    # select(target, dist, normalized_dist_to_ref, normalized_dist_within_cat) %>%
    select(target, dist,col.ns , dist_rel_within) %>%
    pivot_longer(cols = c(dist, col.ns, dist_rel_within),
                 names_to = "method", values_to = "distance") %>%
    mutate(
      method = case_when(
        method == "dist" ~ "Raw",
        method == col.ns ~ paste("Normalized to", reference_target),
        method == "dist_rel_within" ~ "Normalized within target"
      )
    )
  
  # Create comparison plot
  p <- ggplot(plot_data, aes(x = target, y = distance, fill = target)) +
    geom_boxplot(alpha = 0.7) +
    stat_summary(fun = median, geom = "point", shape = 23, size = 3, 
                 fill = "white", color = "black") +
    facet_wrap(~ method, scales = "free_y", ncol = 3) +
    labs(
      title = "Distance Comparison: Raw vs target-Normalized",
      subtitle = "Diamond = median",
      y = "Distance",
      x = "target"
    ) +
    theme_minimal() +
    theme(legend.position = "none")
  
  return(p)
}
#gplot.dist(dfa,"all")
#df <- read.csv("eval-001.csv")

# # Ensure q is ordered a-f
# dfe$q <- factor(dfe$q, levels = c("a", "b", "c", "d", "e", "f"))

# dfb<-create.sub(qltdf,c("ref","obs"),letters[1:6],F)
# dfc<-create.sub(qltdf,c("ref","obs"),letters[1:6],T)
dfa<-qltdf
# unique(dfa$det)
#rm(qltdf)
# Y <- dfa$dist           # Dependent variable
# mean(Y[dfa$target=="obs"],na.rm = T)
# mean(Y[dfa$target=="obs"])
# mean(Y[dfa$target=="ref"])
# ###
# anova_model <- aov(dist ~ target*q*det, data = dfa)
# anova_model <- aov(dist ~ target*q, data = dfa)
# #anova_model <- aov(Y ~ group*q, data = dfa)
# anova.sum<-summary(anova_model)
# anova.sum<-anova.sum[[1]]
# anova.sum
library(lmerTest)
library(dplyr)
# lmeform.l<-list(no.pre.det=
# lme.form.f<-"dist~target*q+range+(1|lemma)",pre.det=
# lme.form.t<-"dist~target*q+range+(1|lemma)+(1|det)",pre.det.r=
# lme.form.r<-"dist_rel_all~target*q+(1|lemma)+(1|det)")
# anova.form.l<-list(no.pre.det="dist ~ target*q",pre.det="dist ~ target*q*det",
#                    pre.det.r="dist_rel_all ~ target*q*det")
#   target<-c("ref","obs")
# con<-letters[1:6]
# det.t<-c(F,T)
# r<-c(T)
# ref<-"all"
get.anovas<-function(qltdf,target,con,det.t,r,ref){
#  dfa<-qltdf[qltdf$target%in%target&qltdf$q%in%con,]
  dfa<-create.sub(qltdf,target,con,det.t)
  d.ns<-c(paste0("dist_rel_",ref))
  c.dist<-which(colnames(dfa)%in%d.ns)
  d.sel<-which(colnames(dfa)==d.ns)
  d.sel<-ifelse(r,colnames(dfa)[d.sel],"dist")
  det.f<-ifelse(sum(det.t)>0,"*det","")
  anova.fstr<-paste0(d.sel," ~ target*q",det.f)
  lme.str<-paste0(d.sel," ~ target*q",det.f,"+(1|lemma)",ifelse(r,"","+range"))
  # lmeform.l<-list(no.pre.det=
  #                   lme.form.f<-paste0(d.sel,"~target*q+range+(1|lemma)"),pre.det=
  #                   lme.form.t<-paste0(d.sel,"~target*q+range+(1|lemma)+(1|det)"))
  lmeform.l<-list(form.global<-lme.str)
  lmeform.l
  anova.form.l<-list(no.pre.det=anova.fstr,
                     pre.det=paste0(anova.fstr,"*det"))
  anova.form.l
  #lmeform<-ifelse(sum(det.t)==1,lmeform<-lmeform.l$pre.det,lmeform.l$no.pre.det)
  lmeform<-lmeform.l[[1]]
  lmeform
  #lmeform<-lmeform.l$pre.det
  #Y <- dfa$dist           
  #aov(as.formula(fstr),data = dfa)
  ifelse(sum(det.t)==1,model<-aov(as.formula(anova.fstr),data=dfa),
                              model<-aov(as.formula(anova.fstr),data=dfa))
          # makes no sense, not wks. if length(unique(dfa$det))==1 i.e. the subset includes only det==T or det==F, so only pass whole set
  anova.sum<-summary(model)
  anova.sum<-anova.sum[[1]]
  anova.sum
  lm2<-lmer(eval(expr(lmeform)),dfa)
  #lm3<-lmer(eval(expr(lmeform)),dfa)
  summary(lm2)
  lm2.summ<-summary(lm2)
  lm2.summ
  anlm.summ<-anova(lm2)
  anlm.summ
  lm2.summ
  anlm.summ
  anova.sum
  df.eval<-get.mean.df(dfa,d.sel)
  dfe<-df.eval
  dfe$q <- factor(dfe$q, levels = c("a", "b", "c", "d", "e", "f"))
  
 # bp<-rmd.plot.lme(lm2.summ)
  
  return(list(anova.plain=anova.sum,anova.lme=anlm.summ,lme=lm2.summ,plot.md=dfe,lme.form=lmeform,anova.form=anova.fstr))
}
#rm(eval.1)
# if(!exists("eval.1"))
# eval.1<-get.anovas(qltdf,c("obs","ref"),letters[1:6],c(T,F),c(T),"obs")
#eval.1$plot.lme
fun.dep<-function(){
lm2<-lmer(eval(expr(lmeform.l$no.pre.det)),dfa)
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
anova.sum
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
}
#mno
#mnr

### simple
# get.mean.df<-function(dfa){
#   q.u<-unique(dfa$q) 
#   ql<-unlist(lapply(seq_along(q.u),function(i){
#     rep(q.u[i],2)
#   }))
#   ql
#   c.u<-unique(dfa$target)
#   df.m<-data.frame(target=rep(c.u,length(q.u)),q=ql,n=NA,mean=NA,median=NA)
#   for(k in 1:length(q.u)){
#     qx<-q.u[k]
#     m.q<-dfa$q==qx
#     sum(m.q)
#     for(c in 1:length(c.u)){
#       cx<-c.u[c]
#       m.c<-dfa$target[m.q]==cx
#       l<-sum(m.c)
#       df.m$n[df.m$target==cx&df.m$q==qx]<-l
#       df.m$mean[df.m$target==cx&df.m$q==qx]<-mean(dfa$dist[m.q][m.c])
#       df.m$median[df.m$target==cx&df.m$q==qx]<-median(dfa$dist[m.q][m.c])
#     }
#   }
#   return(df.m)
# }
# 
# 
# #df <- read.csv("eval-001.csv")
# df.eval<-get.mean.df(dfa)
# df.eval$mean[df.eval$target=="obs"]
# df.eval$mean[df.eval$target=="ref"]
# dfe<-df.eval
# 
# # Ensure q is ordered a-f
# dfe$q <- factor(dfe$q, levels = c("a", "b", "c", "d", "e", "f"))
# 
#plot

plot.dist<-function(dfe,m){
  # Reshape data: rows = q, columns = corp, values = dist
  ifelse(m=="median",bar_mat <- tapply(dfe$median, list(dfe$q, dfe$target), identity),
  bar_mat <- tapply(dfe$mean, list(dfe$q, dfe$target), identity))
  bar_mat <- t(bar_mat)  # barplot expects groups in columns
  par(las=1)
  # Make grouped barplot
  df.plot<-barplot(bar_mat,
                   beside = TRUE,
                   col = c("black", "red"),
                   names.arg = levels(dfe$q),
                   legend.text = rownames(bar_mat),
                   args.legend = list(x = "right"),
                   ylab = paste0(m," distance"),
                   main = "distance by query and corpus")
  
}
#plot.dist()
rmd.plot.lme<-function(lm2.summ){
  coef<-lm2.summ$coefficients
  cats<-rownames(coef)
  mean.abs<-coef[,1]
  mean.abs[1]<-0
  par(las=2)
  bp <- barplot(mean.abs~cats,xlab = "",ylab="mean token distance",main="lmer estimate relations")
  y_intercept <- mean.abs[1]
  x_min <- min(bp)
  x_max <- max(bp)
  tx<-x_max+1
  ty<-2
  text(x = tx-4, y = ty+10, labels = paste0("Intercept (corpus=obs) = ",round(coef[1,1],0)), pos = 3, col = "black", cex = 0.8)
 # return(bp)
}
### sums df
# 
# sumtx.a<-data.frame(anlm.summ)
# sumtx.a<-cbind(anova.lme=rownames(sumtx.a),sumtx.a)
# sumtx.a<-sumtx.a[c(1,4,2,3,6,7)]
# sumtx.b<-data.frame(anova.sum)
# sumtx.b<-cbind(anova.plain=rownames(sumtx.b),sumtx.b)
# #sumtx.c<-rbind(sumtx.a,sumtx.b)
# #sumtx.b<-sumtx.b[c(1,2,3,5,6,7)]
# #umtx$dun<-NA
# lmco<-lm2.summ$coefficients
# lmco<-cbind(anova.lme=rownames(lmco),lmco)
# 
# empty<-(rep("---",6))
# ns.an.a<-colnames(sumtx.a)
# ns.an.b<-colnames(sumtx.b)
# ns.lm<-c(colnames(lmco))
# colnames(sumtx.a)<-rep("X",6)
# colnames(sumtx.b)<-rep("X",6)
# colnames(lmco)<-rep("X",6)
# sumtxdf<-rbind(ns.an.a,sumtx.a,ns.an.b,sumtx.b,ns.lm,lmco,empty)
# 
# 
