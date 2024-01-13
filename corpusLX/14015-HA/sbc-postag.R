#20240112(13.21)
#14027.create.SBC.postagged.corpus
##################################
#source("https://github.com/esteeschwarz/SPUND-LX/raw/main/corpusLX/14015-HA/14015.concrete-abstract_HA.R"
 
R.1<-"https://www.linguistics.ucsb.edu/research/santa-barbara-corpus"
Q.2<-"https://www.linguistics.ucsb.edu/sites/secure.lsit.ucsb.edu.ling.d7/files/sitefiles/research/SBC/SBCorpus.zip"
Q.3<-"https://www.linguistics.ucsb.edu/sites/secure.lsit.ucsb.edu.ling.d7/files/sitefiles/research/SBC/SBCSAE_chat.zip"
library(utils)
library(stringi)
library(quanteda.textstats)
library(udpipe) # for pos tagging
library(writexl)
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
sbctrn<-paste0(sbctempdir,"/TRN/")
filestrn<-list.files(sbctrn)
filestrn
#trnlist<-list()
trndf<-data.frame(scb=NA,id=NA,text=NA)
for(k in 1:length(filestrn)){
  cat(k,"\n")
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
#trndf$lfd<-1:length(trndf$scb)
#save(trndf,file = "~/boxHKW/21S/DH/local/SPUND/corpuslx/stefanowitsch/HA/data/SCB-df.cpt.RData")
trndf<-trndf.2
rm(trndf.2)
rm(trntemp)
rm(trntemp.2)
rm(trntext)

tok.list<-list()
pos.list<-list()
scb.unique<-unique(trndf$scb)
k<-36
for(k in 1:length(scb.unique)){
  cat(k,"\n")
scb.id<-scb.unique[k]
scb.text<-trndf$text[trndf$scb==scb.id]
clean<-function(x)gsub("[+%?~,-.0-9()=<>@]|\\]|\\[","",x)
clean.s<-function(x)gsub("(^ )","",x)
scb.text.cl<-lapply(scb.text, clean)
scb.text.cl.2<-lapply(scb.text.cl, clean.s)
head(scb.text.cl.2)
scb.text.cl.2[[14]]
#scb.text.cl<-
#scb.text<-gsub("[^a-zA-Z]"," ",scb.text)
trndf.split<-tokens(scb.text.cl.2,remove_numbers = T,remove_punct = T,remove_symbols = T,remove_separators = T,include_docvars = T)
trndf.split<-tokens(tna,remove_numbers = T,remove_punct = T,remove_symbols = T,remove_separators = T,include_docvars = T)
trndf.split[[14]]
scb.text.cl.2[[14]]
#tna.u<-unlist(trndf.split)
sum(is.na(tna.u))
sum(tna.u=="")
sum(grep("[^a-zA-Z]",tna.u))
tna<-trndf.split
tna<-scb.text.cl.2
m<-grep("[^a-zA-Z' ]",unlist(tna))
m<-grep("(')",unlist(tna))
m<-tna==""
sum(m)
m<-tna==" "
ltna<-function(x)length(x)
ltnm<-lapply(tna, length)
m<-ltnm==0
tna<-tna[!m]
sum(m)
tna<-tna[!m]
m<-tna=="H"
sum(m)
tna<-tna[!m]
tna[1]
m<-grepl("_",tna)
sum(m)
tna.m<-tna[!m]
tna.m[1]
#m<-grep("[^a-z -.A-Z?_~,]",tna)
sum(m)
tna[m]
#tna<-scb.text
#sum(is.na(tna))
#tna.u
strtest<-utf8ToInt(unlist(tna))
strutf<-function(x)utf8ToInt(x)
testutf<-lapply(tna, strutf)  
tna[[66]]
m<-is.null(testutf)
sum(m)
tnanul<-lapply(tna, is.null)
m<-tnanul==T
intToUtf8(72)
testutf[m]
tna<-trndf.split
an3<-udpipe_annotate(md,x=tna,tagger = "default",parser = "none")
an3<-udpipe_annotate(md,x=tna.m,tagger = "default",parser = "none")
tna[2]
m<-grep("_",tna)
tna[m]
tna<-tna[!m]
k<-2
scb.ann.list<-list()
for(k in 1:length(scb.unique)){
  cat(k,"\n")
  sbc<-trndf
  scb.id<-scb.unique[k]
  scb.sub<-subset(trndf,trndf$scb==scb.id)
  colnames(scb.sub)[1]<-"doc_id"
  scb.sub$text<-gsub("[+%?~,-.0-9()=<>@]|\\]|\\[","",scb.sub$text)
  scb.sub$text<-gsub("(^ )","",scb.sub$text)
  mode(scb.sub$text)
  sbc.sub.c<-corpus(scb.sub,docid_field = 'doc_id',text_field = 'text',unique_docnames = F)
  an4<-udpipe_annotate(md,x=sbc.sub.c,tokenizer="tokenizer",tagger = "default",trace = 2)
  ###wks.
  an7<-data.frame(an4)
  an7[50:100,]
  an7$paragraph_id<-paste0("doc",scb.id)
  colnames(an7)[2]<-"sbc_id"
xldir<-"~/boxHKW/21S/DH/local/SPUND/corpuslx/stefanowitsch/HA/data/posxl"
ns.df<-paste0(xldir,"/SCB-pos_",scb.id,".xlsx")
write_xlsx(an7,ns.df)
ns.list<-paste0("doc",scb.id)
scb.ann.list[[ns.list]]<-an7
}
#wks.
#save(scb.ann.list,file="~/boxHKW/21S/DH/local/SPUND/corpuslx/stefanowitsch/HA/data/scb.ann.list.RData")
library(tokenizers)
tna.t<-tokenize_words(
  trndf$text,
  lowercase = TRUE,
  stopwords = NULL,
  strip_punct = TRUE,
  strip_numeric = T,
  simplify = FALSE
)
tna.t[[1]]
tna[1]
an3<-udpipe_annotate(md,x=tna.t[[1]])
an3<-udpipe_annotate(md,x=tna)
anno<-function(x)udpipe_annotate(md,x)
tna.ann<-lapply(tna, anno)
todf<-function(x)data.frame(x)
tna.ann.df<-lapply(tna.ann, todf)
tna.ann.df$text3$doc_id
toxl<-function(x)write_xlsx(x,paste0())

xldir<-"~/boxHKW/21S/DH/local/SPUND/corpuslx/stefanowitsch/HA/data/posxl"
for(k in 1:length(tna.ann.df)){
  
  ns.df<-paste0(xldir,"/SCB-pos_",names(tna.ann.df[k]),".xlsx")
  write_xlsx(tna.ann.df[k],ns.df)
  
}
tna.ann.df[2]
tna[1]
names(tna.ann.df[1])
tna.ann$text1$conllu
m<-tna.t==" "
2+3
sum(m,na.rm = T)
m<-is.na(tna.t)
sum(m)
tna.t<-tna.t[!m]
an6<-data.frame(an3)
