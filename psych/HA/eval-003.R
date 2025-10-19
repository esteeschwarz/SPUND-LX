#20250713(12.14)
#15292.psych.eval.cleaned
#########################
#dataset<-7
source(paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/psych/HA/eval-init-vars.R"))
read.db_dep<-function(){
  
  
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
  tdb<-read.db(run)
n_obs<-length(tdb$obs$token)
n_ref<-length(tdb$ref$token)
build.q_dep<-function(){
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
read.embed<-function(witch){
  e2<-new.env()
  load(paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/stef_psych/embed-",witch,".RData"),envir = e2)
  return(e2$t3)
  
}
#t3<-read.embed(211)
#load(paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/stef_psych/eval-007.RData"))
# if(!exists("dfa")){
# ifelse(exists("eval.n"),qltdf<-read.eval(eval.n),qltdf<-read.eval(dataset))
# dfa<-qltdf
# dfa<-get.dist.norm(dfa)
# }
create.sub<-function(dfa,target,con){
  sub1<-dfa[dfa$q%in%con&dfa$target%in%target,]
}
#dfa<-qltdf
#dist<-"dist_rel_obs"
get.mean.df<-function(dfa,dist){
  q.u<-unique(dfa$q)
  q.u<-q.u[!is.na(q.u)]
  ql<-unlist(lapply(seq_along(q.u),function(i){
    rep(q.u[i],2)
  }))
  ql<-ql[order(ql)]
  c.u<-unique(dfa$target)
  c.u<-c.u[!is.na(c.u)]
#  dist<-c("dist","dist_rel)
  df.m<-data.frame(target=rep(c.u,length(q.u)),q=ql,n=NA,mean=NA,median=NA)
  k<-1
  for(k in 1:length(q.u)){
    qx<-q.u[k]
    m.q<-dfa$q==qx
    sum(m.q)
    c<-1
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
#dfe<-get.mean.df(dfa,"dist_rel_ref")
#dfe
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
get.dist.rel_dep<-function(qltdf){
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
##############################################
gplot.dist<-function(dfnorm,reference_target,margin){
  library(ggplot2)
  library(tidyr)  
  selector<-c(obs="dist_rel_obs",ref="dist_rel_ref",all="dist_rel_all",scaled="dist_rel_scaled")  
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
       # method == "dist_rel_scaled" ~ "Raw",
        method == col.ns ~ paste("Normalized to", reference_target),
        method == "dist_rel_within" ~ "Normalized within target"
      )
    )
#  ylim<-max(dfe$mean)+100
  ylim<-margin
  # Create comparison plot
  p <- ggplot(plot_data, aes(x = target, y = distance, fill = target)) +
    geom_boxplot(alpha = 0.7,coef=0,outlier.shape = NA) +
    stat_summary(fun = median, geom = "point", shape = 23, size = 3, 
                 fill = "white", color = "black") +
    coord_cartesian(ylim = c(0, ylim)) +  # Adjust to your desired y-axis range
  
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
library(lmerTest)
library(dplyr)
library(pbapply)
### normalize distances
#limit<-T
#tdb4<-qltdf.le.red
lemma.reduce<-function(qltdf){
  le.lemma<-pblapply(qltdf$lemma,function(x){
    l<-strsplit(x,"")%>%unlist()%>%length()
    return(l)
  })
  le.lemma.u<-unlist(le.lemma)
  #sum(le.lemma.u)
  #head(le.lemma.u,700)
  qltdf$le.char<-le.lemma.u
  qltdf<-qltdf[qltdf$le.char>1,]
  return(qltdf)
  
}

get.dist.norm<-function(dfa,limit){
  df<-data.frame(dfa)
#  lim<-limit
  dflim<-subset(df,df$dist<limit)
  typeof(dflim)
  Q1 <- quantile(df$dist, 0.25,na.rm = T)
  Q3 <- quantile(df$dist, 0.75,na.rm = T)
  IQR <- Q3 - Q1
  #limit
  tdb_no_outliers <- subset(df, dist > (Q1 - 1.5 * IQR) & dist < (Q3 + 1.5 * IQR))
  max(tdb_no_outliers$dist)
#  df_no_outliers <- subset(df, dist < limit)
  #df<-df_no_outliers
  ifelse(sum(limit)>0,ifelse(sum(limit)==1,tdb6<-tdb_no_outliers,tdb6<-dflim),tdb6<-df)
  
  max.l<-max(tdb6$dist,na.rm = T)
  mna<-is.na(tdb6$token)
#cat("token NA",sum(mna))
  if(sum(mna)>0)
    tdb6<-tdb6[!mna,]
  mna<-is.na(tdb6$dist)
  if(sum(mna)>0)
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
  tdb6$dist_rel_within<-tdb6$dist*tdb6$range_f_within
  tdb6$dist_rel_all<-tdb6$dist*tdb6$range_f_all
  tdb6$dist_rel_obs<-tdb6$dist*tdb6$range_f_obs
  tdb6$dist_rel_ref<-tdb6$dist*tdb6$range_f_ref
  tdb6$range_c<-tdb6$range-mean(tdb6$range,na.rm=T)
  tdb6$embed_c<-tdb6$embed.score-mean(tdb6$embed.score,na.rm=T)
  tdb6$dist_rel_scaled<-tdb6$dist / tdb6$range  # values now in [0,1] relative to each URL’s size

  return(tdb6)
}
if(reload){
#  ifelse(exists("eval.n"),qltdf<-read.eval(eval.n),qltdf<-read.eval(dataset))
  qltdf<-read.eval(dataset)
  qltdf_embed<-read.csv(paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/stef_psych/qltdf_embed.csv"))
  #load(paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/stef_psych/eval-012.RData")) #qltdf
  # qltdf$embed.score<-qltdf_embed$embed_score
  qltdf$embed.score<-qltdf_embed$embed_score*100 # for better align in estimates (+1 unit change)
  #dfa<-get.dist.norm(qltdf,limit)
  qltdf<-lemma.reduce(qltdf)
  #dfa<-qltdf
  # dfa<-get.dist.norm(dfa,limit)
}

#dfa<-get.dist.norm(qltdf,limit)

#################
### apply embeds: restore!
# qltdf_sf<-qltdf
# t4<-read.csv(paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/stef_psych/embed-2146.csv"))
# load(paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/stef_psych/embed-211.RData"))
# t3$embed.score<-t4$embed_score
# t3$url<-as.character(t3$url)
# 
# dfa$embed.score<-NA
# t3n<-t3[!is.na(t3$embed.score),]
# for (k in 1:length(t3n$lemma)){
#   cat("\r",k)
#   l<-t3n$lemma[k]
#   u<-t3n$url[k]
#   e<-t3n$embed.score[k]
#   r1<-dfa$lemma==l&dfa$url==u
#   dfa$embed.score[r1]<-e
# }
# factor(dfa$embed.score)
# df_used <- na.omit(dfa[, c("dist", "target", "lemma", "embed.score")])
# df_used <- na.omit(dfa[, c("target", "embed.score")])
# length(unique(df_used$target))
#################################
### to redo if enoght levels for embed score
############################################
# max(tdb4$dist,na.rm = T)
# limit<-5000
# tdb5<-tdb4[tdb4$dist<limit,]
# tdb6<-get.dist.norm(tdb5,5000)

get.anovas_dep<-function(qltdf,target,con,det.t,r,ref,author){
#  dfa<-qltdf[qltdf$target%in%target&qltdf$q%in%con,]
  dfa<-create.sub(qltdf,target,con,det.t)
  #dfa<-get.dist.norm(dfa,limit)
  d.ns<-c(paste0("dist_rel_",ref))
  c.dist<-which(colnames(dfa)%in%d.ns)
  d.sel<-which(colnames(dfa)==d.ns)
  d.sel<-ifelse(r,colnames(dfa)[d.sel],"dist")
  det.f<-ifelse(sum(det.t)>0,"*det","")
  anova.fstr<-paste0(d.sel," ~ target*q",det.f)
  aut.str<-ifelse(author,"+(1|aut_id)","")
  lme.str<-paste0(d.sel," ~ target*q",det.f,"+(1|lemma)",aut.str,ifelse(r,"","+range"))
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

### with embed
### 15336. TODO: include lemma switch
get.anovas.e<-function(dfa,target,con,det.t,ref,lemma,author,url,range.ti,embed.ti,lme){
  #  dfa<-qltdf[qltdf$target%in%target&qltdf$q%in%con,]
  lme_stage_one<-function(){
    lm1<-lm("dist ~ range",dfa)
    res<-lm1$residuals
    #dfa$dist_rel_lm<-res
    return(res)
  }
  dfa<-create.sub(dfa,target,con)
  #dfa<-get.dist.norm(dfa,limit)
  d.ns<-c(paste0("dist_rel_",ref))
  d.ns<-c(paste0("dist",ref))
  c.dist<-which(colnames(dfa)%in%d.ns)
  d.sel<-which(colnames(dfa)==d.ns)
  d.sel<-ifelse(range.ti[1],colnames(dfa)[d.sel],"dist")
  #d.sel<-d.ns
  det.f<-ifelse(sum(det.t)>0,"*det","")
  embed.i<-ifelse(embed.ti[2]=="f","+(embed.score)","+(1|embed.score)")
  embed.f<-ifelse(embed.ti[1],embed.i,"")
  range.i<-ifelse(range.ti[2]=="f","+range","+(1|range)")
  range.f<-ifelse(range.ti[1],range.i,"")
  lemma.f<-ifelse(lemma,"+(1|lemma)","")
  anova.fstr<-paste0(d.sel," ~ target*q",det.f)
 # print(anova.fstr)
  aut.str<-ifelse(author,"+(1|aut_id)","")
  url.str<-ifelse(url,"+(1|url_id)","")
  lme.str<-paste0(d.sel," ~ target*q",det.f,lemma.f,aut.str,range.f,embed.f,url.str)
  ifelse(lme,dfa$dist_rel_lm<-lme_stage_one(),F)
  d.sel<-ifelse(!lme,d.sel,"dist_rel_lm")
  lme.str<-ifelse(!lme,lme.str,paste0(d.sel," ~ target*q",det.f,lemma.f,aut.str,embed.f,url.str))
  # lmeform.l<-list(no.pre.det=
  #                   lme.form.f<-paste0(d.sel,"~target*q+range+(1|lemma)"),pre.det=
  #                   lme.form.t<-paste0(d.sel,"~target*q+range+(1|lemma)+(1|det)"))
  lmeform.l<-list(form.global<-lme.str)
  #lmeform.l
  # anova.form.l<-list(no.pre.det=anova.fstr,
  #                    pre.det=paste0(anova.fstr,"*det"))
  # anova.form.l<-list(adapted=anova.fstr)
  # 
  #   anova.form.l
  #lmeform<-ifelse(sum(det.t)==1,lmeform<-lmeform.l$pre.det,lmeform.l$no.pre.det)
  lmeform<-lmeform.l[[1]]
 # print(lmeform)
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
  
  return(list(anova.plain=anova.sum,anova.lme=anlm.summ,lme=lm2.summ,lmer=lm2,plot.md=dfe,lme.form=lmeform,anova.form=anova.fstr))
}

#rm(eval.1)
# if(!exists("eval.1"))
#eval.1$plot.lme
fun.dep<-function(){
  ######
  qltdf_embed<-read.csv(paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/stef_psych/qltdf_with_scores.csv"))
  load(paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/stef_psych/eval-012.RData")) #qltdf
  qltdf$embed.score<-qltdf_embed$embed_score
  library(pbapply)
  le.lemma<-pblapply(qltdf$lemma,function(x){
    l<-strsplit(x,"")%>%unlist()%>%length()
    return(l)
  })
  le.lemma.u<-unlist(le.lemma)
  sum(le.lemma.u)
  head(le.lemma.u,700)
  qltdf$le.char<-le.lemma.u
  qltdf.le.red<-qltdf[qltdf$le.char>1,]
  sum(!is.na(qltdf$embed.score))
  dfa<-get.dist.norm(qltdf,limit)
  max(dfa$dist)
  dfa<-get.dist.norm(qltdf.le.red,limit)
  # get.anovas.e<-function(qltdf,target,con,det.t,ref,lemma,author,range.ti,embed.ti){
    
  eval.3<-get.anovas.e(dfa,c("obs","ref"),letters[1:6],c(T,F),"obs",T,c(T,T),c(T,T))
  eval.0<-get.anovas.e(dfa,c("obs","ref"),letters[1:6],c(T,F),c(T),"obs",T,F)
  eval.4<-get.anovas.e(dfa,c("obs","ref"),letters[1:6],c(T,F),"obs",T,c(T,T),c(T,T))
  eval.4<-get.anovas.e(dfa,c("obs","ref"),letters[1:6],c(T,F),"obs",T,c(F,F),c(T,F))
  eval.5<-get.anovas.e(dfa,c("obs","ref"),letters[1:6],c(T,F),"obs",F,T,c(T,F),c(T,F))
  eval.6<-get.anovas.e(dfa,c("obs","ref"),letters[1:6],c(T,F),"obs",F,T,c(T,F),c(T,T)) #no
  #### with embed
  eval.1$anova.lme
  l1<-lmer(dist~target*q*det+embed.score+(1|aut_id),dfa)
  #l2<-lmer(dist~target*q*det+(embed.score*-1)+(1|aut_id),dfa)
  summary(l2)
  summary(eval.1$lme)
  summary(eval.4$lme)
  summary(eval.0$lme)
  summary(eval.5$lme)
  max(dfa$dist)
  mean(dfa$dist)
  dfa.l<-dfa[dfa$dist<2000,]
  qltdf.l<-qltdf.le.red[qltdf.le.red$dist<2000,]
  dfa.l<-get.dist.norm(qltdf.l,T)
  
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
mean(dfa.l$dist[dfa$target=="obs"],na.rm=T)
mean(dfa.l$dist[dfa$target=="ref"],na.rm=T)
median(dfa.l$dist[dfa$target=="obs"],na.rm=T)
median(dfa.l$dist[dfa$target=="ref"],na.rm=T)
mean(dfa$dist[dfa$target=="obs"],na.rm=T)
mean(dfa$dist[dfa$target=="ref"],na.rm=T)
median(dfa$dist[dfa$target=="obs"],na.rm=T)
median(dfa$dist[dfa$target=="ref"],na.rm=T)
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
#par(plot=new)
#plot.new()
rmd.plot.lme<-function(lm2.summ){
  coef<-lm2.summ$coefficients
  cats<-rownames(coef)
  mean.abs<-coef[,1]
  baseline<-round(mean.abs[1],0)
  #print(baseline)
  mean.abs[1]<-0
  par(las=2)
  
  # Get current y-axis ticks
  bp <- barplot(mean.abs~cats,xlab = "",yaxt="n",ylab="estimated mean token distance",main="lmer estimate relations")
  y_ticks3 <- pretty(range(coef[,1]))
#  y_ticks3 <- coef[,1]
  
 # print(y_ticks3)
  y_labels3 <- y_ticks3 + baseline
  axis(2, at = y_ticks3, labels = y_labels3)
#  mtext("Absolute Value", side = 2, line = 3)
#  y_ticks <- axTicks(2)  # gets the current tick positions
  #print(y_ticks)
    #baseline <- 287
#  y_labels <- y_ticks + baseline
  
  # Replace y-axis
 # old_par <- par(no.readonly = TRUE)
  
#  par(yaxt="n")
  
 #axis(2, labels=FALSE, tick=FALSE)
#  axis(2, at=y_ticks, labels=y_labels)
#  par(old_par)
  
#  axis(2, at=y_ticks)
  y_intercept <- mean.abs[1]
  x_min <- min(bp)
  x_max <- max(bp)
  tx<-x_max+1
  ty<-2
#  text(x = tx-4, y = ty+10, labels = paste0("Intercept (corpus=obs) = ",round(coef[1,1],0)), pos = 3, col = "black", cex = 0.8)
#  text(x = tx-4, y = ty+10, labels = paste0("Intercept (corpus=obs) = ",round(coef[1,1],0)), pos = 3, col = "black", cex = 0.8)
  # return(bp)
  
}
#rmd.plot.lme(s3)
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
