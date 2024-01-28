#14042.collexeme analysis
#########################
# vertical corpus object
### sec 1.1
### get verb + objects df
#load("~/boxHKW/21S/DH/local/SPUND/corpuslx/stefanowitsch/HA/data/scb.ann.list.RData")
load("~/boxHKW/21S/DH/local/SPUND/corpuslx/stefanowitsch/HA/data/scb.ann.list.pos-all-dfs.RData")
# df<-scb.ann.list$doc1
# x<-scb.ann.list[[2]]

#x<-scb.ann.list[[2]]
#x<-corpus.df
#x<-scb.pos.df.list$sbc15
get.corpus.deprel<-function(x){
  # assign unique id to token
  x$sbc.token.id<-as.double(paste0(x$sbc.id,".",  1:length(x$sbc.id)))  
  x$pos.0<-"lfd.pos"  
  x$obj<-NA
  tdf<-t(x)
  rtdf<-rownames(tdf)
  rtdf.0<-which(rtdf=="pos.0")
  all.zero<-which(tdf=="lfd.pos")-rtdf.0
#  all.zero.0<-all.zero-length(rtdf)
  # pos.deprel<-length(rtdf)-grep("dep",rtdf)
  # pos.head<-length(rtdf)-grep("head",rtdf)
  # pos.upos<-length(rtdf)-grep("upos",rtdf)
  # pos.lemma<-length(rtdf)-grep("lemma",rtdf)
  # pos.token<-length(rtdf)-which(rtdf=="token")
  # pos.token.id<-length(rtdf)-which(rtdf=="token_id")
  #########################################
  pos.deprel<-all.zero+grep("dep",rtdf)
  pos.head<-all.zero+grep("head",rtdf)
  pos.upos<-all.zero+grep("upos",rtdf)
  pos.lemma<-all.zero+grep("lemma",rtdf)
  pos.token<-all.zero+which(rtdf=="token")
  pos.token.id<-all.zero+which(rtdf=="token_id")
  #########################
  # t.head<-all.zero-pos.head
  # t.head<-all.zero-grep("head",rtdf)
  # t.id<-all.zero-pos.token.id
  # t.tag<-all.zero-pos.upos
  # t.token<-all.zero-pos.token
  # t.lemma<-all.zero-pos.lemma
  # t.deprel<-all.zero-pos.deprel
  t.head<-pos.head
  t.id<-pos.token.id
  t.tag<-pos.upos
  t.token<-pos.token
  t.lemma<-pos.lemma
  t.deprel<-pos.deprel
  m.h.t.0<-which(tdf[t.head]==0)
  h.t.pos.rel<-as.double(tdf[t.id])-as.double(tdf[t.head])
  h.t.pos.rel[m.h.t.0]<-0
  h.t.pos.abs<-t.id-(h.t.pos.rel*length(tdf[,1]))
  #tdf[h.t.pos.abs]
  h.t.value<-t.token-(h.t.pos.rel*length(tdf[,1]))
  
  #head(tdf[h.t.value])
  m1<-which(h.t.value<0)
  sum(m1)
  h.t.value[m1]<-1 # prevent negative subscripts
  h.l.value<-t.lemma-(h.t.pos.rel*length(tdf[,1]))
  m2<-which(h.l.value<0)
  sum(m2)
  h.l.value[m2]<-1 # prevent negative subscripts
  head(tdf[h.l.value])
  ####################
  all.obj<-tdf=="obj"
  #all.obj[]
  all.ob.w<-which(all.obj)
  all.ob.w
  obj.head<-as.double(all.ob.w-1)
  tdf[obj.head]
  obj.tag<-all.ob.w-4 #4 
  tdf[obj.tag]
  obj.lemma<-all.ob.w-5 #5
  tdf[obj.lemma]
  obj.token<-all.ob.w-6 #6
  tdf[obj.token]
  obj.id<-as.double(all.ob.w-7) #7
  tdf[obj.id]
  h.t.o.pos.rel<-as.double(tdf[obj.id])-as.double(tdf[obj.head])
  h.t.o.pos.abs<-obj.id-(h.t.o.pos.rel*length(tdf[,1]))
  tdf[h.t.o.pos.abs]
  h.t.o.value<-obj.token-(h.t.o.pos.rel*length(tdf[,1]))
  tdf[h.t.o.value]
  h.l.o.value<-obj.lemma-(h.t.o.pos.rel*length(tdf[,1]))
  tdf[h.l.o.value]
  obj.pos<-all.ob.w+5
  tdf[obj.pos]<-tdf[h.l.o.value]
  ####################
  #obj.df<-get.lemma.obj(x)
  #tdf[obj.df$obj.pos]<-as.character(obj.df$obj)
  #tdf[16,1]
 # tdf[675]
  tdf.r<-as.data.frame(t(tdf))
  m<-!is.na(tdf.r$obj)
  sum(m)
  #length(tdf[obj.pos])
  #length(tdf[h.t.value])
  x$obj<-tdf.r$obj
  x$head_token_value<-tdf[h.t.value]
  x$head_lemma_value<-tdf[h.l.value]
  mode(x$line)<-"double"
  mode(x$sbc.id)<-"double"
  mode(x$token_id)<-"double"
  mode(x$head_token_id)<-"double"
  
  return(x)  
  
}
corpus.head.list<-lapply(scb.pos.df.list, get.corpus.deprel)

