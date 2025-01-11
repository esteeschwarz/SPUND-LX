library(tm)
library(dplyr)

text<-k2
text<-paste0(k2,collapse = "\n")
get.keys<-function(text=character()){
  given_text <- text
  given_corpus <- Corpus(VectorSource(given_text))
  clean_corpus <- function(corpus) {
    corpus <- tm_map(corpus, content_transformer(tolower))
    corpus <- tm_map(corpus, removePunctuation)
    corpus <- tm_map(corpus, removeNumbers)
    corpus <- tm_map(corpus, removeWords, stopwords("de"))
    corpus <- tm_map(corpus, stripWhitespace)
    return(corpus)
  }
#}
#k3<-get.keys(k2)
  #c2<-tm_map(k2)
  given_corpus <- clean_corpus(given_corpus)
  given_dtm <- DocumentTermMatrix(given_corpus)
  #given_freq <- as.data.frame(as.matrix(given_dtm))
  given_freq <- as.data.frame(t(as.matrix(given_dtm)))
  given_freq
  #library(collostructions)
  #given_freq<-freq.list(k2$token)
  #reference_freq <- as.data.frame(as.matrix(reference_dtm))
  
  # Sum the frequencies of each token
  #given_freq <- colSums(given_freq)
  #reference_freq <- colSums(reference_freq)
  #reference_freq<-k1
  reference_freq<-k1[,c(1,4)]
  length(reference_freq$token)
  length(unique(reference_freq$token))
  length(given_freq$token)
  length(unique(given_freq$token))
  
  head(given_freq)
  head(reference_freq)
  #colnames(given_freq)<-c("token","freq")
  #colnames(reference_freq)<-c("token","freq")
  #jfreq<-join.freqs(given_freq,reference_freq,all = T)
  #c1<-collex.dist(jfreq)
  #c1%>%arrange(desc(COLL.STR.LOGL))
  # Convert to data frames
  given_freq <- data.frame(token = row.names(given_freq), freq = given_freq)
  #reference_freq <- data.frame(token = names(reference_freq), freq = reference_freq)
  # Merge the frequency data frames
  freq_comparison <- merge(given_freq, reference_freq, by = "token", all = F)
  colnames(freq_comparison) <- c("token", "given_freq", "reference_freq")
  #freq_comparison$token[52]==freq_comparison$token[75]
  # Replace NA values with 0
  #freq_comparison[is.na(freq_comparison[,2:3]),2:3] <- 0
  #freq_comparison[freq_comparison$]
  freq_comparison[is.na(freq_comparison)] <- 0
  
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
