load("~/boxHKW/21S/DH/local/SPUND/corpuslx/stefanowitsch/HA/data/scb.ann.list.RData")
df<-scb.ann.list$doc1
x<-scb.ann.list[[2]]
#tdf<-
get.lemma.obj<-function(x){
tdf<-t(x)
all.obj<-tdf=="obj"
#all.obj[]
all.ob.w<-which(all.obj)
all.ob.w
obj.head<-as.double(all.ob.w-1)
tdf[obj.head]

obj.tag<-all.ob.w-4
tdf[obj.tag]
obj.lemma<-all.ob.w-5
tdf[obj.lemma]
obj.token<-all.ob.w-6
tdf[obj.token]
obj.id<-as.double(all.ob.w-7)
tdf[obj.id]
h.t.pos.rel<-as.double(tdf[obj.id])-as.double(tdf[obj.head])
h.t.pos.abs<-obj.id-(h.t.pos.rel*14)
tdf[h.t.pos.abs]
h.t.value<-obj.token-(h.t.pos.rel*14)
tdf[h.t.value]
h.l.value<-obj.lemma-(h.t.pos.rel*14)
#tdf[h.l.value]
df.verb.object<-data.frame(lemma=tdf[h.l.value],object=tdf[obj.lemma])
}
###
library(collostructions)
frequency(df.verb.object)
collex.covar(df.verb.object)
verb.object.list<-lapply(scb.ann.list, get.lemma.obj)
#save(verb.object.list,file="verb.object.list.RData")
freq.joined<-join.freqs(freq.list[[1]],freq.list[[2]])
freq.list.joined<-lapply(freq.list[[1]],join.lists)
library(abind)
dim(freq.list[[1]])
llist<-verb.object.list[[1]]
for (k in 2:length(verb.object.list)){
  llist<-abind(llist,freq.list[[k]],along = 1)
  
}
save(llist,file="verb.object.df.cpt.RData")
#a<-abind(freq.list[[1]],freq.list[[2]],along = 1)
#bindl<-function(x)abind(x,along = 1)
#verb.object.list.cpt<-lapply(verb.object.list, bindl)
llist.df.cpt<-data.frame(lemma=unlist(llist.df$lemma),object=unlist(llist.df$object))
typeof(llist.df.cpt)
eval1<-collex.covar(llist.df.cpt)
eval1
collex.eval<-eval1
save(collex.eval,file="collex.eval.RData")
make1<-which(eval1$SLOT1=="make")
eval1[make1,]
target1<-eval1$SLOT2=="pizza"
eval1[target1,]
t1<-which(target1)
tail(eval1[make1,],100)
### wks.
### concrete array:
c.array.make<-c(124,880,937,943,1170,1843,1844,1847,3137,3140,3141,3146,3147,3151,3152,3156,3160,3162,3368,4096,4838,4843,5299,5301,5635,5636,5812,5815,5818,5817,5818,6026,6027,6029,6030,6032,6033,6034,6408,6410,6542,6840,6842,6860,6903,6904,7263,7365,7687)
target.list<-list()
k<-5
sum(eval1$SLOT2==eval1$SLOT2[k])
for(k in c.array.make){
  target.list[[eval1$SLOT2[k]]]<-eval1$SLOT2==eval1$SLOT2[k]
  
}
target.list
target.list.make<-target.list
eval1[target.list[[2]],]
save(target.list.make,file = "target.list.make.RData")
### wks.
dim(eval1[target.list.make[[1]],])

llist<-verb.object.list[[1]]
target.df.make<-eval1[target.list.make[[1]],]
for (k in 2:length(target.list.make)){
  target.df.make<-abind(target.df.make,eval1[target.list.make[[k]],],along = 1)
  
}
target.df.make.2<-data.frame(target.df.make)
target.df.make.2<-data.frame(target.df.make)
target.df.make.s<-target.df.make.2[order(as.double(target.df.make.2$COLL.STR.LOGL),decreasing = T),]
target.make.coll<-collex.covar(data.frame(verb=target.df.make.s$SLOT1,object=target.df.make.s$SLOT2))
target.make.coll
save(target.make.coll,file = "target.make.collex.RData")
v.make.uniqe<-unique(target.make.coll$SLOT1)
### which complies to make semasiological?
print(data.frame(v.make.uniqe))
make.semas<-c(2,6,7,25,31,40,41,48,50,56,63,81,88,92,99,106)
v.make.uniqe[make.semas]
semas.list<-list()
for(k in make.semas){
    verb<-v.make.uniqe[k]
    semas.list[[verb]]<-eval1$SLOT1==verb
    }
semas.df.make<-eval1[semas.list[[1]],]
for (k in 2:length(semas.list)){
  semas.df.make<-abind(semas.df.make,eval1[semas.list[[k]],],along = 1)
  
}
semas.df.make.2<-data.frame(semas.df.make)
semas.df.make.s<-semas.df.make.2[order(as.double(semas.df.make.2$COLL.STR.LOGL),decreasing = T),]
semas.make.coll<-collex.covar(data.frame(verb=semas.df.make.s$SLOT1,object=semas.df.make.s$SLOT2))
semas.make.coll
hs<-head(semas.make.coll,15)

#save(semas.make.coll,file="semasiol.make.collex.RData")
#join.freqs(freq.list)

hs.a<-hs[,1:2]
hs.a
hs.where<-array()
k<-1
for (k in 1:length(hs.a$SLOT1)){
hs.k<-hs.a[k,]
  m<-which(eval1$SLOT1%in%hs.k$SLOT1)
  hs.where[k]<-which(eval1$SLOT2[m]%in%hs.k$SLOT2)
  hs.where[k]<-m[hs.where[k]]
m
  }
eval.semas<-eval1[hs.where,]
eval.semas<-eval.semas[order(eval.semas$COLL.STR.LOGL,decreasing = T),]
eval.semas
plotlist$eval.semas<-eval.semas
verb.object<-paste(eval.semas$SLOT1,eval.semas$SLOT2,sep = ".")
eval.semas$ns<-verb.object
plotlist$eval.semas<-eval.semas
plotlist
par(las=3)
barplot(eval.semas$COLL.STR.LOGL~verb.object,xlab = "",ylab = "collex.log.like")
save(plotlist,file="plotlist.RData")
barplot(plotlist$eval.semas$COLL.STR.LOGL~plotlist$eval.semas$ns,xlab = "",ylab = "collex.log.like")
# obj.head<-all.ob.w-22
# tdf[obj.t]
# obj.head<-all.ob.w-
# tdf[obj.t]
# tdf[all.obj]
# tdf[1:10]
# dim(tdf)
# get.pos<-function(x)x-15
# tdf.m.p<-matrix(1:length(tdf),dim(tdf))
# tdf.m.t<-lapply(tdf.m.p, get.pos)
# tdf.m.t.2<-matrix(unlist(tdf.m.t),dim(tdf))
# tdf.m.t.2[10]
# tdf.m.p[19]-10
