#20240103(07.42)
#SPUND.corpusLX.stefanowitsch.HA
################################
#study replication Q.1
Q.1<-"Mehl, S. orcid.org/0000-0003-3036-8132 (2018) What we talk about when we talk about corpus frequency: The example of polysemous verbs with light and concrete senses. 
Corpus Linguistics and Linguistic Theory. ISSN 1613-7027 https://doi.org/10.1515/cllt-2017-0039"
R.p23<-"If onomasiological frequency measurements do indeed correlate with elicitation tests, 
potential impact would be immense. Researchers would be able to examine onomasiological frequencies in spoken corpora 
rather than performing elicitation tests. That possibility would facilitate cognitive research into languages and 
varieties around the world, without the necessity of in situ psycholinguistic testing, 
and would also encourage the creation of more spoken corpora. "
###############################################################
### this script runs without local files, all data fetched from online sources.
###############################################################################
R.1<-"https://www.linguistics.ucsb.edu/research/santa-barbara-corpus"
Q.2<-"https://www.linguistics.ucsb.edu/sites/secure.lsit.ucsb.edu.ling.d7/files/sitefiles/research/SBC/SBCorpus.zip"
Q.3<-"https://www.linguistics.ucsb.edu/sites/secure.lsit.ucsb.edu.ling.d7/files/sitefiles/research/SBC/SBCSAE_chat.zip"
library(utils)
library(stringi)
library(quanteda.textstats)
library(quanteda)
library(udpipe) # for pos tagging

#mini:
#udpipepath<-"/volumes/ext/boxHKW/21S/DH/local/SPUND/corpuslx/english-ewt-ud-2.5-191206.udpipe"

#lapsi
udpipepath<-"~/boxHKW/21S/DH/local/SPUND/corpuslx/english-ewt-ud-2.5-191206.udpipe"
### if not yet, the model must be downloaded, comment in above line 
get.udp<-function(){
udpipe_download_model("english",model_dir = tempdir("md"))
mdf<-list.files(tempdir())
mdw<-grep(".udpipe",mdf)
mdfile<-paste0(tempdir(),"/",mdf[mdw])
md<-udpipe_load_model(mdfile)
}
ifelse(exists("udpipepath"),md<-udpipe_load_model(udpipepath),md<-get.udp())
getwd()

#setwd("~/boxHKW/21S/DH/local/SPUND/corpuslx/stefanowitsch/HA")
#tempdir()
#dir.create("data")
sbctemp<-tempfile("SBCtemp.zip")
sbctempdir<-tempdir()
#download.file(Q.2,"SBC.zip")
download.file(Q.2,sbctemp)
#unzip("SBC.zip",exdir = "data")
unzip(sbctemp,exdir = sbctempdir)
#regx<-".([0-9]{1,7}_[0-9]{1,7})."

library(readr)
# # SBC001 <- read_delim("data/TRN/SBC001.trn", 
# #                      delim = "\t", escape_double = FALSE, 
# #                      trim_ws = TRUE,col_names = c("id","spk","text"))
# View(SBC001)
#filestrn<-list.files("data/TRN")
# SBC015 <- read_delim("data/TRN/SBC015.trn", 
#                      delim = "\t", escape_double = FALSE, 
#                      trim_ws = F,col_names = c("id","spk","text"))
# View(SBC014)
sbctrn<-paste0(sbctempdir,"/TRN/")
filestrn<-list.files(sbctrn)
filestrn
#trnlist<-list()
trndf<-data.frame(scb=NA,id=NA,text=NA)
for(k in 1:length(filestrn)){
  cat(k,"\n")
# trnlist[[k]]<-read_delim(paste0("data/TRN/",filestrn[k]), 
#                          delim = "\t", escape_double = FALSE, 
#                          trim_ws = TRUE,col_names = c("id","spk","text"))
trntemp<-read_delim(paste0(sbctrn,filestrn[k]), 
                         delim = "\t", escape_double = FALSE, 
                         trim_ws = TRUE,col_names = c("id","spk","text"))
l1<-length(trntemp)
trntext<-trntemp[,l1]
colnames(trntext)<-"text"
trntemp.2<-data.frame(scb=k,id=1:length(trntext$text),text=trntext)
  
trndf<-rbind(trndf,trntemp.2)

}

