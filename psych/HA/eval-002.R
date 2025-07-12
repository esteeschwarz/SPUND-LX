#20250730(19.09)
#15273.reddit.stats.analysis
############################
#dfa<-read.csv(paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/psych/HA/eval-002.csv"))
#dfa<-read.csv(paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/psych/HA/eval-003.csv"))
#dfa<-read.csv(paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/psych/HA/eval-004.csv"))
### df 005 to big for git as .csv
#load(paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/psych/HA/eval-005.RData")) # qltdf
read.db<-function(){
  
  
  library(DBI)
  library(RSQLite)
  #con <- dbConnect(RSQLite::SQLite(),"~/db/reddit_com.df.15242.sqlite")
  con <- dbConnect(RSQLite::SQLite(),"~/db/reddit_com.df.15276.sqlite")
  dbListTables(con)
  #tdb.pos<-dbGetQuery(con,"SELECT * FROM reddit_com_pos")
  tdbref<-dbGetQuery(con,"SELECT * FROM reddit_pos_ref")
  tdbcorp<-dbGetQuery(con,"SELECT * FROM reddit_com_pos")
  return(list(obs=tdbcorp,ref=tdbref))
}
tdb<-read.db()
n_obs<-length(tdb$obs$token)
n_ref<-length(tdb$ref$token)
rm(tdb)
eval.ns<-list.files(paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/psych/HA/"))
eval.ext<-c(".csv",".RData")
eval.f<-eval.ns[unlist(lapply(eval.ext,function(x){grep(paste0("eval-0..",x),eval.ns)}))]
eval.fs<-paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/psych/HA/",eval.f)
eval.fs
library(tools)
#dataset<-5
eval.n.hard<-dataset
dn<-dataset
read.eval<-function(dn){
  e<-new.env()
  ext<-file_ext(eval.fs[dn])
  f<-eval.fs[dn]
  f
  ifelse(ext=="csv",out<-read.csv(f),load(f,envir = e))
  ifelse(ext=="csv",out<-out,out<-e$qltdf)
  return(out)
  
}
###################
# select eval 3-5
# if rmd defined eval.n
#eval.n.hard<-2

ifelse(exists("eval.n"),qltdf<-read.eval(eval.n),qltdf<-read.eval(eval.n.hard))
dfa<-qltdf
###################
mx<-colnames(dfa)!="X"
if(!is.null(mx))
  dfa<-dfa[,mx]
#dfa<-qltdf
queries<-unique(dfa$query_long)
if(is.null(queries))
  queries<-unique(dfa$q)
qf<-dfa$q%in%letters[1:6]
if(sum(qf)==0){
  qn<-unique(dfa$q)
  dfa$q_long<-dfa$q
  c<-letters[1:length(qn)]
  for(k in 1:length(qn)){
    m<-dfa$q==qn[k]
    dfa$q[m]<-c[k]
  }
queries<-unique(dfa$q)
  
}

#df<-q.all.df
# qn<-unique(dfa$q)
# c<-letters[1:length(qn)]
# for(k in 1:length(qn)){
#   m<-dfa$q==qn[k]
#   dfa$q[m]<-c[k]
# }
unique(dfa$q)

Y <- dfa$dist           # Dependent variable
mean(Y[dfa$target=="obs"])
mean(Y[dfa$target=="ref"])
target <- dfa$target       # Assuming the second column is the grouping variable

target <- as.factor(target)
table(target)
dfsa<-dfa[dfa$q%in%queries[c(2,3,4)],]
dfsb<-dfa[dfa$q%in%queries[c(5,6)],]
length(dfsa$dist)
length(dfsb$dist)
#Y<-dfsb$dist
#anova_model <- aov(Y ~ target, data = dfa)
anova_model <- aov(Y ~ target*q, data = dfa)
#anova_model <- aov(Y ~ target, data = dfsb)
#anova_model <- aov(Y ~ group*q, data = dfa)
anova.sum<-summary(anova_model)
anova.sum
library(lmerTest)
#scipen(999)
#lm1<-lmer(dist~target*q+(1|mf_rel)+(1|range)+(1|ld),dfa)
#lm2<-lmer(dist~target+range+(1|lemma),dfa)
lme.form<-"dist~target*q+range+(1|lemma)"
lm2<-lmer(eval(expr(lme.form)),dfa)
#lm2<-lmer(dist~target*q+range+(1|lemma),dfa)
#lm2<-lmer(dist~target*q+range+(1|lemma),dfa)
#lm2<-lm(dist~target*q+range,dfa) # without random effects
summary(lm2)
lm2.summ<-summary(lm2)
lm2.summ
anlm.summ<-anova(lm2)
anlm.summ
#lm.summ<-summary(lm1)
#an.summ<-anova(lm1)
lm2.summ
anlm.summ
mean(dfa$dist[dfa$target=="obs"])
mean(dfa$dist[dfa$target=="ref"])
for(q in seq_along(queries)){
  query<-queries[q]
#  cat("condition:",query," > obs / ref\n")
  #cat("obs,ref\n")
  mno<-mean(dfa$dist[dfa$target=="obs"&dfa$q==query])
  mnr<-mean(dfa$dist[dfa$target=="ref"&dfa$q==query])
  
}
# mean(dfa$dist[dfa$target=="obs"&dfa$q=="a"])
# mean(dfa$dist[dfa$target=="ref"&dfa$q=="a"])
# mean(dfa$dist[dfa$target=="obs"&dfa$q=="b"])
# mean(dfa$dist[dfa$target=="ref"&dfa$q=="b"])
# mean(dfa$dist[dfa$target=="obs"&dfa$q=="c"])
# mean(dfa$dist[dfa$target=="ref"&dfa$q=="c"])
# mean(dfa$dist[dfa$target=="obs"&dfa$q=="d"])
# mean(dfa$dist[dfa$target=="ref"&dfa$q=="d"])
# mean(dfa$dist[dfa$target=="obs"&dfa$q=="e"])
# mean(dfa$dist[dfa$target=="ref"&dfa$q=="e"])
# mean(dfa$dist[dfa$target=="obs"&dfa$q=="f"])
# mean(dfa$dist[dfa$target=="ref"&dfa$q=="f"])
#wks.
# #get mean:
# m.target<-median(dfa$dist[dfa$target=="obs"])
# m.ref<-median(dfa$dist[dfa$target=="ref"])
k<-1
c<-1
get.m.df<-function(dfa){
  q.u<-unique(dfa$q) 
  ql<-unlist(lapply(seq_along(q.u),function(i){
    rep(q.u[i],2)
  }))
  ql
  c.u<-unique(dfa$target)
  df.m<-data.frame(target=rep(c.u,6),q=ql,n=NA,mean=NA,median=NA)
  for(k in 1:length(q.u)){
    qx<-q.u[k]
    m.q<-dfa$q==qx
    sum(m.q)
    for(c in 1:length(c.u)){
      cx<-c.u[c]
      m.c<-dfa$target[m.q]==cx
      l<-sum(m.c)
      df.m$n[df.m$target==cx&df.m$q==qx]<-l
      df.m$mean[df.m$target==cx&df.m$q==qx]<-mean(dfa$dist[m.q][m.c])
      df.m$median[df.m$target==cx&df.m$q==qx]<-median(dfa$dist[m.q][m.c])
    }
  }
  return(df.m)
}


# Read the data
#df <- read.csv("eval-001.csv")
df.eval<-get.m.df(dfa)
df.eval$mean[df.eval$target=="obs"]
df.eval$mean[df.eval$target=="ref"]
dfe<-df.eval

# Ensure q is ordered a-f
dfe$q <- factor(dfe$q, levels = c("a", "b", "c", "d", "e", "f"))


### not for eval-002
gpt.manual.fun<-function(dfa){
#gpt manual p
  data<-dfa
  
  # Center covariates
  # t3<-
  data$range_c    <- data$range    - mean(data$range[data$q=="a"]) # level intercept for conditions b-f 
  # Corpus dummy
  data$corpusB <- ifelse(data$target == 'ref', 1, 0)
  data$corpusA <- ifelse(data$target == 'obs', 1, 0)
  
  # Dummy code condition (a-e) into 4 dummy vars (base = 'a')
  #data$cond_a <- ifelse(data$q == 'a', 1, 0)
  data$cond_b <- ifelse(data$q == 'b', 1, 0)
  data$cond_c <- ifelse(data$q == 'c', 1, 0)
  data$cond_d <- ifelse(data$q == 'd', 1, 0)
  data$cond_e <- ifelse(data$q == 'e', 1, 0)
  data$cond_f <- ifelse(data$q == 'f', 1, 0)
  

  X <- as.matrix(cbind(
    1,
    data$corpusB,
    # data$range_c,
    #data$corpsize_c,
    #data$m_rel_c,
  #    data$cond_a,
    data$cond_b,
    data$cond_c,
    data$cond_d,
    data$cond_e,
    data$cond_f
  ))
  qr(X)$rank  # should equal ncol(X) = 8
  
  Y <- data$dist
  
  XtX <- t(X) %*% X
  XtY <- t(X) %*% Y
  beta_hat <- solve(XtX) %*% XtY
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
  colnames(data)
  co.ns<-grep("corpusB|cond_b|cond_c|cond_d|cond_e|cond_f",colnames(data))
  co.df<-data.frame(coeff,row.names = c("intercept",colnames(data)[co.ns]))
  #co.df<-data.frame(coeff,row.names = c("intercept","targetRef","b","c","d","e","f"))
  co.df
  p_v<-round(p_value,14)
  return(co.df)
}
#co.df<-gpt.manual.fun(dfe)
#co.df
plot.dist<-function(){
# Reshape data: rows = q, columns = corp, values = dist
bar_mat <- tapply(dfe$median, list(dfe$q, dfe$target), identity)
bar_mat <- t(bar_mat)  # barplot expects groups in columns

# Make grouped barplot
df.plot<-barplot(bar_mat,
        beside = TRUE,
        col = c("black", "red"),
        names.arg = levels(dfe$q),
        legend.text = rownames(bar_mat),
        args.legend = list(x = "right"),
        ylab = "median distance",
        main = "distance by query and corpus")

}
#plot.dist()
rest.fun<-function(){
# df.eval$mean==mdf$mean
# df.eval$median==mdf$median
# df.eval$mean<-mdf$mean
# df.eval$median<-mdf$median
# # Set colors: black for obs, red for ref
# bar_colors <- ifelse(df.eval$target == "obs", "black", "red")
# 
# # Set bar names: combine condition and corpus for clarity
# bar_names <- paste0(df.eval$q)
# 
# barplot(
#   height = as.numeric(df.eval$mean),
#   names.arg = bar_names,
#   col = bar_colors,
#   las = 1,
#   cex.names = 0.7,
#   main = "Distances distribution of corpus/reference corpus over conditions",
#   ylab = "token distance",
#   beside = TRUE
# )
# legend("topright", legend = c("obs", "ref"), fill = c("black", "red"))
# bar_matrix <- t(as.matrix(df.eval$median[df.eval$target%in%c("obs", "ref")]))
# t.sum<-rowSums(df1_wide[,3:length(df1_wide)],na.rm = T)
# t.sum<-rowSums(df1_wide,na.rm = T)
# t.sum
#bar_matrix <- t.sum
# Plot grouped barplot
# barplot(
#   bar_matrix,
#   beside = TRUE,
#   #  names.arg = c("0",levels(df1_wide$q)[2:6]),
#   col = c("black", "red"),
#   las = 1,
#   cex.names = 0.7,
#   main = "Distances distribution over conditions",
#   ylab = "same-noun distance"
# )
# legend("topright", legend = c("obs", "ref"), fill = c("black", "red"))
#anova_model <- aov(dist ~ group + q + mf_rel , range, data = df)
#summary(anova_model)
#not. wks
# 
# #15276.caveats, new essai
# #general test
# # build query interface
# 
# build.q<-function(){
# q0<-list(a=list(q=".*",det="DET"))
# q1<-list(b=list(q=c("this","that","these","those"),det="DET")) # mean distance: 76
# q2<-list(c=list(q=c("the"),det="DET")) # mean distance: 81
# q3<-list(d=list(q=c("a","an","some","any"),det="DET")) # mean distance: 63, lower
# q4<-list(e=list(q=c("my"),det=F)) # mean distance: 55, lower
# q5<-list(f=list(q=c("your","their","his","her"),det=F)) # mean distance: 100, higher
# 
# return(list(q0,q1,q2,q3,q4,q5))
# }
# qs<-build.q()
# qs[[2]]
# names(qs)
# qs
# qk<-2
# get.dist<-function(qk,tdbw,det="notset"){
# ifelse(tdbw=="obs",tdb<-tdbcorp,tdb<-tdbref)
# uid<-tdb$uid
# length(unique(uid))
# head(uid)
# uid2<-gsub("dfurl([0-9]{1,4})-.*","\\1",uid)
# #uid2<-gsub("-.*","",uid)
# head(uid2)
# length(unique(uid2))
# tdb$url<-uid2
# m<-tdb$upos=="NOUN"
# qs[[qk]][[1]]$q
# # m2<-tdbcorp$token%in%c("this","that","those","these")
# query<-unlist(qs[[qk]][[1]]$q)
# ifelse(qk!=1,m2<-tdb$token%in%query,m2<-!is.na(tdb$token)) # if condition A, match all tokens
# m1w<-which(m)
# m2w<-which(m2)
# det.q<-qs[[qk]][[1]]$det
# det.y<-F
# #det<-F
# if(mode(det)=="character")
#   det.y<-T
# ifelse(det!="notset"&det.y,det.q<-det,det.y<-F)
# # det<-F
#  ifelse(det.y,1,2)
# ifelse(det.y,m5<-tdb$upos==det.q,m5<-m2)
# 
# # m5<-tdb$upos=="DET"
# m5w<-which(m5)
# m6<-m2w%in%m5w
# m2w<-m2w[m6]
# sum(m6)
# # q1<-head(tdbcorp$token[(m2w)],20)
# # t1<-head(tdbcorp$token[(m2w+1)],20)
# # u1<-head(tdbcorp$upos[(m2w)],20)
# 
# p1<-m1w[m2w]
# # l1<-tdbcorp$lemma[p1]
# # uid1<-tdbcorp$url[p1]
# # nouns.det<-unique(l1)
# # nouns.det<-data.frame(lemma=nouns.det,include=1)
# #write_csv(nouns.det,paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/psych/HA/nouns-002.csv"))
# 
# d1<-lapply(p1, function(x){
# l2<-tdb$lemma[x]
# u2<-tdb$url[x]
# r1<-tdb$url==u2
# r1w<-which(r1)
# l3<-tdb$lemma[r1w]==l2
# l3w<-which(l3)
# d1<-diff(l3w)
# ifelse(length(d1)>0,
#   df<-data.frame(q=names(qs[[qk]]),target=tdbw,url=u2,lemma=l2,range=sum(r1),dist=d1,det=det.y),
#   df<-NA)
# #df$url<-u2
# #df$range<-length(r1w)
# return(df)
# return(data.frame(url=u2,lemma=l2,range=r1w,dist=d1))
# return(list(url=u2,lemma=l2,range=r1w,dist=d1))
# })
# 
# return(d1)
# }
# qda<-get.dist(1,"obs","DET")
# qdb<-get.dist(2,"obs","DET")
# qdc<-get.dist(3,"obs","DET")
# qdd<-get.dist(4,"obs","DET")
# qde<-get.dist(5,"obs",F)
# qdf<-get.dist(6,"obs",F)
# #qdb<-get.dist(qk,"obs")
# qdar<-get.dist(1,"ref","DET")
# qdbr<-get.dist(2,"ref","DET")
# qdcr<-get.dist(3,"ref","DET")
# qddr<-get.dist(4,"ref","DET")
# qder<-get.dist(5,"ref",F)
# qdfr<-get.dist(6,"ref",F)
# #########################
# get.lt.df<-function(ql){
#   
# lt1<-ql
# #length(lt1[[1]])
# # lt2<-lapply(lt1, function(x){
# #   l<-length(x)
# #   return(ifelse(l!=0,x,NA))
# # })
# lt2<-lt1[!is.na(lt1)]
# lt3<-lapply(lt2, function(x){
#   df3<-data.frame(x$dist)
#   df3$q<-x$q
#   df3$target<-x$target
#   df3$url<-x$url
#   df3$lemma<-x$lemma
#   df3$range<-x$range
#   df3$det<-x$det
# #  df3$mf_rel<-x[[1]]$mf_rel
#  # df3$ld<-x[[1]]$ld
#   return(df3)
#   return(x[[1]]$dist)
# })
# library(abind)
# lt4.df<-data.frame(abind(lt3,along = 1))
# colnames(lt4.df)[1]<-"dist"
# mode(lt4.df$dist)<-"double"
# mode(lt4.df$range)<-"double"
# print(mean(lt4.df$dist))
# print(median(lt4.df$dist))
# return(lt4.df)
# }
# 
# qltdf<-rbind(get.lt.df(qda),get.lt.df(qdb),get.lt.df(qdc),get.lt.df(qdd),get.lt.df(qde),get.lt.df(qdf),
#              get.lt.df(qdar),get.lt.df(qdbr),get.lt.df(qdcr),get.lt.df(qddr),get.lt.df(qder),get.lt.df(qdfr))
# #write.csv(qltdf,paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/psych/HA/eval-003.csv"))


paste(q1,t1,u1,sep = " ")
m3<-m1w%in%(m2w+1)
m4<-(m2w+1)%in%m1w
m4w<-which(m4)
sum(m3)
m3w<-which(m3)
head(m3w,20)
show.tok<-function(k){
q1<-tdbcorp$token[m2w[m4w]][k]
t1<-tdb$token[m1w[m3w]][k]
u1<-tdb$upos[m2w[m4w]][k]
print(paste(q1,t1,u1,sep = " "))
u1<-tdb$uid[m1w[m3w]][k]
print(u1)
#u1<-tdb[m1w[m3w[1:20]],]$uid[1]
#tdb[m2w[m4w[1:20]],]
#uid<-tdb$uid[m1w][m3w]
r1<-tdb$uid==u1
sum(r1)
print(tdb$token[r1])
print(tdb$upos[r1])
}
show.tok(2)
}
sumtx<-data.frame(anlm.summ)
sumtx<-cbind(anova.plain=rownames(sumtx),sumtx)
#umtx$dun<-NA
lmco<-lm2.summ$coefficients
lmco<-cbind(anova.lme=rownames(lmco),lmco,"---")

empty<-(rep("---",6))
ns.an<-colnames(sumtx)
ns.lm<-c(colnames(lmco))
colnames(sumtx)<-rep("X",7)
colnames(lmco)<-rep("X",7)
sumtxdf<-rbind(ns.an,sumtx,ns.lm,lmco,empty)




# write.table(sumtxdf,paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/psych/HA/anovas.csv"),append = T,sep=",",row.names = F)
# 
# anovas<-read.csv(paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/psych/HA/anovas.csv"))

plot.lme<-function(anovas){
  plot.dist<-function(dfe){
    # Reshape data: rows = q, columns = corp, values = dist
    # bar_mat <- tapply(dfe$median, list(dfe$q, dfe$target), identity)
    # bar_mat <- t(bar_mat)  # barplot expects groups in columns
    bar_mat<-dfe$X.1
    print(bar_mat)
    # Make grouped barplot
    df.plot<-barplot(bar_mat,
                     beside = TRUE,
#                     col = c("black", "red"),
                     names.arg = levels(rownames(dfe)),
#                     legend.text = rownames(bar_mat),
 #                    args.legend = list(x = "right"),
                     ylab = "median distance",
                     main = "distance by query and corpus")
    
  }
  m<-anovas$X=="anova.lme"
  sum(m)
  m2<-anovas$X=="---"
  m2w<-which(m2)
  m1w<-which(m)
  x<-m1w[1]
  lapply(m1w, function(x){
    range<-(x+1):(x+13)
    subdf<-anovas[range,]
    mode(subdf$X.1)<-"double"
    subdf$plot<-subdf$X.1[1]-subdf$X.1
    subdf$plot<-subdf$X.1
    subdf$plot[1]<-0
    # barplot(subdf$X.1~subdf$X,xlab = "",ylab="mean distance",main="lmer estimates")
    par(las=2)
    # After your barplot call
    bp <- barplot(subdf$plot~subdf$X,xlab = "",ylab="mean distance",main="lmer estimate relations")
    # bp <- barplot(bar_mat, beside = TRUE, col = c("black", "red"), names.arg = levels(dfe$q), legend.text = rownames(bar_mat), args.legend = list(x = "right"), ylab = "median distance", main = "distance by query and corpus")
    
    # Get the y-value for the line (e.g., first bar's height)
    y_intercept <- subdf$plot[1]
    
    # Get x-limits from the barplot (bp gives midpoints of bars)
    x_min <- min(bp)
    x_max <- max(bp)
    
    # Draw the horizontal line only within the barplot area
  #  segments(x0 = x_min, y0 = y_intercept, x1 = x_max, y1 = y_intercept, col = "red", lwd = 1)
    tx<-x_max+1
    ty<-2
    # Add label "intercept" near the line (adjust x/y as needed)
   # text(x = tx, y = ty, labels = "intercept", pos = 3, col = "red", cex = 0.8)
    text(x = tx-4, y = ty+10, labels = paste0("Intercept (targetobs) = ",round(subdf$X.1[1],0)), pos = 3, col = "black", cex = 0.8)
    #  abline(h = subdf$X.1[1], col = "red", lwd = 1)
    
    

})
  
}
rmd.plot.lme<-function(lm2.summ){
coef<-lm2.summ$coefficients
cats<-rownames(coef)
mean.abs<-coef[,1]
mean.abs[1]<-0
par(las=2)
# After your barplot call
bp <- barplot(mean.abs~cats,xlab = "",ylab="mean distance",main="lmer estimate relations")
# bp <- barplot(bar_mat, beside = TRUE, col = c("black", "red"), names.arg = levels(dfe$q), legend.text = rownames(bar_mat), args.legend = list(x = "right"), ylab = "median distance", main = "distance by query and corpus")

# Get the y-value for the line (e.g., first bar's height)
y_intercept <- mean.abs[1]

# Get x-limits from the barplot (bp gives midpoints of bars)
x_min <- min(bp)
x_max <- max(bp)

# Draw the horizontal line only within the barplot area
#  segments(x0 = x_min, y0 = y_intercept, x1 = x_max, y1 = y_intercept, col = "red", lwd = 1)
tx<-x_max+1
ty<-2
# Add label "intercept" near the line (adjust x/y as needed)
# text(x = tx, y = ty, labels = "intercept", pos = 3, col = "red", cex = 0.8)
text(x = tx-4, y = ty+10, labels = paste0("Intercept (targetobs) = ",round(coef[1,1],0)), pos = 3, col = "black", cex = 0.8)
#return(bp)
}
#rmd.plot.lme(lm2.summ)
#plot.lme(anovas)

