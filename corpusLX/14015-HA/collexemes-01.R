#20240128(10.37)
#14052.SBC.frequency evaluations
################################
### replace with local sources before running:
#install.packages("~/boxHKW/21S/DH/local/SPUND/corpuslx/stefanowitsch/collostructions_0.2.0.tar.gz", repos = NULL, type = "source")
# dtemp<-tempfile("colltar.tar.gz")
### below is the only online source, but only v0.1.0 missing collex.covar.mult()
# download.file("http://userpage.fu-berlin.de/~flach/wp-content/uploads/collostructions_0.1.0.tar.gz",dtemp)
# #install.packages("~/boxHKW/21S/DH/local/SPUND/corpuslx/stefanowitsch/collostructions_0.2.0.tar.gz", repos = NULL, type = "source")
# dtemp
# install.packages(dtemp, repos = NULL, type = "source")
load("~/boxHKW/21S/DH/local/SPUND/corpuslx/stefanowitsch/HA/data/sbc.corpus.df.deprel.ann.RData")


# build annotated token for concrete /take/, /give/ (/make/ already annotated)
# these annotations are already applied to the actual dataset, the function is not called in script
# the concrete /give/, /take/ objects below are defined manually as occuring in the corpus as objects of or in context with the given lemma. see https://github.com/esteeschwarz/SPUND-LX/blob/main/corpusLX/14015-HA/get-freq-df.R on how these objects were defined.
########################################
# sec 2.
get.light.annotation<-function(corpus.df.deprel){
concrete.give<-c(1066,2620,10469,20369,20373,20377,31957,41100,45424,45538,48045,50236,51759,52340,52341,54654,56016,60668,
                 61952,64351,67497,69012,70356,71167,74595,75162,76991,77442,77553,81098,81099,81859,81860,94278,
                 96953,99281,99880)

concrete.give.txt<-c("sticker","antibiotic","gift","iguana","recognition","toothpick","herb","anything","enzyme","cake","lettuce","candy","card","literature","ornament","tape","ticket","pair","clothes","juice","pepper","money","goldfish","machine","cup","kiss","amount","bit","picture","mine","pass","dollar","ten","drink","something","car","lot")

concrete.make.txt<-c("horseshoe","sound","cartilage","ceviche","food","noise","hay","grape","cookie","spatula","clothes","wiper","quilt","outfit","copy","tape","string","intercession","application","balloon","basket","kebab","salad","juice","gravy","tamale","sauce","ton","tail","stuff","papers","pasta","loaf","sandwich","ornament","picture","pillow","database","statue","pizza","fudge","recipe","pan","plate","decaf","tart")

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
corpus.df.deprel$light<-NA
corpus.df.deprel$alt<-"a-other"
###
#q.lemma<-"make|made|making"
#lemma<-"make"
###
#concrete.array<-concrete.make.txt

apply.light<-function(corpus.df.deprel=corpus.df.deprel,q.lemma,lemma,concrete.array){
#m4<-grepl("make|made|making",corpus.df.deprel$sentence)
  corpus.df.deprel$lemma<-gsub("[^a-zA-z']","",corpus.df.deprel$lemma)
  corpus.df.deprel$head_lemma_value<-gsub("[^a-zA-z']","",corpus.df.deprel$head_lemma_value)
  
m1<-grepl(q.lemma,corpus.df.deprel$sentence)
m13<-grepl(lemma,corpus.df.deprel$lemma)

sum(m1)
sum(m13)
corpus.df.deprel$sentence[m1]
#unique(corpus.df.deprel$head_lemma_value)
length(unique(corpus.df.deprel$head_token_value))
length(unique(corpus.df.deprel$token))
#table(corpus.df.deprel$lemma)
corpus.df.deprel$alt[m1]<-lemma # set concrete instances
corpus.df.deprel$light[m13]<-1 # set all to light
#corpus.df.deprel$light[m4]<-1 # set all give sentences to 1=light
m2<-corpus.df.deprel$head_lemma_value%in%concrete.array#&grepl(lemma,corpus.df.deprel$sentence)
for (k in 1:length(concrete.array)){
  m16<-grepl(concrete.array[k],corpus.df.deprel$sentence[m1])
  corpus.df.deprel$light[m1][m16]<-0

  }
# table(corpus.df.deprel$lemma,corpus.df.deprel$light)
# m2<-corpus.df.deprel
# sum(m2)
# which(m2)
# #m2<-m2[!is.na(m2)]
# corpus.df.deprel$sentence[which(m2)]
# m11<-corpus.df.deprel$sentence%in%corpus.df.deprel$sentence[m2]
# length(m11)
# sum(m11)
# wm11<-which(m11)
# length(wm11)
# m12<-corpus.df.deprel$alt==lemma
# wm12<-which(m12)
# length(wm12)
# m13<-wm11%in%wm12
# wm13<-wm11[m13]
# wm13
# #sum(wm13)
# corpus.df.deprel$sentence[wm13]
# #corpus.df.deprel$light[wm13]<-0
# m14<-corpus.df.deprel$lemma[wm13]==lemma
# sum(m14)
# k<-1
# for(k in 1:length(concrete.array)){
#   m15<-corpus.df.deprel$lemma[m14]==concrete.array[k]
#   sum(m15,na.rm = T)
#   concrete.array[k]
#   corpus.df.deprel$sentence[m14][m15]<-0
# }
#m1<-corpus.df.deprel$head_lemma_value[m4]%in%concrete.make.txt
#m<-corpus.df.deprel$lemma=="give"&corpus.df.deprel$head_lemma_value=="ornament"
#sum(m1)
#corpus.df.deprel$sentence[m2]
#corpus.df.deprel$light[m2]<-0
return(corpus.df.deprel)
}
corpus.df.deprel<-apply.light(corpus.df.deprel,"make|made|making","make",concrete.array=concrete.make.txt)
corpus.df.deprel<-apply.light(corpus.df.deprel,"take|took|taken|taking","take",concrete.take.txt)
corpus.df.deprel<-apply.light(corpus.df.deprel,"give|gave|given|giving","give",concrete.give.txt)
table(corpus.df.deprel$alt,corpus.df.deprel$light,corpus.df.deprel$head_lemma_value)
#chk
return(corpus.df.deprel)
}

