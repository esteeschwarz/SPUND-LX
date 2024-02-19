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
cwbdir<-"~/boxHKW/21S/DH/local/SPUND/corpuslx/cwb/sbc/csv"
#dir.create(xldir)
dir.create(cwbdir)
colnames(scb.ann.list)
colnames(scb.ann.list)<-gsub("\\.","_",colnames(scb.ann.list))
c(1,2,4,5,6,7,8,9,10,11,12,13,14,16,17,18)
sbc.columns<-c(5,6,7,8,9,11,13,16,17,18)
k<-1
la<-length(unique(scb.ann.list$sbc_id))
for(k in 1:la){
  ns.df<-paste0(xldir,"/SCB-pos_",k,".xlsx")
  df<-scb.ann.list[scb.ann.list$sbc_id==k,]
  df.red<-df[sbc.columns]
  colnames(df.red)
  df.ns<-colnames(df.red)
df.tok<-df.ns=="token"
colnames(df.red)[df.tok]<-"tok"
    write_xlsx(df.red,ns.df)

}
# 
# for(k in 1:la){
#   ns.df<-paste0(cwbdir,"/SCB-pos_",k,".xlsx")
#   df<-scb.ann.list[scb.ann.list$sbc_id==k,sbc.columns]
#   df.red<-df[sbc.columns]
#   df.ns<-colnames(df)
#   df.tok<-df.ns=="token"
#   colnames(df)[df.tok]<-"tok"
#   write.csv(df.red,ns.df,sep = "\t",row.names = F)
#   
# }
#cat("dreimal\tschwarzer\tkater")

cns<-colnames(corpus.light.ann)
cns<-gsub("\\.","_",cns)
cns
sbc.columns<-c(5,6,7,8,9,11,13,16,17,18)
cns[sbc.columns]
sbc.cwb<-corpus.light.ann[,cns[sbc.columns]]
library(readr)
write.csv2(sbc.cwb,paste0(cwbdir,"/sbc-cwb.tsv"),row.names = F,fileEncoding = "UTF-8")
write_delim(sbc.cwb,paste0(cwbdir,"/sbc-cwb.tsv"),delim = "\t")
# annis vert
sbc.columns<-c(5,7,6,8,9,11,13,16,17,18,1)
cns[sbc.columns]
m<-cns=="token"
cns[m]<-"tok"
m<-cns=="upos"
cns[m]<-"pos"
sbc.cwb<-corpus.light.ann[,sbc.columns]
m<-colnames(sbc.cwb)=="token"
colnames(sbc.cwb)[m]<-"tok"
m<-colnames(sbc.cwb)=="upos"
colnames(sbc.cwb)[m]<-"pos"
colnames(sbc.cwb)<-gsub("\\.","_",colnames(sbc.cwb))
write_delim(sbc.cwb,"vert/SBC102.tsv",delim = "\t")
la<-length(unique(sbc.cwb$sbc_id))
xldir<-"~/boxHKW/21S/DH/local/SPUND/corpuslx/annis/xls4/SBC102"
cwbdir<-"~/boxHKW/21S/DH/local/SPUND/corpuslx/cwb/sbc/csv"
dir.create(xldir)
k<-1
for(k in 1:la){
  ns.df<-paste0(xldir,"/SBC_",k,".xlsx")
  ns.df
  df<-sbc.cwb[sbc.cwb$sbc_id==k,]
  colnames(df)
  write_xlsx(df,ns.df)
}
write_xlsx(sbc.cwb,"vert/SBC102.xlsx")

"cwb-encode -d sbc102 -xsBC9 -c utf8 -f scb.cwb.vrt -R SBC -P lemma -P upos -P xpos -P feats -P dep_rel -P light -P obj -P head_token_value -P head_lemma_value"
"/Users/guhl/boxHKW/21S/DH/local/SPUND/corpuslx/cwb/corpora/tsv/SBC102.tt"

source("~/boxHKW/21S/DH/local/SPUND/corpuslx/annis/callpepper_global.R")
pepper.call("~/boxHKW/21S/DH/local/SPUND/corpuslx/annis/r-con_xl-tt")
pepper.call("~/boxHKW/21S/DH/local/SPUND/corpuslx/annis/r-con_tt-annis.xml")
pepper.call("~/boxHKW/21S/DH/local/SPUND/corpuslx/annis/r-conxl6.pepper","SBC_v1.0.2","SBC_v1.0.2")
###########
pepper.call("~/boxHKW/21S/DH/local/SPUND/corpuslx/annis/r-con.vrt-annis.xml")
setwd("~/boxHKW/21S/DH/local/SPUND/corpuslx/annis/")
zipannis("xpfin/SBC102","SBC102.zip")
