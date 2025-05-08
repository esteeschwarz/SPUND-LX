library(RedditExtractoR)
#library(dplyr)
library(udpipe)
library(readr)
library(pbapply)
library(abind)
#####################
tstamp<-15196
#thread<- "de"
thread<-"schizophrenia"
corpus<-"stef_psych_schiz"
subject.dir<-"SPUND-LX/psych/data"
cloud<-"~/box.dh-index.org/httpdocs/cloud"
cloud<-paste0(Sys.getenv("WWW_TOP"),"/cloud")
get.urls<-function(){
url.df.x<-find_thread_urls(subreddit = thread)
save(url.df.x,file = paste0(Sys.getenv("GIT_TOP"),"/",subject.dir,"/reddit_url.df.",tstamp,".RData"))
max(url.df.x$date_utc)
min(url.df.x$date_utc)
#url.df.2<-url.df
# old datasets max date 02-12-2024
#load("/Users/guhl/boxHKW/21S/DH/local/SPUND/intLX/reddit_url.df.RData")
#load("/Users/guhl/boxHKW/21S/DH/local/SPUND/intLX/reddit_15494.df.RData")
#tail(url.df)
# url.df<-url.df[2:length(url.df$date_utc),]
# max(url.df$date_utc)
# min(url.df$date_utc)
# l.com<-array()
# k<-1
# for (k in 1:length(url.df.x$date_utc)){
# lc<-url.df.x$comments[k]
# m<-grep(url.df.x$url[k],url.df$url)
# lc1<-url.df$comments[m]
# if(length(lc1)>0)
#   l.com[k]<-lc1
# }
# m<-url.df.x$url%in%url.df$url
# sum(m)
return(url.df.x)
}

