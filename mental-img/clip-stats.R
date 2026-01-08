d2<-paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/hux/pqdir/clip_results.parquet")
#library(parqr)
#parquet<-"~/boxHKW/21S/DH/local/SPUND/2025/hux/pqdir"
d1<-"~/boxHKW/21S/DH/local/SPUND/2025/hux/tabelle.parquet"
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
df$id<-1:length(df$filename)
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

# If multiple list columns, chain them sequentially
df_flat <- df |>
  unnest_longer(items) |>
  unnest_longer(other_list)

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