#x<-corpus.head.list$sbc1

# get.lemma.obj<-function(x){
# # matrix of object: annis like horizontal df, token left > right, annotation layer top > bottom
# x$obj<-NA
# tdf<-t(x)
# all.obj<-tdf=="obj"
# #all.obj[]
# all.ob.w<-which(all.obj)
# all.ob.w
# obj.head<-as.double(all.ob.w-1)
# tdf[obj.head]
# # tdf1<-rbind(tdf,lfd=c(1:length(tdf)))
# # rownames(tdf1)[14]<-"lfd"
# # tdf1[14,]<-"lfdrun"
# # t.dep<-tdf[11,]
# 
# #obj.tag<-all.ob.w-4
# obj.tag<-all.ob.w-4 #4 
# tdf[obj.tag]
# obj.lemma<-all.ob.w-5 #5
# tdf[obj.lemma]
# obj.token<-all.ob.w-6 #6
# tdf[obj.token]
# obj.id<-as.double(all.ob.w-7) #7
# tdf[obj.id]
# h.t.pos.rel<-as.double(tdf[obj.id])-as.double(tdf[obj.head])
# h.t.pos.abs<-obj.id-(h.t.pos.rel*length(tdf[,1]))
# tdf[h.t.pos.abs]
# h.t.value<-obj.token-(h.t.pos.rel*length(tdf[,1]))
# tdf[h.t.value]
# h.l.value<-obj.lemma-(h.t.pos.rel*length(tdf[,1]))
# tdf[h.l.value]
# obj.df<-data.frame(obj.pos=h.t.pos.abs,obj=tdf[obj.lemma])
# return(obj.df)
# }
# length(tdf[h.l.value])
# ### add headtoken value to df
# #tdf.1<-tdf
# tdf.1<-x
# ht.id<-tdf.1$head_token_id
# t.id<-as.double(tdf.1$token_id)
# ht.rel<-as.double(t.id)-as.double(ht.id)
# ht.pos<-t.id-(ht.rel*length(tdf.1))
# ht.pos
# ht<-tdf
# #length(tdf)
# #tdf.ht<-rbind(tdf,tdf[h.l.value])
# df.verb.object<-data.frame(lemma=tdf[h.l.value],object=tdf[obj.lemma])
# }
#####################################################
#verb.object.list<-lapply(scb.ann.list, get.lemma.obj)
# corpus.head.list<-lapply(scb.pos.df.list, get.corpus.deprel)
#save(verb.object.list,file="verb.object.list.RData")
#library(abind)
# llist<-verb.object.list[[1]]
# for (k in 2:length(verb.object.list)){
#   llist<-abind(llist,freq.list[[k]],along = 1)
#   
# }
### get corpus object
# corpus.df<-data.frame(scb.ann.list$doc1)
# for (k in 2:length(scb.ann.list)){
#   corpus.df<-rbind(corpus.df,scb.ann.list[[k]])
# }
### get corpus object
corpus.df.deprel<-data.frame(corpus.head.list$sbc1)
for (k in 2:length(corpus.head.list)){
  corpus.df.deprel<-rbind(corpus.df.deprel,corpus.head.list[[k]])
}
### run until here
################################
#save(corpus.df.deprel,file="~/boxHKW/21S/DH/local/SPUND/corpuslx/stefanowitsch/HA/data/sbc.corpus.df.deprel.RData")
head(corpus.df.deprel,20)
# corpus.df$doc_id<-gsub("doc","",corpus.df$doc_id)
# colnames(corpus.df)[1]<-"line"
# colnames(corpus.df)
# corpus.df.red<-corpus.df[,c(1,2,4,5,6,7,8,9,10,11,12)]
#save(llist,file="verb.object.df.cpt.RData")
#a<-abind(freq.list[[1]],freq.list[[2]],along = 1)
#bindl<-function(x)abind(x,along = 1)
#llist.df<-lapply(verb.object.list, bindl)
#llist.df$
#verb.object.df.cpt<-data.frame(lemma=unlist(llist[,1]),object=unlist(llist[,2]))
#typeof(llist.df.cpt)
#save(verb.object.df.cpt,file = "verb.object.df.cpt.RData")
# eval1<-collex.covar(verb.object.df.cpt)
# eval1
# collex.eval<-eval1
# #save(collex.eval,file="collex.eval.RData")
# make1<-which(eval1$SLOT1=="make")
# eval1[make1,]
# #target1<-eval1$SLOT2=="pizza"
# #eval1[target1,]
# #t1<-which(target1)
# tail(eval1[make1,],100)
### wks.
###################
### 14043.
### 2.1
### concrete array: manually defined concrete use of make in corpus
c.array.make<-c(124,880,937,943,1170,1843,1844,1847,3137,3140,3141,3146,3147,3151,3152,3156,3160,3162,3368,4096,4838,4843,5299,5301,5635,5636,5812,5815,5818,5817,5818,6026,6027,6029,6030,6032,6033,6034,6408,6410,6542,6840,6842,6860,6903,6904,7263,7365,7687)
concrete.make.id<-c.array.make
concrete.make.array.txt<-eval1$SLOT2[c.array.make]
concrete.make.array.txt
target.list<-list()
k<-5
sum(eval1$SLOT2==eval1$SLOT2[k])
eval1$SLOT2[c.array.make[1]]
############################
# target list of all potential concrete targets of make alternatives in corpus (devised in above array, manually)
for(k in c.array.make){
  target.list[[eval1$SLOT2[k]]]<-eval1$SLOT2==eval1$SLOT2[k]
  
}
#target.list
target.list.make<-target.list
eval1[target.list[[2]],]
save(target.list.make,file = "target.list.make.RData")
### wks.
dim(eval1[target.list.make[[1]],])

