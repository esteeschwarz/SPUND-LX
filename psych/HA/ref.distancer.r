#20250622(12.29)
#15262.HA.psych
###############
library(DBI)
library(RSQLite)
#con <- dbConnect(RSQLite::SQLite(),"~/db/reddit_com.df.15242.sqlite")
con <- dbConnect(RSQLite::SQLite(),"~/db/reddit_com.df.15276.sqlite")
dbListTables(con)
#tdb.pos<-dbGetQuery(con,"SELECT * FROM reddit_com_pos")
tdbref<-dbGetQuery(con,"SELECT * FROM reddit_pos_ref")
tdbcorp<-dbGetQuery(con,"SELECT * FROM reddit_com_pos")
#tdb<-tdbcorp
#tdb.com<-dbGetQuery(con,"SELECT * FROM redditpsych")
###
# task: devise referrer distance of demonstratives
# build query interface
q1<-list(token=c("this","that","these","those")) # mean distance: 76
q2<-list(token=c("the")) # mean distance: 81
q3<-list(token=c("a","an","some","any")) # mean distance: 63, lower
q4<-list(token=c("my")) # mean distance: 55, lower
q5<-list(token=c("your","their","his","her")) # mean distance: 100, higher
### intercept!
q0<-list(token="#intercept")
q<-q1
df<-tdbref
get.q<-function(q,df){
  i<-1
  qt<-q[[1]]
  qt
 # print(names(q))
  column<-names(q)
#re<-lapply(qt,function(x){
    rq<-df[,column]%in%qt
    if("#intercept"%in%qt)
      rq<-rep(T,length(df$token))
    #rq<-grepl(q[i],df[,names(q[i])])
  #})
  print(sum(unlist(rq)))
  return(rq)
}
sum(get.q(q2,tdbref))
q<-q5
q5
tdb<-tdbref
system.time(get.q(q,tdb))
get.matches<-function(q,tdb){
  re1<-get.q(q,tdb)
  
  re1<-unlist(re1)
  re1w<-which(re1)
#  head(re1,1000)
 # sum(re1)
  #tdb[re1,column]
  noun1<-which(re1)+1
  #noun1
  noun1.p<-which(tdb$upos=="NOUN")
  noun1.in<-noun1.p%in%noun1
}
#q1mc<-get.matches(q,tdb)
#preliminaries
uid<-tdb$uid
head(uid)
uid2<-gsub("dfurl([0-9]{1,4})-.*","\\1",uid)
head(uid2)
tdb$url<-uid2
### this is schwachsinn. i dont need to define distance for each unique noun but for every similar noun egal what it is.
tdbcorp$target<-"obs"
tdbref$target<-"ref"
q<-q1
q
tdb<-tdbcorp
#names(tdb)
get.mean.gl<-function(q,tdb){
  uid<-tdb$uid
  length(unique(uid))
  head(uid)
  uid2<-gsub("dfurl([0-9]{1,4})-.*","\\1",uid)
  #uid2<-gsub("-.*","",uid)
  head(uid2)
  length(unique(uid2))
  tdb$url<-uid2
  
  column<-names(q)
  column
  re1<-get.q(q,tdb)
  re1<-unlist(re1)
  re1w<-which(re1)
  #head(re1,1000)
  sum(re1)
  #tdb[re1,column]
  target<-tdb$target[1]
  ifelse(sum(re1)==length(tdb$token),noun1<-re1w,noun1<-which(re1)+1)
  #sum(noun1)
  #noun.p<-which(tdb$upos=="NOUN")
  #noun1.in.p<-noun.p%in%noun1
  #sum(noun1.in.p)
  #noun1.in.p<-which(noun1.in.p)
  #noun1.in.p<-noun1.p[noun1.in.p]
  #head(tdb[noun1.in.p,column])
  uid4<-tdb$url
  head(uid4)
  uid4
  uid5<-unique(uid4)
  head(uid5)
  uid5<-uid5[uid5!=""]
  x<-uid5[1]
  rm(x)
  lt1<-lapply(uid5, function(x){
    tdb.s<-tdb[tdb$url==x,] # subset of url
    tdb.n<-tdb.s$upos=="NOUN"
    sum(tdb.n)
    tdb.nw<-which(tdb.n)
    range.l<-tdb.s$lemma
    range.t<-tdb.s$token
      
    m<-grepl("<s|</s|<doc|</doc",range.t)
    sum(m)
    range.l<-range.l[!m]
    l.dup<-duplicated(range.l)
    l.dup<-which(l.dup)
    l.dup.n<-l.dup[l.dup%in%tdb.nw]
    l.dup.n<-l.dup.n[l.dup.n%in%re1w]
    #sum(l.dup.n)
    ld.l<-tdb.s$lemma[l.dup.n]
    l<-ld.l[1]
    ### 15273.class:
    ### another task: determine type/token ration in range AND function to return list of ALL noun distances to perform anova p eval on overall df, not only the yet calculated mean!!
    #so:
    # type/token-ratio
    n.token<-length(range.l)
    n.type<-length(unique(tdb.s$token))
    tt.r<-n.type/n.token
#    ifelse(length(dist)>0,return(list(dist=dist,range=length(range.w),ld=ld)),NA)
    
    m2<-lapply(ld.l, function(l){
      m3<-tdb.s$lemma==l
      sum(m3)
      m3<-which(m3)
      ##########################
      ### NOTE> this relative match frequency affects heavily the anova lmer analysis in the 
      # evaluation if included there. so have to think thoroughly how its derived.
      # here we divide the n nouns which match the query within the url range by the total
      # token n of that range.
      mf_rel<-length(m3)/n.token
      ###################################################################################
      #tdb.s$token[(m3-m3):(m3+30)]
      dist<-diff(m3)
      median(dist)
      condition<-paste0(unlist(q),collapse = ",")
      ifelse(length(dist)>0,return(list(dist=dist,q=condition,range=length(range.l),mf_rel=mf_rel,
                                        ld=tt.r,lemma=l,url=x,target=target)),return(NA))
      
    })
    
    #return(list(dist=m2,range=length(range.l)))
       # l.dist<-diff(l.dup)
  })
  #x<-lt1[[1]]
  lt2<-lapply(lt1, function(x){
    l<-length(x)
    return(ifelse(l!=0,x,NA))
  })
  lt2<-lt2[!is.na(lt2)]
  lt3.df<-lapply(lt2, function(x){
    df3<-data.frame(x[[1]]$dist)
    df3$q<-x[[1]]$q
    df3$target<-x[[1]]$target
    df3$url<-x[[1]]$url
    df3$lemma<-x[[1]]$lemma
    df3$range<-x[[1]]$range
    df3$mf_rel<-x[[1]]$mf_rel
    df3$ld<-x[[1]]$ld
    return(df3)
    return(x[[1]]$dist)
  })
  lt4.df<-abind(lt3.df,along = 1)
  colnames(lt4.df)[1]<-"dist"
  ### okay this wks., now have a dataframe with all single distances on range and lemma
  ### we stop here the old execution and return df
  return(lt4.df)
  lt3.ld<-lapply(lt2, function(x){
    return(x[[1]]$ld)
  })
  median(unlist(lt3.d))
  lt3.r<-lapply(lt2, function(x){
    return(x[[1]]$range)
  })
  median(unlist(lt3.r))
  head(lt3.d)
  head(lt3.r)
  #unlist(lt2)
  mlt2.d<-median(unlist(lt3.d))
  mlt2.r<-median(unlist(lt3.r))
  mlt2.ld<-median(unlist(lt3.ld))
  print(mlt2.d)
  print(mlt2.r)
  print(mlt2.ld)
  ### return ALL dist elements for anova perform:
  return(list(dist=lt3.d,range=lt3.r,ld=lt3.ld)) #1.q5.40.5 (with return median distances) / 43 with return 
}
qtest<-get.mean.gl(q3,tdbref)

