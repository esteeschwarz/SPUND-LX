#20240128(10.37)
#14052.SBC.frequency evaluations
################################
#load("~/boxHKW/21S/DH/local/SPUND/corpuslx/stefanowitsch/HA/data/sbc.corpus.df.deprel.RData")
### replace with local .RData before running:
load("~/boxHKW/21S/DH/local/SPUND/corpuslx/stefanowitsch/HA/data/sbc.corpus.df.deprel.ann.RData")


# build annotated token for concrete /take/, /give/ (/make/ already annotated)
tempfun<-function(){
get.light.annotation<-function(corpus.df.deprel){
concrete.give<-c(1066,2620,10469,20369,20373,20377,31957,41100,45424,45538,48045,50236,51759,52340,52341,54654,56016,60668,
                 61952,64351,67497,69012,70356,71167,74595,75162,76991,77442,77553,81098,81099,81859,81860,94278,
                 96953,99281,99880)

concrete.give.txt<-c("sticker","antibiotic","gift","iguana","recognition","toothpick","herb","anything","enzyme","cake","lettuce","candy","card","literature","ornament","tape","ticket","pair","clothes","juice","pepper","money","goldfish","machine","cup","kiss","amount","bit","picture","mine","pass","dollar","ten","drink","something","car","lot")

concrete.take<-c(848,6381,14466,16674,18611,18809,19366,22031,24813,24827,24829,24831,24832,24834,24835,29159,32908,36540,
                 38239,38243,38247,38253,38254,38258,45020,45021,45032,49577,49582,49583,49588,53267,56405,56406,56409,
                 59372,61588,61592,65654,65656,65657,66021,69440,71127,72201,72320,73797,73798,78435,78440,78442,
                 79454,79456,82282,83099,83834,83836,84599,85311,85932,88155,89310,91865,93070,96464,96465,99149,
                 99745,104020,117695)

concrete.take.txt<-c("balloon","shelf","checkbook","car","bag","everything","puppies","silverware","torque","tree","Tupperware","wastebasket","wire","money","capsule","guitar","stub","tail","Tylenol","blanket","clipping","tablecloth","crown","medicine","nail","spacesuit","sweater","hers","knife","rack","rock","diary","woodwork","pill","ticket","trash","plug","some","tape","band","flip","water","container","pants","buck","insulin","foot","painting","drug","gift","cart","hair","egg","ball","dollar","pound","drink","thing","NPH")
concrete.false.take<-c("while","time","care","advantage","picture","half","off","down","dollars to do it","look","with me","out","them to")
concrete.false.take.regx<-paste0(concrete.false.take,collapse = "|")
concrete.false.take.regx<-paste0("(",concrete.false.take.regx,")")
#concrete.take.txt<-gsub("\\.[NA0-1]","",concrete.take.txt)
# write_clip(paste0(concrete.take.txt,collapse = '","'))
##########################################################
### apply light label

m4<-grepl("give|gave|given|giving",corpus.df.deprel$sentence)
sum(m4)
corpus.df.deprel$sentence[m4]
corpus.df.deprel$light[m4]<-1 # set all give sentences to 1=light
m1<-corpus.df.deprel$head_lemma_value%in%concrete.give.txt&grepl("give|gave|given|giving",corpus.df.deprel$sentence)
#m<-corpus.df.deprel$lemma=="give"&corpus.df.deprel$head_lemma_value=="ornament"
sum(m1)
#m1<-which(m1)
#m1
m11<-corpus.df.deprel$sentence%in%corpus.df.deprel$sentence[m1]
sum(m11)
corpus.df.deprel$sentence[m11]
corpus.df.deprel$light[m11]<-0 # set concrete instances
m5<-grepl("take|took|taken|taking",corpus.df.deprel$sentence)
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
return(corpus.df.deprel)
}


}
#############################
#save(corpus.df.deprel,file="~/boxHKW/21S/DH/local/SPUND/corpuslx/stefanowitsch/HA/data/sbc.corpus.df.deprel.RData")



#set<-corpus.df.deprel
library(collostructions)
# get collocation df to feed into collex.covar()
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
  coll.1<-data.frame(cbind(set[var1],set[var2],set[var3],obj.to=set$obj,pos=set$upos))
}

