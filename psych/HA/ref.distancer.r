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
  print(sum(unlist(re)))
  return(re)
}
q<-q5
tdb<-tdbcorp
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
get.mean<-function(q,tdb){
  column<-names(q)
  re1<-get.q(q,tdb)
  re1<-unlist(re1)
  re1w<-which(re1)
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
  te<-2
  x<-tok.dem.u[te]
  tok.test<-tok.dem.u[1:5]
  lt<-lapply(tok.dem.u, function(x){
    # lt<-lapply(tok.test, function(x){
      #strsplit(x,"a")
   # print(x)
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
   # cat(sum(mn),"\n")
    mnw<-which(mn)
    lemma<-tdb$lemma[mnw[1]]
    mn2<-tdb$lemma==lemma
    mnw<-which(mn2)
    #mnw<-mnw[te:length(mnw)]
    mnw1<-mnw-1
    mnwq<-mnw1%in%re1w
    sum(mnwq)
    mnwqw<-which(mnwq)
    tdb[mnw,column]
    tdb[mnw1,column]
    tdb[mnw1[mnwqw],column]
    mnw<-mnw1[mnwqw] # this reduces to nouns with respective token (q) preceding
    
    #p1<-lapply(seq_along(1:length(mnw)),function(b){
    mnw.sub<-mnw[te:length(mnw)]
    c<-mnw[1]
    m1<-lapply(mnw, function(c){
     # print(c)
      uid<-tdb$uid[c]
      range<-tdb$uid==uid
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
    return(dist)
    # if(px>1){
    #   p.b<-p.before[p.before<c]
    #   #p.a<-p.before[p.before>npos]
    #   #p.b.p<-p.b.p<
    #   return(list(pos=npos,before=p.b))
    #   
    # }
#    return(p1)
    })
    m1u<-unique(m1)
   # mean(unlist(m1)) #107
  #  mean(unlist(m1u)) #115
   # median(unlist(m1)) #56
    return(unlist(m1))
    return(median(unlist(m1u))) #56
    
   # return(p1)
  })
  lt2<-lt[!is.na(lt)]
  unlist(lt2)
  mlt2<-median(unlist(lt2))
  print(mlt2)
  return(mlt2) #1.q5.40.5 (with return median distances) / 43 with return unlist(m1)[all distances]
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
#system.time(get.mean(q5,tdbcorp)) #45s
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
#install.packages("lme4",type = "source")
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

### eval
qdf<-read_csv("eval-001.csv")
df<-qdf
n_obs<-length(tdbcorp$token)
n_ref<-length(tdbref$token)

# Example if you have size data
df$corp_size <- ifelse(df$corp == "obs", n_obs, n_ref)
q1mc<-get.matches(q1,tdbcorp)
q1mr<-get.matches(q1,tdbref)
q2mc<-get.matches(q2,tdbcorp)
q2mr<-get.matches(q2,tdbref)
q3mr<-get.matches(q3,tdbref)
q3mc<-get.matches(q3,tdbcorp)
q4mr<-get.matches(q4,tdbref)
q4mc<-get.matches(q4,tdbcorp)
q5mr<-get.matches(q5,tdbref)
q5mc<-get.matches(q5,tdbcorp)

df$m<-unlist(lapply(list(q1mc,q2mc,q3mc,q4mc,q5mc,q1mr,q2mr,q3mr,q4mr,q5mr),sum))
df
sum(q1mc)
model <- lm(d ~ corp * q + corp_size + m, data = df)

anova(model)
lmer(d~corp*q+corp_size,df)

anova(model)
#################
library(lmerTest)
df$corp<-c(rep("A",5),rep("B",5))
df
df$m_rel<-df$m/df$corp_size
model1<-lmer(d~corp*m+(1|q)+(1|corp_size),df)
model2 <- lmer(d ~ corp*m_rel + (1|q), data = df) # with relative match frequencies

summary(model1) #p=0.043 for corpA (obs)
summary(model2) #p=0.00024
############################################
# q=query,m=matches,d=distance,corp=obs/ref
#wks. p=0.043 for corpA (obs)
#############################
# Fit reduced model without the term of interest
reduced_model <- lmer(d ~ q + (1|corp_size), data = df) 
full_model <- lmer(d ~ corp*m + (1|corp_size), data = df)

# Compare models
anova(reduced_model, full_model) # Gives chi-square test and p-value




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
write_csv(df,paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/psych/HA/eval-001.csv"))
# library(jsonlite)
# write_json(list(a=q1,b=q2,c=q3,d=q4,e=q5),"~/gith/SPUND-LX/psych/HA/eval-qs.json")