get.mean<-function(q,tdb){
  uid<-tdb$uid
  head(uid)
  uid2<-gsub("dfurl([0-9]{1,4})-.*","\\1",uid)
  head(uid2)
  tdb$url<-uid2
  
  column<-names(q)
  re1<-get.q(q,tdb)
  re1<-unlist(re1)
  re1w<-which(re1)
  head(re1,1000)
  sum(re1)
  #tdb[re1,column]
  
  ifelse(sum(re1)==length(tdb$token),noun1<-which(re1),noun1<-which(re1)+1)
  noun1
  noun.p<-which(tdb$upos=="NOUN")
  noun1.in.p<-noun.p%in%noun1
  sum(noun1.in.p)
  noun1.in.p<-which(noun1.in.p)
  noun1.in.p<-noun1.p[noun1.in.p]
  head(tdb[noun1.in.p,column])
  tok.dem<-tdb[noun1.in.p,"lemma"]
  #which(tok.dem=="life")
  tok.uid<-tdb$url[noun1.in.p]
  #tok.uid.u<-unique(tok.uid)
  tok.dem.u<-unique(tok.dem)
  
  i<-1
  b<-1
  rm(i)
  rm(b)
  #rm(ii)
  te<-2
  x<-tok.dem.u[te]
  tok.test<-tok.dem.u[1:5]
  lt<-lapply(tok.dem.u, function(x){
  #   lt<-lapply(tok.test, function(x){
      #strsplit(x,"a")
   # print(x)
   mn<-tdb$lemma==x
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
   # cat(sum(mn),"\n")
    mnw<-which(mn)
    #lemma.x<-tdb$lemma[mnw[1]]
    #lemma.x
    #mn2<-tdb$lemma==lemma.x # postags not reliable: e.g. caring(VERB) has lemma=car
    #mnw<-which(mn2)
    #mnw<-mnw[te:length(mnw)]
    ifelse(sum(re1)==length(tdb$token),mnw1<-mnw,mnw1<-mnw-1) # if intercept
    
   # mnw1<-mnw-1 # query position
    mnw2<-mnw1%in%re1w # lemma position matches query
     #mnw1q<-mnw1%in%re1w
    sum(mnw2)
    mnw3<-which(mnw2)
    #mnwqw<-which(mnwq)
    #mnwqw<-mnwqw[mnwqw%in%noun1.in.p]
    tdb[mnw,column]
    tdb[mnw1[mnw3],column]
    #tdb[mnw1[mnwqw],column]
    mnwn<-mnw1[mnw3] # this reduces to nouns with respective token (q) preceding
    tdb[mnwn,column]
    
    #p1<-lapply(seq_along(1:length(mnw)),function(b){
    mnw.sub<-mnw[te:length(mnw)]
    c<-mnw[1]
    c<-mnwn[1]
    m1<-lapply(mnwn, function(c){
     # print(c)
      uid<-tdb$url[c]
      #uid<-strsplit(uid,"url|-")
      #uid<-uid[2]
      range<-tdb$url==uid
      range.w<-which(range)
    #})  
    #cat("\r",b,":\t")
    #npos<-noun1.in.p[c]
#    })
 #   m1<-unlist(m1)
  #  m1<-m1[!is.na(m1)]
   # m1
  #  npos<-m1
   # cat(npos,"\n")
    tdb[range.w,column]
    #uid<-tdb$uid[npos]
    #range<-which(tdb$uid==uid)
    #range
    #p.before<-npos
    px<-sum(mnw%in%range.w)
    p.before<-mnw[mnw%in%range.w] # this all positions within comment
    tdb[p.before,column]
    ### define distance between tokens
    ### task: i have 3 numbers and want for each the distance?
    dist<-diff(p.before)
    # easy
    # but now i have for each occurence (e.g. 3 numbers) here the distance, so tripled in return.
    # shall i devise the mean here yet to have a singled mean distance in the return instead of 3x the same distances?
    ifelse(length(dist)>0,return(list(dist=dist,range=length(range.w))),NA)
# ### 15273.class:
# ### another task: determine type/token ration in range AND function to return list of ALL noun distances to perform anova p eval on overall df, not only the yet calculated mean!!
#     #so:
#     # type/token-ratio
#     n.token<-length(range.w)
#     n.type<-length(unique(tdb$token[range.w]))
#     ld<-n.type/n.token
#     ifelse(length(dist)>0,return(list(dist=dist,range=length(range.w),ld=ld)),NA)
    })
    unlist(m1)
    m1<-m1[!is.na(m1)]
    m1
    # m1u<-unique(m1)
    # mean(unlist(m1)) #107
    # mean(unlist(m1u)) #115
    # median(unlist(m1)) #56
    # median(unlist(m1u)) #56
    return(m1)
    return(median(unlist(m1u))) #56
    
   # return(p1)
  })
  lt2<-lapply(lt, function(x){
    l<-length(x)
    ifelse(length(x)!=0,x,NA)
  })
  lt2<-lt2[!is.na(lt2)]
  lt3.d<-lapply(lt2, function(x){
    return(x[[1]]$dist)
  })
  
  median(unlist(lt3.d))
  lt3.r<-lapply(lt2, function(x){
    return(x[[1]]$range)
  })
  head(lt3.d)
  head(lt3.r)
  #unlist(lt2)
  mlt2.d<-median(unlist(lt3.d))
  mlt2.r<-median(unlist(lt3.r))
  print(mlt2.d)
  print(mlt2.r)
  return(list(dist=lt3.d,range=lt3.r)) #1.q5.40.5 (with return median distances) / 43 with return unlist(m1)[all distances]
}
  # tdb[368,column]
  # m1
  # m1u<-unique(m1)
  #   mean(unlist(m1)) #107
  #   mean(unlist(m1u)) #115
  #   median(unlist(m1)) #56
  #   median(unlist(m1u)) #56
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
#   i<-298
#   #dem.ref[[287]]
#   #tdb$token[noun1.in.p[[287]]]
#   p.d<-lapply(seq_along(dem.ref),function(i){
#     t<-dem.ref[[i]]$before>0
#     ifelse(t,
#            td<-dem.ref[[i]]$pos-dem.ref[[i]]$before,return(NA))
#   })
#   unlist(dem.ref)
#   unlist(p.d)
#   p.d
#   print(m<-mean(unlist(p.d)))
# }
# mean(unlist(p1))
# q1<-list(token=c("this","that","these","those")) # mean distance: 76
# q2<-list(token=c("the")) # mean distance: 81
# q3<-list(token=c("a","an","some","any")) # mean distance: 63, lower
# q4<-list(token=c("my")) # mean distance: 55, lower
# q5<-list(token=c("your","their","his","her")) # mean distance: 100, higher
# ### intercept!
# q0<-list(token="#intercept")


