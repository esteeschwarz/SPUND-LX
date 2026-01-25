library(quanteda)
dfmat2 <-
  matrix(c(1,1,2,1,0,0, 1,1,0,0,2,3),
         byrow = TRUE, nrow = 2,
         dimnames = list(docs = c("document1", "document2"),
                         features = c("this", "is", "a", "sample",
                                      "another", "example"))) |>
  as.dfm()
dfmat2
docfreq(dfmat2)
docfreq(dfmat2, scheme = "inverse")
docfreq(dfmat2, scheme = "inverse", k = 1, smoothing = 1)
docfreq(dfmat2, scheme = "unary")
docfreq(dfmat2, scheme = "inversemax")
docfreq(dfmat2, scheme = "inverseprob")

# library(devtools)
# install_github("skeptikantin/collostructions")

library(collostructions)
btt.f<-lapply(btt.summaries$summary,function(x){
  t<-strsplit(x," ")
  freq.list(unlist(t))
})
dfmat2<-matrix
library(dplyr)
library(tidyr)
#install.packages("tidytext")
library(tidytext)
df<-btt.summaries
# Add corpus labels for binding
df_human <- df %>%
  mutate(corpus = "human") %>%
  rename(text = text)

df_gpt <- df %>%
  mutate(corpus = "gpt") %>%
  rename(summary = text)
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
# Compute raw document frequency per word-corpus

# dfm1<-dfm(tokens(df_combined$text))
# dfm.stem<-dfm_wordstem(dfm1)
# head(stemdf[[1]][1])
# tokens$stem<-stemdf
stops<-stopwords("de")
m<-tokens$word%in%stops
tokens.r<-tokens[!m,]
df_freq <- tokens.r %>%
  group_by(target, word) %>%
  summarise(docs_with_word = n_distinct(id), .groups = "drop") %>%
  mutate(total_docs = length(unique(df_combined$id)))  # N same for both corpora
df_freq <- tokens.r %>%
  group_by(target, word) %>%
  summarise(docs_with_word = n_distinct(id), .groups = "drop") %>%
  mutate(total_docs = length(unique(df_combined$date)))  # N same for both corpora

# Laplace smoothing: p_w = (docs_with_word + 1) / (total_docs + 1)
df_freq <- df_freq %>%
  mutate(p = (docs_with_word + 1) / (total_docs + 1))
head(df_freq)
dffh<-df_freq[df_freq$target=="human",]
dffg<-df_freq[df_freq$target=="gpt",]
dffh$word[which.max(dffh$p)]
dffg$word[which.max(dffg$p)]

