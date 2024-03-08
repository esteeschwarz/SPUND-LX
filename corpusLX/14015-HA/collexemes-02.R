dtemp<-tempfile()
load("~/boxHKW/21S/DH/local/SPUND/corpuslx/stefanowitsch/HA/data/sbc.corpus.df.deprel.ann.RData")
#load("/volumes/ext/boxHKW/21S/DH/local/SPUND/corpuslx/stefanowitsch/HA/data/sbc.corpus.df.deprel.ann.RData")
download.file("https://github.com/esteeschwarz/SPUND-LX/raw/main/corpusLX/14015-HA/functions.R",dtemp)
source(dtemp)
#############
library(collostructions)
coll6<-corpus.df.deprel
coll6.2.m<-collex.covar.mult(data.frame(head_lemma=coll6$head_lemma_value,lemma=coll6$lemma,light=  coll6$light))
coll6.2.m
#########
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
t8.100<-t8/rowSums(t8)
t8.100
eval3.s
eval3.o<-eval3.s[eval3.s$lemma%in%concrete.objects,]
######
eval3.o
t8<-table(factor(eval3.o$lemma),eval3.o$head_lemma=="make")
t8.2<-t8[,2]==T
sum(t8[,2])-sum(t8.2)
t8.2<-t8[,2]>1
sum(t8[,2])-sum(t8.2)
t8.2[t8.2]
eval3.cfa<-cfa(eval3.o[,1:2],eval3.o$OBS)
eval3.cfa[duplicated(eval3.cfa$table$label),]
mdup<-function(x)grep(x,eval3.cfa$table$label)
mobjects<-lapply(concrete.objects, mdup)
mobjects[1]
gdouble<-function(x)
mdobjects<-lapply(mobjects, length)
mobjects.2<-mobjects[mdobjects>1]
eval3.cfa$table[mobjects.2[[1]],]
#################################
make.array<-c("make","produce","generate","build","create")
eval3.m<-eval3[eval3$head_lemma%in%make.array,]
eval3.cfa.m<-cfa(eval3.m[,1:2],eval3.m$OBS)
mdup<-function(x)grep(x,eval3.cfa.m$table$label)
mobjects<-lapply(concrete.objects, mdup)
mobjects[1]
#gdouble<-function(x)
  mdobjects<-lapply(mobjects, length)
mobjects.2<-mobjects[mdobjects>1]
eval3.cfa.m$table[mobjects.2[[8]],]
library(stringi)
gobj<-function(x)stri_split_boundaries(eval3.cfa.m$table$label[1])

uobj<-stri_split_boundaries(eval3.cfa.m$table$label,simplify = T)
head(uobj)
uobj.c<-gsub("[^a-z]","",uobj[,2])
sum(concrete.objects%in%uobj.c)
uobj.d<-uobj.c[uobj.c%in%concrete.objects]
mdup<-function(x)which(uobj.c%in%x)
#mdup<-function(x)which(x%in%uobj.c)
mobjects<-lapply(uobj.c, mdup)
mobjects
mu<-unlist(mobjects)
#gdouble<-function(x)
mdobjects<-lapply(mobjects, length)
mobjects.2<-mobjects[mdobjects>1]
eval3.cfa.m$table[mobjects.2[[3]],]
eval3.cfa.m$table[mu,]
