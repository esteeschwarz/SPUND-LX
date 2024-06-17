get.corpus.deprel<-function(x){
  #  x1<-data.frame(x)
  # x<-x1
  # assign unique id to token
  colnames(x)[1]<-"paragraph"
  
  x$paragraph<-gsub("doc","",x$paragraph)
  x$token.id<-paste0(x$paragraph,".",  1:length(x$paragraph))  
  #  x$sbc.token.id<-1:length(x$sbc.id)  
  x$pos.0<-"lfd.pos"  
  x$obj<-NA
  tdf<-t(x)
  rtdf<-rownames(tdf)
  rtdf.0<-which(rtdf=="pos.0")
  all.zero<-which(tdf=="lfd.pos")-rtdf.0
  #  all.zero.0<-all.zero-length(rtdf)
  # pos.deprel<-length(rtdf)-grep("dep",rtdf)
  # pos.head<-length(rtdf)-grep("head",rtdf)
  # pos.upos<-length(rtdf)-grep("upos",rtdf)
  # pos.lemma<-length(rtdf)-grep("lemma",rtdf)
  # pos.token<-length(rtdf)-which(rtdf=="token")
  # pos.token.id<-length(rtdf)-which(rtdf=="token_id")
  #########################################
  pos.deprel<-all.zero+grep("dep",rtdf)
  pos.head<-all.zero+grep("head",rtdf)
  pos.upos<-all.zero+grep("upos",rtdf)
  pos.lemma<-all.zero+grep("lemma",rtdf)
  pos.token<-all.zero+which(rtdf=="token")
  pos.token.id<-all.zero+which(rtdf=="token_id")
  #########################
  # t.head<-all.zero-pos.head
  # t.head<-all.zero-grep("head",rtdf)
  # t.id<-all.zero-pos.token.id
  # t.tag<-all.zero-pos.upos
  # t.token<-all.zero-pos.token
  # t.lemma<-all.zero-pos.lemma
  # t.deprel<-all.zero-pos.deprel
  t.head<-pos.head
  t.id<-pos.token.id
  t.tag<-pos.upos
  t.token<-pos.token
  t.lemma<-pos.lemma
  t.deprel<-pos.deprel
  m.h.t.0<-which(tdf[t.head]==0)
  h.t.pos.rel<-as.double(tdf[t.id])-as.double(tdf[t.head])
  h.t.pos.rel[m.h.t.0]<-0
  h.t.pos.abs<-t.id-(h.t.pos.rel*length(tdf[,1]))
  #tdf[h.t.pos.abs]
  h.t.value<-t.token-(h.t.pos.rel*length(tdf[,1]))
  
  #head(tdf[h.t.value])
  m1<-which(h.t.value<0)
  sum(m1)
  h.t.value[m1]<-1 # prevent negative subscripts
  h.l.value<-t.lemma-(h.t.pos.rel*length(tdf[,1]))
  m2<-which(h.l.value<0)
  sum(m2)
  h.l.value[m2]<-1 # prevent negative subscripts
  head(tdf[h.l.value])
  ####################
  all.obj<-tdf=="obj"
  #all.obj[]
  all.ob.w<-which(all.obj)
  all.ob.w
  obj.head<-as.double(all.ob.w-1)
  tdf[obj.head]
  obj.tag<-all.ob.w-4 #4 
  tdf[obj.tag]
  obj.lemma<-all.ob.w-5 #5
  tdf[obj.lemma]
  obj.token<-all.ob.w-6 #6
  tdf[obj.token]
  obj.id<-as.double(all.ob.w-7) #7
  tdf[obj.id]
  h.t.o.pos.rel<-as.double(tdf[obj.id])-as.double(tdf[obj.head])
  h.t.o.pos.abs<-obj.id-(h.t.o.pos.rel*length(tdf[,1]))
  tdf[h.t.o.pos.abs]
  h.t.o.value<-obj.token-(h.t.o.pos.rel*length(tdf[,1]))
  tdf[h.t.o.value]
  h.l.o.value<-obj.lemma-(h.t.o.pos.rel*length(tdf[,1]))
  tdf[h.l.o.value]
  obj.pos<-all.ob.w+5
  tdf[obj.pos]<-tdf[h.l.o.value]
  ####################
  #obj.df<-get.lemma.obj(x)
  #tdf[obj.df$obj.pos]<-as.character(obj.df$obj)
  #tdf[16,1]
  # tdf[675]
  tdf.r<-as.data.frame(t(tdf))
  m<-!is.na(tdf.r$obj)
  sum(m)
  #length(tdf[obj.pos])
  #length(tdf[h.t.value])
  x$obj<-tdf.r$obj
  x$head_token_value<-tdf[h.t.value]
  x$head_lemma_value<-tdf[h.l.value]
  # mode(x$line)<-"double"
  # mode(x$sbc.id)<-"double"
  # mode(x$token_id)<-"double"
  # mode(x$head_token_id)<-"double"
  
  return(x)  
  
}
