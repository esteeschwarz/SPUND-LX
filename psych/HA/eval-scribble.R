plain:target:q  4.797e-05   0.0004797
an:lme  0.003563
0.15 1.5e-01
0.0035 3.5-03
0.00004.797-05

write.csv(dfa[sample(length(dfa$q),100),],paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/psych/HA/sampledist.df.csv"))
contrasts(dfa$target)
levels(dfa$target)
levels(dfa$q)
data<-dfa
data$q<-factor(data$q)
data$target<-factor(data$target)
levels(data$target)
levels(data$q)
contrasts(data$target)
data$target <- relevel(data$target, ref = "obs")  # Now intercept = "ref" baseline
data$q <- relevel(data$q, ref = "a")  # Optional: set another reference
lm1<-lmer(lme.form.t,data)
summary(lm1)
lm2<-lmer(dist~target*q+(1|det),data)
summary(lm2)
#length(unique(dfa$pos))
dup<-duplicated(data$pos)
dfa2<-data[!dup,]
data<-dfa2
unique(data$det)
unique(data$q)
length(sum(data$q=="f"))
length(sum(data$q=="d"))
table(dfa$q)
t.o<-table(tdb$obs$upos)
t.r<-table(tdb$ref$upos)
f.noun.obs<-t.o["NOUN"]/length(tdb$obs$token)
f.noun.ref<-t.r["NOUN"]/length(tdb$ref$token)
f.det.obs<-t.o["DET"]/length(tdb$obs$token)
f.det.ref<-t.r["DET"]/length(tdb$ref$token)
data$f.n<-NA
data$f.d<-NA
data$f.n[data$target=="obs"]<-f.noun.obs
data$f.n[data$target=="ref"]<-f.noun.ref
data$f.d[data$target=="obs"]<-f.det.obs
data$f.d[data$target=="ref"]<-f.det.ref

lm3<-lmer(dist~target*q+f.n+f.d+(1|det)+(1|lemma),data)
lm3<-lmer(dist~target*q+f.n+f.d+range+(1|det),data) # well
lm3<-lmer(dist~target*q+f.n+f.d+range+(1|det)+(1|pos),data) # no
lm3<-lmer(dist~target*q*det+f.n+f.d+range+(1|m),data) # this one most explicable
# highest variance for condition targetref:qc:detTRUE, 
# also ("the" == DET)
sum3<-summary(lm3)
sum3
anova(lm3)
d1<-sum3$coefficients[1,1]+sum3$coefficients["targetref:qc:detTRUE",1]
d1
summary(lm3)
table(data$q)
model<-aov(dist~target*q*det+f.n+f.d+m,data)
model<-aov(dist~target*q*det,data)
summary(model)
anova(lm3)

eval.df7<-get.mean.df(data)
plot.dist(eval.df7,"median")
plot.dist(eval.df7,"mean")
boxplot(dist~target,data,outline=F)
# rm outliers, so if token distance exceeds 1000 tokens, discard
which.max(data$dist)
data.s<-data[order(data$dist,decreasing = T),]
head(data.s$dist,100)
mo<-data.s$dist>max(data$range)
sum(mo)
max(data$range)
data<-data.s[!mo,]

# 15294.
### 3rd approach
tdb_s<-tdba
tdb$obs$target<-"obs"
tdb$ref$target<-"ref"
tdb1o<-tdb$obs
tdb1r<-tdb$ref
m1<-grepl("<doc |<s |</s>|</doc>",tdb1o$token)
sum(m1)
tdb1o<-tdb1o[!m1,]
m1<-grepl("<doc |<s |</s>|</doc>",tdb1r$token)
sum(m1)
tdb1r<-tdb1r[!m1,]
library(gtools)
order_ido <- mixedorder(tdb1o$pid,decreasing = F)
tdb1os<-tdb1o[order(order_ido,rownames(tdb1o),tdb1o$timestamp),]
order_idr <- mixedorder(tdb1r$pid)
tdb1rs<-tdb1r[order(order_idr),]
#tdb1rs<-tdb1r[order(tdb1r$pid),]
tdb1os$pos<-1:length(tdb1os$token)
tdb1rs$pos<-1:length(tdb1rs$token)
################################
tdb1o$pos<-1:length(tdb1o$token)
tdb1r$pos<-1:length(tdb1r$token)
tdb1os[grep("l2-com9.",tdb1os$pid),"pid"]
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
n1w<-n1w[!is.na(n1w)]
n1w[n1w==0]<-1
#n1w<-as.double(rownames(tdba.n))-1
tdba.n$pre<-NA
length(tdba$token[n1w])
tdba.n$pre<-tdba$token[n1w]
#m<-grep("<doc ",tdba.n$pre)
tdba.n$prepos<-tdba$upos[n1w]
#tdba.n$pos<-as.double(rownames(tdba.n))
dis1<-diff(tdba.n$pos)
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
model<-aov(dist~target*q,tdba.n)
summary(model)
lm1<-lmer(dist~target*q+(1|prepos)+(1|lemma),tdba.n)
sum1<-summary(lm1)
sum1
boxplot(dist~target,tdba.n,outline=F)
# overall all-noun distances: lower for target
mean
library(utils)
citation("RedditExtractoR")

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
boxplot(dist~target,tdba.n,outline=F)
# overall all-noun distances: lower for target
ar.obs<-array()
ar.ref<-array()
for(q in letters[1:6]){
mn1<-mean(tdba.2$dist[tdba.2$q==q&tdba.2$target=="obs"])
mn2<-mean(tdba.2$dist[tdba.2$q==q&tdba.2$target=="ref"])
ar.obs[q]<-mn1
ar.ref[q]<-mn2

}  
print(ar.obs)
print(ar.ref)
print(ar.ref-ar.obs)
# worthless information since dist is random
# get same-noun dist within range
# define ranges
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
n.u<-unique(tdba.2$lemma)
m.dup<-duplicated(tdba.2$lemma)
dup.w<-which(m.dup)
ld.u<-unique(tdba.2$lemma[dup.w])
x<-ld.u[1]
x<-ld.u[69]
which(ld.u=="evidence")
library(pbapply)
library(abind)
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
  u<-r1u[6]
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
  target<-"obs"
  get.ds<-function(r1u,target){
  m1<-grep(target,r1u)
  r1u<-unique(r1u[m1])
  r1u
  um<-which(r1u=="obs.2")
  u<-r1u[um]
  d1<-lapply(r1u,function(u){
    print(u)
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
  d1r<-get.ds(r1u,"ref")
  d1r2<-d1r[!is.na(d1r)]
  #d1<-unique(d1)
  d1o3<-data.frame(abind(d1o2,along = 1))
  d1r3<-data.frame(abind(d1r2,along = 1))
  d2<-rbind(d1o3,d1r3)
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
dim(tdb3.l[[113]])==0
tdb4<-lapply(tdb3.l,function(x){
  d<-dim(x)
  ifelse(d[1]==0,return(NA),return(x))
})
tdb4<-tdb4[!is.na(tdb4)]
tdb4<-data.frame(abind(tdb4,along = 1))
mode(tdb4$dist)<-"double"
tdb4$dist[tdb4$dist==0]<-NA
tdb4$det<-FALSE
tdb4$det[tdb4$prepos=="DET"]<-TRUE
#qltdf<-tdb4
#save(qltdf,file=paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/stef_psych/eval-008.RData"))
#######################################
boxplot(dist~target,tdb4,outline=F)
max(tdb4$dist)
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
lm1<-lmer(dist~target*q+(1|prepos),tdb4)
sum1<-summary(lm1)
sum1
anova(lm1)


which(ld.u=="amateur")
ld.u[219]
tdba[p1,]
tdba.2[r1w,] # stuck
#######
# bottom
getwd()
library(rmarkdown)
render("poster-ext.Rmd")

dfe<-get.mean.df(tdb4)
plot.dist(dfe,"mean")
plot.dist(dfe,"median")
qltdf<-tdb4
