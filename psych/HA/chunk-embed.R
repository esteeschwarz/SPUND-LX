
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
df<-c.obs.c
token_col<-"token"
doc_col<-"uid"
make_ngrams_df <- function(df, n = 2, doc_col = "uid", token_col = "token", pos_col = NULL) {
  # df: data.frame with at least doc and token columns (ordered by doc and position)
  stopifnot(is.data.frame(df), n >= 1)
 # docs <- split(df[[token_col]], df[[doc_col]])
  docs <- split(
    df[[token_col]],
    factor(df[[doc_col]], levels = unique(df[[doc_col]]))
  )
  out_list <- vector("list", length(docs))
  idx <- 1L
  for (d in names(docs)) {
    toks <- docs[[d]]
    L <- length(toks)
    if (L >= n) {
      starts <- seq_len(L - n + 1)
      ngrams <- vapply(starts, function(i) paste(toks[i:(i + n - 1)], collapse = " "), character(1))
      out_list[[idx]] <- data.frame(doc = rep(d, length(ngrams)),
                                    start = starts,
                                    ngram = ngrams,
                                    stringsAsFactors = FALSE)
      idx <- idx + 1L
    } else {
      # optionally produce zero-row data.frame, skip by leaving NULL
    }
  }
  if (idx == 1L) return(data.frame(doc=character(), start=integer(), ngram=character(), stringsAsFactors = FALSE))
  do.call(rbind, out_list[seq_len(idx - 1L)])
}
# Base-R version
make_ngrams_df <- function(df, n = 2, doc_col = "uid", token_col = "token", pos_col = NULL) {
  stopifnot(is.data.frame(df), n >= 1)
  # create a position column if none provided (assumes current row-order is desired within each doc)
  temp_pos <- FALSE
  if (is.null(pos_col)) {
    df$..pos_temp <- ave(seq_len(nrow(df)), df[[doc_col]], FUN = seq_along)
    pos_col_used <- "..pos_temp"
    temp_pos <- TRUE
  } else {
    pos_col_used <- pos_col
  }
  # order by doc and position
  df2 <- df[order(df[[doc_col]], df[[pos_col_used]]), , drop = FALSE]
  docs <- split(df2[[token_col]], df2[[doc_col]])
  out <- vector("list", length(docs))
  oi <- 1L
  for (dname in names(docs)) {
    toks <- docs[[dname]]
    L <- length(toks)
    if (L >= n) {
      starts_idx <- seq_len(L - n + 1)
      ngrams <- vapply(starts_idx, function(i) paste(toks[i:(i + n - 1)], collapse = " "), character(1))
      orig_positions <- df2[df2[[doc_col]] == dname, pos_col_used]
      start_positions <- orig_positions[starts_idx]
      out[[oi]] <- data.frame(doc = dname, start = start_positions, ngram = ngrams, stringsAsFactors = FALSE)
      oi <- oi + 1L
    }
  }
  if (oi == 1L) res <- data.frame(doc = character(), start = integer(), ngram = character(), stringsAsFactors = FALSE) else
    res <- do.call(rbind, out[seq_len(oi - 1L)])
  res <- res[order(res$doc, res$start), ]
  if (temp_pos) df$..pos_temp <- NULL
  res
}

# Example usage
df <- data.frame(doc = c(rep("d1",5), rep("d2",4)),
                 pos = c(1:5, 1:4),
                 token = c("a","b","c","d","e","x","y","z","w"),
                 stringsAsFactors = FALSE)
make_ngrams_df(df, n = 3, doc_col = "doc", token_col = "token", pos_col = "pos")
m<-grepl("[^a-zA-Z']",c.obs$token)
sum(m)
sum(c.obs$token=="")
c.obs$token[m]<-gsub("[^a-zA-Z']","",c.obs$token[m])
sum(c.obs$token=="")
c.obs.c<-c.obs[!c.obs$token=="",]
m<-c.obs$token%in%c("!",",",".",";","?","-","(",")")
n5<-make_ngrams_df(c.obs.c, n = 5,pos_col = "pos")
#d1<-get.ngrams(c.obs,5)
library(pbapply)
e1<-pblapply(s1$lemma,function(x){
  e<-get.embeds(x)
})
# 17s
e2<-pblapply(n5$ngram,function(x){
  e<-get.embeds(x)
})
e<-get.embeds(n5$ngram[1])

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
