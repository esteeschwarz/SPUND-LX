#20240128(10.37)
#14052.SBC.frequency evaluations
################################
### replace with local sources before running:
#install.packages("~/boxHKW/21S/DH/local/SPUND/corpuslx/stefanowitsch/collostructions_0.2.0.tar.gz", repos = NULL, type = "source")
# dtemp<-tempfile("colltar.tar.gz")
# ### below is the only online source, but only v0.1.0 missing collex.covar.mult()
# #download.file("http://userpage.fu-berlin.de/~flach/wp-content/uploads/collostructions_0.1.0.tar.gz",dtemp)
# download.file("http://userpage.fu-berlin.de/stschwarz/file/collostructions_0.2.0.tar.gz",dtemp)
# install.packages("~/boxHKW/21S/DH/local/SPUND/corpuslx/stefanowitsch/collostructions_0.2.0.tar.gz", repos = NULL, type = "source")
# dtemp
# install.packages(dtemp, repos = NULL, type = "source")
load("~/boxHKW/21S/DH/local/SPUND/corpuslx/stefanowitsch/HA/data/sbc.corpus.df.deprel.ann.RData")
#load("/volumes/ext/boxHKW/21S/DH/local/SPUND/corpuslx/stefanowitsch/HA/data/sbc.corpus.df.deprel.ann.RData")


# build annotated token for concrete /take/, /give/ (/make/ already annotated)
# these annotations are already applied to the actual dataset, the function is not called in script
# the concrete /give/, /take/ objects below are defined manually as occuring in the corpus as objects of or in context with the given lemma. see https://github.com/esteeschwarz/SPUND-LX/blob/main/corpusLX/14015-HA/get-freq-df.R on how these objects were defined.
########################################
# sec 2.

