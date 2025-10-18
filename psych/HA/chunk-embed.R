
source(knitr::purl("paper/prelim.Rmd", documentation = 0))

#source(paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/psych/HA/eval-003.R"),echo = F)
source(paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/psych/HA/api-ollama.R"),echo = F)

c.obs<-tdb$obs
c.ref<-tdb$ref
uid.o<-unique(c.obs$uid)
uid.o<-uid.o[uid.o!=""]
s1<-c.obs[c.obs$uid==uid.o[1],]
length(unique(s1$lemma))
uid.r<-unique(c.ref$uid)
uid.r<-uid.r[uid.r!=""]
s2<-c.ref[c.ref$uid==uid.r[1],]
s1<-lemma.reduce(s1)
s2<-lemma.reduce(s2)

bigrams <- c.obs %>% group_by(uid) %>% mutate(tok = lead(token)) %>% filter(!is.na(tok)) %>% transmute(bigram = paste(token, tok))
bigrams

library(dplyr)
library(purrr)
c.obs$pos<-1:length(c.obs$token)
df<-c.obs
n<-3
get.ngrams <- function(df, n = 3) {
  idxs <- seq_len(n) - 1
#  df %>%
#    group_by(uid) %>%
 #   arrange(pos) %>%
  #  mutate(across(all_of(sprintf("lead_%d", idxs)), ~lead(token, .x), .names = "lead_{col}")) -> tmp
  # simpler: create n columns using map
  leads <- map(idxs, ~lead(df$token, .x))
  tibble(ngram = map_chr(seq_along(df$token), 
                         ~ if (any(map_lgl(leads, ~is.na(.x[.y])) ) ) NA_character_ else 
                           paste(c(df$token[.x], map_chr(leads, ~ .x[.x])), collapse = " ")))
}

d1<-get.ngrams(c.obs,3)
library(pbapply)
e1<-pblapply(s1$lemma,function(x){
  e<-get.embeds(x)
})
# 17s
l1<-s1$lemma
get.score(e1[[1]],e1[[2]])
x<-e1[[1]]
f1<-pblapply(seq_along(1:length(e1)),function(x,i){
s<-c()
f1<-list(lemma=l1,s=NA)
f2<-list()
unique(s1$upos)
i<-1
r<-10
for(i in 1:length(e1)){

  p<-s1$upos[i]
  # s<-c()
#  if(p=="NOUN"){
  for(k in 1:length(e1)){
    s[k]<-get.score(e1[[i]],e1[[k]])
  }
  f2[[i]]<-s
 # }
}
f1$s<-f2
f1$p<-s1$upos
fc<-3
s2<-pblapply(f1$s,function(x){
  m<-max(x)
  md<-median(x)
  sd<-sd(x)
  mp<-length(x)/2
  mi<-x[order(x)]
  mi<-mi[mp:(mp+150)]
  l<-which(x>max(mi))
})
s1$lemma[l]
md
x
mi<-x[order(x)]
mp<-length(x)/2
mi<-mi[mp:(mp+10)]

range(x)
md*md+md*md
x<-f1$s[[1]]

  return(s)
})

f1[[2]]
f1<-s
fe<-f1[[2]]

#f2<-which(!is.null(f1))
f1w1<-which(fe==1)
f1w2<-which(fe>0.7)
l1[f1w2]
s1
lu1<-unique(qltdf$lemma[qltdf$upos=="NOUN"])
t1<-unique(c.obs$token[c.obs$lemma=="he"&c.obs$upos=="VERB"])
t1