###########################################
### notes
# the script reads the postagged reddit corpus (NO control!) from sqlite db and
# defines the mean distance of any NOUN token preceded by above query 
# to the last before mentioning of that token within one author-comment range.
# this shall give us an index of reference stability (coherence) within that comment.
# assumption is, that for q(indefinite article) the index is higher
# test:

# q1r<-get.mean(q1,tdbref) # ref: 124
# q1c<-get.mean(q1,tdbcorp) # ref: 124
# 
# q2r<-get.mean(q2,tdbref) # ref: 131
# q2c<-get.mean(q2,tdbcorp) # ref: 124
# 
# q3r<-get.mean(q3,tdbref) # ref: 83
# q3c<-get.mean(q3,tdbcorp) # ref: 124
# 
# q4r<-get.mean(q4,tdbref) # ref: 70
# q4c<-get.mean(q4,tdbcorp) # ref: 124
# 
# q5r<-get.mean(q5,tdbref) # ref: 103
# q5c<-get.mean(q5,tdbcorp) # ref: 124

q1r<-get.mean.gl(q1,tdbref) # ref: 124
q1c<-get.mean.gl(q1,tdbcorp) # ref: 124
q2r<-get.mean.gl(q2,tdbref) # ref: 131
q2c<-get.mean.gl(q2,tdbcorp) # ref: 124
q3r<-get.mean.gl(q3,tdbref) # ref: 83
q3c<-get.mean.gl(q3,tdbcorp) # ref: 124
q4r<-get.mean.gl(q4,tdbref) # ref: 70
q4c<-get.mean.gl(q4,tdbcorp) # ref: 124
q5r<-get.mean.gl(q5,tdbref) # ref: 103
q5c<-get.mean.gl(q5,tdbcorp) # ref: 124

