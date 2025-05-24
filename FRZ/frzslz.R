d<-read.csv("frzslz.csv")
d<-data.frame(t(d))
colnames(d)<-d[1,]
d<-d[2:length(d$a),]
#mode(d[,1:length(d)])<-double
ds<-d
d[17,1]<-sum(as.double(d[,1]),na.rm = T)/sum(!is.na(d[,1]))
d[17,2]<-sum(as.double(d[,2]),na.rm = T)/sum(!is.na(d[,2]))
d[17,3]<-sum(as.double(d[,3]),na.rm = T)/sum(!is.na(d[,3]))
d[17,4]<-sum(as.double(d[,4]),na.rm = T)/sum(!is.na(d[,4]))
d[17,5]<-sum(as.double(d[,5]),na.rm = T)/sum(!is.na(d[,5]))
d[17,6]<-sum(as.double(d[,6]),na.rm = T)/sum(!is.na(d[,6]))
#d[17,1]<-sum(as.double(d[,1]),na.rm = T)
#d[17,1]<-sum(as.double(d[,1]),na.rm = T)
#d[17,1]<-sum(as.double(d[,1]),na.rm = T)
#d[17,1]<-sum(as.double(d[,1]),na.rm = T)
#d[17,1]<-sum(as.double(d[,1]),na.rm = T)
dsum<-sum(as.double(d[17,]))/(7+23+6+8+4+6)
dsum
d[17,]       
