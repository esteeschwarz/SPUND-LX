# 20250114(08.05)
# 16015.class.clip stats from scores
####################################

d2<-paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/hux/pqdir/clip_results.parquet")
#library(parqr)
#parquet<-"~/boxHKW/21S/DH/local/SPUND/2025/hux/pqdir"
d1<-paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/hux/tabelle.parquet")
#df<-parquet_readr(path=d1)
#install.packages("arrow")
library(arrow)
#df<-open_dataset(d1)


df<-read_parquet(d2)
#df<-read_parquet(d1)
# f <- system.file(parquet, package = "arrow")
# f
# pq <- ParquetFileReader$create(d1)
# pq$GetSchema()
# if (codec_is_available("snappy")) {
#   # This file has compressed data columns
#   tab <- pq$ReadTable()
#   tab$schema
# }
#reticulate::py_install("pandas")

library(lme4)
library(lmerTest)
colnames(df)
#df$id<-1:length(df$filename)
head(df)
lm1<-lmer(mean_clip~group+(1|filename),df)
lm2<-lm(mean_clip~group,df)
summary(lm2)
summary(lm1)
summary(lm1)
# i<-1
# ch.spl<-lapply(seq_along(1:length(df$text_chunk_clips)),function(i){
#   l<-unlist(df$text_chunk_clips[i])
#   d2<-data.frame(l)
#   d1<-data.frame(df[i,])
#   d3<-rbind(rep(d1,length(l)))
#   
#   
#   
#   
#   })
### explode df:
library(tidyr)
library(dplyr)

dff <- df |>
  unnest_longer(text_chunk_clips)

# # If multiple list columns, chain them sequentially
# df_flat <- df |>
#   unnest_longer(items) |>
#   unnest_longer(other_list)

colnames(dff)
colnames(df)
head(dff$list_tokens)
head(df$text_chunk)
colnames(dff)[7]<-"cl_score"
lm3<-lmer(cl_score~group+(1|filename),dff)
lm4<-lm(cl_score~group,dff)
summary(lm1)
summary(lm2)
summary(lm3)
summary(lm4)
library(ggplot2)
ggplot(data = dff, aes(x = cl_score,fill = group)) +
  geom_density(alpha=0.5) +
  labs(title = "Density Plot", x = "clip score", y = "Density") +
  theme_minimal() 
### wks.
# separated score means plot
############################
#?density
#plot(density(dff$cl_score), main = "Density Plot", xlab = "Variable", ylab = "Density")

### try establish more vars for finer regression
# - PoS? > no: score applies to whole chunk, so no further split possible
dff.sample<-dff[sample(1:length(dff$filename),20),]
# Q1: theres a text(participant): WMatrix-full-clinical-raw.txt? whats that?
m<-dff$filename=="WMatrix-full-clinical-raw.txt"
sum(m)
dff2<-dff[!m,]
ggplot(data = dff2, aes(x = cl_score,fill = group)) +
  geom_density(alpha=0.5) +
  labs(title = "Density Plot", x = "clip score", y = "Density") +
  theme_minimal() 
lm5<-lmer(cl_score~group+(1|filename),dff2)
#lm4<-lm(cl_score~group,dff)
summary(lm1)
summary(lm5) # Q1 excluded, big difference!
dff.sample<-dff2[sample(1:length(dff2$filename),20),]
lm6<-lmer(cl_score~group+(1|filename)+(1|text_chunk),dff2) # account for specific chunk content
summary(lm6)

#################
chk1<-function(){
# Q2: i dont really know how list_of_chunks or chunk_text applies to text or list_of_tokens, it seems totally different sources. chk score calc script again, or parquet R convert error?
dfb<-read_parquet(d1)
s1<-dff$filename[1]
dfb.1<-dfb[dfb$filename==s1,]
dfa.1<-dff[dff$filename==s1,]

dff <- df |>
  unnest_longer(text_chunk_clips)
dfa.2<-df[1:20,]
### Q2 issue only with 03EB14_Raw.txt?
# exclude
m<-df$filename=="WMatrix-full-clinical-raw.txt"|df$filename=="03EB14_Raw.txt"
sum(m)
dfa.3<-df[!m,]
dff3 <- dfa.3 |>
  unnest_longer(text_chunk_clips)
colnames(dff3)[7]<-"cl_score"
ggplot(data = dff3, aes(x = cl_score,fill = group)) +
  geom_density(alpha=0.5) +
  labs(title = "Density Plot", x = "clip score", y = "Density") +
  theme_minimal() 
lm5<-lmer(cl_score~group+(1|filename),dff3)
#lm4<-lm(cl_score~group,dff)
summary(lm1)
summary(lm5)
dff3.sample<-dff3[1:20,]

### Q2:
# chk chunk_text vs. text
c<-dff$text_chunk[1]
q2.a<-lapply(seq_along(1:length(df$text_chunk)), function(c){
  cat("processing row:",c,"\r")
  t<-unlist(strsplit(df$text_chunk[c]," "))
  t<-gsub("[^a-z]","",t)
  # m<-sum(unlist(lapply(t, function(g){
  #   grepl(g,df$text[c])
    m<-lapply(t, function(g){
      g%in%df$text[c]
  })
  mu<-unlist(m)
  mt<-length(mu)==length(t)
})
#qm<-!q2.a
qm<-unlist(q2.a)
sum(!qm)
length(unique(df$filename))
df$filename[qm]
length(unique(df$filename[qm]))
dfq.1<-df[qm,]

grep("repository",dfa.2$text)
dfa.2$text[1]
### Q2 no issue, all checked
}
############################
### okay, other features? simple lexical diversity first
ld<-lapply(seq_along(1:length(df$filename)),function(l){
cat("processing row:",l,"\r")
    t<-df$text[l]
  t2<-unlist(strsplit(t," "))
  t3<-unique(t2)
  ttr<-length(t3)/length(t2)
  firstPPr<-t2%in%c("I","my","me","mine")
  fstPP<-sum(firstPPr)
  
  return(data.frame(l=length(t2),ttr=ttr,firstPPr=fstPP))
  # return(list(ttr=ttr,fstPP=fstPP))
})
#rm(ld)
library(abind)
ldf<-data.frame(abind(ld,along=1))
ldf$fstPPr_rate<-ldf$firstPPr/ldf$l
df4<-cbind(df,ld=ldf$ttr,fstPPr_rate=ldf$fstPPr_rate)
dff4 <- df4 |>
  unnest_longer(text_chunk_clips)
colnames(dff4)[7]<-"cl_score"
lm6<-lmer(cl_score~group+(1|filename)+(1|text_chunk)+ld+fstPPr_rate,dff4)
#lm4<-lm(cl_score~group,dff)
summary(lm1)
summary(lm6)
df4_lim<-df4[,c("text_chunk_clips","group","ld","fstPPr_rate")]
#save(df4,file=paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/hux/df4.RData"))
save(df4_lim,file=paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/mental-img/HA/df4_lim.RData"))
#########################################################################
### wks., proceed from here:
load(paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/hux/df4.RData"))
###############################################################
library(tidyr)
library(dplyr)

dff4 <- df4 |>
  unnest_longer(text_chunk_clips)
colnames(dff4)[7]<-"cl_score"
ggplot(data = dff4, aes(x = cl_score,fill = group)) +
  geom_density(alpha=0.5) +
  labs(title = "Density Plot", x = "clip score", y = "Density") +
  theme_minimal() 
lm6<-lmer(cl_score~group+(1|filename)+(1|text_chunk)+ld+fstPPr_rate,dff4)
#lm4<-lm(cl_score~group,dff)
# summary(lm1)
summary(lm6)