trndf.2<-trndf[2:length(trndf$scb),]
trndf.2$lfd<-1:length(trndf.2$scb)
rownames(trndf.2)<-trndf.2$lfd
trndf$lfd<-1:length(trndf$scb)
#save(trndf,file = "~/boxHKW/21S/DH/local/SPUND/corpuslx/stefanowitsch/HA/data/SCB-df.cpt.RData")
m1<-grep("tak|took",trndf$text) #take:415,tak:478 obs.
trn.take<-cbind(trndf[m1,],"concrete"=0,"light"=1)
m2<-grep("made|make|making",trndf$text) #take:415,tak:478 obs. #mak
trn.make.2<-cbind(trndf[m2,],"concrete"=0,"light"=1) #430
m3<-grep("give|gave|giving",trndf$text) #take:415,tak:478 obs.
trn.give<-cbind(trndf[m3,],"concrete"=0,"light"=1) #235
### wks., wonderful. now annotate for concrete/light use
######################################
### count instances concrete vs. light
### Q.1: (Mehl 2021)
i.make.w<-c(concrete=68,light=321) #17% vs. 83% written ICE 
i.make.s<-c(concrete=96,light=353) #spoken ICE
i.take<-c(con=62,light=85) 
i.give<-c(con=52,light=167) 
###########################
#m.ns<-make.l.1$id


getwd()
trndf_sf<-trndf # save created, load only annotations from github
dtemp<-tempfile()
# download.file("https://github.com/esteeschwarz/SPUND-LX/raw/main/corpusLX/14015-HA/data/trn.make.cpt.RData",dtemp)
# load(dtemp)
# download.file("https://github.com/esteeschwarz/SPUND-LX/raw/main/corpusLX/14015-HA/data/SCB-df.cpt.RData",dtemp)
# load(dtemp)
# #load(dtemp)
# download.file("https://github.com/esteeschwarz/SPUND-LX/raw/main/corpusLX/14015-HA/data/light.ann.make.RData",dtemp)
# load(dtemp)
### B
download.file("https://github.com/esteeschwarz/SPUND-LX/raw/main/corpusLX/14015-HA/data/SBC.ann.df.RData",dtemp)
load(dtemp)
###
### B
get.ann.x<-function(scb,ann.df){
  trndf.lm<-cbind(scb,ann.df)
}
### B
trndf.lm<-get.ann.x(trndf.2,scb.ann.df)
###

### B
m4<-trndf.lm$light==1&trndf.lm$alt=="make"
sum(m4,na.rm = T)
l.light<-sum(m4,na.rm = T)
l.conc<-sum(trndf.lm$light==0&trndf.lm$alt=="make",na.rm = T)
i.make.m<-c(concrete=l.conc,light=l.light)
i.make.w[2]/(i.make.w[1]+i.make.w[2])
i.make.s[2]/(i.make.s[1]+i.make.s[2])
i.make.m[2]/(i.make.m[1]+i.make.m[2]) # 29 vs 71%
i.make.m
i.make.s
i.make.w
i.make.m
# barplot(cbind(ICE.w=i.make.w,ICE.sp=i.make.s,SBC.sp=i.make.m),main="distribution: lemma /make/",beside=T,legend.text = c("concrete use","light use"))
### wks.
### semantic alternates of concrete /make/ (p.14)
###
### B >
trndf_sf<-trndf
trndf<-trndf.lm
get.alt<-function(altregex,alt){
m1<-grep(altregex,trndf$text)
trn.temp<-cbind(trndf[m1,],alt=alt,light=0)
trn.alt<-rbind(trn.alt,trn.temp)
}
m1<-c("(generat(e|ing|ed))[^generator]","generate")
m2<-c("(construct(ing|ed))[^constructor]","construct")
m3<-c("(produc(e|ing|ed))[^producer]","produce")
m4<-c("(creat(e|ing|ed))[^creator]","create")
m5<-c("(buil(d|ding|t))[^builder]","build")
m1.m<-grep(m1[1],trndf$text)
trn.temp<-cbind(trndf[m1.m,],alt=m1[2],light=0)
trn.alt<-trn.temp
trn.alt<-get.alt(m2[1],m2[2])
trn.alt<-get.alt(m3[1],m3[2])
trn.alt<-get.alt(m4[1],m4[2])
trn.alt<-get.alt(m5[1],m5[2])