get.light.annotation<-function(corpus.df.deprel){
  concrete.give<-c(1066,2620,10469,20369,20373,20377,31957,41100,45424,45538,48045,50236,51759,52340,52341,54654,56016,60668,
                   61952,64351,67497,69012,70356,71167,74595,75162,76991,77442,77553,81098,81099,81859,81860,94278,
                   96953,99281,99880)
  
  concrete.give.txt<-c("sticker","sweets","antibiotic","gift","iguana","recognition","toothpick","herb","anything","enzyme","cake","lettuce","candy","card","literature","ornament","tape","ticket","pair","clothes","juice","pepper","money","goldfish","machine","cup","kiss","amount","bit","picture","mine","pass","dollar","ten","drink","something","car","lot")
  
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
  q.lemma<-"make|made|making"
  q.lemma<-"give|given|gave"
  lemma<-"make"
  lemma<-"give"
  ###
  concrete.array<-c(concrete.make.txt)
  concrete.array<-c(concrete.give.txt)
  # #  concrete.array
  apply.light<-function(corpus.df.deprel=corpus.df.deprel,q.lemma,lemma,concrete.array){
    corpus.df.deprel$lemma<-gsub("[^a-zA-z']","",corpus.df.deprel$lemma)
    corpus.df.deprel$head_lemma_value<-gsub("[^a-zA-z']","",corpus.df.deprel$head_lemma_value)
    m5<-corpus.df.deprel$lemma==""
    corpus.df.deprel$lemma[m5]<-NA
    m6<-corpus.df.deprel$head_lemma_value==""
    corpus.df.deprel$head_lemma_value[m6]<-NA
    m1<-grepl(q.lemma,corpus.df.deprel$sentence)
    m13<-grepl(lemma,corpus.df.deprel$lemma)
    m14<-grepl(lemma,corpus.df.deprel$head_lemma_value)
    
    sum(m1)
    sum(m13)
    #corpus.df.deprel$sentence[m1]
    #unique(corpus.df.deprel$head_lemma_value)
    length(unique(corpus.df.deprel$head_token_value))
    length(unique(corpus.df.deprel$token))
    #table(corpus.df.deprel$lemma)
    corpus.df.deprel$alt[m1]<-lemma # set concrete instances
    corpus.df.deprel$light[m13]<-1 # set all to light
    lemma
    library(stringi)
    library(purrr)
    concrete.regx<-paste0(concrete.array,collapse = "|")
    concrete.regx<-paste0('(',concrete.regx,')')
    m38<-grepl(concrete.regx,corpus.df.deprel$lemma)
    m41.alt<-corpus.df.deprel$alt==lemma
    #sum(m41)
    corpus.df.deprel$light[m41.alt]<-1
    m42.conc<-corpus.df.deprel$lemma[m41.alt]%in%concrete.array|corpus.df.deprel$token[m41.alt]%in%concrete.array
    sum(m42.conc)
    m43.obj<-corpus.df.deprel$obj[m41.alt][m42.conc]==lemma
    corpus.df.deprel$light[m41.alt][m42.conc][m43.obj]<-0
    #    sum(m40)
    #   corpus.df.deprel$lemma[m41][m39][m40]
    m39.conc.sent<-grepl(concrete.regx,corpus.df.deprel$sentence[m41.alt])
    m40.lemma.alt.sent<-grepl(lemma,corpus.df.deprel$lemma[m41.alt][m39.conc.sent])
    # sum(lemma,corpus.df.deprel$lemma[m39][m40])
    # corpus.df.deprel$light[m38]<-0
    corpus.df.deprel$light[m41.alt][m39.conc.sent][m40.lemma.alt.sent]<-0
    #  stext<-stri_split_boundaries(corpus.df.deprel$sentence,type="word")
    #  stext<-function(x)stri_split_boundaries(x,type="word")
    #  stext.x<-lapply(corpus.df.deprel$sentence, stext)
    #  stext.x[[1]]
    #  stext.m<-function(x)unlist(x)%in%concrete.array
    #  m31<-lapply(stext.x, stext.m)
    # # m31[212351]
    #  m32<-lapply(m31, sum)
    #  m33<-unlist(m32)
    #  m34<-m33>0
    #  sum(m33)
    #  which(m34)
    #  #head(corpus.df.deprel$sentence[m34][m35],30)
    #  m35<-corpus.df.deprel$lemma[m34]%in%lemma
    #  sum(m35)
    #  corpus.df.deprel$light[m34][m35]<-0
    # m36<-corpus.df.deprel$lemma[m34][m35]==lemma
    # head(corpus.df.deprel$sentence[m34][m35][m36])
    # head(corpus.df.deprel$lemma[m34][m35][m36])
    # corpus.df.deprel$light[m34][m35][m36]<-0
    
    #    m31[1]
    # m31<-corpus.df.deprel$sentence%>%stri_split_boundaries(type="word")%in%concrete.array
    # sum(m31)
    # which(m31)
    # corpus.df.deprel$sentence[6292]
    # m31<-concrete.array%in%corpus.df.deprel$sentence)
    #  sum(m3)
    #  m4<-corpus.df.deprel$head_lemma_value[m3]%in%lemma
    #  sum(m4)
    # # head.pos<-corpus.df.deprel[m3,'sbc.id'])
    #  #corpus.df.deprel$sentence[m3][m4]
    #  corpus.df.deprel$light[m3][m4]<-0
    # m16<-corpus.df.deprel$dep_rel[m1]=="root"
    # m17<-corpus.df.deprel$lemma[m1][m16]==lemma
    # sum(m16,na.rm = T)
    # m18<-which(m3[m4])%in%which(m16)
    # m19<-which(m3[m4])[m18]
    # corpus.df.deprel$light[m1][m16][m17]<-1
    # corpus.df.deprel$light[m19]<-0
    #  table(corpus.df.deprel$lemma[m1][m16][m17])
    return(corpus.df.deprel)
  }
  
  corpus.df.deprel<-apply.light(corpus.df.deprel,"make|made|making","make",concrete.make.txt)
  corpus.df.deprel<-apply.light(corpus.df.deprel,"take|took|taken|taking","take",concrete.take.txt)
  corpus.df.deprel<-apply.light(corpus.df.deprel,"give|gave|given|giving","give",concrete.give.txt)
  table(corpus.df.deprel$alt,corpus.df.deprel$light,corpus.df.deprel$head_lemma_value)
  #chk
  return(corpus.df.deprel)
}
# corp<-get.light.2(corpus.df.deprel)
# m<-corp$light==0&corp$lemma=="make"
# sum(m,na.rm = T)
# corp$lemma[m19]

