s<-"~/boxHKW/21S/DH/local/SPUND/2025/huening/concordance_preloaded_nltenten20_tt3_20260209141042.csv"
d<-read.csv(s)
m<-grep("^''s",d$X.1)
d[m,]
d$X.1[m]
ds<-d[m,]
ds