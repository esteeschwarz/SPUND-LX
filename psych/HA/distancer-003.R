# 20250720(17.04)
# 15302.3rd approach distancer, model 8
# with basic df position diffs
##############################

# get tdb from sqlite
qs<-build.q()

#tdb<-read.db(15276) # 2nd run
tdb<-read.db(15302) # 3nd run

tdb$obs$target<-"obs"
tdb$ref$target<-"ref"
tdb1o<-tdb$obs
tdb1r<-tdb$ref
m1<-grepl("<doc |<s |</s>|</doc>",tdb1o$token)
sum(m1)
m2<-grepl("<doc id=",tdb1o$token)
m3<-which(m2)
sum(m2)
library(xml2)
doc.a<-tdb1o$token[m2]
doc1<-lapply(doc.a,function(x){
  htm<-read_html(x)
  doc<-xml_find_all(htm,"//doc")
  id<-xml_attr(doc,"id")
  url<-xml_attr(doc,"url")
  aut<-xml_attr(doc,"author")
  return(data.frame(m=x,id,url,author=aut))
  
})
htm<-doc1[[1]]
t1<-doc1[[1]]
tdb2o<-tdb1o
tdb2o$url_t<-NA
tdb2o$author<-NA
m31<-m3-1
m32<-m31[2:length(m31)]
m32<-c(m32,last(m3))
k<-1
for(k in 1:length(doc1)){
  print(k)
  t2<-doc1[[k]]
  r1<-c(m3[k]:m32[k])
  tdb2o$url_t[r1]<-t2$url
  tdb2o$author[r1]<-t2$author
  
}
#head(tdb1o$token[m2])
tdb1o<-tdb2o[!m1,]
##################
m1<-grepl("<doc |<s |</s>|</doc>",tdb1r$token)
sum(m1)
m2<-grepl("<doc id=",tdb1r$token)
m3<-which(m2)
sum(m2)
#library(xml2)
doc.a<-tdb1r$token[m2]
doc1<-lapply(doc.a,function(x){
  htm<-read_html(x)
  doc<-xml_find_all(htm,"//doc")
  id<-xml_attr(doc,"id")
  url<-xml_attr(doc,"url")
  aut<-xml_attr(doc,"author")
  return(data.frame(m=x,id,url,author=aut))
  
})
htm<-doc1[[1]]
t1<-doc1[[1]]
tdb2r<-tdb1r
tdb2r$url_t<-NA
tdb2r$author<-NA
m31<-m3-1
m32<-m31[2:length(m31)]
m32<-c(m32,last(m3))
k<-1
for(k in 1:length(doc1)){
  print(k)
  t2<-doc1[[k]]
  r1<-c(m3[k]:m32[k])
  tdb2r$url_t[r1]<-t2$url
  tdb2r$author[r1]<-t2$author
  
}
tdb1r<-tdb2r[!m1,]
# library(gtools)
# order_ido <- mixedorder(tdb1o$pid,decreasing = F)
# tdb1os<-tdb1o[order(order_ido,rownames(tdb1o),tdb1o$timestamp),]
# order_idr <- mixedorder(tdb1r$pid)
# tdb1rs<-tdb1r[order(order_idr),]
#tdb1rs<-tdb1r[order(tdb1r$pid),]
# tdb1os$pos<-1:length(tdb1os$token)
# tdb1rs$pos<-1:length(tdb1rs$token)
################################
tdb1o$pos<-1:length(tdb1o$token)
tdb1r$pos<-1:length(tdb1r$token)
#tdb1os[grep("l2-com9.",tdb1os$pid),"pid"]
#tdb$ref$pos<-1:length(tdb$ref$token)
tdba.1<-rbind(tdb1o,tdb1r)
tdba<-tdba.1
l1<-length(tdba.1$target)
#tdba<-rbind(tdb$obs,tdb$ref)
#tdba$run<-NA
#tdba$run[1:1012759]<-1
#tdba$run[1012760:(length(tdba$token))]<-2
tdba.n<-tdba[tdba$upos=="NOUN",]
n1w<-tdba.n$pos-1
sum(n1w==1)
sum(n1w==0)
n1w<-n1w[!is.na(n1w)]
n1w[n1w==0]<-1
#n1w<-as.double(rownames(tdba.n))-1
tdba.n$pre<-NA
length(tdba$token[n1w])
tdba.n$pre<-tdba$token[n1w]
#m<-grep("<doc ",tdba.n$pre)
tdba.n$prepos<-tdba$upos[n1w]
#tdba.n$pos<-as.double(rownames(tdba.n))
#dis1<-diff(tdba.n$pos)
#tdba.n$dist<-c(1,dis1)
qs[[2]]
#sub.1<-tdba.n[tdba.n$pre%in%qs[[2]]$b$q,]
sub.2<-tdba.n[tdba.n$pre%in%qs[[2]]$b$q,]
sub.3<-tdba.n[tdba.n$pre%in%qs[[3]]$c$q,]
sub.4<-tdba.n[tdba.n$pre%in%qs[[4]]$d$q,]
sub.5<-tdba.n[tdba.n$pre%in%qs[[5]]$e$q,]
sub.6<-tdba.n[tdba.n$pre%in%qs[[6]]$f$q,]
m2<-tdba.n$pre%in%qs[[2]]$b$q
m3<-tdba.n$pre%in%qs[[3]]$c$q
m4<-tdba.n$pre%in%qs[[4]]$d$q
m5<-tdba.n$pre%in%qs[[5]]$e$q
m6<-tdba.n$pre%in%qs[[6]]$f$q
tdba.n$q<-"a"
# tdba.n$q[m2]<-"b"
# tdba.n$q[m3]<-"c"
# tdba.n$q[m4]<-"d"
# tdba.n$q[m5]<-"e"
# tdba.n$q[m6]<-"f"
table(tdba.n$q)
#model<-aov(dist~target*q,tdba.n)
#summary(model)
#lm1<-lmer(dist~target*q+(1|prepos)+(1|lemma),tdba.n)
#sum1<-summary(lm1)
#sum1
#boxplot(dist~target,tdba.n,outline=F)
# overall all-noun distances: lower for target
#mean
#library(utils)
#citation("RedditExtractoR")

