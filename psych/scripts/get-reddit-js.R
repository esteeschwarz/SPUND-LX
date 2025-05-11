library(httr)
library(jsonlite)
library(abind)
library(pbapply)
library(RedditExtractoR)


subject.dir<-"SPUND/2025/stef_psych"
run<-1
tstamp<-paste0(format(Sys.Date(),"%y-%m-%d"),".",run)
out.com.df.ns<-paste0(Sys.getenv("HKW_TOP"),"/",subject.dir,"/reddit_com.df.",tstamp,".RData")
tstamp
out.com.df.ns

b.url<-"https://www.reddit.com/r/schizophrenia/top.json?t=year&limit=1000"
r<-GET(b.url)
t<-content(r,"text")
js<-fromJSON(t)
for (k in 1:length(js$data$children$data)){
  jt<-mode(js$data$children$data[[k]])
  print(jt)
  if (jt=="list")
    js$data$children$data[[k]]<-NA
}
jdf<-data.frame(js$data$children$data)
colnames(jdf)
jdf[1,]
length(jdf)
j.after<-js$data$after
j.after<-gsub("t3_","",j.after)
# UTC timestamp
timestamp <- 1726158203
#timestamp<-jdf$data.created
jdf<-jdf[jdf$selftext!="",]
jdf<-jdf[grepl("comment",jdf$url),]
jdf$url
jdf<-jdf[order(jdf$created,decreasing = T),]

######
i<-1
#url.df<-find_thread_urls(subreddit = "schizophrenia",period = "year")
################
### load url.df
url.df<-url.df.x
url.df<-url.df[!is.na(url.df$url),]
url<-url.df$url[1]
url
jdf<-url.df.cpt
i<-3
url.com.df<-list()
#save(url.com.df,file = out.com.df.ns)
#url.com.df<-pblapply(seq_along(1:length(jdf$url)),function(i){
length(unique(jdf$timestamp))==length(jdf$timestamp)
start.i<-4
i<-1
e<-3
e<-length(jdf$url)
for(i in start.i:e){
  #id<-jdf$id[i]
  url<-jdf$url[i]
  url
  df<-get_thread_content(url)
  # timestamp<-jdf$timestamp[i]
  # p.url<-path.expand(url)
  p.url<-unlist(strsplit(url,"/"))
  id<-p.url[7]
  table_name<-id
  #url.e<-paste0(p.url[1:length(p.url)-1],collapse = "/")
  # url.e
  # url.j<-"https://www.reddit.com/r/schizophrenia/comments/%s/top.json"
  # url.j<-"%s/top.json"
  # p.url<-sprintf(url.j,url.e)
  # p.url
  cat("\rprocessing: ",i,"/",length(jdf$url))
  # r<-GET(p.url,user_agent("RStudio,httr"))
  # t<-content(r,"text")
  # t
  #cat("sleep 10s...")
  wait<-2
  length(jdf$url)*wait/60
  # js<-fromJSON(t)
  ifelse(length(df)>0,"fetched...",break)
#  ifelse(length(js)>0,"fetched...",break)
  # ifelse(length(jdf.1$data)>0,Sys.sleep(wait),break)
  com.df.meta<-data.frame(df$threads)
  com.df.meta$tstamp<-tstamp
  com.df.comments<-data.frame(df$comments)
  # dbWriteTable(con, name = table_name, value = df_list[[i]], overwrite = TRUE)
  #dbWriteTable(con, name = "meta", value = com.df.meta, overwrite = TRUE)
  #dbWriteTable(con, name = "comments", value = com.df.comments, overwrite = TRUE)
  dbAppendTable(con, name = "meta", value = com.df.meta)
  if(com.df.meta$comments>0){
    com.df.comments$tstamp<-tstamp
    dbAppendTable(con, name = "comments", value = com.df.comments)
  }
  
  #url.com.df[[i]]<-df
  Sys.sleep(wait)
}
out.com.df.ns
save(url.com.df,file = out.com.df.ns)
writeLines("testesxt",tempfile("test.txt"))
  t<-p.url
  return(t)

  js<-fromJSON(t)
  jdf.1<-data.frame(js$data$children[1])
  jdf.2<-data.frame(js$data$children[2])
  jdf.2$data$replies[2]
  jdf.2$data$body
  jdf.4<-data.frame(jdf.2$data$replies[[2]]$data$children$data)
  jdf.3<-data.frame(unlist(jdf.2$data$replies))
  jdf.3<-data.frame(t(jdf.3))
  jdf.aut<-jdf.3$data.children.data.replies.data.children.data.author
  jdf.body<-jdf.3$data.children.data.replies.data.children.data.body
  
return(jdf.2)
})
url.com.df.1<-data.frame(abind(url.com.df,along = 1))
timestamp<-jdf$created[1]
# Convert to formatted date
formatted_date <- as.POSIXct(timestamp, origin = "1970-01-01", tz = "UTC")
print(formatted_date)
jdf$date<-as.POSIXct(jdf$created, origin = "1970-01-01", tz = "UTC")
#length(js$data$children$data)
#js.m.l<-mode(js$data$children$data)
#jdf<-jdf[jdf$selftext!="",]
#curl https://www.reddit.com/r/schizophrenia/top.json?t=month&limit=100&after=t3_1khvdne
colnames(jdf)
jdf$url
jdf$date
url<-"https://www.reddit.com/r/schizophrenia/top.json?t=month&limit=100&after=t3_1kio6ig"
r<-GET(url)
t<-content(r,"text")
js<-fromJSON(t,flatten = T)
jdf<-data.frame(js$data$children)
url<-"https://www.reddit.com/r/schizophrenia/comments/1kio6ig/top.json"
r<-GET(url)
t<-content(r,"text")
js<-fromJSON(t,flatten = T)
jdf.1<-data.frame(js$data.children[1])
jdf.2<-data.frame(js$data.children[2])



