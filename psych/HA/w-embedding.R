# 20250729(16.03)
# 15314.word embeddings essai
# add token-corpus similarity covar to distance df
##################################################
library(text)
library(dplyr)
#library(tibble)
#install.packages("RSpectra") # text fail from source
# Initialize text package (this will install Python dependencies if needed)
#text::textrpp_install()
#text::textrpp_initialize()

# Example corpus
corpus <- c(
  "The dog ran quickly through the park",
  "A canine sprinted rapidly across the field", 
  "The cat walked slowly down the street",
  "Birds fly high in the sky",
  "The puppy played energetically in the yard",
  "Felines move gracefully through gardens",
  "Animals need water and food to survive",
  "The veterinarian examined the sick animal"
)
corpus <- c(
  "The dog ran quickly through the park",
  "A canine sprinted rapidly across the field", 
  "The cat walked slowly down the street",
  "Birds fly high in the sky",
  "The puppy played energetically in the yard",
  "Felines move gracefully through gardens",
  "Animals need water and food to survive",
  "The veterinarian examined the sick animal",
  "The windows of the van were very dirty",
  "and the author also writes books about Gustav Mahler.",
  "but mainly cats do eat mouse."
)
tx.dir<-paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/stef_psych/data/txt/15303/")
f<-list.files(tx.dir)
fns<-paste0(tx.dir,f)
fns<-fns[grep("\\.txt",fns)]
# load corpus db complete, annotated
#load(paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/stef_psych/dcorpus.df.cpt-012.RData"))
# load(paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/stef_psych/eval-012.RData")) #qltdf

### notes:
# we want to get a similarity score for determined nouns in corpus, per condition. the conditions are already
# available as covar in the df. so for each noun with matching condition:
# 1. get url range
# 2. get sim score for that noun vs. the range: expresses if a noun more or less fits semantically
# within the range=corpus or if its out-of-context.
# 3. in the mixed model add covar as random factor or somehow scale as continuos var

#######################################
#corpus<-paste0(corpus,collapse = ". ")
corpus<-readLines(fns[1])
# Create embeddings for the entire corpus
get.embed<-function(corpus,m){
  corpus<-paste0(corpus[m],collapse = ". ")
  corpus
  
embeddings <- textEmbed(corpus, 
                       model = "sentence-transformers/all-MiniLM-L6-v2")
}
target_word<-"dog"
get.score<-function(target_word,embeddings){
  
  # corpus<-paste0(corpus[m],collapse = ". ")
  # corpus
  # Create embeddings for the entire corpus
  # embeddings <- textEmbed(corpus, 
  #                         model = "sentence-transformers/all-MiniLM-L6-v2")
  # Function to find semantic references of a target word
find_semantic_references <- function(target_word, embeddings) {
  
  # Create embedding for target word
  target_embedding <- textEmbed(target_word, 
                               model = "sentence-transformers/all-MiniLM-L6-v2")
  
  # Calculate cosine similarity between target and corpus
 similarities <- textSimilarity(target_embedding$texts$texts, embeddings$texts$texts)
}
return(find_semantic_references(target_word,embeddings))
}
corpus
m<-1:length(corpus)
#m<-c(1:9,11)

#similarities<-get.score("car",embeddings,m)
corpus
tokens<-unique(unlist(strsplit(corpus[m]," "))) # for within-corpus consistency
tokens
#tokens<-unique(unlist(strsplit(corpus," ")))
#tokens<-unique(unlist(strsplit(corpus[10]," ")))
library(pbapply)
tokens<-c("cats","dogs","food") # for single token score
#tokens<-c("hare")
embeddings<-get.embed(corpus,m)
###############################
tokens<-c("depression")
tokens<-c("schizophrenia","depression","book","car","dog")
t.score<-pblapply(tokens, function(x){
  s<-get.score(x,embeddings)
})
get.m.score<-function(t.score,tokens){
sim.df<-data.frame(token=tokens,score=unlist(t.score))
sim.df<-sim.df[order(sim.df$score,decreasing = T),]
eval1<-mean(sim.df$score)
return(sim.df)
}
eval3<-get.m.score(t.score,tokens)
#wks
### now realtime
mdf<-data.frame(qid=1:10,target=NA,condition=NA,upos=NA,det=F,m=NA)
mdf[1,]<-c(1,"obs","b","NOUN",T,1)
m<-1
get.text<-function(qltdf,tdba.1,mdf,m){
mdf1<-mdf[m,]
mdf1
um<-qltdf$q==mdf1$condition&qltdf$target==mdf1$target&qltdf$det==mdf1$det&qltdf$upos==mdf1$upos
u<-qltdf$url[um]
u<-unique(u)
i<-as.double(mdf1$m)
ux<-u[i]
r1<-tdba.1$url_t==ux
t1<-paste0(tdba.1$token[r1],collapse = " ")
l<-qltdf$lemma[um]
l<-unique(l)
return(list(t=t1,lemmas=l))
}
t1<-get.text(qltdf,tdba.1,mdf,1)
###wks
embeddings<-get.embed(t1$t,1)
tokens<-t1$lemmas
get.t.score<-function(tokens,embeddings){
t.score<-pblapply(tokens, function(x){
  s<-get.score(x,embeddings)
})
return(t.score)
}
get.m.score<-function(t.score,tokens){
  sim.df<-data.frame(token=tokens,score=unlist(t.score))
  sim.df<-sim.df[order(sim.df$score,decreasing = T),]
  eval1<-mean(sim.df$score)
  return(sim.df)
}
evalt1<-get.m.score(t.score,tokens)
### wks.
# now new, apply on basedata
url.u<-unique(tdba.1$url_t)
tdba.1$ld<-NA
tdba.1$embed.score<-NA
u<-1
rm(qltdf)
for(u in 1:length(url.u)){
  cat("\rprocessing ",u,"/",length(url.u))
  url<-url.u[u]
  r1<-tdba.1$url_t==url
  t1<-tdba.1$token[r1]
  t1u<-unique(t1)
  n1<-tdba.1$upos=="NOUN"
  r1w<-which(r1)
  n1w<-which(n1)
  r2<-r1w[r1w%in%n1w]
  l1<-tdba.1$lemma[r2]
  l1u<-unique(l1)
  ld<-length(t1u)/length(t1)
  tdba.1$ld[r1]<-ld
  t2<-paste0(t1,collapse = " ")
  embedd<-get.embed(t2,m)
  t.score<-get.t.score(l1u,embedd)
  t.s.df<-get.m.score(t.score,l1u)
  for(t in 1:length(t.s.df$token)){
    tok<-t.s.df$token[t]
    r3<-tdba.1$lemma[r2]%in%tok
    tdba.1$embed.score[r2[r3]]<-t.s.df$score[t]
  }
  
}
#save(tdba.1,file=paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/stef_psych/dcorpus.df.cpt-012b.RData"))