# idea: use df.complete as intercept and rbind subsets of conditions
sub.2$q<-"b"
sub.3$q<-"c"
sub.4$q<-"d"
sub.5$q<-"e"
sub.6$q<-"f"
#sub.2$q<-"b"
tdba.2<-rbind(tdba.n,sub.2,sub.3,sub.4,sub.5,sub.6)
table(tdba.2$q)
t.det<-table(tdba.2$q[tdba.2$prepos=="DET"])
t.det
# b -311, c/d ==, e/f 0 : the + a,any,some,an are all DET
# unnu?
# 1st: get only distances of same-noun
#boxplot(dist~target,tdba.n,outline=F)
# overall all-noun distances: lower for target
# ar.obs<-array()
# ar.ref<-array()
# for(q in letters[1:6]){
#   mn1<-mean(tdba.2$dist[tdba.2$q==q&tdba.2$target=="obs"])
#   mn2<-mean(tdba.2$dist[tdba.2$q==q&tdba.2$target=="ref"])
#   ar.obs[q]<-mn1
#   ar.ref[q]<-mn2
#   
# }  
# print(ar.obs)
# print(ar.ref)
# print(ar.ref-ar.obs)
# worthless information since dist is random
# get same-noun dist within range
# define ranges
# 15303.new url range essai per url_text
urlt<-tdba.2$url_t
length(unique(urlt))
###############
uid<-tdba.2$uid
length(unique(uid))
head(uid)
uid2<-gsub("dfurl([0-9]{1,4})-.*","\\1",uid)
#uid2<-gsub("-.*","",uid)
head(uid2)
uid2<-paste0(tdba.2$target,".",uid2)

