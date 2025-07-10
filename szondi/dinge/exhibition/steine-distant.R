#20250709(05.26)
#15285.xdinge.caillois-steine-distant-reading
#############################################
get.texts<-function(){
t.dir<-paste0(Sys.getenv("HKW_TOP"),"/AVL/2024/dinge/schrift-der-steine")
texts<-list.files(t.dir)
texts.d<-paste(t.dir,texts,sep = "/")
t.db<-lapply(texts.d, readLines) # read OCR files of pdf into one textfile
names(t.db)<-texts
t.db[1]
#x<-t.db
put.names<-function(x)c(names(x),x)
#t.db.n<-lapply(t.db, put.names)
#c(names(x[1]),t.db[1])
t.db.n<-mapply(c,texts,t.db)
t.db.n[4]
t.db.u<-unlist(t.db.n)
#t.db.u<-unlist(t.db)
t1<-t.db.u
t1[1:10]
head(t1,10)
t.out.ns<-paste0(Sys.getenv("HKW_TOP"),"/AVL/2024/dinge/schrift-der-steine.txt")
writeLines(t.db.u,t.out.ns)
}
#get.texts()
############
### now for distant reading

library(quanteda)
library(quanteda.textstats)
#library(DramaAnalysis)
library(collostructions)
to1<-tokenize_word1(t1)
to1[[2]]
ta1<-table(unlist(to1))
ta1<-ta1[order(ta1,decreasing = T)]
head(ta1,30)
to.u<-unlist(to1)
ft<-freq.list(to.u)
ft<-ft[,c(2,1)]
#keywords
# tma<-matrix(unlist(to1))
# d.dfm<-dfm(tma)
# d.freq<-docfreq(d.dfm,scheme = "count")
# ft <- frequencytable(to.u, byCharacter = TRUE, normalize = FALSE)
# 
# d.key<-keyness(ft$FREQ, method = "logratio")
# 
# ft<-matrix(dfreq$FREQ,ncol = length(dfreq$WORD))
# colnames(ft)<-dfreq$WORD
# keywords<-keyness(ft, method = "logratio")
# ##############
# data("rksp.0")
# ft <- frequencytable(rksp.0, byCharacter = TRUE, normalize = FALSE)
# # Calculate log ratio for all words
# genders <- factor(c("m", "m", "m", "m", "f", "m", "m", "m", "f", "m", "m", "f", "m"))
# keywords <- keyness(ft, method = "logratio", 
#                     categories = genders, 
#                     minimalFrequency = 5)
# # Remove words that are not significantly different
# keywords <- keywords[names(keywords) %in% names(keyness(ft, siglevel = 0.01))]
# keywords
### wks.
########
#install.packages(c( "topicmodels", "stm"))
library(quanteda)
library(topicmodels)
library(stm)

corpus <- corpus(t1)
dfm <- dfm(corpus, remove = stopwords("de"), remove_punct = TRUE)
dfm <- dfm_trim(dfm, min_termfreq = 2)

# Suppose you have groups
# docvars(corpus, "group") <- c("A", "A", "B")
# dfm_grouped <- dfm_group(dfm, groups = "group")
# result <- textstat_keyness(dfm_grouped, target = "A")
# head(result)

dtm <- convert(dfm, to = "topicmodels")
lda_model <- LDA(dtm, k = 3, control = list(seed = 1234))
terms(lda_model, 10)  # Top 5 terms per topic

# out <- stm(as.matrix(dfm), K = 3, verbose = FALSE)
# labelTopics(out)

### attributes, adjectives
library(udpipe)
# model.dir<-"./modeldir"
# #source("rlog.R")
# library(readr)
head(t1,100)
model.dir<-paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/intLX/createcorp/modeldir")
model<-list.files(model.dir)
print(model)
model.l<-"ger"
print(model.l)
model.g<-paste(model.dir,model[grep(model.l,model)],sep = "/")
print(model.g)
model<-udpipe::udpipe_load_model(model.g)
pos1<-udpipe_annotate(model,t1)
pos.df<-as.data.frame(pos1)