# call collex analysis
get.collex<-function(coll6,filter.pos,na.rm=FALSE){
  m3<-coll6$lemma==coll6$head_lemma_value # remove observations with lemma==head_lemma
  sum(m3,na.rm = T)
  #coll6na<-coll6
  coll6<-coll6[!m3,]
  m4<-is.na(coll6$light)
  
  if(na.rm!=T)
    coll6$light[m4]<-"n.a."
  # m5<-is.na(coll6$obj.to)
  # coll6<-coll6[!m5,]
  if(filter.pos!="")
    coll6<-coll6[coll6$pos==filter.pos,]
  
  #  coll6<-coll6na
  # coll6$l.lemma<-paste0(coll6$lemma,".",coll6$dep_rel)
  # coll6$l.light<-paste0(coll6$head_lemma_value,".",coll6$light)
  # coll6$l.obj<-paste0(coll6$obj.to,".",coll6$lemma)
#  coll6$l.light<-paste0(coll6$lemma,".",coll6$light)
  #coll4.l<-paste0(coll4$lemma,".",coll4$head_lemma_value)
  #coll6.2<-collex.covar(data.frame(coll6$l.obj,coll6$l.light))
  #coll6.2<-collex.covar(data.frame(coll6$l.light,coll6$l.light))
  #colldf<-data.frame(lemma=coll6$lemma,head_lemma=coll6$head_lemma_value,light=coll6$light,obj.to=coll6$obj.to)
  colldf<-data.frame(head_lemma=coll6$head_lemma_value,lemma=coll6$lemma,light=coll6$light)
  coll6.2<-collex.covar.mult(colldf,threshold = 1,decimals = 3)
 # coll6.2<-collex.covar.mult(data.frame(coll6$lemma,coll6$head_lemma_value,coll6$light,coll6$obj.to),threshold = 1,decimals = 2)
}
#save(corpus.df.deprel,file = "~/boxHKW/21S/DH/local/SPUND/corpuslx/stefanowitsch/HA/data/sbc.corpus.df.deprel.ann.RData")
# load("~/boxHKW/21S/DH/local/SPUND/corpuslx/stefanowitsch/HA/data/sbc.corpus.df.deprel.ann.RData")
#############################
### now collex again:
# get df with 3 variables:
coll6<-get.coll.df(corpus.df.deprel,"lemma","head_lemma_value","light",sub=F,na.rm=F)
coll6.2.na.rm<-get.collex(coll6,filter.pos = "NOUN",na.rm = T)
coll6.2<-get.collex(coll6,filter.pos = "NOUN",na.rm = F)

coll6.2
coll6.2.na.rm
coll6.2[coll6.2$head_lemma=="make",]
coll6.2[coll6.2$head_lemma=="make"&coll6.2$light==0,]
coll6.2[coll6.2$head_lemma=="make",]
coll6.2[coll6.2$head_lemma=="make"&coll6.2$light==1,]
coll6.2[coll6.2$head_lemma=="make",]
make.array<-c("make","generate","produce","create","build")
eval1<-coll6.2[coll6.2$head_lemma%in%make.array&coll6.2$light==0,]
coll6.2[coll6.2$head_lemma=="make",]
coll6.2[coll6.2$head_lemma=="make"&coll6.2$light==0,]
eval1<-coll6.2[coll6.2$head_lemma%in%make.array&coll6.2$light==0,]
make<-sum(eval1$T[eval1$head_lemma=="make"])
build<-sum(eval1$T[eval1$head_lemma=="build"])
create<-sum(eval1$T[eval1$head_lemma=="create"])
produce<-sum(eval1$T[eval1$head_lemma=="produce"])
generate<-sum(eval1$T[eval1$head_lemma=="generate"])
eval1
#sum(eval1$T[eval1$head_lemma=="make"])
barplot(cbind(make,produce,create,build,generate), main="absolute preference in concrete context",ylab="T score sum association strength")
#factor(plotdf$T)
#table(plotdf)
take.array<-c("take","bring","carry")
eval2<-coll6.2[coll6.2$head_lemma%in%take.array&coll6.2$light==0,]
take<-sum(eval2$T[eval2$head_lemma=="take"])
bring<-sum(eval2$T[eval2$head_lemma=="bring"])
carry<-sum(eval2$T[eval2$head_lemma=="carry"])
barplot(cbind(bring,carry,take),ylab="T score sum association strength", main="absolute preference in concrete context")
df<-factor(coll6.2$head_lemma)
levels(df)
df<-length(levels(df))
#df<-177
#edge
#p_value_left = pt(q = -0.77, df = 15, lower.tail = TRUE)
get.p<-function(x)pt(x,df,lower.tail = F)
eval1$p<-unlist(lapply(eval1$T, get.p))
eval1
eval2$p<-unlist(lapply(eval2$T, get.p))
eval2
#x<-eval1$head_lemma[1]
sumobs<-function(x)sum(grepl(x,eval1[['head_lemma']]))
eval1$obs<-unlist(lapply(eval1$head_lemma, sumobs))
#obs1
eval1
plotdf1<-data.frame(lemma=factor(eval1$head_lemma),p=eval1$p,obs=eval1$obs)
par(las=3)
boxplot(plotdf1$p~plotdf1$lemma,varwidth=T,outline=F,xlab = "",ylab="p-value of collexeme association strength",main="binding of lemma in concrete noun context")
plotdf2<-data.frame(lemma=factor(eval2$head_lemma),p=eval2$p)
eval2$obs<-unlist(lapply(eval2$head_lemma, sumobs))
par(las=3)
boxplot(plotdf2$p~plotdf2$lemma,varwidth=T,outline=F,xlab = "",ylab="p-value of collexeme association strength",main="binding of lemma in concrete noun context")
### result: preference of build over make, preference of bring over take
### > the alternative construction is preferred in concrete contexts