trndf.all<-trndf
table(trn.alt$alt)
### B <
### B >
par(las=3)
alt.c.table<-table(trndf.all$alt[trndf.all$light==0])
alt.c.table
# barplot(alt.c.table/sum(alt.c.table)*100,main = "SBC concrete /make/ vs. alternate",ylab = "% over verbforms")
### B <
chk<-trndf.lm$alt=="make"
head(trndf.lm[chk,])
trndf.lm[chk,]
sum(trndf.lm$alt=="make"&trndf.lm$light==1,na.rm = T)
sum(trndf.lm$alt=="make"&(trndf.lm$light==1|trndf.lm$light==0),na.rm = T)
sum(trndf.lm$alt=="make"&(trndf.lm$concrete==1|trndf.lm$concrete==0),na.rm = T)
sum(is.na(trndf.lm$light))
sum(trndf.lm$light[trndf.lm$light==-9],na.rm = T)
sum(trndf.lm$light==-9,na.rm = T)
trntable<-table(trndf.lm$alt[trndf.lm$light==0])
trntable

#par(las=3,cex=0.5,pin=c("1.5","1.5"))
# barplot(trntable[c(1,2,3,4,5,6,7)]/sum(table(trndf.lm$alt))*100,main = "SBC concrete /make/ vs. alternate",ylab = "% in corpus")

#save(trndf.lm,file = "~/Documents/GitHub/SPUND-LX/corpusLX/14015-HA/data/trndf.lm.cpt.RData")
#save(trn.make.cpt,file = "~/Documents/GitHub/SPUND-LX/corpusLX/14015-HA/data/trn.make.cpt.RData")
#save(light.ann.make,file = "~/Documents/GitHub/SPUND-LX/corpusLX/14015-HA/light.ann.make.RData")
#save(smdf,file = "~/Documents/GitHub/SPUND-LX/corpusLX/14015-HA/data/SBC.20-sample.RData")
#14023.class
### binäre logistische regression, anova, mehrdimensionale, nominale daten
### open american national corpus

#14027.Mehl,alternatives,define onomasiological alternates
#load("~/boxHKW/21S/DH/local/SPUND/corpuslx/stefanowitsch/HA/data/trndf.lm.cpt.RData")
#save(trndf.lm,file = "~/boxHKW/21S/DH/local/SPUND/corpuslx/stefanowitsch/HA/data/trndf.lm.cpt.RData")

