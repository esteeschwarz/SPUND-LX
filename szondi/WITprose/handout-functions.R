# 20250127(17.11)
# 15053.wolf.handout.functions
##############################
# calculates posgram statistics of textcorpus
############################################
src.tp<-"~/boxHKW/21S/DH/local/AVL/2024/WIT/ff.txt"
t1<-readLines(src.tp)
library(quanteda)
library(udpipe)
library(collostructions)
library(tidytext)
###############

### create vertical corpus
model<-udpipe::udpipe_load_model("~/Documents/GitHub/SPUND-LX/intLX/createcorp/modeldir/german-gsd-ud-2.5-191206.udpipe")
get.ann.df<-function(x){
  cor.tok<-udpipe::udpipe_annotate(model,x)
  return(as.data.frame(cor.tok))
}
i<-1
tdf<-lapply(seq_along(1:length(t1)),function(i){
  com.vrt.s<-tokenize_sentence(t1[i])
ts<-unlist(com.vrt.s)
com.vrt.t<-udpipe::udpipe_annotate(model,ts)
tok<-unlist(head(com.vrt.t$conllu,20))
df<-as.data.frame(com.vrt.t)
})
tdf2<-data.frame(abind(tdf,along = 1))
# wks.
##########################
get.ngrams<-function(text,n){
  #text<-tdf2$token
  #text<-t1[1]
#  print(text)
 # print("get.ngrams...")
  text_df <- data.frame(line = 1:length(text), text = text, stringsAsFactors = FALSE)
  ngrams_df.2 <- text_df %>%
    unnest_tokens(ngram, text, token = "ngrams", to_lower=F,n=n)
}
t.ngrams.3<-lapply(seq_along(1:length(t1)),function(i,n){
  t<-t1[i]
#  print(head(t))
  ng<-get.ngrams(t,n=3)
})
ng3<-data.frame(abind(t.ngrams.3,along = 1))
t.ng3<-table(ng3$ngram)
nf3<-freq.list(ng3$ngram)
length(ng3$ngram)==length(nf3$FREQ)
# no double 3-grams
###################
t.ngrams.2<-lapply(seq_along(1:length(t1)),function(i,n){
  t<-t1[i]
 # print(head(t))
  ng<-get.ngrams(t,n=2)
})
ng2<-data.frame(abind(t.ngrams.2,along = 1))
t.ng2<-table(ng2$ngram)
nf2<-freq.list(ng2$ngram)
length(ng2$ngram)-length(nf2$FREQ)
print(head(nf2,10))
# F: 48 multiple 2-grams
########################
# posgrams
  tdf2$upos[tdf2$token=="it"]<-NA
  upna<-tdf2[!is.na(tdf2$upos),]
  m<-grepl("[,;:]|it",upna$token)
  sum(m)
  upna<-upna$upos[!m]
ann<-paste0(upna,collapse = " ")
  posg3<-get.ngrams(ann,n=3)
nf.p3<-freq.list(posg3$ngram)
posg4<-get.ngrams(ann,n=4)
nf.p4<-freq.list(posg4$ngram)
posg5<-get.ngrams(ann,n=5)
nf.p5<-freq.list(posg5$ngram)
nf3.e<-head(nf.p3,10)
nf3.e
nf3.sam<-strsplit(as.character(nf3.e$WORD),split = " ")
nf3.2<-lapply(nf3.sam,toupper)
nf3.2
nfu<-unique(unlist(nf3.2))
nf3.ex<-lapply(seq_along(1:length(nfu)), function(i){
  t<-tdf2$token[tdf2$upos==nfu[i]]
  tf<-freq.list(t)
#  tf<-tf[tf$WORD!="it",]
  tout<-tf$WORD[1]
})
print(nf3.e)
pos.sample<-data.frame(pos=nfu,bsp=unlist(nf3.ex))
pos.sample
#print()
handlist<-list(grams=head(nf2,10),posgrams=head(nf3.e,10),possample=pos.sample)
handlist
ps2<-lapply(seq_along(1:length(pos.sample$pos)), function(i){
sam<-gsub(pos.sample$pos[i],pos.sample$bsp[i],unlist(nf3.2))  
})
i<-1
ps2<-lapply(seq_along(1:length(nf3.2)), function(i){
  sam<-nf3.2[[i]]
  for(k in 1:length(pos.sample$pos)){
    sam<-gsub(pos.sample$pos[k],pos.sample$bsp[k],sam)
   # print(sam)
  }
  return(sam)
})
ps2
#sam
nf3.e$BEISPIEL<-ps2
nf3.e<-nf3.e[,c(1,3,2)]
nf3.e
colnames(nf3.e)<-c("POS-gram","BEISPIEL","FREQ")
colnames(nf2)<-c("2-gram","FREQ")

handlist<-list(grams=head(nf2,10),posgrams=head(nf3.e,10))
handlist
#?stderr
#?
