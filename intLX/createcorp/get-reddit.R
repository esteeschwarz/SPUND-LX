# library(RedditExtractoR)
# #library(dplyr)
# library(udpipe)
# library(readr)
# library(pbapply)
# library(abind)
#####################

# no matching urls: all new comments
####################################
### extract workflow from <getcompilecorp-srv.R>
# get old dataframe to only check new comments
# global VARS
wd<-"~/docker/ske"
getwd()
check.dir<-"/var/www/apps/docker/ske/corpora/reddit/vertical"
list.files(check.dir)
ske.dir<-"/var/www/apps/docker/ske"
list.files(ske.dir)
out.dir<-paste(getwd(),"corpora/reddit/vertical/vrt6",sep="/")
out.dir<-"/Users/guhl/temp/ske/corpora/reddit/auto/vertical"
out.dir<-paste(ske.dir,"corpora/reddit/vertical",sep="/")
dir.create(out.dir)
ns.timestamp<-15024
out.ns<-paste0(out.dir,"/source12.",ns.timestamp,".vrt")
out.ns
### uncomment to start with new table, since data is appended >
file.create(out.ns)
###################
log.ns<-"~/Documents/GitHub/SPUND-LX/intLX/createcorp/createcorp.log.csv"
log.ns<-"~/createcorp.log.csv"
file.create(log.ns)
model.dir<-"./modeldir"
source(paste(getwd(),"srv-functions.R",sep="/"))

# get url dataframe
# local:
#load(paste(wd,"reddit_15494.df.RData",sep = "/"))
# cloud:
url.df.x<-get.urls(url = "https://box.dh-index.org/estee/cloud/reddit_url.df.15024.RData")
#url.df.x<-get.urls(F)
####################
urls<-url.df.x$url
url.u<-unique(urls)
####################
# url.sub<-url.u[1:200] # 1:10:411 obs
# url.sub.df<-com.df[com.df$url%in%url.sub,]
# stopped after finishing 23, new start from 24!
# next,start from: 
# 30:74
# wt log: 89. wks.
# 101:120
###################################
# get annotated comments, function instead of loop:
get.url.comments<-function(url){
  com.df<-get_thread_content(url.df.x$url[url])
}
com.df.list<-list()

run<-130
rm(run)
#for (run in 115:125){
######################
### start here:
 pblapply(seq_along(1:length(url.u)),function(run){
   url.sub.df<-get.url.comments(run)
   
   url.df<-as.data.frame(url.sub.df$comments)
   url.sub.df<-url.df
   print(url.sub.df[1,])
   
   ##################################################################
  ### > here adapt change to length of url.sub.df to get all url pos
  # df.ex.url<-pblapply(seq_along(1:2),function(i){
  #   cat("url:",url,"\n")
  df.ex.l<-pblapply(seq_along(url.sub.df$url), function(i) {
    comments<-url.sub.df[i,]
    print(author<-comments$author)
    print(timestamp<-comments$timestamp)
    print(score<-comments$score)
    print(com_id<-comments$comment_id)
    print(url<-comments$url)
    print(date<-comments$date)
    print(comment<-comments$comment)
    com.x<-fetch.pos(comment, run,i,data=list(author=author,timestamp=timestamp,date=date,url=url,score=score,com_id=com_id))
    return(com.x)
  })
  df.ex<-abind::abind(df.ex.l,along = 1)
  df.ex<-data.frame(df.ex)
  m2<-colnames(df.ex)=="misc"|colnames(df.ex)=="deps"|colnames(df.ex)=="sentence"
  m3<-c(1:length(m2))[!m2]
  m3
  df.ex<-df.ex[,m3]
  # com.df.list[[run]]<-df.ex
  
  write.table(df.ex,out.ns,sep = "\t",quote = F,
              row.names = F,col.names = F,na="",append=T)
# save to list:
  save(com.df.list,file = "~/boxHKW/21S/DH/local/SPUND/intLX/data/com.df.list.15015.RData")
    # save to http:
  cloud<-"~/box.dh-index.org/httpdocs/cloud"
  #save(df.ex.l,file=paste(cloud,"red_df.ex.el.RData",sep="/"))
  # write to logfile
  writelog(c(run,"url"),log.ns)
}) # end url/run loop
unique(com.df.list[[1]]$pid)