# no matching urls: all new comments
####################################
### extract workflow from <getcompilecorp-srv.R>
# get old dataframe to only check new comments
# global VARS
model.dir<-"./modeldir"
model.dir<-paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/intLX/createcorp/modeldir")
model.l<-"eng"
#model.l<-"ger"
doc.id.act<-tstamp
###
 source(paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/intLX/createcorp/srv-functions.R"))
wd<-"~/dl/ske"
out.dir<-paste0("~/temp/ske/corpora/reddit/auto/",thread,"/data")
#out.dir<-"/Users/guhl/temp/ske/corpora/reddit/auto/vertical"
dir.create(out.dir,recursive = T)
#?dir.create
out.com.df.ns<-paste0(out.dir,"/comment.df.",tstamp,".RData")
out.com.df.ns
log.ns<-paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/intLX/createcorp/createcorp.log.csv")
#load(paste(wd,"reddit_15494.df.RData",sep = "/"))
# get url dataframe
url.df.x<-get.urls()
url.df.cpt<-url.df.x
save(url.df.cpt,file = paste0(Sys.getenv("GIT_TOP"),"/",subject.dir,"/reddit_url.df.",tstamp,".RData"))
####################
urls<-url.df.x$url
url.u<-unique(urls)
### uncomment to start with new table, since data is appended >
#file.create(out.ns)
file.create(log.ns)
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

#run<-130
#rm(run)
#for (run in 115:125){
######################
### start here:
### only url df + text
url.df.ns<-paste0(cloud,"/url.sub.df.",tstamp,".csv")
url.df.ns
file.create(url.df.ns)

url.temp<-tempfile("urltemp.csv")
url.sub.df<-pblapply(seq_along(1:length(url.u)),function(run){
 #url.sub.df<-pblapply(seq_along(1:10),function(run){
#for(run in 1:length(url.u)){
    url.sub.df<-get.url.comments(run)
  
  url.df<-as.data.frame(url.sub.df$comments)
  # # write.table(url.df,url.temp,
  #             row.names = F,col.names = F,na="",append=T)
#  print(url.df[1,])
  # open_cons <- showConnections(all = TRUE)
  # print(open_cons)
  # # open_ids <- as.integer(rownames(open_cons))
  # for (con in open_ids) {
  #   close(getConnection(con))
  # }
  # ?close
  # closeAllConnections()
  cat(run,"finished\n")
#}
   return(url.df)
 })

#writeLines(url.temp,"~/boxHKW/21S/DH/local/SPUND/2025/stef_psych/urltemp.csv")
# open_cons <- showConnections(all = TRUE)
# print(open_cons)
# open_ids <- as.integer(rownames(open_cons))
# for (con in open_ids) {
#   close(getConnection(con))
# }
# ?close
# closeAllConnections()
#save(url.sub.df,file = out.com.df.ns)
length(unique(url.comment.df$timestamp))==length(url.comment.df$timestamp)

#?matrix
#url.comment.df.1<-matrix(unlist(url.sub.df),ncol = 10,byrow = T)
#url.comment.df<-data.frame(url.comment.df.1)
#?abind
is.na(url.sub.df[[1]])
# if(length(url.sub.df[[1]])==0)
  # url.sub.df[[1]]<-url.sub.df[[2]][1,]
url.sub.na<-lapply(seq_along(url.sub.df), function(d){
  if(length(url.sub.df[[d]])<1)
    return(NA)
  return(url.sub.df[[d]])
})
una<-is.na(url.sub.na)
una
url.comment.df.1<-abind(url.sub.na[!una],along = 1,force.array = T)
url.comment.df.2<-data.frame(url.comment.df.1)
url.comment.df<-url.comment.df.2
load(out.com.df.ns) # loads old dataframe as .cpt
m.time<-url.comment.df.2$timestamp%in%url.comment.df.cpt$timestamp
sum(m.time)
url.comment.df.3<-url.comment.df.2[!m]
url.comment.df.4<-data.frame(url.comment.df.3)
#########################################################

url.comment.df.cpt<-rbind(url.comment.df,url.comment.df.4)
#url.comment.df.cpt<-url.comment.df
save(url.comment.df.cpt,file=out.com.df.ns) # saves new dataframe after removing duplicate timestamps


list.files("~/temp/ske")
out.ns

#write.csv(url.comment.df,out.ns)
# t<-url.comment.df$comment
# df.sub<-url.comment.df[1:ceiling(length(url.comment.df$url)/2),]
# t<-df.sub$comment
# writeLines("testwrite",paste0(Sys.getenv("HKW_TOP"),"/",subject.dir,"/url.comments.",tstamp,".sub.txt"))
# writeLines("testwrite",paste0("~/temp/R/gzissue.",tstamp,".txt"))
# library(readxl)
# library(writexl)
# write_xlsx(df.sub,paste0(Sys.getenv("HKW_TOP"),"/",subject.dir,"/url.com.",tstamp,"/.sub1.xlsx"))
# save(url.comment.df,file = paste0(Sys.getenv("HKW_TOP"),"/",subject.dir,"/url.comment.df.",tstamp,".RData"))

  #colnames(url.comment.df)<-colnames(url.sub.df[[2]])
#######################
  # pblapply(seq_along(1:length(url.u)),function(run){
  #  url.sub.df<-get.url.comments(run)
  #  
  #  url.df<-as.data.frame(url.sub.df$comments)
  #  url.sub.df<-url.df
  #  print(url.sub.df[1,])
  #  
library(stringi)
authors<-unique(url.comment.df$author)
url.comment.df$auth_anon<-NA
#aut<-2
for (aut in 1:length(authors)){
  m<-url.comment.df$author==authors[aut]
  sum(m)
  author_anon<-stri_rand_strings(1, 15, pattern = "[A-Za-z0-9]")
  url.comment.df$auth_anon[m]<-author_anon
  
}
   ##################################################################
  ### > here adapt change to length of url.sub.df to get all url pos
  # df.ex.url<-pblapply(seq_along(1:2),function(i){
  #   cat("url:",url,"\n")
  # df.ex.l<-pblapply(seq_along(url.sub.df$url), function(i) {
#i<-1
#run<-1
print(model)
    df.ex.l<-pblapply(seq_along(1:length(url.comment.df$url)), function(i) {
      comments<-url.comment.df[i,]

    print(author<-comments$auth_anon)
#    print(author<-comments$author)
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
  df.ex$token<-gsub("[^[:print:]]","_",df.ex$token)
  df.ex$lemma<-gsub("[^[:print:]]","_",df.ex$lemma)
  # com.df.list[[run]]<-df.ex
  out.ns
  write.table(df.ex,out.ns,sep = "\t",quote = F,
              row.names = F,col.names = F,na="",append=T)
  # save to vrt dir:
  out.vrt.top<-"~/dl/ske/corpora"
  out.vrt.ns<-paste0(out.vrt.top,"/reddit/vertical/psych/vrt01a/source")
  write.table(df.ex,out.vrt.ns,sep = "\t",quote = F,
              row.names = F,col.names = F,na="",append=F)
  colnames(df.ex)
  # save to list:
 # save(com.df.list,file = "~/boxHKW/21S/DH/local/SPUND/intLX/data/com.df.list.15015.RData")
    # save to http:
#  cloud<-"~/box.dh-index.org/httpdocs/cloud"
  #save(df.ex.l,file=paste(cloud,"red_df.ex.el.RData",sep="/"))
  # write to logfile
  writelog(c(run,"url"),log.ns)
#}) # end url/run loop
unique(com.df.list[[1]]$pid)

# command: make execute CMD="compilecorp --no-ske testvrt"
call.noske<-'make execute CMD="compilecorp --no-ske --recompile-corpus reddit-psych"'
call.noske<-'sh ~/ske-compile.sh'
system(call.noske)



