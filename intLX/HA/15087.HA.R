# 20250221(10.30)
# 15087.SPUND.intLX.HA
# figurative language and style correlation
###########################################
# RQ: how do the use of figurative language in internet speech and style/register
# correlate?
############
# Q: r/de
load("~/boxHKW/21S/DH/local/SPUND/intLX/url.comment.df.15086.RData")

# chunk df in subsets of containing not more than 120.000 chars in df$comments for further analysing in MAXQDA
# where this is the limit for AI assisted coding (recognition of figurative language)

t1<-url.comment.df$comment
t1c<-strsplit(t1,"")
tc<-unlist(t1c) # 13.445.500
margin<-119995
########
# chunks
l.df<-length(tc)
# Create the vector
vector <- 1:l.df

# Define the chunk size
chunk_size <- margin  # Example chunk size

# Function to split the vector into chunks of equal length
split_into_chunks <- function(vec, chunk_size) {
  split(vec, ceiling(seq_along(vec) / chunk_size))
}

# Split the vector into chunks
chunks <- split_into_chunks(vector, chunk_size)
###############################################
margin.end<-tail(1:margin,40)
gm<-paste0(tc[chunks[[1]][margin.end]],collapse = "")
gms<-strsplit(gm,"[?.!]")
gms<-unlist(gms)
gms<-gsub("[*)?(\\[\\]]",".",gms)
gms
m<-grep(gms[1],url.comment.df$comment)
#m<-grep("*alle*",url.comment.df$comment)
url.comment.df[m,]

### chunk
# chunks
l.df<-length(url.comment.df$url)
# Create the vector
vector <- 1:l.df
margin<-420
# Define the chunk size
chunk_size <- margin  # Example chunk size

# Function to split the vector into chunks of equal length
split_into_chunks <- function(vec, chunk_size) {
  split(vec, ceiling(seq_along(vec) / chunk_size))
}

# Split the vector into chunks
chunks <- split_into_chunks(vector, chunk_size)
k<-1
library(writexl)
for(k in 1:length(chunks)){
  subdf<-url.comment.df[chunks[[k]][1]:chunks[[k]][length(chunks[[k]])],]
  subdf$sub<-k
  xlns<-paste0("~/boxHKW/21S/DH/local/SPUND/intLX/HA/comments.subdf.",k,".xlsx")
  write_xlsx(subdf,xlns)
  t<-paste(subdf$url,subdf$author,subdf$comment)
  t<-paste(paste0("@",subdf$author,"\t"),subdf$comment)
  #  t<-c(paste0("@author: ",subdf$author),paste0("@url: ",subdf$url),t)
  tns<-paste0("~/boxHKW/21S/DH/local/SPUND/intLX/HA/comments.subtx.",k,".txt")

  writeLines(t,tns)
  
}



