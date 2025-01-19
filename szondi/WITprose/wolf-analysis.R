# 2025011(17.08)
# 15031.false-friends.essai
###########################
# Q reference corpus frequencies: <https://www.ids-mannheim.de/digspra/kl/projekte/methoden/derewo/>
# load into workspace:
fr.ref<-load("/Users/guhl/boxHKW/21S/DH/local/SPUND/corpuslx/DeReKo.freq.ref.RData")
k2<-read.csv("~/Documents/static/server/ada/es/r/knitessai/db/wolfdb003.csv")
k2<-k2$content[k2$book=="FF"]  
#k2
k2
table(names(k1$token))
length(k1$token)
length(unique(k1$token))
head(k1$token,30)
k1.d<-duplicated(k1$token)
k1<-k1[!k1.d,]
length(k1$token)
length(unique(k1$token))
d1<-which(k1.d)
k1$token[31:33]

sum(k1.d)
library(tm)
library(dplyr)

get.keys<-function(){
  # Sample given text
  given_text <- "This is a sample text. This text is for keyword analysis. We do not change anything important in the text but only ugly words."
  #library(readtext)
  #text<-readtext()
  # Sample reference corpus
  #reference_corpus <- "This is a reference corpus. It contains many words. This corpus is used for comparison."
  
  # Create a Corpus object for both texts
 # given_corpus <- Corpus(VectorSource(given_text))
  #reference_corpus <- Corpus(VectorSource(reference_corpus))
  
  #g2<-Corpus(VectorSource(k2$token))
  g2<-Corpus(VectorSource(k2))
  given_corpus<-g2
  # Tokenize and clean the text
  clean_corpus <- function(corpus) {
   # corpus <- tm_map(corpus, content_transformer(tolower)) # no difference: wolf text wo capital letters
    corpus <- tm_map(corpus, removePunctuation)
    corpus <- tm_map(corpus, removeNumbers)
    corpus <- tm_map(corpus, removeWords, stopwords("en"))
    corpus <- tm_map(corpus, stripWhitespace)
    return(corpus)
  }
  
  #c2<-tm_map(k2)
  given_corpus <- clean_corpus(given_corpus)
  #reference_corpus <- clean_corpus(reference_corpus)
  #given_corpus <- clean_corpus(given_corpus)
  
  # Create a Document-Term Matrix
  given_dtm <- DocumentTermMatrix(given_corpus)
  #reference_dtm <- DocumentTermMatrix(reference_corpus)
  
  # Convert to data frames
  given_freq <- as.data.frame(as.matrix(given_dtm))
  # no
  #library(collostructions)
  #given_corpus
  #given_freq<-freq.list(k2$token)
  #reference_freq <- as.data.frame(as.matrix(reference_dtm))
  
  # Sum the frequencies of each token
  given_freq <- colSums(given_freq)
  #reference_freq <- colSums(reference_freq)
  #reference_freq<-k1
  reference_freq<-k1[,c(1,4)]
  ### tolower tokens:
  lowcaps<-lapply(reference_freq$token, tolower)
  reference_freq$token_lc<-lowcaps
  reference_freq.dp<-duplicated(lowcaps)
  sum(reference_freq.dp)
  # Sample dataframe
  df <- data.frame(
    token = c("a", "b", "a", "c", "b", "d"),
    frequency = c(1, 2, 3, 4, 5, 6)
  )
  
  # Merge duplicated tokens by summing their frequencies
  merged_df <- df %>%
    group_by(token) %>%
    summarise(frequency = sum(frequency))
  
  #print(merged_df)
  ref_freq_merged<- reference_freq %>%
    group_by(token_lc) %>%
    summarise(frequency =sum(freq))
  
  head(given_freq)
  head(ref_freq_merged)
  colnames(ref_freq_merged)<-c("token","freq")
  #colnames(reference_freq)<-c("token","freq")
  given_freq <- data.frame(token = names(given_freq), freq = given_freq)
  m<-given_freq$token%in%ref_freq_merged$token
  sum(m)
  tok.out<-given_freq$token[!m]
  tok.out.df<-data.frame(token=tok.out,freq=1)
  colnames(tok.out.df)==colnames(ref_freq_merged)
  ref_freq_plus<-rbind(ref_freq_merged,tok.out.df)
    #jfreq<-join.freqs(given_freq,reference_freq,all = T)
  #c1<-collex.dist(jfreq)
  #c1%>%arrange(desc(COLL.STR.LOGL))
  # Convert to data frames
  #reference_freq <- data.frame(token = names(reference_freq), freq = reference_freq)
  # Merge the frequency data frames
#  freq_comparison <- merge(given_freq, reference_freq, by = "token", all = F)
  freq_comparison <- merge(given_freq, ref_freq_plus, by = "token", all = F)
  colnames(freq_comparison) <- c("token", "given_freq", "reference_freq")
  freq_comparison$token[52]==freq_comparison$token[75]
  # Replace NA values with 0
  freq_comparison[is.na(freq_comparison[,2:3]),2:3] <- 0
  
  # Calculate the keyword score (e.g., log-likelihood ratio)
  freq_comparison <- freq_comparison %>%
    mutate(keyword_score = (given_freq + 1) / (reference_freq + 1))
  
  # Sort by keyword score
  freq_comparison <- freq_comparison %>%
    arrange(desc(keyword_score))
  length(freq_comparison$token)
  length(unique(freq_comparison$token))
  
  # Print the top keywords
  print(freq_comparison)
}
get.keys()
# wks.

######
# how:
# 1. get annotated df, define pos pattern, compare to poetry/prose patterns used in reference corpus
# 2. 
ref.pos.folder<-"~/Documents/GitHub/clones/DLK/DLK/meterized/json_DLK_v6"
f<-list.files(ref.pos.folder)
f.ns<-paste(ref.pos.folder,f,sep="/")
library(jsonlite)
x<-fromJSON(readLines(f.ns[1]),simplifyDataFrame = T,flatten = T)
#jsonlite::
x1<-abind(unlist(x$dta.poem.1$poem),along = 0)
x1<-lapply(x$dta.poem.1$poem, data_frame)