q0r<-get.mean.gl(q0,tdbref) # ref: 124
q0c<-get.mean.gl(q0,tdbcorp) # ref: 124
################################################################
### this 15275.
q.all.cr<-rbind(q0c,q0r,q1c,q1r,q2c,q2r,q3c,q3r,q4c,q4r,q5c,q5r)
q.all.df<-as.data.frame(q.all.cr)
mode(q.all.df$dist)<-"double"
mode(q.all.df$range)<-"double"
mode(q.all.df$mf_rel)<-"double"
mode(q.all.df$ld)<-"double"
###########################
### run from beginnin to here
#############################
median(q.all.df$dist[q.all.df$target=="obs"])
median(q.all.df$dist[q.all.df$target=="ref"])
mean(q.all.df$dist[q.all.df$target=="obs"])
mean(q.all.df$dist[q.all.df$target=="ref"])
# get.m.df<-function(df){
#   q.u<-unique(df$q)
#   df.m<-data.frame(target=NA,q=)
# }

mac<-median(dfa$dist[dfa$target=="obs"&dfa$q=="a"])
mar<-median(dfa$dist[dfa$target=="ref"&dfa$q=="a"])
mbc<-median(dfa$dist[dfa$target=="obs"&dfa$q=="b"])
mbr<-median(dfa$dist[dfa$target=="ref"&dfa$q=="b"])
mcc<-median(dfa$dist[dfa$target=="obs"&dfa$q=="c"])
mcr<-median(dfa$dist[dfa$target=="ref"&dfa$q=="c"])
mdc<-median(dfa$dist[dfa$target=="obs"&dfa$q=="d"])
mdr<-median(dfa$dist[dfa$target=="ref"&dfa$q=="d"])
mec<-median(dfa$dist[dfa$target=="obs"&dfa$q=="e"])
mer<-median(dfa$dist[dfa$target=="ref"&dfa$q=="e"])
mfc<-median(dfa$dist[dfa$target=="obs"&dfa$q=="f"])
mfr<-median(dfa$dist[dfa$target=="ref"&dfa$q=="f"])

