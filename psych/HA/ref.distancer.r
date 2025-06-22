#20250622(12.29)
#15262.HA.psych
###############
library(DBI)
library(RSQLite)
con <- dbConnect(RSQLite::SQLite(),"~/db/reddit_com.df.15242.sqlite")
dbListTables(con)
tdb.pos<-dbGetQuery(con,"SELECT * FROM reddit_com_pos")
#tdb.com<-dbGetQuery(con,"SELECT * FROM redditpsych")
###
# task: devise referrer distance of demonstratives
# build query interface
q<-list(token=c("this","that","these","those","the")) # mean distance: 76
q<-list(token=c("the")) # mean distance: 81
###########################################
### notes
# the script reads the postagged reddit corpus (NO control!) from sqlite db and
# defines the mean distance of any NOUN token preceded by above query 
# to the last before mentioning of that token within one author-comment range.
# this shall give us an index of reference stability (coherence) within that comment.
# assumption is, that for q(indefinite article) the index is higher
# test:
q<-list(token=c("a","an","some","any")) # mean distance: 63, lower
# q<-list(token=c("my")) # mean distance: 55, lower

q<-list(token=c("your","their","his","her")) # mean distance: 100, higher

df<-tdb
get.q<-function(q,df){
  i<-1
  re<-lapply(seq_along(q),function(i){
    print(names(q[i]))
    column<-names(q[i])
    rq<-df[,column]%in%q[[i]]
    #rq<-grepl(q[i],df[,names(q[i])])
  })
}
re1<-get.q(q,tdb)
re1<-unlist(re1)
sum(re1)
tdb$token[re1]
noun1<-which(re1)+1
noun1
noun1.p<-which(tdb$upos=="NOUN")
noun1.in<-noun1.p%in%noun1
noun1.in.p<-which(noun1.in)
noun1.in.p<-noun1.p[noun1.in.p]
tok.dem<-tdb$token[noun1.p][noun1.in]
which(tok.dem=="life")
tok.uid<-tdb$uid[noun1.p][noun1.in]
i<-315
dem.ref<-lapply(seq_along(1:length(noun1.in.p)),function(i){
  noun<-tok.dem[[i]]
  uid<-tok.uid[[i]]
  range<-which(tdb$uid==uid)
  print(noun)
  p.before<-grep(noun,tdb$token)
  p.before<-p.before[p.before%in%range]
  if(length(p.before)>1){
    p.b<-p.before[p.before<noun1.in.p[[i]]]
    p.a<-p.before[p.before>noun1.in.p[[i]]]
    #p.b.p<-p.b.p<
    return(list(pos=noun1.in.p[[i]],before=p.b,after=p.a))
    
  }
  
})
dem.ref
unlist(dem.ref)>0
#tdb$token[1216]%in%tok.dem
i<-298
#dem.ref[[287]]
#tdb$token[noun1.in.p[[287]]]
p.d<-lapply(seq_along(dem.ref),function(i){
  t<-dem.ref[[i]]$before>0
  ifelse(t,
    td<-dem.ref[[i]]$pos-dem.ref[[i]]$before,return(NA))
})
unlist(p.d)
p.d
mean(unlist(p.d))
