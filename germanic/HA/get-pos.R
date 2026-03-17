library(dplyr)
library(tidyr)
#install.packages(c("tidytext","abind","tidyr","dplyr","stringr"))
library(tidytext)
print("loading data...")
load(paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/huening/btt.summaries.RData")) # protocols + gpt summary texts 
#load(paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/huening/ptdf_btt02.RData")) # protocols after gemini
#load(paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/huening/ptdf_btt01.RData")) # protocols before gemini
load(paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/huening/ptdf_btt03.RData")) # protocols all
df<-btt.summaries

# Add corpus labels for binding
# df_human <- df %>%
#   mutate(corpus = "human") %>%
#   rename(text = text)
# 
# df_gpt <- df %>%
#   mutate(corpus = "gpt") %>%
#   rename(summary = text)
#df1<-df[,1:2]
df2<-df[,c(1,3)]
df1<-ptdf.2
df1<-cbind(df1,"human")
df2<-cbind(df2,"gpt")
colnames(df1)<-c("date","text","target")
colnames(df2)<-c("date","text","target")
df1$text<-gsub("[^\na-zA-ZäöüÄÖÜß-]"," ",df1$text)
df2$text<-gsub("[^\na-zA-ZäöüÄÖÜß-]"," ",df2$text)
df_combined <- bind_rows(df1,df2)
library(stringr)
# Tokenize to words (lowercase, remove punctuation/numbers)
df_combined$idd<-1:length(df_combined$date)
gp<-df_combined$target=="gpt"
#writeLines(head(df_combined$text[gp]),paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/huening/btt-test-gpt.txt"))
##########################
source(paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/germanic/HA/pos-py.R"))

escape_regex <- function(x) {
  gsub("([.|()\\^{}+$*?]|\\[|\\]|\\\\)", "\\\\\\1", x)
}
split_into_chunks <- function(vec, chunk_size) {
  split(vec, ceiling(seq_along(vec) / chunk_size))
}

##########################
range<-1:5
range<-1:length(df2$date)
i<-1
print("get pos summaries df...")
pos.btt<-lapply(seq_along(range), function(i){
  cat("postag summaries:",i,"\n")
  p<-get.pos(df2[i,])
  if(length(p)<2)
    return(NA)
  leun<-unique(p$lemma)
  cat("cleaning df from -",length(leun), "- already lemmatized...")
  tu<-unique(p$text)
  ps<-i+1
  if(ps<length(df2$date)){
  tcl<-df2$text[ps:length(df2$text)]
  tcl
  vector <- 1:length(tu)
  chunk_size <- 100  # Example chunk size
  
  # Function to split the vector into chunks of equal length
  
  # Split the vector into chunks
  chunks <- split_into_chunks(vector, chunk_size)
  chunks
  for(k in chunks){
    pattern <- paste0(
    "\\b(",
    paste(escape_regex(tu[k]), collapse="|"),
    ")\\b"
  )
  tcl<-gsub(pattern," ",tcl)
  }
  # for(k in 1:length(tu)){
  #   l<-tu[k]
  #   cat("replacing ",k,"\r")
  #   l<-escape_regex(l)    
  #   tcl<-gsub(l," ",tcl)
  # }
  df2$text[ps:length(df2$text)]<<-tcl
  }
  return(p)
    
  
})
pos.btt<-pos.btt[!is.na(pos.btt)]
pos.bt.df2<-data.frame(abind(pos.btt,along = 1))
save(pos.bt.df2,file=paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/huening/df2.pos.RData")) # protocols all
print("sync cloud...")
system("sh ~/syncbg.sh")
########################
#break

range<-1:length(df1$date)
print("get pos protocols...")
pos.btt<-lapply(seq_along(range), function(i){
  cat("postag protocols:",i,"\n")
  p<-get.pos(df1[i,])
  if(length(p)<2)
    return(NA)
  leun<-unique(p$lemma)
  cat("cleaning df from -",length(leun), "- already lemmatized...")
  tu<-unique(p$text)
  vector <- 1:length(tu)
  chunk_size <- 100  # Example chunk size
  
  # Function to split the vector into chunks of equal length
  
  # Split the vector into chunks
  chunks <- split_into_chunks(vector, chunk_size)
  chunks
  ps<-i+1
  tcl<-df1$text[ps:length(df1$text)]
  tcl
  if(ps<length(df1$date)){
    for(k in 1:length(chunks)){
      chunk<-chunks[[k]]
      cat("gsub -",k,"of -",length(chunks),"\r")
    pattern <- paste0(
      "\\b(",
      paste(escape_regex(tu[chunk]), collapse="|"),
      ")\\b"
    )
    tcl<-gsub(pattern," ",tcl)
    }
  # for(k in 1:length(tu)){
  #    l<-tu[k]
  #    cat("replacing ",k,"\r")
  #     l<-escape_regex(l)    
  #     tcl<-gsub(l," ",tcl)
  # }
  df1$text[ps:length(df1$text)]<<-tcl
  }
  return(p)
})


pos.btt<-pos.btt[!is.na(pos.btt)]
pos.bt.df1<-data.frame(abind(pos.btt,along = 1))
tokens.r$lemma <- dfa.pos$lemma[match(tokens.r$word, dfa.pos$token)]
tokens.r$lemma[lna] <- tok.na.anno$lemma[match(tokens.r$word[lna], tok.na.anno$token)]

save(pos.bt.df1,file=paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/huening/df1.pos.RData")) # protocols all
print("sync cloud...")
system("sh ~/syncbg.sh")
print("finished...")
