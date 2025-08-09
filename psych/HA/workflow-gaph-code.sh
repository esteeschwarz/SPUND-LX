getDistance<- function (tdba.2)
{
    m.dup<-duplicated(tdba.2$lemma)
    dup.w<-which(m.dup)
    ld.u<-unique(tdba.2$lemma[dup.w])
    ld.u<-ld.u[order(ld.u)]
    ld.u<-ld.u[!ld.u==""]
    mo<-grep("[^a-z]",ld.u)
    
    for (l in ld.u){
          r1<-tdba.2$lemma==x
  r1w<-which(r1)
  r1u<-tdba.2$url[r1w]
  dups <- names(table(r1u))[table(r1u) > 1]
  r1ud <- which(r1u %in% dups)
  c1<-tdba.2$pos[r1w[r1ud]]
  r1w<-r1w[r1ud]
  r1u<-r1u[r1ud]
  u<-r1u[1]
    }
unique(tdba.2$target[dup.w])
te<-unique(tdba.2$url[dup.w])
d1o<- get.ds(r1u,"obs") 

}

get.ds<-function (r1u,target){
    d1<-lapply(r1u,function(u){
      d3<-NA
      r2w<-which(tdba.2$url==u)
      r3w<-which(r1w%in%r2w)
      tdba.2$url[r1w[r3w]]
      tdba.2$pos[r1w[r3w]]
      tdba.2[r1w[r3w],]
      dups <- names(table(tdba.2$q[r1w[r3w]]))[table(tdba.2$q[r1w[r3w]]) > 1]
      dups
      qd <- which(tdba.2$q[r1w[r3w]] %in% dups)
      #r1w<-r1w[]
      r4w<-r1w[r3w[qd]]
      #    qd<-
      d2<-diff(tdba.2$pos[r4w])
      d2[d2<1]<-0
      ifelse(sum(d2)>0,d3<-c(0,d2),d3<-NA)
      tdba.2$dist[r4w]<-d3
      tdba.2[r4w,]
      # if(length(d2)>1)
      #   tdba.2$dist[r1w[r3w]]<-d2
      subr1<-tdba.2[r4w,]
      ifelse(length(subr1$target)>0,return(subr1),return(NA))
      return(rdf)
    })
  }
