t<-c("s")
t<-c("s","u","e","e","e","l","m","r","f")
i<-1
a<-lapply(seq_along(t), function(i){
  b<-t[i]
  a<-1:length(t)
  o<-a%in%i 
  o
  t2<-t[!o]
  t2
  t3<-t2
  t4<-matrix(rep(t2,length(t2)),ncol = length(t2))
  
  s<-paste0(b,paste0(t2[sample(length(t2),length(t2),replace = F)],collapse = ""))
})