### vorsicht falschrum!

mdac<-mean(dfa$dist[dfa$target=="obs"&dfa$q=="a"])
mdar<-mean(dfa$dist[dfa$target=="ref"&dfa$q=="a"])
mdbc<-mean(dfa$dist[dfa$target=="obs"&dfa$q=="b"])
mdbr<-mean(dfa$dist[dfa$target=="ref"&dfa$q=="b"])
mdcc<-mean(dfa$dist[dfa$target=="obs"&dfa$q=="c"])
mdcr<-mean(dfa$dist[dfa$target=="ref"&dfa$q=="c"])
mddc<-mean(dfa$dist[dfa$target=="obs"&dfa$q=="d"])
mddr<-mean(dfa$dist[dfa$target=="ref"&dfa$q=="d"])
mdec<-mean(dfa$dist[dfa$target=="obs"&dfa$q=="e"])
mder<-mean(dfa$dist[dfa$target=="ref"&dfa$q=="e"])
mdfc<-mean(dfa$dist[dfa$target=="obs"&dfa$q=="f"])
mdfr<-mean(dfa$dist[dfa$target=="ref"&dfa$q=="f"])


mdf<-data.frame(median=c(mac,mar,mbc,mbr,mcc,mcr,mdc,mdr,mec,mer,mfc,mfr),
                mean=c(mdac,mdar,mdbc,mdbr,mdcc,mdcr,mddc,mddr,mdec,mder,mdfc,mdfr))