### 14063.after class
### how is corpus.df.deprel?

#corpus.df.deprel<-get.light.annotation(corpus.df.deprel)
# corpus.df.deprel.new<-get.light.annotation(corpus.df.deprel)
# corpus.df.deprel<-corpus.df.deprel.new
############################################################


#############################
#save(corpus.df.deprel,file="~/boxHKW/21S/DH/local/SPUND/corpuslx/stefanowitsch/HA/data/sbc.corpus.df.deprel.ann.RData")



#set<-corpus.df.deprel
library(collostructions)
# get collocation df to feed into collex.covar()
# filter.pos<-list(head_lemma_value=c("make","take","give"),light=1)
# filter.pos
# call collex analysis
# vers<-'lemma'
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
#coll6.2
#save(corpus.df.deprel,file = "~/boxHKW/21S/DH/local/SPUND/corpuslx/stefanowitsch/HA/data/sbc.corpus.df.deprel.ann.RData")
# load("~/boxHKW/21S/DH/local/SPUND/corpuslx/stefanowitsch/HA/data/sbc.corpus.df.deprel.ann.RData")
#############################
### now collex again:
# get df with 3 variables:
# coll6<-get.coll.df(corpus.light.ann,"lemma","head_lemma_value","light",sub=F,na.rm=F)
# coll6<-get.coll.df(corpus.df.deprel,"lemma","head_lemma_value","light",sub=F,na.rm=F)
# coll6.2<-get.collex(coll6,filter.pos = "NOUN",na.rm = T) # light==NA stays NA which lets collex sort them out of computation
# coll6.2<-get.collex(coll6,filter.pos = "NOUN",na.rm = F) # light==NA will be replaced by "n.a." which lets collex calculate them as variant of light > they are part of the computation
# coll6.2.na.rm<-get.collex(coll6,filter.pos = "",na.rm = T)
#coll6.2<-get.collex(coll6,filter.pos = "",na.rm = F)
# collex.eval<-coll6.2
# #save(collex.eval,file = "~/Documents/GitHub/SPUND-LX/corpusLX/14015-HA/data/collex.eval.RData")
# coll6.2
# coll6.2.na.rm
#############
### subset evaluation
# coll6.2[coll6.2$head_lemma=="make",]
# coll6.2[coll6.2$head_lemma=="make"&coll6.2$light==0,]
# coll6.2[coll6.2$head_lemma=="make",]
# coll6.2[coll6.2$head_lemma=="make"&coll6.2$light==1,]
# coll6.2[coll6.2$head_lemma=="make",]
make.array<-c("make","generate","produce","create","build")
# eval1<-coll6.2[coll6.2$head_lemma%in%make.array&coll6.2$light==0,]
# coll6.2[coll6.2$head_lemma=="make",]
# coll6.2[coll6.2$head_lemma=="make"&coll6.2$light==0,]
# eval1<-coll6.2[coll6.2$head_lemma%in%make.array&coll6.2$light==0,]
# make<-sum(eval1$T[eval1$head_lemma=="make"])
# build<-sum(eval1$T[eval1$head_lemma=="build"])
# create<-sum(eval1$T[eval1$head_lemma=="create"])
# produce<-sum(eval1$T[eval1$head_lemma=="produce"])
# generate<-sum(eval1$T[eval1$head_lemma=="generate"])
# eval1
#sum(eval1$T[eval1$head_lemma=="make"])
#barplot(cbind(make,produce,create,build,generate), main="absolute preference in concrete context",ylab="T score sum association strength")
#factor(plotdf$T)
#table(plotdf)
take.array<-c("take","bring","carry")
# eval2<-coll6.2[coll6.2$head_lemma%in%take.array&coll6.2$light==0,]
# take<-sum(eval2$T[eval2$head_lemma=="take"])
# bring<-sum(eval2$T[eval2$head_lemma=="bring"])
# carry<-sum(eval2$T[eval2$head_lemma=="carry"])
# barplot(cbind(bring,carry,take),ylab="T score sum association strength", main="absolute preference in concrete context")
# df<-factor(coll6.2$head_lemma)
# levels(df)
# df<-length(levels(df))
#df<-177
#edge
#p_value_left = pt(q = -0.77, df = 15, lower.tail = TRUE)
# get.p<-function(x)pt(x,df,lower.tail = F)
#get.p<-function(x)pt(x,df,lower.tail = T)
# eval1$p<-unlist(lapply(eval1$T, get.p))
# eval1
# eval2$p<-unlist(lapply(eval2$T, get.p))
# eval2
# #x<-eval1$head_lemma[1]
# sumobs<-function(x)sum(grepl(x,eval1[['head_lemma']]))
# eval1$obs<-unlist(lapply(eval1$head_lemma, sumobs))
# #obs1
# eval1
# plotdf1<-data.frame(lemma=factor(eval1$head_lemma),p=eval1$p,obs=eval1$obs)
# par(las=3)
# boxplot(plotdf1$p~plotdf1$lemma,varwidth=T,outline=F,xlab = "",ylab="p-value of collexeme association strength",main="binding of lemma in concrete noun context")
# plotdf2<-data.frame(lemma=factor(eval2$head_lemma),p=eval2$p)
# eval2$obs<-unlist(lapply(eval2$head_lemma, sumobs))
# par(las=3)
# boxplot(plotdf2$p~plotdf2$lemma,varwidth=T,outline=F,xlab = "",ylab="p-value of collexeme association strength",main="binding of lemma in concrete noun context")
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
# coll6<-corpus.df.deprel.new
# coll6<-corp
corpus.df.deprel.new<-corpus.df.deprel
coll6<-corpus.df.deprel.new
coll6.2.lm<-get.collex(coll6,vers="lemma",filter.pos<-list(head_lemma_value=c("make","take","give"),light=0)
,na.rm = T) # light==NA stays NA which lets collex sort them out of computation
# coll6.2.m<-get.collex(coll6,vers="light",filter.pos<-list(head_lemma_value=c("make","take","give"))
#                     ,na.rm = T) # light==NA stays NA which lets collex sort them out of computation
coll6.2<-get.collex(coll6,vers="light",filter.pos<-list(head_lemma_value=c("make"))
                    ,na.rm = T) # light==NA stays NA which lets collex sort them out of computation
