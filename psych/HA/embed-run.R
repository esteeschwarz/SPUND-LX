library(text)
library(dplyr)
print("loading datasets...")
#load(paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/stef_psych/dcorpus.df.cpt-012.RData")) # tdba.1
load(paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/stef_psych/eval-012_url-text.RData")) # t2.l
load(paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/stef_psych/eval-012.RData")) #qltdf
print("initializing text::")
text::textrpp_initialize()

t1<-table(qltdf$lemma,qltdf$url)
t2<-t1[order(t1,decreasing = T)]
head(t1)
t2<-as.data.frame(t1)
colnames(t2)<-c("lemma","url","freq")
t3<-t2[t2$freq>0,]

get.embed<-function(corpus,m){
  corpus<-paste0(corpus[m],collapse = ". ")
  corpus
  
  embeddings <- textEmbed(corpus, 
                          model = "sentence-transformers/all-MiniLM-L6-v2")
}
#target_word<-l1u[1]
#target_word
get.score<-function(target_word,embeddings){
  
  tw<-as.character(target_word)
  print(tw)
  write(paste0(Sys.time(),  " || processing word: -",tw,"-"),log.ns,append = T)
  
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
    # target_embedding <- textEmbed("arm",
    #                               model = "sentence-transformers/all-MiniLM-L6-v2")
    # 
    # Calculate cosine similarity between target and corpus
    ifelse(length(target_embedding$texts$texts)>0,
      similarities <- textSimilarity(target_embedding$texts$texts, embeddings$texts$texts),
      similarities<-NA)
  }
  return(find_semantic_references(tw,embeddings))
}
#s1<-get.score(l1u[1],embedd)
library(pbapply)
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
#embedd<-get.embed(t2,m)
# t.score<-get.t.score(l1u,embedd)
# t.s.df<-get.m.score(t.score,l1u)
# for(t in 1:length(t.s.df$token)){
#   tok<-t.s.df$token[t]
#   r3<-tdba.1$lemma[r2]%in%tok
#   tdba.1$embed.score[r2[r3]]<-t.s.df$score[t]
# }
#embeddings<-get.embed(corpus,m)
url.u<-unique(t3$url)
t3$embed.score<-NA
#u<-1
load(paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/stef_psych/embed-211.RData"))
m<-is.na(t3$embed.score)
sum(m)
url.n.done<-t3$url[m]
url.u.2<-unique(url.n.done)
length(url.u)
length(url.u.2)
url.u.sf<-url.u
url.u<-url.u.2
log.ns<-"~/log/embed-log.txt"
u<-1
range.u<-length(url.u)
range.u<-1:15
for(u in 1:length(range.u)){
  cat("\rprocessing ",u,"/",length(range.u))
  write(paste0(Sys.time(),  " || processing url: -",u,"- of -",length(range.u),"-"),log.ns,append = T)
  t2<-t2.l[[u]]
  ut3<-url.u[u]
  embedd<-get.embed(t2,1)
  #embeddings<-embedd
  r1<-t3$url==ut3
  r1w<-which(r1)
  l1u<-t3$lemma[r1w]
  l1u
#  l1<-tdba.1$lemma[r2]
 # l1u<-unique(l1)
  t.score<-get.t.score(l1u,embedd)
  t.s.df<-get.m.score(t.score,l1u)
  for(t in 1:length(t.s.df$token)){
    tok<-t.s.df$token[t]
    r3<-t3$lemma[r1w]%in%tok
    t3$embed.score[r1w[r3]]<-t.s.df$score[t]
  }
  
}
write(paste0(Sys.time(),  " || finished. processed: ",length(range.u)," urls"),log.ns,append = T)

save(t3,file = paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/stef_psych/embed-211.RData"))
