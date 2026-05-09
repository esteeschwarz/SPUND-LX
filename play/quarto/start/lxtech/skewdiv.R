# 20260508(20.05)
# 16197.lx-tech.zinsmeister
###########################

## ----skew

# computing skew divergence score for noun-noun compound vectors
# Q: zinsmeister(2013)


# D(p||q) = Sig^i p^i x log(p^i/q^i)
l1<-c(0.6,0.4,0) # milchzahn
l2<-c(0.25,0.5,0.25) # zahn
l3<-c(0,0,1) # löwenzahn
### test: löwenzahn::ziehen=1 occurence instead 0
l4<-c(0,1,2)
l5<-unlist(lapply(l4,function(x){
x/sum(l4)
}))
########################
# l2 is the reference p
# l1,l3 are the target q probabilities which are projected on /smoothed by reference p
#############################################
lx<-list(list(l2,l1),list(l2,l3),list(l2,l5))
#f<-sum(pi*(log(pi/qi)))
w<-0.9
s1<-lapply(lx,function(l){
  print(l)
#  lapply(l,function(p){
 #   cat("p:",p,"\n")
    s<-array()
    for(i in 1:length(l[[1]])){
      p1<-l[[1]][i]
      q1<-l[[2]][i]
      qi<-(w*q1)+((1-w)*p1) # qi smoothed
      cat("qi:",qi,"\n")
      # s[i]<-sum(pi*log((pi/qi)))
      s[i]<-p1*log(p1/qi)
      cat("s:",s[i],"\n")
    }
    spq<-sum(s)
    cat("skew div:",spq,"\n")
  return(s)
})
names(s1)<-c("milchzahn","löwenzahnA","löwenzahnB")
lapply(s1,sum) #chk.
par(las=2)
boxplot(s1,main="skew divergence scores, reference: zahn")