#llist<-verb.object.list[[1]]
target.df.make<-eval1[target.list.make[[1]],]
for (k in 2:length(target.list.make)){
  target.df.make<-abind(target.df.make,eval1[target.list.make[[k]],],along = 1)
  
}
target.df.make.2<-data.frame(target.df.make)
#target.df.make.2<-data.frame(target.df.make)
target.df.make.s<-target.df.make.2[order(as.double(target.df.make.2$COLL.STR.LOGL),decreasing = T),]
target.make.coll<-collex.covar(data.frame(verb=target.df.make.s$SLOT1,object=target.df.make.s$SLOT2))
target.make.coll
#save(target.make.coll,file = "target.make.collex.RData")

# unique verb lemmas in target list of objects of concrete /make/
v.make.uniqe<-unique(target.make.coll$SLOT1)

### which complies to make semasiological?
print(data.frame(v.make.uniqe))

# 
# devise verb lemmas making sense as alternative to concrete /make/ objects
make.semas<-c(2,6,7,25,31,40,41,48,50,56,63,81,88,92,99,106)
concrete.make.alt.id.int<-make.semas
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
####################################################
concrete.make.alt.id<-rownames(semas.df.make.2)
####################################################
semas.make.coll<-collex.covar(data.frame(verb=semas.df.make.s$SLOT1,object=semas.df.make.s$SLOT2))
semas.make.coll
hs<-head(semas.make.coll,15)
hs
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
# plotlist$eval.semas<-eval.semas
# verb.object<-paste(eval.semas$SLOT1,eval.semas$SLOT2,sep = ".")
# eval.semas$ns<-verb.object
# plotlist$eval.semas<-eval.semas
# plotlist
# par(las=3)
# barplot(eval.semas$COLL.STR.LOGL~verb.object,xlab = "",ylab = "collex.log.like")
# save(plotlist,file="plotlist.RData")
# barplot(plotlist$eval.semas$COLL.STR.LOGL~plotlist$eval.semas$ns,xlab = "",ylab = "collex.log.like")
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
#############################################
#14043.class
# aftermath: ich glaube, das problem jetzt gegriffen zu haben: ich müsste doch, um die präferenz oder nicht der alternativkonstruktion bestimmen zu können: in einem subset, bestehend aus der konstruktion (also make + 1 bestimmtes objekt) UND allen verben + objekten (im korpus) die eine alternative zu der konstruktion bilden könnten, die collexem analyse durchführen. oder? (und dieses dann, um generelle aussagen über die präferenz machen zu können, auf alle auftreten von concrete /make/ + objekt transponieren...) / das wird dann nur sehr dünn von den daten her habe ich schon gesehen, kann aber sagen, dasz sich das bei /make/ fast ausschlieszlich auf die kategorie food beschränkt also dort überhaupt eine präferenz ermittelt werden könnte...
#############################################
# all instances of concrete /make/ + semantic alternatives devised from objects of concrete make
concrete.make.plus.alt.ids<-c(concrete.make.id,concrete.make.alt.id)
eval2<-eval1[concrete.make.plus.alt.ids,]
eval2.s<-eval2[order(eval2$COLL.STR.LOGL,decreasing = T),]
eval2.s
eval3<-collex.covar(eval2[,1:2])
eval3
#############################################
#14045.process
# preference measurement in words:
# p.light vs. p.concrete
p.light<- light.all / cpt.all #p.concrete == # this is not reasonable: it has to be done per verb
p.light.make<-light.make / all.make
load("~/boxHKW/21S/DH/local/SPUND/corpuslx/stefanowitsch/HA/data/scb.ann.list.pos-all-dfs.RData")
### get corpus object

