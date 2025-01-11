# reference corpus compare frequencies
Q<-"https://www.ids-mannheim.de/digspra/kl/projekte/methoden/derewo/"

library(readr)
rm(t1)
t1<-read.csv("~/Documents/lade/1-gram-token-lemma-pos-freqs-with-punctuation.01.tsv",sep = "\t",col.names = c("token","lemma","pos","freq"))
f<-list.files("downloads")
f
rm(t1)
k1<-read.csv("~/documents/lade/token_keys.01.tsv")
k1<-read.csv("~/Documents/lade/token_keys.01.tsv",sep = "\t",col.names = c("token","key"))
t1<-readLines("~/Downloads/DeReKo-2014-II-MainArchive-STT.100000.freq/DeReKo-2014-II-MainArchive-STT.100000.freq")
m<-grepl('"',t1)
t1<-t1[!m]
m<-grepl("['|]",t1)
t1<-t1[!m]
t1[78284]
sum(m)
ttemp<-tempfile("t1.csv")
writeLines(t1,ttemp)
k1<-read.table(ttemp,col.names = c("token","lemma","f1","f2"),sep = "\t")

t1<-readLines("~/Documents/GitHub/benjaminfeldkraft/corpus/benjaminfeldkraft.vert")

m<-grepl('"',t1)
t1<-t1[!m]
m<-grepl("['|]",t1)
t1<-t1[!m]
m<-grepl("(<s>|</s>|<g/>)",t1)
t1<-t1[!m]
t1[41671]
sum(m)
ttemp<-tempfile("t1.csv")
writeLines(t1,ttemp)
k2<-read.csv(ttemp,col.names = c("token","lemma","pos"),sep = "\t")
t1[1:10]
#k1<-read.table("~/Downloads/DeReKo-2014-II-MainArchive-STT.100000.freq/DeReKo-2014-II-MainArchive-STT.100000.freq",col.names = 1:4,sep = "\t")
head(t1)
head(k1)
toktext<-"~/temp/refcorpus.txt"
# for (k in 4:50){
#   key<-k1$key[k]
#   token<-k1$token[k]
#   f<-t1$freq[k]
#   tline<-rep(token)
#   
# }
install.packages("tm")
install.packages("dplyr")

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
  given_corpus <- Corpus(VectorSource(given_text))
  #reference_corpus <- Corpus(VectorSource(reference_corpus))
  
  g2<-Corpus(VectorSource(k2$token))
  given_corpus<-g2
  # Tokenize and clean the text
  clean_corpus <- function(corpus) {
    corpus <- tm_map(corpus, content_transformer(tolower))
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
  #given_freq <- as.data.frame(as.matrix(given_dtm))
  # no
  library(collostructions)
  given_freq<-freq.list(k2$token)
  #reference_freq <- as.data.frame(as.matrix(reference_dtm))
  
  # Sum the frequencies of each token
  #given_freq <- colSums(given_freq)
  #reference_freq <- colSums(reference_freq)
  #reference_freq<-k1
  reference_freq<-k1[,c(1,4)]
  head(given_freq)
  head(reference_freq)
  colnames(given_freq)<-c("token","freq")
  colnames(reference_freq)<-c("token","freq")
  jfreq<-join.freqs(given_freq,reference_freq,all = T)
  c1<-collex.dist(jfreq)
  c1%>%arrange(desc(COLL.STR.LOGL))
  # Convert to data frames
  #given_freq <- data.frame(token = names(given_freq), freq = given_freq)
  #reference_freq <- data.frame(token = names(reference_freq), freq = reference_freq)
  # Merge the frequency data frames
  freq_comparison <- merge(given_freq, reference_freq, by = "token", all = F)
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

ben.vrt<-read.table("~/Documents/GitHub/benjaminfeldkraft/corpus/benjaminfeldkraft.vert",sep = "\t")
ben.vrt<-readLines("~/Documents/GitHub/benjaminfeldkraft/corpus/benjaminfeldkraft.vert")

save(reference_freq,file="~/Documents/GitHub/SPUND-LX/corpusLX/data/DEREKO-referenceFreqList.RData")
save(given_freq,file="~/Documents/GitHub/SPUND-LX/corpusLX/data/benjamintest-referenceFreqList.RData")
