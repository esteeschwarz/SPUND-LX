#20240209(06.27)
#14067.evaluation models
########################
make1<-c("make","m1")
make2<-c("make","m2")
make3<-c("make","m3")
make4<-c("make","m1")
pr1<-c("produce","m1")
pr2<-c("produce","p1")
pr3<-c("produce","m2")
pr4<-c("produce","m3")
rnd1<-expression(paste0(sample(letters,6),collapse = ""))
eval(rnd1)
r1<-c("r","r1")
r2<-c("r","r2")
r3<-c("r",eval(rnd1))
r4<-c("r",eval(rnd1))
r5<-c("r",eval(rnd1))
r6<-c("r",eval(rnd1))
r7<-c("r",eval(rnd1))
b1<-c("b","m1")
b2<-c("b","r1")
b3<-c("b",eval(rnd1))

model1<-data.frame(rbind(make1,make2,make3,make4,pr1,pr2,pr3,pr4,r1,r2,r3,r4,r5,r6,r7,b1,b2,b3))
model1
mcoll<-collex.covar(model1,str.dir = T)
mcoll
boxplot(mcoll$COLL.STR.LOGL~mcoll$SLOT1)
df<-length(levels(factor(mcoll$SLOT1)))-1
df
mcoll.d<-rbind(mcoll[duplicated(mcoll$SLOT2,fromLast = T),],mcoll[duplicated(mcoll$SLOT2,fromLast = F),])
mcoll$p<-pt(mcoll$COLL.STR.LOGL,df,lower.tail = F)
boxplot(mcoll$p~mcoll$SLOT1)
boxplot(mcoll$COLL.STR.LOGL~  mcoll$SLOT1,outline=F)
df<-length(levels(factor(mcoll.d$SLOT1)))-1
df
mcoll.d$p<-pt(mcoll.d$COLL.STR.LOGL,df,lower.tail = F)
#mcoll.d<-rbind(mcoll[duplicated(mcoll$SLOT2,fromLast = T),],mcoll[duplicated(mcoll$SLOT2,fromLast = F),])
mcoll.d
boxplot(mcoll.d$p~mcoll.d$SLOT1,main="preference of make over produce",xlab = "lemma in equivalent context",ylab = "p-value of lemma/object association strength")
boxplot(mcoll.d$STR.DIR  ~mcoll.d$SLOT1,main="preference of make over produce",xlab = "lemma in equivalent context",ylab = "T-score of lemma/object association strength")
boxplot(mcoll.d$COLL.STR.LOGL  ~mcoll.d$SLOT1,main="preference of make over produce",xlab = "lemma in equivalent context",ylab = "T-score of lemma/object association strength")

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