q.all.df<-dfa
median(q.all.df$dist[q.all.df$target=="obs"])
median(q.all.df$dist[q.all.df$target=="ref"])
mean(q.all.df$dist[q.all.df$target=="obs"])
mean(q.all.df$dist[q.all.df$target=="ref"])
boxplot(dist ~ target, data = q.all.df,
        col = c("lightblue", "pink"),
        main = "Boxplot grouped by binary variable",
        xlab = "Group",
        ylab = "Value"
        )

# Remove outliers within each group (q, corp) using the IQR rule
library(purrr)
library(reshape2)

df1_no_outliers <- q.all.df %>%
  group_by(target) %>%
  filter(
    dist >= quantile(dist, 0.25) - 1.5 * IQR(dist),
    dist <= quantile(dist, 0.75) + 1.5 * IQR(dist)
  ) %>%
  ungroup()
boxplot(dist~target,df1_no_outliers)
### bind all observations to df
length(q0c$dist)
q0c.d<-abind(q0r$dist,along = 1)
q0c.r<-abind(q0r$range,along=1)
q0c.ld<-abind(q0r$ld,along = 1)

mq5r<-median(unlist(q5r$dist))
mq5c<-median(unlist(q5c$dist))
mq4r<-median(unlist(q4r$dist))
mq4c<-median(unlist(q4c$dist))
mq3r<-median(unlist(q3r$dist))
mq3c<-median(unlist(q3c$dist))
mq2r<-median(unlist(q2r$dist))
mq2c<-median(unlist(q2c$dist))
mq1r<-median(unlist(q1r$dist))
mq1c<-median(unlist(q1c$dist))
mq0r<-median(unlist(q0r$dist))
mq0c<-median(unlist(q0c$dist))

mq5rl<-median(unlist(q5r$range))
mq5cl<-median(unlist(q5c$range))
mq4rl<-median(unlist(q4r$range))
mq4cl<-median(unlist(q4c$range))
mq3rl<-median(unlist(q3r$range))
mq3cl<-median(unlist(q3c$range))
mq2rl<-median(unlist(q2r$range))
mq2cl<-median(unlist(q2c$range))
mq1rl<-median(unlist(q1r$range))
mq1cl<-median(unlist(q1c$range))
mq0rl<-median(unlist(q0r$range))
mq0cl<-median(unlist(q0c$range))
#system.time(get.mean(q5,tdbcorp)) #45s
# qdf<-data.frame(q=c(letters[1:5],letters[1:5]),
#                 d=c(76,81,63,55,70,124,131,83,70,103),
#                 corp=c(rep("obs",5),rep("ref",5)))
# qdf<-data.frame(q=c(letters[1:5],letters[1:5]),
#                 d=c(76,81,63,55,70,124,131,83,70,103),
#                 corp=c(rep(1,5),rep(0,5)))
# qdf1<-data.frame(q=c(letters[1:5],letters[1:5]),
#                 d=c(76,81,63,55,70,124,131,83,70,103),
#                 corp=c(rep(0,5),rep(1,5)))
qdf<-data.frame(q=c(letters[1:6],letters[1:6]),
                dist=c(mq0c,mq1c,mq2c,mq3c,mq4c,mq5c,mq0r,mq1r,mq2r,mq3r,mq4r,mq5r),
                range=c(mq0cl,mq1cl,mq2cl,mq3cl,mq4cl,mq5cl,mq0rl,mq1rl,mq2rl,mq3rl,mq4rl,mq5rl),
                corp=c(rep("obs",6),rep("ref",6)))
# qdf1<-data.frame(q=c(letters[1:5],letters[1:5]),
#                 d=c(q1c,q2c,q3c,q4c,q5c,q1r,q2r,q3r,q4r,q5r),
#                 corp=c(rep(0,5),rep(1,5)))
# mode(qdf1[,2])<-"double"
# mode(qdf1[,3])<-"double"
# library(lme4)
# #install.packages("lme4",type = "source")
# qdf
# lm1<-lmer(d~corp+(1|q),qdf)
# summary(lm1)
# lm2<-lmer(d~q+(1|corp),qdf)
# s2<-summary(lm2)
# s2
# print(lm2,signif.stars=T)
# lm2<-glmer(d~q+(1|corp),qdf)
# summary(lm2)
# library(lattice)
# anova(lm2)
# library(stats)
# qdf.c<-qdf[,c(2,3)]
cor.test(qdf1[,2],qdf1[,3])
# df<-tdb