length(unique(uid2))
#tdb$url<-uid2
unique(uid2)
tdba.2$url<-uid2
################
tdba.2$url<-urlt
################
ld<-tdba.2$lemma
mo<-grep("[^a-z]",ld)
length(mo)
tdba.2$lemma[mo]<-gsub("[^a-z]","",tdba.2$lemma[mo])
n.u<-unique(tdba.2$lemma) #14614
m.dup<-duplicated(tdba.2$lemma)
dup.w<-which(m.dup)
ld.u<-unique(tdba.2$lemma[dup.w])
length(ld.u)
head(ld.u)
ld.u<-ld.u[order(ld.u)]
ld.u<-ld.u[!ld.u==""]
head(ld.u)
mo<-grep("[^a-z]",ld.u)
length(mo)


unique(tdba.2$target[dup.w])
te<-unique(tdba.2$url[dup.w])
length(grep("schizophrenia",te))
length(grep("unpopular",te))
#x<-ld.u[1]
#x<-ld.u[69]
#which(ld.u=="evidence")
library(pbapply)
library(abind)
###############
# takes 2min45s
x<-ld.u[3]
tdb3.l<-pblapply(ld.u,function(x){
  tdba.2$dist<-NA
  print(x)
  r1<-tdba.2$lemma==x
  r1w<-which(r1)
  r1w
  #p1.o<-duplicated(tdba.2$token_id[r1w])
  #sum(p1.o)
  #u<-r1u[1]
  #r1u
  #r1u<-r1u[!p1.o]
  #r1w<-r1w[!p1.o]
  r1u<-tdba.2$url[r1w]
  table(r1u)
  #r1ud<-duplicated(r1u)
  dups <- names(table(r1u))[table(r1u) > 1]
  dups
  r1ud <- which(r1u %in% dups)
  c1<-tdba.2$pos[r1w[r1ud]]
  c1
  r1w<-r1w[r1ud]
  #r1u<-r1u[r1ud]
  #p1<-tdba.2$pos[r1w]
  r1u<-r1u[r1ud]
  r1u
  ### 15295.e
  #  p1.o<-duplicated(tdba.2$token_id[r1w])
  # sum(p1.o)
  u<-r1u[1]
  u
  #uw<-which(r1u=="obs.23")
  r1u
  #r1u<-r1u[!p1.o]
  #r1w<-r1w[!p1.o]
  #r1u2<-strsplit(r1u,"\\.")
  #r1u2
  #  r1u2<-data.frame(t(abind(r1u2,along = 2)))
  #r1u2<-t(r1u2)
  # r1u2
  #  r1ud<-duplicated(r1u)
  #  r1u<-r1u[r1ud]
  #tdba.2[r1w[uw],]
  #############################
  #target<-"obs"
  get.ds<-function(r1u,target){
    # m1<-grep(target,r1u)
    # 
    # r1u<-unique(r1u[m1])
    # r1u
    # um<-which(r1u=="obs.2")
    # u<-r1u[um]
    d1<-lapply(r1u,function(u){
     # print(u)
      d3<-NA
      r2w<-which(tdba.2$url==u)
      r3w<-which(r1w%in%r2w)
      tdba.2$url[r1w[r3w]]
      tdba.2$pos[r1w[r3w]]
      tdba.2[r1w[r3w],]
      dups <- names(table(tdba.2$q[r1w[r3w]]))[table(tdba.2$q[r1w[r3w]]) > 1]
      dups
      qd <- which(tdba.2$q[r1w[r3w]] %in% dups)
      #r1w<-r1w[]
      r4w<-r1w[r3w[qd]]
      #    qd<-
      d2<-diff(tdba.2$pos[r4w])
      d2[d2<1]<-0
      ifelse(sum(d2)>0,d3<-c(0,d2),d3<-NA)
      tdba.2$dist[r4w]<-d3
      tdba.2[r4w,]
      # if(length(d2)>1)
      #   tdba.2$dist[r1w[r3w]]<-d2
      subr1<-tdba.2[r4w,]
      ifelse(length(subr1$target)>0,return(subr1),return(NA))
      return(rdf)
    })
  }
  d1o<-get.ds(r1u,"obs") 
  sum(is.na(d1o))
  d1o2<-d1o[!is.na(d1o)]
  # d1r<-get.ds(r1u,"ref")
  # d1r2<-d1r[!is.na(d1r)]
  # #d1<-unique(d1)
  d1o3<-data.frame(abind(d1o2,along = 1))
  #d1r3<-data.frame(abind(d1r2,along = 1))
  #d2<-rbind(d1o3,d1r3)
  d2<-d1o3
  unique(d2$target)
  #   d1<-unlist(d1)
  #   d1<-c(0,d1)
  #   #mna<-is.na(d1)
  # #  d1<-d1[!mna]
  #   if(length(d1)>1)
  #     tdba.2$dist[r1w]<-d1
  #   tdba.2[r4w,]
  #   ###################
  #   m1<-grep("ref",r1u)
  #   
  #   d1<-lapply(r1u[m1],function(u){
  #     d3<-NA
  #     r2w<-which(tdba.2$url==u)
  #     r3w<-which(r1w%in%r2w)
  #     d2<-diff(tdba.2$pos[r1w[r3w]])
  #     ifelse(d2!=0,d3<-c(0,d2),d3<-NA)
  #     return(d3)
  #   })
  #   d1
  #   d1<-unique(d1)
  #   d1
  #   d1<-unlist(d1)
  #   d1
  #   mna<-is.na(d1)
  #   d1<-d1[!mna]
  #   if(length(d1)>1)
  #     tdba.2$dist[r1w[r3w[which(!mna)]]]<-d1
  #   
  #   
  
  return(d2)
})
#dim(tdb3.l[[113]])==0
save(tdb3.l,file = paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/stef_psych/dist.df-010.RData"))
tdb4<-lapply(tdb3.l,function(x){
  d<-dim(x)
  ifelse(d[1]==0,return(NA),return(x))
})
tdb4<-tdb4[!is.na(tdb4)]
tdb4<-data.frame(abind(tdb4,along = 1))
unique(tdb4$target)
ur.u<-unique(tdb4$url)
tdb4$uid<-NA
for(u in 1:length(ur.u)){
  r1<-tdb4$url==ur.u[u]
  tdb4$url_t[r1]<-u
}
colnames(tdb4)[colnames(tdb4)=="url_t"]<-"url_id"
head(tdb4)
mode(tdb4$dist)<-"double"
tdb4$dist[tdb4$dist==0]<-NA
tdb4$det<-FALSE
tdb4$det[tdb4$prepos=="DET"]<-TRUE
#qltdf<-tdb4
#write.csv(qltdf,paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/psych/HA/eval-008.csv")) # too big for git
#save(qltdf,file=paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/stef_psych/eval-011.RData"))
#load(paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/stef_psych/eval-008.RData"))
#tdb4<-qltdf
mna<-is.na(tdb4$token)
sum(mna)
tdb4<-tdb4[!mna,]

# apply url range to final df
uid<-tdb$obs$uid
uid2<-gsub("dfurl([0-9]{1,4})-.*","\\1",uid)
#################
uid2<-tdb2o$url_t
mn1<-which(uid2=="")
mn1<-uid2==""
sum(mn1,na.rm = T)
mn1w<-which(mn1)
mn2<-which(is.na(uid2))
mn3<-c(mn1w,mn2)
uid2[mn3]<-"url_unknown"
head(uid2)
##########
#uid2[!mn1]<-paste0("obs.",uid2[!mn1])
##########
length(unique(uid2))
#unique(uid2)
tdb$obs$url<-uid2
url.u.o<-unique(uid2)
tdb$obs$range<-NA
# for(k in url.u.o){
#   r<-tdb$obs$url==k
#   tdb$obs$range[r]<-sum(r)
# }
# uid<-tdb$ref$uid
# uid2<-gsub("dfurl([0-9]{1,4})-.*","\\1",uid)
####################
uid2<-tdb2r$url_t
mn1<-which(uid2=="")
mn1<-uid2==""
sum(mn1,na.rm = T)
mn1w<-which(mn1)
mn2<-which(is.na(uid2))
mn3<-c(mn1w,mn2)
uid2[mn3]<-"url_unknown"
head(uid2)

length(unique(uid2))
#unique(uid2)
tdb$ref$url<-uid2
url.u.r<-unique(uid2)
tdb$ref$range<-NA

# mn1<-which(uid2=="")
# mn1<-uid2==""
# mn2<-which(is.na(uid2))
# head(uid2)
# uid2[!mn1]<-paste0("ref.",uid2[!mn1])
# length(unique(uid2))
# unique(uid2)
# tdb$ref$url<-uid2
# url.u.r<-unique(uid2)
# tdb$ref$range<-NA
tdb4$range<-NA
for(k in url.u.o){
  r1<-tdb$obs$url==k
  r2<-tdb4$url==k
  tdb4$range[r2]<-sum(r1)
}
for(k in url.u.r){
  r1<-tdb$ref$url==k
  r2<-tdb4$url==k
  tdb4$range[r2]<-sum(r1)
}
aut.u<-unique(qltdf$author)
qltdf$aut_id<-NA
for(a in 1:length(aut.u)){
  r1<-qltdf$author==aut.u[a]
  qltdf$aut_id[r1]<-a
  
}
#url.u<-c(url.u.o,url.u.r)
#head(uid)
#qltdf<-tdb4
#write.csv(qltdf,paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/psych/HA/eval-008.csv")) # too big for git
#save(qltdf,file=paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/stef_psych/eval-011.RData"))
#load(paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/stef_psych/eval-008.RData"))

### normalize distances # is done externally in eval-003.R during tests
dist.norm<-function(tdb4){
tdb6<-tdb4
mna<-is.na(tdb6$token)
sum(mna)
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
return(tdb6)
}

max(tdb4$dist,na.rm = T)
# limit<-5000
# tdb5<-tdb4[tdb4$dist<limit,]
tdb6<-dist.norm(tdb4)
unique(tdba.2$target)
#######################################
boxplot(dist_rel_all~target,tdb6,outline=F)
boxplot(dist_rel_within~target,tdb6,outline=F)
boxplot(dist_rel_ref~target,tdb6,outline=F)
boxplot(dist_rel_obs~target,tdb6,outline=F)
###########################################
#df_norm<-dfnorm
# colnames(tdb6)[colnames(tdb6)=="dist"]<-"dist_rel"
# colnames(tdb6)[colnames(tdb6)=="dist_abs"]<-"dist"
#reference_target<-"ref"

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
#gplot.dist(dfa,"all")gplot.dist(tdb6,"obs")
###########################################

max(tdb6$dist,na.rm = T)
which.max(tdb4$dist)
tdb4[7280:7300,]
ceil<-4000
mc<-tdb4$dist>ceil
sum(mc)
tdb4$dist[mc]<-NA
boxplot(dist~target,tdb4,outline=F)
model<-aov(dist~target*q,tdb4)
summary(model)
library(lmerTest)
lm1<-lmer(dist~target*q+(1|prepos)+(1|lemma),tdb4)
lm1<-lmer(dist~target*q+range+(1|prepos)+(1|det),tdb4)
lm1<-lmer(dist~target*q+(1|prepos)+(1|det),qltdf)
sum1<-summary(lm1)
sum1
anova(lm1)
model<-aov(dist~target*q,qltdf)
summary(model)
rmd.plot.lme(sum1)
which(ld.u=="amateur")
ld.u[219]
tdba[p1,]
tdba.2[r1w,] # stuck
#######
# bottom
getwd()
library(rmarkdown)
render("poster-ext.Rmd")

dfe<-get.mean.df(qltdf)
plot.dist(dfe,"mean")
plot.dist(dfe,"median")
qltdf<-tdb4
