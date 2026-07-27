imp<-"# prio
## capacities
1. textur
2. lxtech
3. litki
4. nietzsche

## like
1. textur
2. nietzsche
3. litki
4. lxtech

## dringlichkeit
1. avl
2. spund
"
getwd()
#f<-list.dirs("Documents/GitHub",full.names=T,recursive=T)
f
#setwd(f[85])
setwd("/Users/guhl/Documents/GitHub/SPUND-LX/agenda")
df<-read.csv("prio.csv")
df
# ?rowsum
# df$sum=rowsum(df)
# x <- matrix(runif(100), ncol = 5)
# group <- sample(letters[1:8], 20, TRUE)
# group
# length(group)
# (xsum <- rowsum(x, group))
# group<-letters[1:length(df$fac)]
# group
# dim(df)
# #(df$sum <- rowsum(df[,3:length(df)], 1:length(df$fac)))
# ## Slower versions
# x<-df[1,]
# x

df$sum<-unlist(lapply(1:length(df$fac),function(x){
  d<-df[x,]
  m<-d$fac==df$q
  d$prio<-df$prio[m]
  s<-sum(d[3:5],na.rm = T)}))
  




df