library(stringi)
df.build<-trndf.lm[trndf.lm$alt=="build",]
df.build$alt.true<-0
#df.build.a<-fix(df.build) # no. not manually. try define objects (collocates) of /make/ first.
set<-trndf.lm
alt<-"manufacture"
alt.g<-"(manufactur(ing|e|ed))"
trndf.lm$verb<-NA
############################
get.coll<-function(set,verb,alt,alt.g){
    m<-set$alt==alt&set$light==0
    wm<-which(m)
    m2<-grepl(alt.g,set$text)
    sum(m)
    sum(m2)
    m2<-which(m2)
    head(set$text[m])
    head(set$text[m2])
    set$verb[m2]<-verb
    set$alt[m2]<-alt
    #sum(m,na.rm = T)
#    m.split<-stri_split_boundaries(set$text[wm],simplify = T)
 #   m.split.l<-stri_split_boundaries(set$text[wm])
    m.split<-tokens(set$text[wm],remove_numbers = T,remove_punct = T,remove_symbols = T,remove_separators = T,split_hyphens = T,include_docvars = T)
    m.split.g<-tokens(set$text[m2],remove_numbers = T,remove_punct = T,remove_symbols = T,remove_separators = T,split_hyphens = T,include_docvars = T)
    tok.clean<-function(x)gsub("[0-9@]","",x)
    m.split<-lapply(m.split, tok.clean)
    
    m.split.g[[1]]
    tok.clean<-function(x)gsub("[0-9@]","",x)
    sum(grep("[0-9]",m.split.g))
    m.split.g.c<-lapply(m.split.g, tok.clean)
    sum(grep("[0-9]",m.split.g.c))
    m.split.g.c[[1]]
    m.split.g<-m.split.g.c
    #    df.split<-data.frame(m.split)
 #   rownames(m.split)<-wm
  #  head(m.split)
    
#    m.split.a<-array(m.split,dim=length(m.split.l),dimnames = m.split.l)
   # df.1c<-data.frame(term=m.split,id=wm)
    #df.split$ID<-wm
    returnlist<-list(set=set,tokens=m.split,tokens.g=m.split.g)
#returnlist$tokens.g[[1]]
returnlist
    #    returnlist<-list(df=df.split,tokens=m.split,df.1c=df.1c)
    return(returnlist)
    return(df.split)
  
}
#split.build<-get.coll(trndf.lm,"build")
# split.make<-get.coll(trndf.lm,"make","make")
# split.build<-get.coll(trndf.lm,"build","(buil(d|t|ding))")
split.take<-get.coll(trndf.lm,"take","take","(take|took|taken|taking)")
split.take$tokens.g[[1]]
#split.make<-get.coll(trndf.lm,"make")
#split.build$tokens.g==split.build$tokens
#library(udpipe)

get.mfw<-function(df){
  
}


# length(split.take$tokens)
 split.df<-split.take
# split.make$tokens.g$text1

get.noun.coll<-function(split.df){
#dfm.make<-dfm(split.make$matrix)
make.freq<-"n.a."
an6<-"n.a."
an6.n<-"n.a."
tok.clean<-function(x)gsub("[0-9@]","",x)

  if(length(split.df$tokens)>0){
    m.split<-split.df$tokens
    sum(grep("[0-9]",m.split))
 #   m.split.c<-lapply(m.split, tok.clean)
  #   sum(grep("[0-9]",m.split.c))
  #   m.split.c[[1]]
  # #  m.split<-m.split.c
    m.split.c<-lapply(split.df$tokens.g, tok.clean)
    sum(grepl("[0-9]",m.split.c))
    m.split.c[[2]]
    #m.split.g<-m.split.g.c
    m.split.ct<-tokens(m.split.c)
    
#  dfm.make.2<-split.df$tokens%>%tokens_remove(stopwords("en"))%>%dfm()
  dfm.make.2<-m.split.ct%>%tokens_remove(stopwords("en"))%>%dfm()
  make.freq<-textstat_frequency(dfm.make.2)
make.freq
make.freq
#########
tna<-make.freq$feature
length(tna)
an3<-udpipe_annotate(md,x=tna,tagger = "default",parser = "none")
an6<-as.data.frame(an3)
unique(an6$upos)
an6.n<-an6$sentence[an6$upos=="NOUN"]
}
m.split.g<-split.df$tokens.g
sum(grepl("[0-9]",m.split.g))
m.split.g.c<-lapply(split.df$tokens.g, tok.clean)
sum(grepl("[0-9]",m.split.g.c))
m.split.g.c[[1]]
m.split.g<-m.split.g.c
m.split.t<-tokens(m.split.g.c)
#dfm.make.g<-split.df$tokens.g%>%tokens_remove(stopwords("en"))%>%dfm()
dfm.make.g<-m.split.t%>%tokens_remove(stopwords("en"))%>%dfm()
dfm.make.g
make.freq.g<-textstat_frequency(dfm.make.g)
tna.g<-make.freq.g$feature
#tna.g<-gsub("[0-9@]",tna.g)
an3.g<-udpipe_annotate(md,x=tna.g,tagger = "default",parser = "none")
#an4<-list(docid=an3$x,pos=an3$conllu)
#load("~/boxHKW/21S/DH/local/SPUND/corpuslx/stefanowitsch/HA/data/SCB-df.ann.RData")
#an5<-as.data.frame(an3$x,an3$conllu)
an6.g<-as.data.frame(an3.g)
unique(an6.g$upos)
an6.n.g<-an6.g$sentence[an6.g$upos=="NOUN"]
if(length(split.df$tokens)==0){
 make.freq<-make.freq.g
 an6<-an6.g
 an6.n<-an6.n.g
}
returnlist<-list(set=split.df$set,freq=make.freq,ann=an6,nouns=an6.n,freq.g=make.freq.g,ann.g=an6.g,nouns.g=an6.n.g)
#an6.n
}
###wks.
### the only valid common associates seem to be "couple", "lot", "water" and "thing" as the rest of the collocates cannot
### appear as objects of /make/ AND /build/ in a reasonable context

