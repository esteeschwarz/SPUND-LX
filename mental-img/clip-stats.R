parquet<-"~/boxHKW/21S/DH/local/SPUND/2025/hux/pqdir/clip_results.parquet"
library(parqr)
#parquet<-"~/boxHKW/21S/DH/local/SPUND/2025/hux/pqdir"
d1<-"~/boxHKW/21S/DH/local/SPUND/2025/hux/tabelle.parquet"
df<-parquet_readr(path=d1)
install.packages("arrow")
library(arrow)
df<-open_dataset(d1)


df<-read_parquet(parquet)
df<-read_parquet(d1)
f <- system.file(parquet, package = "arrow")
f
pq <- ParquetFileReader$create(d1)
pq$GetSchema()
if (codec_is_available("snappy")) {
  # This file has compressed data columns
  tab <- pq$ReadTable()
  tab$schema
}
#reticulate::py_install("pandas")

library(xml2)
library(lmer)
library(lmerTest)
colnames(df)
df$id<-1:length(df$filename)
head(df)
lm1<-lmer(mean_clip~group+(1|filename)+(1|chunk),df)
lm2<-lm(mean_clip~group,df)
summary(lm2)
summary(lm1)
summary(lm1)
i<-1
ch.spl<-lapply(seq_along(1:length(df$text_chunk_clips)),function(i){
  l<-unlist(df$text_chunk_clips[i])
  d2<-data.frame(l)
  d1<-data.frame(df[i,])
  d3<-rbind(rep(d1,length(l)))
  
  
  
  
  })