### eval
#qdf<-read_csv("eval-001.csv")
df1<-qdf
n_obs<-length(tdbcorp$token)
n_ref<-length(tdbref$token)
tu_obs<-length(unique(tdbcorp$token))
tu_ref<-length(unique(tdbref$token))
ld_obs<-tu_obs/n_obs
ld_ref<-tu_ref/n_ref

df1$ld[df1$corp=="obs"]<-ld_obs
df1$ld[df1$corp=="ref"]<-ld_ref
# Example if you have size data
df1$corp_size <- ifelse(df1$corp == "obs", n_obs, n_ref)
# q0mc<-get.q(q0,tdbcorp)
# q0mr<-get.q(q0,tdbref)
# q1mc<-get.q(q1,tdbcorp)
# q1mr<-get.q(q1,tdbref)
# q2mc<-get.q(q2,tdbcorp)
# q2mr<-get.q(q2,tdbref)
# q3mc<-get.q(q3,tdbcorp)
# q3mr<-get.q(q3,tdbref)
# q4mc<-get.q(q4,tdbcorp)
# q4mr<-get.q(q4,tdbref)
# q5mc<-get.q(q5,tdbcorp)
# q5mr<-get.q(q5,tdbref)
# q1mc<-get.matches(q1,tdbcorp)
# q1mr<-get.matches(q1,tdbref)
# q2mc<-get.matches(q2,tdbcorp)
# q2mr<-get.matches(q2,tdbref)
# q3mr<-get.matches(q3,tdbref)
# q3mc<-get.matches(q3,tdbcorp)
# q4mr<-get.matches(q4,tdbref)
# q4mc<-get.matches(q4,tdbcorp)
# q5mr<-get.matches(q5,tdbref)
# q5mc<-get.matches(q5,tdbcorp)

df1$m<-unlist(lapply(list(q0mc,q1mc,q2mc,q3mc,q4mc,q5mc,q0mr,q1mr,q2mr,q3mr,q4mr,q5mr),sum))
# df
# sum(q1mc)
# model <- lm(d ~ corp * q + corp_size + m, data = df)
# 
# anova(model)
# lmer(d~corp*q+corp_size,df)
# 
# anova(model)
############################################
# library(lme4)
# library(lmerTest)
# df$corp<-c(rep("A",6),rep("B",6))
# df
# df$m_rel<-df$m/df$corp_size
# df
# model1<-lmer(dist~corp*m_rel*range+(1|q),df)
# model2 <- lmer(dist ~ corp*m_rel + (1|q)+(1|range), data = df) # with relative match frequencies
# 
# summary(model1) #p=0.043 for corpA (obs)
# summary(model2) #p=0.00024
# TODO: comment range (mean length of observed range) as var, influences overall token distance
############################################
# q=query,m=matches,d=distance,corp=obs/ref
#wks. p=0.043 for corpA (obs)
#############################
### gpt manually:
#df1 <- read.csv(paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/psych/HA/eval-001.csv"))
df1$m_rel<-df1$m/df1$corp_size

data<-dfa

# Center covariates
 t1<-data$range[data$q=="a"]
 t2<-diff(t1)
# t3<-
data$range_c    <- data$range    - mean(data$range[data$q=="a"]) # level intercept for conditions b-f 
data$range_c    <- data$range    - mean(data$range[data$q=="a"]) # level intercept for conditions b-f 
#data$corpsize_c <- data$corp_size - mean(data$corp_size)
#data$m_rel_c    <- data$m_rel    - mean(data$m_rel)
#data$m_rel_c    <- data$mf_rel - mean(data$mf_rel[data$q=="a"])
#t1<-c(1200,500)
#t2<-abs(t1[1]-t1[2])-abs(t1[1]-t1[2])
# Corpus dummy
data$corpusB <- ifelse(data$target == 'ref', 1, 0)
data$corpusA <- ifelse(data$target == 'obs', 1, 0)