#x.build<-n.x.provide
nouns.com<-nouns.com.provide
verb<-"give"
alt<-"provide"
topdf<-trndf.lm
##############
get.n.freq<-function(topdf,x.build,nouns.com,verb,alt){
n.build<-x.build
n.make<-x.build
n.build$freq
nxdf<-n.build$set
sum.verb<-sum(n.build$set$scb[n.build$set$verb==verb],na.rm = T)
#############################################
n.build$nouns
m.build<-n.build$freq$frequency[n.build$freq$feature%in%nouns.com]
m<-(n.build$freq$feature%in%nouns.com)
m.build
#m.build<-n.build$freq.g$frequency[n.build$freq$feature%in%nouns.com]
#m.build
m.make<-n.make$freq$frequency[n.make$freq$feature%in%nouns.com]
m.make
sum.freq.1<-sum(n.make$freq$frequency)
sum.freq.2<-sum(n.build$freq$frequency)
sum.freq.3<-sum.freq.1+sum.freq.2
f.p.1<-sum(m.make)/sum.freq.1
f.p.2<-sum(m.build)/sum.freq.3
###
k<-1
f.array<-array(1:(length(nouns.com)+2))
names(f.array)<-c(nouns.com,"freq","total")
f.array<-f.array*0
f.array
for(k in 1:length(nouns.com)){
  q<-nouns.com[k]
  m1<-topdf$verb==verb
  sum(m1)
  verb
  x.sub<-topdf[m1,]
  m2<-grepl(q,x.sub$text)
  
  f.sub<-sum(m2,na.rm = T)
  m3<-topdf$alt==alt
  sum(m3)
  f.array[k]<-f.sub
  f.array['freq']<-length(x.sub$scb)
  f.array['freq']<-sum(m3)
  f.array['total']<-length(trndf$scb)
  f.array['sub.verb']<-sum(m1)

}
#f.array['f.sub']<-10
m<-which(names(f.array)=='freq')
f.df<-data.frame(cbind(inst=f.array[1:(m-1)],sub.verb=f.array['sub.verb'],sub.alt=f.array['freq'],total=f.array['total']))
f.df$verb<-verb
f.df
#mode(f.df[,2:4])<-"double"
#colnames(f.df)<-c("verb","inst","sub.alt","total")
#f.rel<-f.array/f.array['total']
f.rel<-f.df$inst/f.df$sub.alt/f.df$total
f.df$p<-f.rel
f.df
#f.rel[length(f.rel)]<-f.array[length(f.array)]
#f.rel
#chisq.test(f.array)
# sum.freq.1<-sum(n.make$freq$frequency)
# sum.freq.2<-sum(n.build$freq$frequency)
# sum.freq.3<-sum.freq.1+sum.freq.2
# f.p.1<-get.freq(topdf,verb,alt)[2]/get.freq(topdf,verb,alt)[1]
# f.p.1
# f.p.2<-sum(m.build)/sum.freq.3

return(list(f.rel=f.df,f.abs=data.frame(q1=verb,q2=alt,p.verb=as.double(f.p.1),alt=as.double(f.p.2))))
}