corpus.df<-data.frame(scb.pos.df.list$sbc1)
for (k in 2:length(scb.pos.df.list)){
  corpus.df<-rbind(corpus.df,scb.pos.df.list[[k]])
}
head(corpus.df)
###############
light.make.t<-table(corpus.df$light[corpus.df$lemma=="make"]) # per line: 80/374
### how many did i annotate per line > chk:
load("~/boxHKW/21S/DH/local/SPUND/corpuslx/stefanowitsch/HA/data/trndf.lm.cpt.RData")
table(trndf.lm$light[trndf.lm$alt=="make"]) # 89/381
light.make.t
#table(corpus.df$light[corpus.df$lemma=="give"]) # give/take not yet annotated
# chk if all lemmas were annotated correctly manually
table(corpus.df$light[corpus.df$alt=="make"]) # per token: 2308 > more precise!
# now  for light/concrete use
light.make.p<-sum(corpus.df$light[corpus.df$alt=="make"],na.rm = T)/length(corpus.df$light[corpus.df$alt=="make"])
# what was my finding with the lines df? > chk:
load("~/Documents/GitHub/SPUND-LX/corpusLX/14015-HA/data/plotlist.RData")
# no p in df
library(collostructions)
set<-corpus.df
var1<-"lemma"
var2<-"alt"
coll.df<-function(set,var1,var2,restrict.var,restrict.value){
  m1<-which(!is.na(set[var1])&!is.na(set[var2]))
  m1<-!is.na(set[var1])&!is.na(set[var2])
  sum(m1)
  #  m2<-which(!is.na(set[var2]))
 # m3<-c(m1,m2)
  set<-set[m1,]
  coll.1<-subset(set,set[restrict.var]==restrict.value)
  coll.1<-data.frame(cbind(coll.1[var1],coll.1[var2]))
}
set<-corpus.df.deprel
var1<-"lemma"
var2<-"head_lemma_value"
var3<-"light"
sub<-c("make","build","produce","create","generate")
########################################################
get.coll.df<-function(set,var1,var2,var3,sub=F,na.rm=F){
#  m1<-which(!is.na(set[var1])&!is.na(set[var2])&!is.na(set[var3]))
  m1<-!is.na(set[var1])&!is.na(set[var2])
  sum(m1)
  m2<-!is.na(set[var3])
  set<-set[m1,]
  
  #  m2<-which(!is.na(set[var2]))
  # m3<-c(m1,m2)
  if(na.rm)
    set<-set[m2,]
  if(sub!=F)

    coll.1<-subset(set,set$lemma%in%sub)
  coll.1<-data.frame(cbind(set[var1],set[var2],set[var3]))
}
coll.make.1<-get.coll.df(corpus.df,"lemma","light",F)
coll.make.2<-collex.covar(coll.make.1,str.dir = T,delta.p = "yes",decimals = 2,am="fye.ln",p.fye = T)
#table(coll.make.1$lemma)
make.eval1<-coll.make.2[coll.make.2$SLOT1=="make"|coll.make.2$SLOT1=="build"|coll.make.2$SLOT1=="produce"|coll.make.2$SLOT1=="generate"|coll.make.2$SLOT1=="create",]
abs((make.eval1$STR.DIR/make.eval1$fS1))
plot(abs(make.eval1$STR.DIR/make.eval1$fS1))
scatter.smooth(abs(make.eval1$STR.DIR/make.eval1$fS1))
p.make<-abs(abs(make.eval1$STR.DIR/make.eval1$fS1)-100)/100
1-p.make
p.make<-abs(abs(make.eval1$fS1/make.eval1$STR.DIR)-100)/100
1-p.make
make.eval1
abs(make.eval1$fS1/make.eval1$STR.DIR)
abs((abs(make.eval1$STR.DIR)/make.eval1$fS1)-1)
barplot(abs(make.eval1$COLL.STR.FYE.LN/100-1))
### distance to 1
par(las=3)
#xcat<-make.eval1$SLOT2
barplot(make.eval1$COLL.STR.FYE.LN~paste0(make.eval1$SLOT1,".",make.eval1$SLOT2),
        xlab = "",ylab = "assoc. strength")
