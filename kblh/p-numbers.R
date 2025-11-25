# 20251125(17.35)
# 16484.kblh
############
# Q: azriel, shor-ha-shoel, porat
# pythagoras vollkommene zahl
#############################
7+4+2+14+1
28/4
28/2
28/3

#x<-6
#k<-1
xl<-1:10000
# 6,28,496,8128
xl-10001:15000
#xl<-list(1:2000)
pa<-array()
#xlist<-list(1:10000)

xk<-lapply(xl,function(i){
  cat("\r",i)
  #p<-i-1
  for (k in 1:i){
#    cat("\r",k)
    b<-i/k
    ifelse(ceiling(b)==b,pa[k]<-b,pa[k]<-0)
    
  }
  #pa<-pa[!is.na(pa)]
  m<-pa==i
  pa<-pa[!m]
 # pp<-sum(pa)==x
  pp<-sum(pa,na.rm = T)==i
  
  return(pp)
})
sum(unlist(xk))
xk2<-unlist(xk)
which(xk2)