#count these:
nouns.com.1<-c("couple","lot","water","thing") # this doesnt seem to be totally reasonable
nouns.com.2<-"thing"

#nouns.f.1<-get.n.freq(nouns.com.2)
#nouns.f.1
n.x.cr<-get.noun.coll(get.coll(trndf.lm,"make","create","(creat(ed|ing|e))")) # test
n.x.bu<-get.noun.coll(get.coll(trndf.lm,"make","build","(buil(d|t|ding))")) # test
n.x.man<-get.noun.coll(get.coll(trndf.lm,"make","manufacture","(manufactur(ing|e|ed))")) # test
#f1 
n.x.test<-get.coll(trndf.lm,"make","manufacture","(manufactur(ing|e|ed))")
n.x.dev<-get.noun.coll(get.coll(trndf.lm,"make","develop","(develop(ing|e?|ed))")) # test
n.x.take<-get.noun.coll(get.coll(trndf.lm,"take","take","(take|took|taken|taking)"))
n.x.give<-get.noun.coll(get.coll(trndf.lm,"give","give","(give|gave|given|giving)"))
n.x.carry<-get.noun.coll(get.coll(trndf.lm,"take","carry","(carry|carrying|carried)"))
n.x.provide<-get.noun.coll(get.coll(trndf.lm,"give","provide","(provide|provided|providing)"))
###
n.x.take$nouns.g # general collocates
###
### put alt cat
set<-trndf.lm
alt<-"take"
verb<-"take"
get.freq<-function(set,verb,alt){
  m.a<-set$alt==alt
  
  m.v<-set$verb==verb
  f.alt<-sum(m.a)
  f.verb<-sum(m.v)
  return(c(f.verb=f.verb,f.alt=f.alt))
}
f.test<-get.freq(trndf.lm,"take","take")
f.test
k<-1
### feed in verb occurences to main df >
#altarray<- c("provide","carry")
########################################
### TODO:
### define concrete:
c(n.x.provide$nouns,"this","that","the","it") # in trndf.lm$text, subset, fix() for concrete use
#sum() above, f=sum/sum(all)
m<-grepl("give",n.x.give$set$verb) 
print(sum(m))
trndf.lm$verb[m]<-"give"
trndf.lm$alt[m]<-"give"
m<-grepl("provide",n.x.provide$set$alt) 
trndf.lm$alt[m]<-"provide"
m<-grepl("take",n.x.take$set$verb) 
print(sum(m))
trndf.lm$verb[m]<-"take"
trndf.lm$alt[m]<-"take"
print(sum(m))
unique(trndf.lm$alt)
unique(trndf.lm$verb)
m<-grepl("carry",n.x.carry$set$alt) 
print(sum(m))
trndf.lm$alt[m]<-"carry"
m<-grepl("build",trndf.lm$alt) 
print(sum(m))
trndf.lm$verb[m]<-"make"
m<-grepl("construct",trndf.lm$alt) 
print(sum(m))
trndf.lm$verb[m]<-"make"
m<-grepl("produce",trndf.lm$alt) 
print(sum(m))
trndf.lm$verb[m]<-"make"
m<-grepl("generate",trndf.lm$alt) 
print(sum(m))
trndf.lm$verb[m]<-"make"
m<-grepl("create",trndf.lm$alt) 
print(sum(m))
trndf.lm$verb[m]<-"make"
unique(trndf.lm$verb)
trndf.lm$verb[m]<-"take"
unique(trndf.lm$alt)
unique(trndf.lm$verb)
f.take<-get.freq(trndf.lm,"take","carry")
f.take
f.give<-get.freq(trndf.lm,"give","provide")
f.give
m<-n.x.give$nouns.g%in%n.x.provide$nouns.g
sum(m)
n.x.provide$nouns.g[m]
### > no common associates for "produce", "construct", "generate","manufacture","develop"
nouns.com.create<-c("thing","day","cause")
nouns.com.provide<-c("service","period")
nouns.com<-c("service","period")
nouns.com.build<-"thing"
nouns.com.create<-c("thing")
nouns.com.carry<-c("bag","lot","chairs","mother")
###
f.provide<-get.freq(n.x.provide$set,"provide")
f.rel.give<-get.n.freq(trndf.lm,n.x.provide,nouns.com.provide,"give","provide")
f.rel.give$f.abs
f.rel.give$f.rel
f.rel.give<-get.n.freq(trndf.lm,n.x.provide,nouns.com.provide,"give","provide")
f.rel.give$f.abs
f.rel.give$f.rel