#corpus.df.deprel<-get.light.annotation(corpus.df.deprel)
corpus.df.deprel.new<-get.light.annotation(corpus.df.deprel)

#############################
#save(corpus.df.deprel,file="~/boxHKW/21S/DH/local/SPUND/corpuslx/stefanowitsch/HA/data/sbc.corpus.df.deprel.ann.RData")



#set<-corpus.df.deprel
library(collostructions)
# get collocation df to feed into collex.covar()
get.coll.df<-function(set,var1,var2,var3,sub=F,na.rm=F){
  m1<-!is.na(set[var1])&!is.na(set[var2])
  sum(m1)
  m2<-!is.na(set[var3])
  set<-set[m1,]
  if(na.rm)
    set<-set[m2,]
  if(sub!=F)
    
    coll.1<-subset(set,set$lemma%in%sub)
  coll.1<-data.frame(cbind(set[var1],set[var2],set[var3],obj.to=set$obj,pos=set$upos))
}
filter.pos<-list(head_lemma_value=c("make","take","give"),light=1)
filter.pos
# call collex analysis
vers<-'lemma'
coll6<-corpus.df.deprel
get.collex<-function(coll6,filter.pos,vers,na.rm=FALSE){
  m3<-coll6$lemma==coll6$head_lemma_value # remove observations with lemma==head_lemma
  sum(m3,na.rm = T)
  #coll6na<-coll6
  coll6<-coll6[!m3,]
  m4<-!is.na(coll6$light)
  sum(m4)
  k<-1
  if(na.rm==F)
    coll6$light[m4]<-"n.a."
  # m5<-is.na(coll6$obj.to)
  # coll6<-coll6[!m5,]
  if(length(filter.pos)>0){
    for(k in length(filter.pos)){
    col<-names(filter.pos[k])
    coll6<-coll6[coll6[[col]]%in%filter.pos[[k]],]
    }
}
  if(vers=="light"){
    colldf.light<-data.frame(head_lemma=coll6$head_lemma_value,lemma=coll6$lemma,light=coll6$light)
    coll6.2<-collex.covar.mult(colldf.light,threshold = 1,decimals = 3)
  }
#  coll6.2
  if(vers=="lemma"){
    colldf.lemma<-data.frame(head_lemma=coll6$head_lemma_value,lemma=coll6$lemma)
    coll6.2<-collex.covar(colldf.lemma,decimals = 3)
  }
  return(coll6.2)
  # coll6.2<-collex.covar.mult(data.frame(coll6$lemma,coll6$head_lemma_value,coll6$light,coll6$obj.to),threshold = 1,decimals = 2)
}
coll6.2
#save(corpus.df.deprel,file = "~/boxHKW/21S/DH/local/SPUND/corpuslx/stefanowitsch/HA/data/sbc.corpus.df.deprel.ann.RData")
# load("~/boxHKW/21S/DH/local/SPUND/corpuslx/stefanowitsch/HA/data/sbc.corpus.df.deprel.ann.RData")
#############################
### now collex again:
# get df with 3 variables:
coll6<-get.coll.df(corpus.light.ann,"lemma","head_lemma_value","light",sub=F,na.rm=F)
coll6<-get.coll.df(corpus.df.deprel,"lemma","head_lemma_value","light",sub=F,na.rm=F)
coll6.2<-get.collex(coll6,filter.pos = "NOUN",na.rm = T) # light==NA stays NA which lets collex sort them out of computation
coll6.2<-get.collex(coll6,filter.pos = "NOUN",na.rm = F) # light==NA will be replaced by "n.a." which lets collex calculate them as variant of light > they are part of the computation
coll6.2.na.rm<-get.collex(coll6,filter.pos = "",na.rm = T)
#coll6.2<-get.collex(coll6,filter.pos = "",na.rm = F)
collex.eval<-coll6.2
#save(collex.eval,file = "~/Documents/GitHub/SPUND-LX/corpusLX/14015-HA/data/collex.eval.RData")
coll6.2
coll6.2.na.rm
#############
### subset evaluation
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
#get.p<-function(x)pt(x,df,lower.tail = T)
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
### result: preference of build over make, preference of bring over take in p
### the opposite result in summed up T-score / lemma
### mehl (2021) on this:
"The null hypothesis for this test is that the underlying selection preference for each verb or its alternate is random. The single-sample Chi-square test shows that in speech, each concrete verb (make, take, and give) is preferred over its alternate beyond what is expected by chance (p < 0.05).
Put differently, each concrete verb is significantly preferred over its alternate in speech."

