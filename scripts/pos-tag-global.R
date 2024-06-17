#20240617(13.25)
#14253.get.pos.df
#global pos tagging workflow
############################
library(udpipe)
source("https://github.com/esteeschwarz/SPUND-LX/raw/main/scripts/functions.R")
################
# WORKFLOW:
#textsource to adapt:
t1<-readLines("~/Documents/GitHub/SPUND-LX/DA/hoecke-voigt/hoecke-voigt_duell_cpt(2024-04-11).txt")
x <- udpipe_download_model(language = "german")
model.ger <- udpipe_load_model(x$file_model)
t2<-udpipe_annotate(model.ger,t1)
t3<-as.data.frame(t2)
m.adj<-t3$upos=="ADJ"
t4<-get.corpus.deprel(t3)
adj.ref<-t4$head_token_value[m.adj]
adj.list<-t4$token[m.adj]
sum(m.adj)
adj.df<-data.frame(tok.id=t4$token.id[m.adj], adj=adj.list,ref=adj.ref)
#write.csv(adj.df,"~/Documents/GitHub/SPUND-LX/DA/hoecke-voigt/adjectives.df.csv")
#######################################################################