nouns.f.1<-get.n.freq(trndf.lm,n.x.cr,nouns.com.create,"make","create")
nouns.f.1
nouns.f.2<-get.n.freq(trndf.lm,n.x.bu,nouns.com.build,"make","build")
nouns.f.2
nouns.f.3<-get.n.freq(trndf.lm,n.x.carry,nouns.com.carry,"take","carry")
nouns.f.3
nouns.f.4<-get.n.freq(trndf.lm,n.x.provide,nouns.com.provide,"give","provide")
nouns.f.4
nouns.f.all<-rbind(nouns.f.1$f.rel,nouns.f.2$f.rel,nouns.f.3$f.rel,nouns.f.4$f.rel)
nouns.f.all
s.inst<-sum(nouns.f.all$inst)
total<-nouns.f.all$total[1]
dif.inst<-total-s.inst
#p.inst<-nouns.f.all$inst*nouns.f.all$sub.alt
#p.inst
#nouns.f.all$q.inst<-nouns.f.all$sub.alt-nouns.f.all$inst
nouns.f.all
#q.ins.other<-sum(nouns.f.all$q.inst)
total
m.other<-trndf.lm$verb=="a-other"
sum.other<-sum(m.other)
#a.other<-c(dif.inst,total-sum(nouns.f.all$inst),total-sum(nouns.f.all$inst),total)
a.other<-c(dif.inst,sum.other,sum.other,total)
a.other<-array(a.other)

