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

##########################
range<-1:5
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
########################
#break
range<-1:length(df1$date)
print("get pos protocols...")
pos.btt<-lapply(seq_along(range), function(i){
  cat("postag protocols:",i,"\n")
  p<-get.pos(df1[i,])
  return(p)
})
pos.bt.df1<-data.frame(abind(pos.btt,along = 1))
save(pos.bt.df1,file=paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/huening/df1.pos.RData")) # protocols all
print("sync cloud...")
system("sh ~/syncbg.sh")
print("finished...")