# add embed score to qltdf
load(paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/stef_psych/dcorpus.df.cpt-012b.RData"))
load(paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/stef_psych/dcorpus.df.cpt-011.RData"))
load(paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/stef_psych/dcorpus.df.cpt-012c.RData")) #wt all tokens included

load(paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/stef_psych/eval-012.RData")) #qltdf
m1<-!is.na(tdba.1$embed.score)
sum(m1)
m1w<-which(m1)
head(tdba.1$pos[m1w])
mode(qltdf$pos)<-"double"
mode(tdba.1$pos)<-"double"
p1<-qltdf$pos
m2<-tdba.1$pos%in%p1
sum(m2)
head(p1)
head(tdba.1$pos)
head(tdba.1$upos[p1])
head(qltdf$upos)
m3<-!is.na(tdba.1$upos[p1])
head(p1)
p1[max(p1)]
sum(m3)

tdba<-tdba.1.15303.sm
#l1<-length(tdba.1$target)
#tdba<-rbind(tdb$obs,tdb$ref)
#tdba$run<-NA
#tdba$run[1:1012759]<-1
#tdba$run[1012760:(length(tdba$token))]<-2
tdba.n<-tdba.1[tdba.1$upos=="NOUN",]
p1<-qltdf$pos
head(tdba.n$pos[p1])
head(tdba.n$upos[p1])
#wks.: positions for df-012 in qltdf match positions in score df
######
# now get score into qltdf
length(p1)
qltdf$embed.score<-NA
t1<-!is.na(tdba.n$embed.score)
t1w<-which(t1)
sum(t1)
tdb2<-tdba.n[t1,]
l1<-qltdf$lemma
l1u<-unique(l1)
u1<-qltdf$url
u1u<-unique(u1)
u2<-tdba.n$url_t[t1]
u2u<-unique(u2)
l2<-tdba.n$lemma[t1]
l2u<-unique(l2)
l<-1
for(l in t1w){
  print(l)
  u<-tdba.n$url_t[l]
  l<-tdba.n$lemma[l]
  e<-tdba.n$embed.score[l]
  if(!is.na(u)&!is.na(l)&!is.na(e)){
    r1<-qltdf$lemma==l&qltdf$url==u
    r1w<-which(r1)
    cat(l,u,e,r1w,"\n")
  
  qltdf$embed.score[r1w]<-e
  }
}

save(qltdf,file= paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/stef_psych/eval-012d.RData"))

mean(qltdf$embed.score[qltdf$target=="obs"],na.rm = T)

for (k in 1:length(p1)){
  
  p<-p1[k]
  print(k)
  tdburl<-unique(tdb2$url_t[p])
  r<-qltdf$url==tdburl
  rw<-which(r)
  if(sum(r,na.rm = T)>0)
    qltdf$embed.score[rw]<-tdb2$embed.score[p]
}

### new, only fetch scores for distanced nouns
l1<-qltdf$lemma
l1u<-unique(l1)
u1<-qltdf$url
u1u<-unique(u1)
# matrix of unique nouns in unique urls
# simply get lemma-url pairs (collocations)
# library(collostructions)
# freq.list(data.frame(factor(qltdf$lemma),factor(qltdf$url)))
# fl<-freq.list(qltdf$lemma)
# ul<-freq.list(qltdf$url)
# fc<-join.freqs(fl,ul)
t1<-table(qltdf$lemma,qltdf$url)
t2<-t1[order(t1,decreasing = T)]
head(t1)
t2<-as.data.frame(t1)
colnames(t2)<-c("lemma","url","freq")
t3<-t2[t2$freq>0,]
get.text<-function(tdba.1,ux){
  r1<-tdba.1$url_t==ux
  t1<-paste0(tdba.1$token[r1],collapse = " ")
#  l<-qltdf$lemma[um]
 # l<-unique(l)
  return(t1)
}
#t1<-get.text(qltdf,tdba.1,mdf,1)
library(pbapply)
t1.l<-pblapply(t3$url,function(x){
  u<-x
  t1<-get.text(tdba.1,u)
})
u1u<-unique(t3$url)
t2.l<-pblapply(u1u,function(x){
  u<-x
  t1<-get.text(tdba.1,u)
})

length(t1.l)
tna<-lapply(t1.l,function(x){
  return(is.na(x))
})
sum(unlist(tna))
t1.l[[1]]
  ###wks
  embeddings<-pblapply(t1.l,function(x){
    e<-get.embed(x,1)
  })
  
  tokens<-t1$lemmas
  