text(5, 50, "0 = concrete use, 1 = light use",
     cex = .8)
make.eval1
x <- seq(0.95, 1.05, by = 0.01)
x
n<-c(1,0,1)
abs(n-1)
abs(x - 1)
library(stats)
lm1<-lm(abs(light-1)~lemma,corpus.df)
lms<-summary(lm1)
lms
lms$coefficients[grepl("lemmabuild|lemmamake|lemmaproduce|lemmacreate|lemmagenerate",rownames(lms$coefficients)),]
### break
load("~/Documents/GitHub/SPUND-LX/corpusLX/14015-HA/data/verb.object.df.cpt.RData")
###
coll.make.2<-collex.covar(coll.make.1,str.dir=T,decimals = 2)
coll.make.2
tail(coll.make.2)
coll.obj<-get.coll.df(corpus.df,"lemma","dep_rel",F)
coll.obj.2<-collex.covar(coll.obj)
coll.obj.2
coll.j<-join.freqs(data.frame(WORD=coll.make.2$SLOT1,coll.make.2$OBS),data.frame(WORD=coll.obj.2$SLOT1,coll.obj.2$fS1),all = F)
coll3<-collex(coll.j)
coll3
tail(coll3,200)
coll.j<-join.freqs()
####################
# 14046.from corpus with all deprel
load("~/boxHKW/21S/DH/local/SPUND/corpuslx/stefanowitsch/HA/data/sbc.corpus.df.deprel.RData")
colnames(corpus.df.deprel)
coll1<-get.coll.df(corpus.df.deprel,"lemma","head_lemma_value",F)
coll1.1<-collex.covar(coll1)
coll1.1[coll1.1$SLOT1=="make",]
coll2<-get.coll.df(corpus.df.deprel,"lemma","light",F)
coll2.1<-collex.covar(coll2)
coll3<-join.freqs(data.frame(coll2.1$SLOT1,coll2.1$OBS),data.frame(coll1.1$SLOT1,coll1.1$OBS),all = F,threshold = max(coll2.1$OBS))
max(coll2.1$OBS)
coll3<-join.freqs(data.frame(paste0(coll2.1$SLOT1,".",coll2.1$SLOT2),coll2.1$OBS),
                  data.frame(paste0(coll1.1$SLOT1,".",coll1.1$SLOT2),coll1.1$OBS))