#mode(a.other[1:4])<-"double"
#mode(a.other[6:7])<-"double"
a.other['p']<-a.other[1]/total
#a.other['verb']<-"a-other"
a.other
nouns.f.all['a-other',1:4]<-a.other[1:4]
nouns.f.all['a-other',6]<-a.other[5]
nouns.f.all['a-other',5]<-"a-other"
nouns.f.all
library(clipr)
write_clip(nouns.f.all[,1:3])
xy<-nouns.f.all$p[1:8]
labv<-c("create.thing","build.thing","carry.bag","carry.lot","carry.chairs","carry.mother","provide.service","provide.period")
labv
xa<-paste0(nouns.f.all$verb[1:8],"-",labv)
xa
nouns.f.all$label<-c(xa,"n.a.")
nouns.f.all$label<-NA
nouns.f.all
par(las=3)
barplot(nouns.f.all$p[1:8]~nouns.f.all$label[1:8],xlab = "",ylab = "p of verb occurence over corpus")
xy<-nouns.f.all$inst[1:8]
xa<-paste0(nouns.f.all$verb[1:8],"-",rownames(nouns.f.all)[1:8])
par(las=3)
barplot(xy~xa,xlab = "",ylab = "instances of alternate verbs over corpus")
m<-which(rownames(nouns.f.all)=="a-other")
mode(nouns.f.all[m,1:4])<-"double"
nouns.f.all$p[m]<-nouns.f.all$inst[m]/nouns.f.all$total[m]
#n.x.give
#sum(n.x.provide$freq$feature=="service")
#sum(n.x.provide$freq$feature=="period") # 0
# nouns.f.make<-c(make=sum(nouns.f.1['p.verb']+nouns.f.2['p.verb']),create=nouns.f.1['p.alt'],build=nouns.f.2['p.alt'],produce=0,generate=0,construct=0)
# nouns.f.x<-c(make=sum(nouns.f.1['p.verb']+nouns.f.2['p.verb']),create=nouns.f.1['p.alt'],build=nouns.f.2['p.alt'],produce=0,generate=0,construct=0)
nouns.f.cpt<-rbind(nouns.f.1,nouns.f.2,nouns.f.3,nouns.f.4)
nouns.f.cpt
disdf<-cbind(ICE.w=i.make.w,ICE.sp=i.make.s,SBC.sp=i.make.m)
disdf
nouns.f.df<-rbind(cbind(make.create=nouns.f.cpt[nouns.f.cpt$q2=="create",c('p.verb')],
                  make.build=nouns.f.cpt[nouns.f.cpt$q2=="build",c('p.verb')],
                  take.carry=nouns.f.cpt[nouns.f.cpt$q1=="take",c('p.verb')],
                  give.provide=nouns.f.cpt[nouns.f.cpt$q1=="give",c('p.verb')]),
                  cbind(make.create=nouns.f.cpt[nouns.f.cpt$q2=="create",c('alt')],
                        make.build=nouns.f.cpt[nouns.f.cpt$q2=="build",c('alt')],
                        take.carry=nouns.f.cpt[nouns.f.cpt$q1=="take",c('alt')],
                        give.provide=nouns.f.cpt[nouns.f.cpt$q1=="give",c('alt')])
                  )
#nouns.f.df<-cbind(make=nouns.f.cpt[nouns.f.cpt$q1=="make",])
nouns.f.df
rownames(nouns.f.df)<-c("verb","alternative")
#barplot(nouns.f.df,main="distribution: lemma /make/",beside=T,legend.text = rownames(nouns.f.df))
#plot(nouns.f.cpt$alt~nouns.f.cpt$p.verb)
### p computation: sum.freq.collocates.alt/sum(sum.freq.collocates.make+sum.freq.collocates.alt)
plot.plots<-function(what){
par(las=3)
    if(what=="dist")
    barplot(cbind(ICE.w=i.make.w,ICE.sp=i.make.s,SBC.sp=i.make.m),main="distribution: lemma /make/",beside=T,legend.text = c("concrete use","light use"))
  if(what=="alt.1")
    barplot(alt.c.table/sum(alt.c.table)*100,main = "SBC concrete /make/ vs. alternate",ylab = "% over verbforms")
  if(what=="alt.2")
    barplot(trntable[c(1,2,3,4,5,6,7)]/sum(table(trndf.lm$alt))*100,main = "SBC concrete /make/ vs. alternate",ylab = "% in corpus")
  if(what=="alt.3")
    barplot(nouns.f.cp,main="semantic alternates w/ equivalent meaning",ylab = "% in corpus")
  if(what=="alt.4")
    barplot(nouns.f.df,main="semantic alternates w/ equivalent meaning",beside=T,ylab = "% in corpus",legend.text = rownames(nouns.f.df))
  
}
save.plotlist<-function(){
  plotlist<-list(dist=cbind(ICE.written=i.make.w,ICE.spoken=i.make.s,SBC.spoken=i.make.m),alt.c.table=alt.c.table,trntable=trntable,nouns.f.cp=NULL,nouns.f.df=nouns.f.df)
  save(plotlist,file = "~/Documents/GitHub/SPUND-LX/corpusLX/14015-HA/data/plotlist.RData")
}
# plotlist.restore<-plotlist

# save(plotlist,file = "~/Documents/GitHub/SPUND-LX/corpusLX/14015-HA/data/plotlist.RData")
# save.plotlist()

 plot.plots("dist")
 plot.plots("alt.1")
 plot.plots("alt.2")
 plot.plots("alt.4")
 # 