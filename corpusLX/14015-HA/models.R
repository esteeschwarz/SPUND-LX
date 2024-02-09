#20240209(06.27)
#14067.evaluation models
########################
make1<-c("make","c1")
make2<-c("make","c2")
make3<-c("make","c3")
make4<-c("make","c1")
make5<-c("make","c2")
make6<-c("make","c8")
make7<-c("make","c1")
make8<-c("make","c7")
make9<-c("make","c5")
pr1<-c("produce","c1")
pr2<-c("produce","c5")
pr3<-c("produce","c6")
pr4<-c("produce","c7")
pr5<-c("produce","c7")
rnd1<-expression(paste0(sample(letters,6),collapse = ""))
eval(rnd1)
r1<-c("r","r1")
r2<-c("r","r2")
r3<-c("r",eval(rnd1))
r4<-c("r",eval(rnd1))
r5<-c("r",eval(rnd1))
r6<-c("r",eval(rnd1))
r7<-c("r",eval(rnd1))
b1<-c("build","c1")
b2<-c("build","c9")
b3<-c("build",eval(rnd1))
b4<-c("build","c7")

model1<-data.frame(rbind(make1,make2,make3,make4,make5,make6,make7,make8,make9,pr1,pr2,pr3,pr4,pr5,r1,r2,r3,r4,r5,r6,r7,b1,b2,b3,b4))
model1
mcoll<-collex.covar(model1,str.dir = T)
mcoll
boxplot(mcoll$COLL.STR.LOGL~mcoll$SLOT1,outline=F)
df<-length(levels(factor(mcoll$SLOT1)))-1
df
mcoll.d<-rbind(mcoll[duplicated(mcoll$SLOT2,fromLast = T),],mcoll[duplicated(mcoll$SLOT2,fromLast = F),])
mcoll$p<-pt(mcoll$COLL.STR.LOGL,df,lower.tail = T)
boxplot(mcoll$p~mcoll$SLOT1,outline=F)
boxplot(mcoll$COLL.STR.LOGL~  mcoll$SLOT1,outline=F)
df<-length(levels(factor(mcoll.d$SLOT1)))-1
df
mcoll.p<-mcoll
mcoll.p$p<-pt(mcoll$COLL.STR.LOGL,df,lower.tail = F) # T: depends on number of obs, F for absolute
mcoll.d<-rbind(mcoll.p[duplicated(mcoll.p$SLOT2,fromLast = T),],mcoll[duplicated(mcoll.p$SLOT2,fromLast = F),])
mcoll.p
boxplot(mcoll.p$p~mcoll.p$SLOT1,main="preference of make over produce",xlab = "lemma in equivalent context",ylab = "p-value of lemma/object association strength",outline=F)
boxplot(mcoll.p$STR.DIR  ~mcoll.p$SLOT1,main="preference of make over produce",xlab = "lemma in equivalent context",ylab = "T-score of lemma/object association strength",outline=F)
boxplot(mcoll.p$COLL.STR.LOGL  ~mcoll.p$SLOT1,main="preference of make over produce",xlab = "lemma in equivalent context",ylab = "T-score of lemma/object association strength",outline=F)

model2<-model1[model1[,1]%in%c("make","produce"),]
mcoll<-collex.covar(model2)
mcoll
boxplot(mcoll$COLL.STR.LOGL~mcoll$SLOT1)
df<-length(levels(factor(mcoll$SLOT1)))-1
df

mcoll$p<-pt(mcoll$COLL.STR.LOGL,df,lower.tail = F)
boxplot(mcoll$p~mcoll$SLOT1)

### apply model
amodel<-get.collex.obj(coll6)
#boxplot(amodel$COLL.STR.LOGL~amodel$SLOT1)
df<-length(levels(factor(amodel$SLOT1)))-1
df
amodel$p<-pt(amodel$COLL.STR.LOGL,df,lower.tail = F)
amodel<-amodel[amodel$SLOT1%in%make.array,]
amodel<-rbind(amodel[duplicated(amodel$SLOT2,fromLast = T),],amodel[duplicated(amodel$SLOT2,fromLast = F),])
#amodel<-amodel.d[amodel.d$SLOT1%in%make.array,]
boxplot(amodel$COLL.STR.LOGL~amodel$SLOT1,outline=F)
boxplot(amodel$p~amodel$SLOT1,outline=F)
### preference of make over produce
amodel<-get.collex.obj(coll6)
df<-length(levels(factor(amodel$SLOT1)))-1
df
amodel$p<-pt(amodel$COLL.STR.LOGL,df,lower.tail = F)
amodel<-amodel[amodel$SLOT1%in%take.array,]
amodel<-rbind(amodel[duplicated(amodel$SLOT2,fromLast = T),],amodel[duplicated(amodel$SLOT2,fromLast = F),])
#amodel<-amodel.d[amodel.d$SLOT1%in%make.array,]
boxplot(amodel$COLL.STR.LOGL~amodel$SLOT1,outline=F)
boxplot(amodel$p~amodel$SLOT1,outline=F)


