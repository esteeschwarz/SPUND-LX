library(quanteda)
# library(devtools)
# install_github("skeptikantin/collostructions")

library(collostructions)
# btt.f<-lapply(btt.summaries$summary,function(x){
#   t<-strsplit(x," ")
#   freq.list(unlist(t))
# })
# dfmat2<-matrix
library(dplyr)
library(tidyr)
#install.packages("tidytext")
library(tidytext)
df<-btt.summaries
# Add corpus labels for binding
# df_human <- df %>%
#   mutate(corpus = "human") %>%
#   rename(text = text)
# 
# df_gpt <- df %>%
#   mutate(corpus = "gpt") %>%
#   rename(summary = text)
df1<-df[,1:2]
df2<-df[,c(1,3)]
df1<-cbind(df1,"human")
df2<-cbind(df2,"gpt")
colnames(df1)<-c("date","text","target")
colnames(df2)<-c("date","text","target")
df_combined <- bind_rows(df1,df2)
library(stringr)
# Tokenize to words (lowercase, remove punctuation/numbers)
df_combined$id<-1:length(df_combined$date)
tokens <- df_combined %>%
  unnest_tokens(word, text, token = "words") %>%
  filter(str_detect(word, "^[a-z]+$")) %>%  # Optional: alphabetic words only
  mutate(word = tolower(word))
stops<-stopwords("de")
stops.m<-c("dass","a","ab")
stops.j<-c(stops,stops.m)
m<-tokens$word%in%stops.j
tokens.r<-tokens[!m,]
# df_freq <- tokens.r %>%
#   group_by(target, word) %>%
#   summarise(docs_with_word = n_distinct(id), .groups = "drop") %>%
#   mutate(total_docs = length(unique(df_combined$id)))  # N same for both corpora
# df_freq <- tokens.r %>%
#   group_by(target, word) %>%
#   summarise(docs_with_word = n_distinct(id), .groups = "drop") %>%
#   mutate(total_docs = length(unique(df_combined$date)))  # N same for both corpora
# ?n_distinct
colnames(tokens.r)
fh<-freq.list(tokens.r$word[tokens.r$target=="human"])
fg<-freq.list(tokens.r$word[tokens.r$target=="gpt"])
fa<-freq.list(tokens.r$word)
fj<-join.freqs(fg,fa)
fs<-fj%>%mutate(p=fg/fa)
### wks., joined frequencies of target=gpt+target=all, score for gpt
head(fs,10)