coll6.2.m<-collex.covar.mult(data.frame(head_lemma=coll6$head_lemma_value,lemma=coll6$lemma,light=  coll6$light))
                       # light==NA stays NA which lets collex sort them out of computation
# coll6.2<-get.collex(coll6,vers="head_lemma_value",filter.pos<-list(lemma=c("make"),light=0)
#                     ,na.rm = T) # light==NA stays NA which lets collex sort them out of computation
coll6.2.lm
coll6.2.m
table(coll6.2$SLOT1,coll6.2$SLOT2)
eval3<-coll6.2.m
#t3<-table()
df<-factor(eval3$head_lemma)
levels(df)
df<-length(levels(df))-1
eval3$p<-pt(eval3$T,df,lower.tail = T)
eval3.s<-eval3[eval3$head_lemma%in%c("make","take","give"),]
t8<-table(factor(eval3.s$head_lemma),eval3.s$light)
t8
xt8<-chisq.test(t8)
xt8
l8<-length(coll6$sbc.id)
t8b<-t8/rowSums(t8)
400/l8
text(5,label="text",col=3)
tp<-t((t8/l8))
tp
barplot(tp,main = "concrete/light distribution SBC",legend.text = c("concrete","light"),ylab = "% in corpus",xlab = "lemma")
text(x=1,sum(tp[,1])*1.1,label=round(tp[2,1],6),col=2)
text(x=2,sum(tp[,1])*1.1,label=round(tp[2,2],6),col=2)
text(x=3,sum(tp[,1])*1.1,label=round(tp[2,3],6),col=2)
text(x=0.8,tp[1,1]*1.5,label=round(tp[1,1],6),col=1)
text(x=2,tp[1,2]*1.5,label=round(tp[1,2],6),col=1)
text(x=3.1,tp[1,3]*1.5,label=round(tp[1,3],6),col=1)
barplot(t(t8b),main = "exposure rate SBC")
text(x=0.8,t8b[1,1]*1.5,label=round(t8b[1,1],5))
text(x=2,t8b[2,1]*1.5,label=round(t8b[2,1],5))
text(x=3.1,t8b[3,1]*1.5,label=round(t8b[3,1],5))
make.ice.wr=c("0"=68,"1"=321)
make.ice.sp=c("0"=96,"1"=353)
take.ice.wr=c("0"=62,"1"=85)
take.ice.sp=c("0"=131,"1"=79)
give.ice.wr=c("0"=52,"1"=167)
give.ice.sp=c("0"=105,"1"=227)
ice.sp<-rbind(make=make.ice.sp,take=take.ice.sp,give=give.ice.sp)
ice.sp
t.ice.sp<-ice.sp/rowSums(ice.sp)
barplot(t(t.ice.sp),main = "exposure rate ICE spoken")
abline(0.5,0,3)

