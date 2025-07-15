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

### 3rd approach
tdb$obs$target<-"obs"
tdb$ref$target<-"ref"
tdba<-rbind(tdb$obs,tdb$ref)
tdba.n<-tdba[tdba$upos=="NOUN",]
n1w<-as.double(rownames(tdba.n))-1
tdba.n$pre<-tdba$token[n1w]
#m<-grep("<doc ",tdba.n$pre)
tdba.n$prepos<-tdba$upos[n1w]
tdba.n$pos<-as.double(rownames(tdba.n))
dis1<-diff(tdba.n$pos)
tdba.n$dist<-c(1,dis1)
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
tdba.n$q[m2]<-"b"
tdba.n$q[m3]<-"c"
tdba.n$q[m4]<-"d"
tdba.n$q[m5]<-"e"
tdba.n$q[m6]<-"f"
table(tdba.n$q)
model<-aov(dist~target*q,tdba.n)
summary(model)
lm1<-lmer(dist~target*q+(1|prepos)+(1|lemma),tdba.n)
sum1<-summary(lm1)
sum1
boxplot(dist~target,tdba.n,outline=F)
