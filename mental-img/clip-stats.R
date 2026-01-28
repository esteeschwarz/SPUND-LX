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
df4_lim<-df4[,c("text_chunk_clips","filename","group","text_chunk","ld","fstPPr_rate")]
df4_lim$text_chunk_clips <- as.list(df4_lim$text_chunk_clips)

#save(df4,file=paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/hux/df4.RData"))
#save(df4_lim,file=paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/mental-img/HA/df4_lim.RData"))
#########################################################################
### wks., proceed from here:
load(paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/hux/df4.RData"))
###############################################################
# library(tidyr)
# library(dplyr)

dff4 <- df4_lim |>
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

### git tidy issue on unnest
unique(df4_lim$filename)
# Check column types
str(df4_lim)
sapply(df4_lim, class)
sapply(df4,class)
sapply(dff4,class)

# > sapply(df4_lim, class)
# $text_chunk_clips
# [1] "arrow_list"    "vctrs_list_of" "vctrs_vctr"    "list"         
# 
# $filename
# [1] "character"
# 
# $group
# [1] "character"
# 
# $text_chunk
# [1] "character"
# 
# $ld
# [1] "numeric"
# 
# $fstPPr_rate
# [1] "numeric"


# Check for duplicates or hidden whitespace in colnames
colnames(df4_lim)
nchar(colnames(df4_lim))  # reveals hidden spaces

# Inspect the cl_score column specifically
class(df4_lim$cl_score)
length(df4_lim$cl_score[[1]])  # length of first nested list
sapply(df4_lim$cl_score, length)  # all lengths

# Check TN specifically
class(df4_lim$TN)
unique(df4_lim$TN) |> head(20)
any(is.na(df4_lim$TN))
any(duplicated(df4_lim$TN))

# Check for empty rows
nrow(df4_lim)
any(rowSums(is.na(df4_lim)) == ncol(df4_lim))

# Try unnesting just cl_score alone
test <- df4_lim %>% select(cl_score) %>% unnest_longer(cl_score)

### base R unnesting
# Get the lengths of each list element
list_lengths <- sapply(df4_lim$text_chunk_clips, length)

# Expand rows
dff4 <- df4_lim[rep(seq_len(nrow(df4_lim)), list_lengths), ]

# Flatten the list column
dff4$cl_score <- unlist(df4_lim$text_chunk_clips)

# Reset rownames
rownames(dff4) <- NULL

list_lengths <- sapply(df4_lim$text_chunk_clips, length)

# Expand rows
dff4 <- df4_lim[rep(seq_len(nrow(df4_lim)), list_lengths), ]

# Flatten the list column
dff4$cl_score <- unlist(df4_lim$text_chunk_clips)
dff4<-dff4[,2:length(dff4)]
t1<-unique(dff4$text_chunk)
for(k in 1:length(t1)){
  m<-dff4$text_chunk==t1[k]
  dff4$text_chunk[m]<-k
}
save(dff4,file=paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/mental-img/HA/df4_lim.RData"))

# Reset rownames
rownames(dff4) <- NULL
#colnames(dff4)[grep("text_chunk_clips",colnames(dff4))]<-"cl_score"
colnames(dff4)[grep("filename",colnames(dff4))]<-"TN"
ggplot(data = dff4, aes(x = cl_score,fill = group)) +
  geom_density(alpha=0.5) +
  labs(title = "Density Plot", x = "clip score", y = "Density") +
  theme_minimal() 
lm6<-lmer(cl_score~group+(1|TN)+(1|text_chunk)+ld+fstPPr_rate,dff4)


load(paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/mental-img/HA/df4_lim.RData"))
###############################################################

library(ggplot2)
library(lme4)
library(lmerTest)
ggplot(data = dff4, aes(x = cl_score,fill = group)) +
  geom_density(alpha=0.5) +
  labs(title = "Density Plot", x = "clip score", y = "Density") +
  theme_minimal() 
lm6<-lmer(cl_score~group+(1|TN)+(1|text_chunk)+ld+fstPPr_rate,dff4)
#lm4<-lm(cl_score~group,dff)
# summary(lm1)
print(summary(lm6))


### randomize table before clip
dfb<-read_parquet(d1)

dfb1<-dfb[sample(length(dfb$filename),length(dfb$filename)),]
dfb1<-dfb1[!grepl("WMatrix",dfb1$filename),]
write_parquet(dfb1,paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/hux/tabelle_rnd.parquet"))
?write_parquet

library(ggplot2)
# Varianzvergleich auf Personen ebene
unique(df$filename)
df_no_big<-df[!grepl("WMatrix",df$filename),]
df_pers_var <- aggregate(var_clip ~ filename + group, data = df_no_big, FUN = mean)
?aggregate
t.test(var_clip ~ group, data = df_pers_var)
t.test(var_clip ~ group, data = df_no_big)

ggplot(df_pers_var, aes(x = group, y = var_clip)) +
  geom_point(position = position_jitter(width = 0.1), size = 2) +
  geom_boxplot(alpha = 0.3) +
  labs(y = "Variance of CLIP score within interview")


# Varianzvergleich auf Chunk ebene

t.test(var_clip ~ group, data = df_no_big)

ggplot(df_no_big, aes(x = group, y = var_clip)) +
  geom_point(position = position_jitter(width = 0.1), size = 2) +
  geom_boxplot(alpha = 0.3) +
  labs(y = "Variance of CLIP score within interview")




# 20260128(18.54)
# 16055.clip data with metadata
###############################
library(arrow)
library(lme4)
library(lmerTest)
d1<-paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/hux/smi_data_metadata.csv")
df<-read.csv(d1)
colnames(df)
t<-lapply(df[,1:length(df)],function(x){
  typeof(x)
})
unlist(t)
lm1<-lmer(mean_clip_de_jina~person+)