ice.wr<-rbind(make=make.ice.wr,take=take.ice.wr,give=give.ice.wr)
ice.wr
t.ice.wr<-ice.wr/rowSums(ice.wr)
barplot(t(t.ice.wr),main = "exposure rate ICE written")
abline(0.5,0,3)
chisq.test(t8)
eval3.l<-eval3[eval3$head_lemma%in%c("make","take","give")&eval3$light==1,]
eval3.c<-eval3[eval3$head_lemma%in%c("make","take","give")&eval3$light==0,]

boxplot(eval3.l$p~factor(eval3.l$head_lemma),outline=F,main="SBC lemma association strength",
        ylab = "p(LOG.LIKE collexeme association strength)",xlab="lemma in context")
legend(2.7,0.6,"light",col = 2)
boxplot(eval3.c$p~factor(eval3.c$head_lemma),outline=F,main="SBC lemma association strength",
        ylab = "p(LOG.LIKE collexeme association strength)",xlab="lemma context",col=2,add = T)
legend(2.7,1,"concrete",col = 2)
abline(0.5,0,3,col=2)


t6<-table(coll6.2.m$head_lemma[coll6.2.m$head_lemma%in%c("make","take","give")],coll6.2.m$light[coll6.2.m$head_lemma%in%c("make","take","give")])
#t6
#chisq.test(t6) # p: 0.8226 > the probability, that this distribution is random, is 82%
#t7<-table(coll6.2.lm$SLOT1,coll6.2.lm$SLOT1)
#chisq.test(t7)
 #xt6<-chisq.test(t6)
#xt6
#xt6$p.value
# df<-factor(coll6.2$head_lemma)
# levels(df)
# df<-length(levels(df))-1
# xt7<-chisq.test(t7)
# get.p<-function(x)pt(x,df,lower.tail = T)
# eval2<-coll6.2
# eval2$p<-get.p(eval2$T)

# dump("xt6",file=dtemp)
# readLines(dtemp)%>%write_clip()
# write_clip(writeLines(xt6))