upos<-"ADJ"
xpos<-"ADJA"
qpos<-"NOUN"
window<-6
get.posx<-function(pos.df,upos,xpos,qpos,window){
m<-pos.df[,c("upos","xpos")]==c(upos,xpos)
m<-which(m)
x<-m[1]
range<-lapply(m,function(x){
  ifelse(x>window,r1<-x-window,r1<-1)
  r2<-x+window
  range<-r1:r2
  ma<-pos.df$token[range] # kwic
  q1<-pos.df$upos[range]==qpos # qpos follows u-xpos
  q1w<-which(q1)
  
  q2<-pos.df$token[x]
  q3<-pos.df$token[range][q1]
  q2<-pos.df$lemma[x]
  q3<-pos.df$lemma[range][q1]
  q3<-q3[!is.na(q3)]
  qdf<-data.frame(qpos=q1,uxpos=q2)
  qdf
  qdf$qpos[q1w]<-q3
  qdf<-qdf[which(q1),]
  return(list(text=ma,qdf=qdf))
#  return(r1:r2)
})
}
m.adj<-get.posx(pos.df,"ADJ","ADJA","NOUN",6)
m.adj[2]
library(abind)
qmdf.l<-lapply(m.adj, function(x){
  return(x$qdf)
})
qmdf<-abind(qmdf.l,along = 1)
qmdf<-qmdf[order(qmdf[,2],decreasing = F),c(2,1)]
qmdf<-data.frame(qmdf)
qmdf.p<-cbind(qmdf,0)
colnames(qmdf.p)<-c("adj","noun","mineral")
write_csv(qmdf.p,paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/szondi/dinge/distant-001-adjectives.csv"))

library(dplyr)

# Example data
# df <- data.frame(qpos = c(...), uxpos = c(...))
df<-qmdf
result <- df %>%
  group_by(qpos, uxpos) %>%
  summarise(freq = n(), .groups = "drop") %>%
  group_by(uxpos) %>%
  slice_max(order_by = freq, n = 1, with_ties = FALSE)
fdf<-data.frame(result[order(result$freq,decreasing = T),])

#print(fdf)
head(fdf,50)

qmdf$uxpos[qmdf$qpos=="Achat"]

noun.u<-unique(qmdf.p$noun)
#noun.u<-data.frame(noun=noun.u,mineral=0)
noun.t<-paste0(noun.u,collapse =" ")
writeLines(noun.u,paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/szondi/dinge/nouns.txt"))
minerals<-read_csv(paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/szondi/dinge/mineral_nouns.csv"))
min1<-readLines(paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/szondi/dinge/deeps_mineral-nouns.txt"))
min2<-read_csv(paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/szondi/dinge/deeps_minerals.csv"))
min3<-cbind(matrix(c(minerals$noun,min1,min2$noun)),1)
min3<-min3[order(min3[,1]),]
min4<-unique(min3[,1])
qmdf$mineral<-F
for (k in min4){
  m<-qmdf$qpos==k
  qmdf$mineral[m]<-T 
}
qmdf$uxpos[qmdf$mineral]
qmineral<-qmdf[qmdf$mineral,]
qmin2<-qmineral
qmin2$mineral<-1
write_csv(qmineral,paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/szondi/dinge/cal-minerals.csv"))
qmin3<-fix(qmin2)
qmin3$uxpos<-gsub("ü","ue",qmin3$uxpos)
qmin3$uxpos<-gsub("ä","ae",qmin3$uxpos)
qmin3$uxpos<-gsub("ö","oe",qmin3$uxpos)
qmin3$uxpos<-gsub("Ü","Ue",qmin3$uxpos)
qmin3$uxpos<-gsub("Ä","Ae",qmin3$uxpos)
qmin3$uxpos<-gsub("Ö","Oe",qmin3$uxpos)
qmin3$uxpos<-gsub("ß","sz",qmin3$uxpos)

qmin3$qpos<-gsub("ü","ue",qmin3$qpos)
qmin3$qpos<-gsub("ä","ae",qmin3$qpos)
qmin3$qpos<-gsub("ö","oe",qmin3$qpos)
qmin3$qpos<-gsub("Ü","Ue",qmin3$qpos)
qmin3$qpos<-gsub("Ä","Ae",qmin3$qpos)
qmin3$qpos<-gsub("Ö","Oe",qmin3$qpos)
qmin3$qpos<-gsub("ß","sz",qmin3$qpos)

qmin4<-qmin3[,c(1,2)]
colnames(qmin4)<-c("adj","noun")
qmin4<-qmin4[order(qmin4$noun,decreasing = F),]
write_csv(qmin4,paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/szondi/dinge/cal-minerals.csv"))