coll3<-join.freqs(data.frame(coll1.1$SLOT1,coll1.1$OBS),data.frame(coll2.1$SLOT1,coll2.1$OBS))
coll3<-join.freqs(data.frame(coll2.1$SLOT1,coll2.1$OBS),data.frame(coll1.1$SLOT1,coll1.1$OBS))
coll3<-join.freqs(data.frame(paste0(coll2.1$SLOT1,".",coll2.1$SLOT2),coll2.1$OBS),
                  data.frame(paste0(coll1.1$SLOT1,".",coll1.1$SLOT2),coll1.1$OBS),all=F,threshold = 2)
#filter:
sum(is.na(coll3$paste0.coll2.1.SLOT1.......coll2.1.SLOT2.))
sum(coll3$`data.frame(paste0(coll2.1$SLOT1, ".", coll2.1$SLOT2), coll2.1$OBS)`==0)
sum(coll3$`data.frame(paste0(coll1.1$SLOT1, ".", coll1.1$SLOT2), coll1.1$OBS)`==0)
m<-coll3[,2]>coll3[,3]
sum(m)
coll3.1<-coll3[!m,]
m<-coll3[,3]<1
sum(m)
coll3.1<-coll3[!m,]
#coll3
coll3.2<-collex(coll3)
coll3.2[coll3.2$COLLEX=="make",]
coll3.2
# chk
coll2.1
coll1.1 # del slot1==slot2
m<-coll1.1$SLOT1==coll1.1$SLOT2
coll1.2<-coll1.1[!m,]
coll3<-join.freqs(data.frame(coll2.1$SLOT1,coll2.1$OBS),data.frame(coll1.2$SLOT1,coll1.2$OBS))
coll3<-join.freqs(data.frame(coll1.1$SLOT1,coll1.1$OBS),data.frame(coll2.1$SLOT1,coll2.1$OBS))
coll2.ns<-paste0(coll2.1$SLOT1,".",coll2.1$SLOT2)
coll2.ns
coll1.ns<-paste0(coll1.1$SLOT1,".",coll1.1$SLOT2)
coll3<-join.freqs(data.frame(coll2.ns,coll2.1$OBS),data.frame(coll1.1$SLOT1,coll1.1$OBS),all = F,threshold = 1)
coll3<-join.freqs(data.frame(coll2.1$SLOT1,coll2.1$OBS),data.frame(coll1.1$SLOT1,coll1.1$OBS),all = F,threshold = 1)
unique(coll1.1$OBS)

length(coll3[,1])
m<-coll3[,2]>coll3[,3]
sum(m)
coll3<-coll3[!m,]
coll3.2<-collex(coll3)
coll3.2
coll.3.3<-coll3.2[coll3.2$COLLEX=="make",]
coll1.1[head(rownames(coll.3.3)),]
coll3.4<-collex.covar(coll3,raw = F)
coll4<-get.coll.df(corpus.df.deprel,"lemma","head_lemma_value","light",F)
coll4$l.lemma<-paste0(coll4$lemma,".",coll4$head_lemma_value)
coll4$l.light<-paste0(coll4$lemma,".",coll4$light)
#coll4.l<-paste0(coll4$lemma,".",coll4$head_lemma_value)
coll4.2<-collex.covar(data.frame(coll4$head_lemma_value,coll4$l.light))
lemma.object.light.df<-coll4
save(lemma.object.light.df,file="~/Documents/GitHub/SPUND-LX/corpusLX/14015-HA/data/lemma.object.light.df.RData")