########################################################################
tempfunc<-function(){
{
t1<-table(corpus.df.deprel.new$light,corpus.df.deprel.new$lemma=="take")
t2<-table(corpus.df.deprel.new$light,corpus.df.deprel.new$lemma=="give")
t3<-table(corpus.df.deprel.new$light,corpus.df.deprel.new$lemma=="make")
table(corpus.df.deprel.new$light,corpus.df.deprel.new$lemma=="take")
table(corpus.df.deprel.new$light,corpus.df.deprel.new$lemma=="give")
table(corpus.df.deprel.new$light,corpus.df.deprel.new$lemma=="make")
table(corpus.df.deprel.new$light,corpus.df.deprel.new$lemma=="take")
table(corpus.df.deprel.new$light,corpus.df.deprel.new$lemma=="give")
table(corpus.df.deprel.new$light)
sum(corpus.df.deprel.new$lemma=="create",na.rm = T)
plotdf<-data.frame(cbind(make.ice.wr=c(68,321),make.ice.sp=c(96,353),take.ice.wr=c(62,85),take.ice.sp=c(131,79),
                         give.ice.wr=c(52,167),give.ice.sp=c(105,227),take.sbc=t1[,2],give.sbc=t2[,2],make.sbc=t3[,2]))
plotdf1<-t(plotdf)
plotdf1<-t(plotdf1)
plotdf
#par(new=T)
par(las=2,lab=c(2,2,5),cex=0.6)
barplot(plotdf1,legend.text = c("concrete use","light use"))
barplot(plotdf1)
#############
### instances concrete vs. light
### Q.1: (Mehl 2021)
i.make.w<-c(concrete=68,light=321) #17% vs. 83% written ICE 
i.make.s<-c(concrete=96,light=353) #spoken ICE
i.take.w<-c(con=62,light=85) 
i.give.w<-c(con=52,light=167)
i.take.s<-c(con=131,light=79) 
i.give.s<-c(con=105,light=227)
"in the written portion of ICE-GB, the light use of each verb is more common than the concrete sense. 
For example, out of the total number of instances of make in all concrete and light uses, 
just over 80% of instances are the light use, and just under 20% are the concrete use."
rownames(plotdf.ann$plot.dist)<-c("concrete","light")
lsbc<-length(corpus.df.deprel$sbc.id)
plotdf.ann<-list(lsbc=lsbc,plot.dist=plotdf1,ann=list(main="distribution of lemmas over corpora",ylab="absolute occurences",
                                       legend.text = c("concrete use","light use")))
rownames(plotdf.ann$plot.dist)<-c("concrete","light")
barplot(plotdf.ann$plot.dist, main=plotdf.ann$ann$main,
        ylab = "absolute occurences",legend.text = plotdf.ann$ann$legend.text)
#save(plotdf.ann,file = "~/Documents/GitHub/SPUND-LX/corpusLX/14015-HA/data/plotdf.ann.RData")
###
#100/plotdf.ann$plot.dist
m<-grep("sbc",colnames(plotdf.ann$plot.dist))
barplot(plotdf.ann$plot.dist[,m]/plotdf.ann$lsbc, main=plotdf.ann$ann$main,
        ylab = "% in corpus",legend.text = plotdf.ann$ann$legend.text)

100/6/100
6/100
}
{
coll6<-corpus.df.deprel.new
coll6.2<-get.collex(coll6,vers="lemma",filter.pos<-list(head_lemma_value=c("make","take","give"),light=0)
                    ,na.rm = T) # light==NA stays NA which lets collex sort them out of computation
coll6.2<-get.collex(coll6,vers="light",filter.pos<-list(head_lemma_value=c("make"))
                    ,na.rm = T) # light==NA stays NA which lets collex sort them out of computation

coll6.2
sum(coll6$lemma=="mistake",na.rm = T)
### lemma/object
filter<-"make"
display.filter<-c("make","take","give")
display.light<-c(0,1)
display.filter<-NULL

length(display.light)
coll.obj.noun<-coll6.obj.n
# save(coll.obj.noun,file = "~/Documents/GitHub/SPUND-LX/corpusLX/14015-HA/data/coll.obj.noun.RData")

get.collex.obj<-function(coll6,display.light=NULL,display.filter=NULL){
coll6.obj<-data.frame(lemma=unlist(coll6$lemma),obj=unlist(coll6$obj),upos=unlist(coll6$upos),light=coll6$light)
coll6.obj.n<-coll6.obj[coll6.obj$upos=="NOUN"&!is.na(coll6.obj$obj),]
  colldf<-data.frame(obj=coll6.obj.n$obj,lemma=coll6.obj.n$lemma,light=coll6.obj.n$light)
  
  if(length(display.light)==0){
    coll6.2<-collex.covar(data.frame(colldf[,1],colldf[,2]),decimals = 3)
  }

    if(length(display.light)>0){
    coll6.2<-collex.covar.mult(colldf,threshold = 1,decimals = 3)
    coll6.2<-coll6.2[coll6.2$light%in%display.light,]
  }
  
    if(length(display.filter)>0){
    coll6.2<-coll6.2[coll6.2[,1]%in%display.filter,]
    }
return(coll6.2)
  }
table(coll6.2$obj[coll6.2$OBS!=0])
  coll6.2<-get.collex.obj(coll6,display.light=c(0,1),display.filter = "make")
  coll6.2<-get.collex.obj(coll6,display.light=NULL,display.filter = c("make","take","give"))
  coll6.2.light<-get.collex.obj(coll6,display.light=c(0))
  table(coll6.2.light$obj)
  coll6.2.obj<-get.collex.obj(coll6,display.light=NULL)
  obj.array<-c(make.array,take.array,"give")
 display.filter<- obj.array
  coll6.2.obj.f<-get.collex.obj(coll6,display.light=c(0,1),display.filter = obj.array)
  #save(coll6.2.light,file = "~/Documents/GitHub/SPUND-LX/corpusLX/14015-HA/data/coll6.2.light.RData")
#save(coll6.2.obj,file = "~/Documents/GitHub/SPUND-LX/corpusLX/14015-HA/data/coll6.2.obj.RData")
coll6.2.light
  coll6.2[coll6.2$SLOT1=="make",]
#if(vers=="lemma"){
library(collostructions)
    colldf.lemma<-data.frame(head_lemma=coll6$head_lemma_value,lemma=coll6$lemma)
coll6.2
#######
# semantic alternatives occuring together
make.array
take.array
make.array
obj.make<-coll6.2.obj[coll6.2.obj$SLOT1%in%make.array,]
sema.make<-obj.make[obj.make$SLOT2%in%obj.make[duplicated(obj.make$SLOT2),][,2],]
make.array
obj.take<-coll6.2.obj[coll6.2.obj$SLOT1%in%take.array,]
sema.take<-obj.take[obj.take$SLOT2%in%obj.take[duplicated(obj.take$SLOT2),][,2],]
coll.sema.1<-list(make=sema.make,take=sema.take)
#save(coll.sema.1,file = "~/Documents/GitHub/SPUND-LX/corpusLX/14015-HA/data/coll.sema.1.RData")
sum(sema.make$COLL.STR.LOGL[sema.make$SLOT1=="make"])
sum(sema.make$COLL.STR.LOGL[sema.make$SLOT1=="make"])
sum(sema.make$COLL.STR.LOGL[sema.make$SLOT1=="make"])
sum(sema.make$COLL.STR.LOGL[sema.make$SLOT1=="make"])
sum(sema.make$COLL.STR.LOGL[sema.make$SLOT1=="make"])
x<-sema.make
y<-make.array
sema.sum<-function(y)y=sum(x['COLL.STR.LOGL'][x['SLOT1']==y])
make.sum<-list(make.array)
make.sum[make.array]<-lapply(y, sema.sum)    
y
make.sum
x<-sema.take
y<-take.array
sema.sum<-function(y)y=sum(x['COLL.STR.LOGL'][x['SLOT1']==y])
take.sum<-list(take.array)
take.sum[take.array]<-lapply(y, sema.sum)    
y
take.sum
coll6
df<-factor(coll6.2.obj$SLOT1)
levels(df)
df<-length(levels(df))
get.p<-function(x)pt(x,df,lower.tail = F)
#get.p<-function(x)pt(x,df,lower.tail = T)
eval1<-sema.make
eval1$p<-unlist(lapply(eval1$COLL.STR.LOGL, get.p))
eval1
eval2<-sema.take
eval2$p<-unlist(lapply(eval2$COLL.STR.LOGL, get.p))
eval2
par(las=3)
eval.make<-eval1
eval.take<-eval2
plotdf.ann$eval.sem[['make']]<-eval.make
plotdf.ann$eval.sem[['take']]<-eval.take
plotdf.ann$eval.sem$make
#save(plotdf.ann,file = "~/Documents/GitHub/SPUND-LX/corpusLX/14015-HA/data/plotdf.ann.RData")

boxplot(eval1$COLL.STR.LOGL~eval1$SLOT1,varwidth=T,outline=F,xlab = "",ylab="LOG.LIKE of collexeme association strength",main="binding of lemma /make/ vs. alternates")
boxplot(eval2$COLL.STR.LOGL~eval2$SLOT1,varwidth=T,outline=F,xlab = "",ylab="LOG.LIKE of collexeme association strength",main="binding of lemma /take/ vs. alternates")
boxplot(eval1$p~eval1$SLOT1,varwidth=T,outline=F,xlab = "",ylab="occurence probability of concrete collexemes",main="preference of lemma /make/ vs. alternates")
boxplot(eval2$p~eval2$SLOT1,varwidth=T,outline=F,xlab = "",ylab="occurence probability index of concrete collexemes",main="preference of lemma /take/ vs. alternates")
### wks.

### concrete objects frequency
make.array<-c("make","generate","produce","create","build")
take.array<-c("carry","bring")
obj.array<-c(make.array,take.array,"give")
display.filter<- obj.array
coll6.2.obj.f<-get.collex.obj(coll6,display.light=NULL,display.filter = obj.array)
coll6.2.obj.f
obj.t<-table(coll6.2.obj.f[,1])
obj.all.t<-obj.t[obj.t!=0]
### concrete objects:
concrete.array<-c("give",concrete.make.txt,concrete.take.txt)
sub.obj.t<-coll6.2.obj.f[coll6.2.obj.f$SLOT2%in%concrete.array,]
conc.obj.t<-table(sub.obj.t[,1])
obj.all.conc.t<-conc.obj.t[conc.obj.t!=0]
obj.eval<-rbind(all.objects=obj.all.t,all.conc.obj=obj.all.conc.t)
obj.eval
barplot(obj.eval)
par(las=3)
barplot(obj.eval,main = "concrete vs. light use over corpus",
        ylab = "absolute occurences",legend.text = c("light","concrete"))
plotdf.ann$obj<-obj.eval
### 

#14064.important TODO: not the verb lemma occurence in context to be tagged light/concrete but the noun object to take/make/give, i.e. in general all nouns that can potentially appear as concrete objects

### chk vs. annis/cwb

annis<-'lemma="take"&lemma=/.*/&head_lemma_value="take"&pos=/NOUN/

&#1 .0,5 #2
&#2_=_#3
&#2_=_#4
'
416

cwb<-'[lemma="take"][]{1,5}[lemma=".*"&head_lemma_value="take"&upos="NOUN"]'
344
corp<-corpus.df.deprel

m<-corp$upos=="NOUN"&corp$head_lemma_value=="take"
sum(m,na.rm = T)
}
  
}