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
source(paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/germanic/HA/pos-py.R"))

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
df_combined <- bind_rows(df1,df2)
library(stringr)
# Tokenize to words (lowercase, remove punctuation/numbers)
df_combined$idd<-1:length(df_combined$date)
gp<-df_combined$target=="gpt"
#writeLines(head(df_combined$text[gp]),paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/huening/btt-test-gpt.txt"))

#df_combined$text[1]
### step to udpipe
# tokens <- df_combined %>%
#   unnest_tokens(word, text, token = "words") %>%
#   filter(str_detect(word, "^[A-Za-z????????????]+$")) %>%  # Optional: alphabetic words only
#   mutate(word = tolower(word))
# tokens <- df_combined %>%
#   unnest_tokens(word, text, token = "words")# Optional: alphabetic words only
# tokens<-unlist(strsplit(df_combined$text,"[ .:,;?!\\)\\(\\|\n|\\]|\\["))
# tokens<-tokens[tokens!=""]
# df_combined$text[1]
# mp<-lapply(df_combined$text,function(x){
#   xt<-unlist(strsplit(x,"\n"))
#   print(length(xt))
#   m<-grep("^[0-9]{3,4}\\. Sitzung $",xt)
#   print(m)
#   m<-m[m>10]
#   print(m)
#   ifelse(length(m)>0,t<-xt[m[1]:length(x)],t<-x)
#   return(t)
#   })
# thead<-unlist(strsplit(df_combined$text[1],"\n"))
# thead<-data.frame(head="head",p=thead[1:965])
# tok.h <- thead %>% unnest_tokens(word,p,token = "words",to_lower = F) # Optional: alphabetic words only
# tok.h<-unnest_tokens(th)
# ht<-table(tok.h$word)
# ht<-ht[order(ht,decreasing = T)]
# htm<-ht>10
# ht[htm]
# ?unnest_tokens
# df_combined$pr<-mp
# head(df_combined$pr)
# df_combined[mp,]
# tokens.2 <- df_combined %>%
 # unnest_tokens(word, text, token = "words",to_lower = F) # Optional: alphabetic words only
 # head(tokens.2$word,20)
ptdf.2$target<-"human"
#tokens.3<-ptdf.2 %>%
  #unnest_tokens(word,text,token = "words",to_lower = F)
# ?unnest_tokens
### USE df1,df2
range<-1:1
range<-1:length(df1$date)
print("get pos protocols...")
# text<-paste(toks[1:20],collapse = "w|w")
# wordarray<-toks[1:20]
# escape_regex <- function(x) {
#   gsub("([.|()\\^{}+$*?]|\\[|\\]|\\\\)", "\\\\\\1", x)
# }

# pattern <- paste0(
#   "\\b(",
#   paste(escape_regex(wordarray), collapse="|"),
#   ")\\b"
# )
# text<-gsub("[)\\(?.*]","dum",text)
# text<-gsub("\\[","dum",text)
# text<-gsub("\\]","dum",text)
# text
# t1<-gsub(pattern,"dum",df1$text[1])
# t1
#range<-1:3
#i<-1
#df_sf<-df1
pos.btt<-lapply(seq_along(range), function(i){
  cat("postag protocols:",i,"\n")
  p<-get.pos(df1[i,])
  # toks<-p$text
  # #text<-paste(toks[1:20],collapse = "/w|/w")
  # # pattern <- paste0(
  # #   "\\b(",
  # #   paste(escape_regex(toks), collapse="|"),
  # #   ")\\b"
  # # )
  # cat("removing",length(toks), "lemmatized tokens from future runs to spare resources\n")
  # ps<-i+1
  # dfm<-df1$text
  # for(k in 1:length(toks)){
  #   cat("replacing -",k,"\n")
  # pattern <- paste0(
  #     "\\b(",
  #     escape_regex(toks[k]),
  #     ")\\b"
  #   )
  #   
  # dfm<-gsub(pattern," ",dfm[ps:length(dfm)])
  # }
  return(p)
})
pos.bt.df1<-data.frame(abind(pos.btt,along = 1))
save(pos.bt.df1,file=paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/huening/df1.pos.RData")) # protocols all
print("sync cloud...")
system("sh ~/syncbg.sh")
range<-1:length(df2$date)
print("get pos summaries df...")
pos.btt<-lapply(seq_along(range), function(i){
  cat("postag summaries:",i,"\n")
  p<-get.pos(df2[i,])
})
pos.bt.df2<-data.frame(abind(pos.btt,along = 1))
save(pos.bt.df2,file=paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/huening/df2.pos.RData")) # protocols all
print("sync cloud...")
system("sh ~/syncbg.sh")
print("finished...")
