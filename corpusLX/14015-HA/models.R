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
make10<-c("make","c7")
make11<-c("make","c9")
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

model1<-data.frame(rbind(make1,make2,make3,make4,make5,make6,make7,make8,make9,make10,make11,pr1,pr2,pr3,pr4,pr5,r1,r2,r3,r4,r5,r6,r7,b1,b2,b3,b4))
### build, produce, make, r
model2<-data.frame(rbind(make1,make2,make3,make4,make5,make6,make7,make8,make9,make10,make11,pr1,pr2,pr3,pr4,pr5,b1,b2,b3,b4))

model1<-model2

mcoll<-collex.covar(model1,str.dir = T)
mcoll
mcoll<-collex.covar(model2,str.dir = T)
mcoll
# boxplot(mcoll$COLL.STR.LOGL~mcoll$SLOT1,outline=F)
df<-length(levels(factor(mcoll$SLOT1)))-1
df
# mcoll.d<-rbind(mcoll[duplicated(mcoll$SLOT2,fromLast = T),],mcoll[duplicated(mcoll$SLOT2,fromLast = F),])
# mcoll$p<-pt(mcoll$COLL.STR.LOGL,df,lower.tail = T)
# boxplot(mcoll$p~mcoll$SLOT1,outline=F)
# boxplot(mcoll$COLL.STR.LOGL~  mcoll$SLOT1,outline=F)
df<-length(levels(factor(mcoll.d$SLOT1)))-1
df
mcoll.p<-mcoll
mcoll.p$p<-pt(mcoll$COLL.STR.LOGL,df,lower.tail = T) # T: depends on number of obs, F for absolute
mcoll.p<-rbind(mcoll.p[duplicated(mcoll.p$SLOT2,fromLast = T),],mcoll.p[duplicated(mcoll.p$SLOT2,fromLast = F),])
mcoll.p
boxplot(mcoll.p$p~mcoll.p$SLOT1,main="preference of make over produce",xlab = "lemma in equivalent context",ylab = "p-value of lemma/object association strength",outline=F)
# model2, F: produce << make < build
# model2, T: build < make << produce
# model1, F: produce << build < make
# model1, T: make < build  << produce

boxplot(mcoll.p$STR.DIR  ~mcoll.p$SLOT1,main="preference of make over produce",xlab = "lemma in equivalent context",ylab = "T-score of lemma/object association strength",outline=F)
# model1, F: make < build << produce
# model1, T: make < build << produce
# model2, F: make <= build << produce 
# model2, T: make <= build << produce
# boxplot(mcoll.p$COLL.STR.LOGL  ~mcoll.p$SLOT1,main="preference of make over produce",xlab = "lemma in equivalent context",ylab = "T-score of lemma/object association strength",outline=F)

model2<-model1[model1[,1]%in%c("make","produce","build"),]
mcoll<-collex.covar(model2,str.dir = T)
mcoll
mcoll<-rbind(mcoll[duplicated(mcoll$SLOT2,fromLast = T),],mcoll[duplicated(mcoll$SLOT2,fromLast = F),])

boxplot(mcoll$COLL.STR.LOGL~mcoll$SLOT1)
df<-length(levels(factor(mcoll$SLOT1)))-1
df

mcoll$p<-pt(mcoll$COLL.STR.LOGL,df,lower.tail = T)
boxplot(mcoll$p~mcoll$SLOT1)
boxplot(mcoll$COLL.STR.LOGL  ~mcoll$SLOT1)

### apply model
apply.model<-function(coll6,p.lower.tail,select.filter=NULL){
amodel<-get.collex.obj(coll6,select.filter = select.filter)
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

}

###
# Create a 2x2 dataset
data <- matrix(c(2, 5, 9, 4), nrow = 2)
# View the dataset
data
# Output:
#      [,1] [,2]
# [1,]    2    9
# [2,]    5    4

fisher.test(data)
"In this example, the rows represent different categories (e.g., “Good” and “Bad”), and the columns represent the presence or absence of an event (e.g., success or failure)."

