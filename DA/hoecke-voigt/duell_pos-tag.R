#20241706(06.50)
#14253.16822.DA.adjectives
#hoecke-voigt-duell, postagging
###############################
t1<-readLines("~/Documents/GitHub/SPUND-LX/DA/hoecke-voigt/hoecke-voigt_duell_cpt(2024-04-11).txt")
library(quanteda)
library(stringi)
library(udpipe)
################
tok1<-tokens(t1)
tok1[[17]]
x <- udpipe_download_model(language = "german")
x$file_model
model.ger <- udpipe_load_model(x$file_model)
t2<-udpipe_annotate(model.ger,t1)
t3<-as.data.frame(t2)
m.adj<-t3$upos=="ADJ"|t3$upos=="ADV"
t.adj<-t3$token[m.adj]
adj.tab<-table(t.adj)
adj.tab
m.adj<-t3$upos=="ADJ"
t.adj<-t3$token[m.adj]
adj.tab<-table(t.adj)
adj.tab
library(clipX)
library(clipr)
write_clip(names(adj.tab))
adj.l<-readLines("~/Documents/GitHub/SPUND-LX/DA/hoecke-voigt/adjectives.txt")
adj.regex<-paste0(adj.l,"|")
adj.regex.c<-paste(adj.regex,collapse = "")
write_clip(adj.regex.c)
