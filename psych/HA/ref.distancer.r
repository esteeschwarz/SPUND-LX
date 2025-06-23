#20250622(12.29)
#15262.HA.psych
###############
library(DBI)
library(RSQLite)
con <- dbConnect(RSQLite::SQLite(),"~/db/reddit_com.df.15242.sqlite")
dbListTables(con)
#tdb.pos<-dbGetQuery(con,"SELECT * FROM reddit_com_pos")
tdbref<-dbGetQuery(con,"SELECT * FROM reddit_pos_ref")
tdbcorp<-dbGetQuery(con,"SELECT * FROM reddit_com_pos")
tdb<-tdbcorp
#tdb.com<-dbGetQuery(con,"SELECT * FROM redditpsych")
###
# task: devise referrer distance of demonstratives
# build query interface
get.q<-function(q,df){
  i<-1
  re<-lapply(seq_along(q),function(i){
    print(names(q[i]))
    column<-names(q[i])
    rq<-df[,column]%in%q[[i]]
    #rq<-grepl(q[i],df[,names(q[i])])
  })
}
q<-q5
tdb<-tdbcorp
get.mean<-function(q,tdb){
  column<-names(q)
  re1<-get.q(q,tdb)
  re1<-unlist(re1)
  head(re1,1000)
  sum(re1)
  tdb[re1,column]
  noun1<-which(re1)+1
  noun1
  noun1.p<-which(tdb$upos=="NOUN")
  noun1.in<-noun1.p%in%noun1
  noun1.in.p<-which(noun1.in)
  noun1.in.p<-noun1.p[noun1.in.p]
  tok.dem<-tdb[noun1.p,column][noun1.in]
  #which(tok.dem=="life")
  tok.uid<-tdb$uid[noun1.p][noun1.in]
  tok.uid.u<-unique(tok.uid)
  tok.dem.u<-unique(tok.dem)
  
  i<-1
  b<-1
  rm(i)
  rm(b)
  rm(ii)
  x<-tok.dem.u[2]
  lt<-lapply(tok.dem.u, function(x,i){
   #strsplit(x,"a")
    print(x)
   mn<-tdb[,column]==x
    #noun<-x
    #cat(noun,"\n")
  # })
  # dem.ref<-lapply(tok.dem.u,function(x){
    #dem.ref<-lapply(seq_along(1:10),function(i){
    #cat("\r",i,"\t:",x)  
    #noun<-tok.dem.u[i]
    #print(noun)
    #mn<-grepl(noun,tdb$token)
    # sum(mn)
    #mn<-tdb[,column]==noun
    cat(sum(mn),"\n")
    mnw<-which(mn)
    tdb[mnw,column]
    p1<-lapply(seq_along(1:length(mnw)),function(b){
    m1<-lapply(mnw, function(c){
      print(c)
    #})  
    #cat("\r",b,":\t")
    npos<-noun1.in.p[c]
    })
    m1<-unlist(m1)
    m1<-m1[!is.na(m1)]
    m1
    npos<-m1
   # cat(npos,"\n")
    tdb[npos,column]
    uid<-tdb$uid[npos]
    range<-which(tdb$uid==uid)
    range
    p.before<-npos
    px<-sum(mnw%in%range)
    p.before<-mnw[mnw%in%range]
    if(px>1){
      p.b<-p.before[p.before<npos]
      #p.a<-p.before[p.before>npos]
      #p.b.p<-p.b.p<
      return(list(pos=npos,before=p.b))
      
    }
#    return(p1)
    })
   # return(p1)
  })
  tdb[368,column]
  
    unlist(p1)
 # # mean(unlist(dem.ref))
 #    uid<-tok.uid[[i]]
 #    range<-which(tdb$uid==uid)
 #    print(noun)
 #    p.before<-grep(noun,tdb$token)
 #    p.before<-p.before[p.before%in%range]
 #    if(length(p.before)>1){
 #      p.b<-p.before[p.before<noun1.in.p[[i]]]
 #      p.a<-p.before[p.before>noun1.in.p[[i]]]
 #      #p.b.p<-p.b.p<
 #      return(list(pos=noun1.in.p[[i]],before=p.b,after=p.a))
 #      
 #    }
    
  # })

 # dem.ref
 # unlist(dem.ref)>0
  #tdb$token[1216]%in%tok.dem
  i<-298
  #dem.ref[[287]]
  #tdb$token[noun1.in.p[[287]]]
  p.d<-lapply(seq_along(dem.ref),function(i){
    t<-dem.ref[[i]]$before>0
    ifelse(t,
           td<-dem.ref[[i]]$pos-dem.ref[[i]]$before,return(NA))
  })
  unlist(dem.ref)
  unlist(p.d)
  p.d
  print(m<-mean(unlist(p.d)))
}
mean(unlist(p1))
q1<-list(token=c("this","that","these","those","the")) # mean distance: 76
q2<-list(token=c("the")) # mean distance: 81
q3<-list(token=c("a","an","some","any")) # mean distance: 63, lower
q4<-list(token=c("my")) # mean distance: 55, lower
q5<-list(token=c("your","their","his","her")) # mean distance: 100, higher