coll4.2[coll4.2$SLOT1=="take",]
sub<-c("make","build","produce","create","generate")
coll4.2[coll4.2$SLOT1%in%sub,]
sub<-c("the") # 0
coll4.2[grep(sub,coll4.2$SLOT2),]
m<-coll4$lemma=="give"
sum(m)
m<-grepl("giv",corpus.df$sentence)
sum(m)
corpus.df$sentence[m]
m<-grepl("giv",corpus.df.deprel$lemma)
sum(m)
###
coll5<-get.coll.df(corpus.df.deprel,"lemma","head_lemma_value","light",sub=F,na.rm=F)
m<-coll5$lemma=="give"
sum(m)
coll5$l.lemma<-paste0(coll5$lemma,".",coll5$head_lemma_value)
coll5$l.light<-paste0(coll5$lemma,".",coll5$light)
#coll4.l<-paste0(coll4$lemma,".",coll4$head_lemma_value)
coll5.2<-collex.covar(data.frame(coll5$head_lemma_value,coll5$l.light))
sub<-c("give")
coll5.2[coll5.2$SLOT1=="give",]
concrete.give<-c(1066,2620,10469,20369,20373,20377,31957,41100,45424,45538,48045,50236,51759,52340,52341,54654,56016,60668,
                 61952,64351,67497,69012,70356,71167,74595,75162,76991,77442,77553,81098,81099,81859,81860,94278,
                 96953,99281,99880)
concrete.give.txt<-c("sticker","antibiotic","gift","iguana","recognition","toothpick","herb","anything","enzyme","cake","lettuce","candy","card","literature","ornament","tape","ticket","pair","clothes","juice","pepper","money","goldfish","machine","cup","kiss","amount","bit","picture","mine","pass","dollar","ten","drink","something","car","lot")
# library(clipr)
# write_clip(paste0(coll5.2$SLOT2[concrete.give],collapse = '","'))
# concrete.give.txt<-gsub("\\.NA","",concrete.give.txt)
# write_clip(paste0(concrete.give.txt,collapse = '","'))
coll5.2[coll5.2$SLOT1=="take",]
coll5.2[coll5.2$SLOT1=="take",]
concrete.take<-c(848,6381,14466,16674,18611,18809,19366,22031,24813,24827,24829,24831,24832,24834,24835,29159,32908,36540,
                 38239,38243,38247,38253,38254,38258,45020,45021,45032,49577,49582,49583,49588,53267,56405,56406,56409,
                 59372,61588,61592,65654,65656,65657,66021,69440,71127,72201,72320,73797,73798,78435,78440,78442,
                 79454,79456,82282,83099,83834,83836,84599,85311,85932,88155,89310,91865,93070,96464,96465,99149,
                 99745,104020,117695)
# write_clip(paste0(coll5.2$SLOT2[concrete.take],collapse = '","'))
concrete.take.txt<-c("balloon","shelf","checkbook","car","bag","everything","puppies","silverware","torque","tree","Tupperware","wastebasket","wire","money","capsule","guitar","stub","tail","Tylenol","blanket","clipping","tablecloth","crown","medicine","nail","spacesuit","sweater","hers","knife","rack","rock","diary","woodwork","pill","ticket","trash","plug","some","tape","band","flip","water","container","pants","buck","insulin","foot","painting","drug","gift","cart","hair","egg","ball","dollar","pound","drink","thing","NPH")
concrete.false.take<-c("while","time","care","advantage","picture","half","off","down","dollars to do it","look","with me","out","them to")
concrete.false.take.regx<-paste0(concrete.false.take,collapse = "|")
concrete.false.take.regx<-paste0("(",concrete.false.take.regx,")")
#concrete.take.txt<-gsub("\\.[NA0-1]","",concrete.take.txt)
# write_clip(paste0(concrete.take.txt,collapse = '","'))
##########################################################
### apply light label
m1<-corpus.df.deprel$head_lemma_value%in%concrete.give.txt&grepl("give|gave|given|giving",corpus.df.deprel$sentence)
#m<-corpus.df.deprel$lemma=="give"&corpus.df.deprel$head_lemma_value=="ornament"
sum(m1)
corpus.df.deprel$sentence[m1]
corpus.df.deprel$light[m1]<-0
m2<-corpus.df.deprel$head_lemma_value%in%concrete.take.txt&grepl("take|took|takenen|taking",corpus.df.deprel$sentence)
#m<-corpus.df.deprel$lemma=="give"&corpus.df.deprel$head_lemma_value=="ornament"
sum(m2)
corpus.df.deprel$sentence[m2]
corpus.df.deprel$light[m2]<-NA
m3<-corpus.df.deprel$head_lemma_value%in%concrete.take.txt&grepl("take|took|takenen|taking",corpus.df.deprel$sentence)&
  !grepl(concrete.false.take.regx,corpus.df.deprel$sentence)
