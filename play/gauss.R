# 20250609(17.39)
# 15243.math
############
# 1.kleiner gauss
# 1.
a<-seq_along(1:100)
b<-a+1
c<-lapply(seq_along(a), function(i){
a[i]+b[i]  
})
d<-unlist(c)
d<-d[1:(length(a)-1)]
sum(d)
# 2.
e<-array()
f<-array()
g<-array()
k<-1
f<-4
for (k in 1:length(a)){
if(k==1){
  s1<-a[k]+1
  e[k]<-s1/2
}
if(k>1){
  
s1<-e[k-1]+a[k]
e[k]<-s1
#f[k]<-e[k]+b[k]
#g[k]<-sum(f,na.rm = T)
}
}
sum(e,na.rm = T)
#f
e
plot(e)
library(clipr)
write_clip(e)
1*(1+1)/2
2*(2+1)/2