# Dummy code condition (a-e) into 4 dummy vars (base = 'a')
data$cond_a <- ifelse(data$q == 'a', 1, 0)
data$cond_b <- ifelse(data$q == 'b', 1, 0)
data$cond_c <- ifelse(data$q == 'c', 1, 0)
data$cond_d <- ifelse(data$q == 'd', 1, 0)
data$cond_e <- ifelse(data$q == 'e', 1, 0)
data$cond_f <- ifelse(data$q == 'f', 1, 0)

# table(data$q)
# dummy_matrix <- as.matrix(cbind(
#   data$cond_b,
#   data$cond_c,
#   data$cond_d,
#   data$cond_e
# ))

# qr(dummy_matrix)$rank
# cor(data$corpusB, data$cond_b)
# cor(data$corpusB, data$cond_c)
# cor(data$corpusB, data$cond_d)
# cor(data$corpusB, data$cond_e)

X <- as.matrix(cbind(
  1,
  data$corpusB,
 # data$range_c,
  #data$corpsize_c,
  #data$m_rel_c,
#  data$cond_a,
  data$cond_b,
  data$cond_c,
  data$cond_d,
  data$cond_e,
  data$cond_f
))
# X <- as.matrix(cbind(
#   1,
#   data$corpusB,
#   data$range_c,
#   data$corpsize_c,
#   data$m_rel_c,
#   data$cond_b,
#   data$cond_c,
#   data$cond_d,
#   data$cond_e
# ))
qr(X)$rank  # should equal ncol(X) = 8

Y <- data$dist

XtX <- t(X) %*% X
XtY <- t(X) %*% Y
beta_hat <- solve(XtX) %*% XtY
#?solve
# m<-matrix(c(1,0,2,1,1,1,1,1,3),ncol = 3)
# m
# solve(m)
# 2^-1
residuals <- Y - X %*% beta_hat
n <- nrow(X)
k <- ncol(X)
sigma2_hat <- sum(residuals^2) / (n - k)

cov_beta <- sigma2_hat * solve(XtX)
std_errors <- sqrt(diag(cov_beta))

t_value <- beta_hat[2] / std_errors[2]
df <- n - k
p_value <- 2 * pt(-abs(t_value), df)
# 1st: 0.352
# 2nd, wt intercept = query(0) : 0.07
coeff<-solve(t(X) %*% X) %*% t(X) %*% data$dist
coeff<-round(coeff,3)
coeff
co.df<-data.frame(coeff,row.names = c("intercept",colnames(data)[c(11,3,7,13,14,15,16,17)]))
co.df<-data.frame(coeff,row.names = c("intercept","targetRef","b","c","d","e","f"))
co.df
p_v<-round(p_value,5)
# # Fit reduced model without the term of interest
# reduced_model <- lmer(d ~ q + (1|corp_size), data = df) 
# full_model <- lmer(d ~ corp*m + (1|corp_size), data = df)
# 
# # Compare models
# anova(reduced_model, full_model) # Gives chi-square test and p-value




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

### 15281.new essai
# finding too many q-noun relations which made no sense in our noun distance measure. try new...
m1<-tdbcorp$upos=="NOUN"
sum(m1)
nouns<-unique(tdbcorp$lemma[m1])
nouns.df<-data.frame(lemma=nouns,include=1)
#write_csv(nouns.df,paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/psych/HA/nouns-001.csv"))




# write_csv(qdf,"~/gith/SPUND-LX/psych/HA/eval-001.csv")
library(readr)
 write_csv(df1,paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/psych/HA/eval-001.csv"))
 write_csv(q.all.df,paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/psych/HA/eval-002.csv"))
 # #  library(jsonlite)
# write_json(list(a=q0,b=q1,c=q2,d=q3,e=q4,f=q5),paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/psych/HA/eval-qs.json"))

