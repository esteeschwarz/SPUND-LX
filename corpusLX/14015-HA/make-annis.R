#20240204(13.39)
#14062.ANNIS.SBC
################
#save(corpus.light.ann,file = "~/boxHKW/21S/DH/local/SPUND/corpuslx/stefanowitsch/HA/data/corpus.light.ann.RData")
load("~/boxHKW/21S/DH/local/SPUND/corpuslx/stefanowitsch/HA/data/corpus.light.ann.RData")
library(writexl)
x<-scb.ann.list
k<-1
### same as above writing xlsx, here from annotated list
scb.ann.list<-corpus.light.ann
xldir<-"~/boxHKW/21S/DH/local/SPUND/corpuslx/annis/xls3"
dir.create(xldir)
colnames(scb.ann.list)
colnames(scb.ann.list)<-gsub("\\.","_",colnames(scb.ann.list))
sbc.columns<-c(1,2,4,5,6,7,8,9,10,11,12,13,14,16,17,18)
k<-1
la<-length(unique(scb.ann.list$sbc_id))
for(k in 1:la){
  ns.df<-paste0(xldir,"/SCB-pos_",k,".xlsx")
  df<-scb.ann.list[scb.ann.list$sbc_id==k,sbc.columns]
df.ns<-colnames(df)
df.tok<-df.ns=="token"
colnames(df)[df.tok]<-"tok"
    write_xlsx(df,ns.df)

  }
source("~/boxHKW/21S/DH/local/SPUND/corpuslx/annis/callpepper_global.R")
pepper.call("~/boxHKW/21S/DH/local/SPUND/corpuslx/annis/r-conxl5.pepper","SBC_v1.0.2","SBC_v1.0.2")
pepper.call("~/boxHKW/21S/DH/local/SPUND/corpuslx/annis/r-conxl6.pepper","SBC_v1.0.2","SBC_v1.0.2")
setwd("~/boxHKW/21S/DH/local/SPUND/corpuslx/annis/")
zipannis("SBC_annis","SBC_annis1.0.2.zip")