### > here my question, what my results mean resp. the hypothesis and the mehl findings. my p-values show the opposite results, the T-score sum interpretation agrees with mehl. did i find just the opposite result in my corpus or am i wrong in building the results? can i simply boxplot the p-values which then shows that the lemma is below its alternatives? or is the sum of T-score yet the right indicator as the means for all T equals 1 saying it is already a mean interpretation of the association strength over the corpus?

### > the alternative construction is preferred in concrete contexts
####################################################################
#14062.new p with simple freqency analysis
### get lemma-object df
getsubset<-function(df,q.obj){
  df<-subset(df,df$obj==q.obj)
}
sub.make<-getsubset(corpus.df.deprel,"make")
sub.take<-getsubset(corpus.df.deprel,"take")
sub.give<-getsubset(corpus.df.deprel,"give")
### wks.
obj.unique.make<-unique(sub.make$lemma)
obj.unique.take<-unique(sub.take$lemma)
obj.unique.give<-unique(sub.give$lemma)
###
# manually define concrete make (give/take defined in sec 2)
concrete.make<-data.frame(obj=obj.unique.make,light=1)
concrete.make.ann<-fix(concrete.make)
# install.packages("devtools")
# library(devtools)
# install_github("esteeschwarz/clipX")
# library(clipX)
# library(clipr)
# write_clip(concrete.make.ann$obj[concrete.make.ann$light==0])
# clipX()
concrete.make.txt<-c("horseshoe","sound","cartilage","ceviche","food","noise","hay","grape","cookie","spatula","clothes","wiper","quilt","outfit","copy","tape","string","intercession","application","balloon","basket","kebab","salad","juice","gravy","tamale","sauce","ton","tail","stuff","papers","pasta","loaf","sandwich","ornament","picture","pillow","database","statue","pizza","fudge","recipe","pan","plate","decaf","tart")

### predefinition chk (with concrete /make/ defined earlier)
t.make<-table(sub.make$light) # > 62/305
t.take<-table(sub.take$light) # > 50/456
t.give<-table(sub.give$light) # > 43/199
###
corpus.df.deprel.new<-get.light.annotation(corpus.df.deprel)
sub.make<-getsubset(corpus.df.deprel.new,"make")
t.make<-table(sub.make$light) # > 54/375
### for consistency to take&give i integrate this new light annotation
corpus.light.ann<-corpus.df.deprel.new
table(corpus.light.ann$light,corpus.light.ann$alt) # 2089/9419
library(collostructions)
###
coll6<-get.coll.df(corpus.light.ann,"lemma","head_lemma_value","light",sub=F,na.rm=F)
coll6.2<-get.collex(coll6,filter.pos = "NOUN",na.rm = T) # light==NA stays NA which lets collex sort them out of computation
coll6.2<-get.collex(coll6,filter.pos = "NOUN",na.rm = F) # light==NA will be replaced by "n.a." which lets collex calculate 
coll6.2
coll6<-corpus.df.deprel
coll6.2<-get.collex(coll6,vers="lemma",filter.pos<-list(head_lemma_value=c("make","take","give"),light=0)
,na.rm = T) # light==NA stays NA which lets collex sort them out of computation
coll6.2<-get.collex(coll6,vers="light",filter.pos<-list(head_lemma_value=c("make","take","give"))
                    ,na.rm = T) # light==NA stays NA which lets collex sort them out of computation
coll6.2
corpus.light.ann$sentence[corpus.light.ann$lemma=="butter"]
sum(is.na(corpus.light.ann$lemma))
m<-corpus.df.deprel$head_lemma_value=="take"&corpus.df.deprel$lemma=="care"&corpus.df.deprel$light==0
corpus.df.deprel$sentence[m]