amodel<-get.collex.obj(coll6)
amodel<-amodel[amodel$SLOT1%in%make.array,]
amodel.d<-rbind(amodel[duplicated(amodel$SLOT2,fromLast = T),],amodel[duplicated(amodel$SLOT2,fromLast = F),])
amodel.d
f<-fisher.test(cbind(amodel.d$fS1,amodel.d$fS2),simulate.p.value = T)
f<-fisher.test(cbind(amodel.d$fS1,amodel.d$OBS))
f<-fisher.test(cbind(amodel.d$fS1,amodel.d$fS2,amodel.d$OBS),simulate.p.value = T)
f
amodel.d
library(stats)
s<-lm(amodel.d$OBS~amodel.d$fS1)
df<-data.frame(lemma=factor(amodel.d$fS1),object=factor(amodel.d$fS2),row.names = paste0(amodel.d$SLOT1,amodel.d$SLOT2))
df<-cbind(lemma=amodel.d$fS1,object=amodel.d$fS2)
df1<-as.data.frame(df)
s<-lm(amodel.d$OBS~df)
summary(s)
df
typeof(df1)

un.obj<-length(unique(amodel$SLOT2))

un.l<-length(unique(amodel$SLOT1))
amodel.i<-amodel[amodel$SLOT1%in%make.array,]
amodel.d<-rbind(amodel.i[duplicated(amodel.i$SLOT2,fromLast = T),],amodel.i[duplicated(amodel.i$SLOT2,fromLast = F),])
amodel.d
get.f<-function(x,lemma)c(x$fS1[x$SLOT1==lemma],x$fS2[x$SLOT1==lemma],x$OBS[x$SLOT1==lemma])
f.m<-get.f(amodel.d,"make") # presence
f.b<-get.f(amodel.d,"build")
f.c<-get.f(amodel.d,"create")
f.g<-get.f(amodel.d,"generate")
f.p<-get.f(amodel.d,"produce")
lemma<-"make"
get.f.n<-function(x,lemma)c(un.l-(x$fS1[x$SLOT1==lemma]),un.obj-(x$fS2[x$SLOT1==lemma]),un.obj+un.l-(x$OBS[x$SLOT1==lemma]))
f.m.n<-get.f.n(amodel.d,"make") # absence
f.b.n<-get.f.n(amodel.d,"build")
f.c.n<-get.f.n(amodel.d,"create")
f.g.n<-get.f.n(amodel.d,"generate")
f.p.n<-get.f.n(amodel.d,"produce")
f.m.n
f.m
k<-1
lobs<-1:(length(f.m.n)/3)
lobs1<-lobs+length(lobs)*2
lobs
lobs1
lobsft<-list()
for(k in lobs){
pos<-c(k,lobs1[k])
#print(pos)}
p.df<-cbind(c(f.m[pos[1]],f.m[pos[2]]),c(f.m.n[pos[1]],f.m.n[pos[2]]))
print(p.df)
ft[[k]]<-fisher.test(p.df)
}
amodel.d
ft[[3]]
max(ft)

#get.f<-function(x,lemma)c(x$OBS[x$SLOT1==lemma],x$fS2[x$SLOT1==lemma],x$OBS[x$SLOT1==lemma])
f.m<-get.f(amodel.d,"make") # presence
f.b<-get.f(amodel.d,"build")
f.c<-get.f(amodel.d,"create")
f.g<-get.f(amodel.d,"generate")
f.p<-get.f(amodel.d,"produce")

f.m

dam<-c(3,1)
report<-c(4,8)
thing<-c(1,6)
way<-c(1,1)
fisher.test(rbind(dam,report,thing,way))
build<-c(3+1,4+1+1+1+6+1)
make<-c(4+1+6+1,3+1+1+1)
create<-c(1,3+4+1+1+1+6+1)
produce<-c(1,3+4+1+1+1+6+1)
build
fisher.test(rbind(build,make,produce,create))