q1r<-get.mean(q1,tdbref) # ref: 124
q1c<-get.mean(q1,tdbcorp) # ref: 124

q2r<-get.mean(q2,tdbref) # ref: 131
q2c<-get.mean(q2,tdbcorp) # ref: 124

###########################################
### notes
# the script reads the postagged reddit corpus (NO control!) from sqlite db and
# defines the mean distance of any NOUN token preceded by above query 
# to the last before mentioning of that token within one author-comment range.
# this shall give us an index of reference stability (coherence) within that comment.
# assumption is, that for q(indefinite article) the index is higher
# test:
q3r<-get.mean(q3,tdbref) # ref: 83
q3c<-get.mean(q3,tdbcorp) # ref: 124

q4r<-get.mean(q4,tdbref) # ref: 70
q4c<-get.mean(q4,tdbcorp) # ref: 124

q5r<-get.mean(q5,tdbref) # ref: 103
q5c<-get.mean(q5,tdbcorp) # ref: 124

qdf<-data.frame(q=c(letters[1:5],letters[1:5]),
                d=c(76,81,63,55,70,124,131,83,70,103),
                corp=c(rep("obs",5),rep("ref",5)))
qdf<-data.frame(q=c(letters[1:5],letters[1:5]),
                d=c(76,81,63,55,70,124,131,83,70,103),
                corp=c(rep(1,5),rep(0,5)))
qdf1<-data.frame(q=c(letters[1:5],letters[1:5]),
                d=c(76,81,63,55,70,124,131,83,70,103),
                corp=c(rep(0,5),rep(1,5)))
qdf<-data.frame(q=c(letters[1:5],letters[1:5]),
                d=c(q1c,q2c,q3c,q4c,q5c,q1r,q2r,q3r,q4r,q5r),
                corp=c(rep("obs",5),rep("ref",5)))
qdf1<-data.frame(q=c(letters[1:5],letters[1:5]),
                d=c(q1c,q2c,q3c,q4c,q5c,q1r,q2r,q3r,q4r,q5r),
                corp=c(rep(0,5),rep(1,5)))
mode(qdf1[,2])<-"double"
mode(qdf1[,3])<-"double"
library(lme4)
install.packages("lme4",type = "source")
qdf
lm1<-lmer(d~corp+(1|q),qdf)
summary(lm1)
lm2<-lmer(d~q+(1|corp),qdf)
s2<-summary(lm2)
s2
print(lm2,signif.stars=T)
lm2<-glmer(d~q+(1|corp),qdf)
summary(lm2)
library(lattice)
anova(lm2)
library(stats)
qdf.c<-qdf[,c(2,3)]
cor.test(qdf1[,2],qdf1[,3])
df<-tdb
# get.q<-function(q,df){
#   i<-1
#   re<-lapply(seq_along(q),function(i){
#     print(names(q[i]))
#     column<-names(q[i])
#     rq<-df[,column]%in%q[[i]]
#     #rq<-grepl(q[i],df[,names(q[i])])
#   })
# }
# 
# get.mean<-function(q,tdb){
# re1<-get.q(q,tdb)
# re1<-unlist(re1)
# sum(re1)
# tdb$token[re1]
# noun1<-which(re1)+1
# noun1
# noun1.p<-which(tdb$upos=="NOUN")
# noun1.in<-noun1.p%in%noun1
# noun1.in.p<-which(noun1.in)
# noun1.in.p<-noun1.p[noun1.in.p]
# tok.dem<-tdb$token[noun1.p][noun1.in]
# which(tok.dem=="life")
# tok.uid<-tdb$uid[noun1.p][noun1.in]
# i<-315
# dem.ref<-lapply(seq_along(1:length(noun1.in.p)),function(i){
#   noun<-tok.dem[[i]]
#   uid<-tok.uid[[i]]
#   range<-which(tdb$uid==uid)
#   print(noun)
#   p.before<-grep(noun,tdb$token)
#   p.before<-p.before[p.before%in%range]
#   if(length(p.before)>1){
#     p.b<-p.before[p.before<noun1.in.p[[i]]]
#     p.a<-p.before[p.before>noun1.in.p[[i]]]
#     #p.b.p<-p.b.p<
#     return(list(pos=noun1.in.p[[i]],before=p.b,after=p.a))
#     
#   }
#   
# })
# dem.ref
# unlist(dem.ref)>0
# #tdb$token[1216]%in%tok.dem
# i<-298
# #dem.ref[[287]]
# #tdb$token[noun1.in.p[[287]]]
# p.d<-lapply(seq_along(dem.ref),function(i){
#   t<-dem.ref[[i]]$before>0
#   ifelse(t,
#     td<-dem.ref[[i]]$pos-dem.ref[[i]]$before,return(NA))
# })
# unlist(p.d)
# p.d
# print(m<-mean(unlist(p.d)))
# }
# write_csv(qdf,"~/gith/SPUND-LX/psych/HA/eval-001.csv")
# library(jsonlite)
# write_json(list(a=q1,b=q2,c=q3,d=q4,e=q5),"~/gith/SPUND-LX/psych/HA/eval-qs.json")