corpus.df.deprel$sentence[m3]
corpus.df.deprel$light[m3]<-0
### apply negative m as 1
m4<-grepl("give|gave|given|giving",corpus.df.deprel$sentence)
sum(m4)
corpus.df.deprel$sentence[m4]
corpus.df.deprel$light[m4]<-1
m1<-corpus.df.deprel$head_lemma_value%in%concrete.give.txt&grepl("give|gave|given|giving",corpus.df.deprel$sentence)
#m<-corpus.df.deprel$lemma=="give"&corpus.df.deprel$head_lemma_value=="ornament"
sum(m1)
m1<-which(m1)
#m1
m11<-corpus.df.deprel$sentence%in%corpus.df.deprel$sentence[m1]
sum(m11)
corpus.df.deprel$sentence[m11]
corpus.df.deprel$light[m11]<-0
m5<-grepl("take|took|takenen|taking",corpus.df.deprel$sentence)
#m<-corpus.df.deprel$lemma=="give"&corpus.df.deprel$head_lemma_value=="ornament"
sum(m5)
corpus.df.deprel$sentence[m5]
corpus.df.deprel$light[m5]<-1
m3<-corpus.df.deprel$head_lemma_value%in%concrete.take.txt&grepl("take|took|takenen|taking",corpus.df.deprel$sentence)&
  !grepl(concrete.false.take.regx,corpus.df.deprel$sentence)
sum(m3)
m31<-corpus.df.deprel$sentence%in%corpus.df.deprel$sentence[m3]
sum(m31)
corpus.df.deprel$sentence[m31]
corpus.df.deprel$light[m31]<-0
#chk
m<-corpus.df.deprel$lemma=="give"&corpus.df.deprel$light==1
#m<-corpus.df.deprel$light==1
sum(m,na.rm = T)
m<-corpus.df.deprel$lemma=="take"&corpus.df.deprel$light==1
#m<-corpus.df.deprel$light==1
sum(m,na.rm = T)
#############################
#save(corpus.df.deprel,file="~/boxHKW/21S/DH/local/SPUND/corpuslx/stefanowitsch/HA/data/sbc.corpus.df.deprel.RData")
load("~/boxHKW/21S/DH/local/SPUND/corpuslx/stefanowitsch/HA/data/sbc.corpus.df.deprel.RData")
#############################
### now collex again:
coll6<-get.coll.df(corpus.df.deprel,"lemma","head_lemma_value","light",sub=F,na.rm=F)
get.collex<-function(coll6){
coll6$l.lemma<-paste0(coll6$lemma,".",coll6$head_lemma_value)
coll6$l.light<-paste0(coll6$head_lemma_value,".",coll6$light)
#coll4.l<-paste0(coll4$lemma,".",coll4$head_lemma_value)
coll6.2<-collex.covar(data.frame(coll6$lemma,coll6$l.light))
#coll6.2<-collex.covar(data.frame(coll6$l.light,coll6$l.light))
}
coll6.2<-get.collex(coll6)
coll6.2
coll6.2[grepl("0",coll6.2$SLOT2),]
coll6.2[grepl(0,coll6.2$SLOT2)&coll6.2$SLOT1=="take",]


