read.db<-function(run){
  
  
  library(DBI)
  library(RSQLite)
  db<-paste0("~/db/reddit_com.df.",run,".sqlite")
  #con <- dbConnect(RSQLite::SQLite(),"~/db/reddit_com.df.15242.sqlite")
  #con <- dbConnect(RSQLite::SQLite(),"~/db/reddit_com.df.15276.sqlite")
  con <- dbConnect(RSQLite::SQLite(),db)
  dbListTables(con)
  #tdb.pos<-dbGetQuery(con,"SELECT * FROM reddit_com_pos")
  tdbref<-dbGetQuery(con,"SELECT * FROM reddit_pos_ref")
  tdbcorp<-dbGetQuery(con,"SELECT * FROM reddit_com_pos")
  dbDisconnect(con)
  return(list(obs=tdbcorp,ref=tdbref))
}
# if(!exists("tdb"))
#   tdb<-read.db()
n_obs<-length(tdb$obs$token)
n_ref<-length(tdb$ref$token)
build.q<-function(){
  q0<-list(a=list(q=".*",det="DET"))
  q1<-list(b=list(q=c("this","that","these","those"),det="DET")) # mean distance: 76
  q2<-list(c=list(q=c("the"),det="DET")) # mean distance: 81
  q3<-list(d=list(q=c("a","an","some","any"),det="DET")) # mean distance: 63, lower
  q4<-list(e=list(q=c("my"),det=F)) # mean distance: 55, lower
  q5<-list(f=list(q=c("your","their","his","her"),det=F)) # mean distance: 100, higher
  
  return(list(q0,q1,q2,q3,q4,q5))
}
qs<-build.q()
