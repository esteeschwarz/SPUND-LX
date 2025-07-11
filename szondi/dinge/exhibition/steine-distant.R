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
get.posdf<-function(){
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
}
library(readtext)
### from here with corrections in .txt
t2<-readtext(paste0(Sys.getenv("HKW_TOP"),"/AVL/2024/dinge/schrift-der-steine.txt"))$text
get.posdf<-function(t2){
t2<-readtext(paste0(Sys.getenv("HKW_TOP"),"/AVL/2024/dinge/schrift-der-steine.txt"))$text
  
t2<-gsub("-\n","",t2)
model.dir<-paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/intLX/createcorp/modeldir")
model<-list.files(model.dir)
print(model)
model.l<-"ger"
print(model.l)
model.g<-paste(model.dir,model[grep(model.l,model)],sep = "/")
print(model.g)
model<-udpipe::udpipe_load_model(model.g)
pos1<-udpipe_annotate(model,t2)
pos.df<-as.data.frame(pos1)

save(pos.df,file = paste0(Sys.getenv("HKW_TOP"),"/AVL/2024/dinge/steine01.pos.2.RData"))
return(pos.df)
}
pos.df<-get.posdf(t2)
#load(paste0(Sys.getenv("HKW_TOP"),"/AVL/2024/dinge/steine01.pos.2.RData"))
###########################
main.fun<-function(pos.df){
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
#get.adj.df<-function(pos.df){
m.adj<-get.posx(pos.df,"ADJ","ADJA","NOUN",6)
m.adj[2]
m.ad.u<-unique(unlist(m.adj))
m.ad.u[grep("iew",m.ad.u)]
library(abind)
qmdf.l<-lapply(m.adj, function(x){
  return(x$qdf)
})
qmdf<-abind(qmdf.l,along = 1)
qmdf<-qmdf[order(qmdf[,2],decreasing = F),c(2,1)]
qmdf<-data.frame(qmdf)
qmdf$uxpos<-gsub("[^a-zA-ZäöüÄÖÜß]","",qmdf$uxpos)
qmdf.p<-cbind(qmdf,0)
#qmdf.p$adj<-gsub("[^a-zA-zäöüÄÖÜß]","",qmdf.p$adj)
colnames(qmdf.p)<-c("adj","noun","mineral")
write_csv(qmdf.p,paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/szondi/dinge/exhibition/distant-001-adj-noun.df.csv"))

#}

#eval.1.dep<-function(qmdf){
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
t.qpos<-table(df$qpos)
t.xpos<-table(df$uxpos)
tq<-t.qpos[order(t.qpos,decreasing = T)]
tu<-t.xpos[order(t.xpos,decreasing = T)]

qmdf$uxpos[qmdf$qpos=="Achat"]
qmdf$uxpos[qmdf$qpos%in%qmin4$noun]

noun.u<-unique(qmdf.p$noun)
#noun.u<-data.frame(noun=noun.u,mineral=0)
noun.t<-paste0(noun.u,collapse =" ")
writeLines(noun.u,paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/szondi/dinge/exhibition/nouns.txt"))
min0<-read_csv(paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/szondi/dinge/exhibition/mineral_nouns.csv"))
min1<-readLines(paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/szondi/dinge/exhibition/deeps_mineral-nouns.txt"))
min2<-read_csv(paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/szondi/dinge/exhibition/deeps_minerals.csv"))
min5<-readLines(paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/szondi/dinge/exhibition/cal-minerals_llma.txt"))
min5<-unique(unlist(strsplit(min5,", "))) # llma minerals
min7<-c(minerals$noun,min1,min2$noun,min5)
min7<-gsub(" ","",min7)
min7<-unique(min7)
min3<-cbind(min7,F)
min3<-min3[order(min3[,1]),]
min3
min3[149,]==min3[150,]
min4
#min6
min4<-unique(min3[,1])
# qmdf$uxpos<-gsub("[^a-zA-ZäöüÄÖÜß","",qmdf$uxpos)
qmdf$mineral<-F
for (k in min4){
  m<-qmdf$qpos==k
  qmdf$mineral[m]<-T 
}
qmdf$uxpos[qmdf$mineral]
qmineral<-qmdf[qmdf$mineral,]
qmin2<-qmineral
qmin2$mineral<-F
qmin.all<-data.frame(noun=unique(min3[,1]),com=NA)
qmin.all$noun
qmineral<-qmineral[order(qmineral$qpos),]
write_csv(qmin.all,paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/szondi/dinge/exhibition/allminerals.csv"))
write_csv(qmineral,paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/szondi/dinge/exhibition/cal-minerals.csv"))
return(qmineral)
}
calminall<-main.fun(pos.df)
# qmin3<-fix(qmin2)
# qmin3$uxpos<-gsub("ü","ue",qmin3$uxpos)
# qmin3$uxpos<-gsub("ä","ae",qmin3$uxpos)
# qmin3$uxpos<-gsub("ö","oe",qmin3$uxpos)
# qmin3$uxpos<-gsub("Ü","Ue",qmin3$uxpos)
# qmin3$uxpos<-gsub("Ä","Ae",qmin3$uxpos)
# qmin3$uxpos<-gsub("Ö","Oe",qmin3$uxpos)
# qmin3$uxpos<-gsub("ß","sz",qmin3$uxpos)
# 
# qmin3$qpos<-gsub("ü","ue",qmin3$qpos)
# qmin3$qpos<-gsub("ä","ae",qmin3$qpos)
# qmin3$qpos<-gsub("ö","oe",qmin3$qpos)
# qmin3$qpos<-gsub("Ü","Ue",qmin3$qpos)
# qmin3$qpos<-gsub("Ä","Ae",qmin3$qpos)
# qmin3$qpos<-gsub("Ö","Oe",qmin3$qpos)
# qmin3$qpos<-gsub("ß","sz",qmin3$qpos)

qmin4<-qmineral[,c(1,2)]
colnames(qmin4)<-c("adj","mineral")
qmin4<-qmin4[order(qmin4$mineral,decreasing = F),]
write_csv(qmin4,paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/szondi/dinge/exhibition/cal-minerals.csv"))
###
# try get range network of associations
qa<-c("schreiben","schrift","zeichen","zeichnen","zeichnung")
file.edit(paste0(Sys.getenv("HKW_TOP"),"/AVL/2024/dinge/schrift-der-steine.txt"))
r<-15
get.st.range<-function(pos.df,qmin4,qa,r,window){
  m1<-pos.df$lemma%in%qa
  sum(m1)
  m1w<-which(m1)
  m2<-pos.df$token%in%qmin4$noun
  m2w<-which(m2)
  sum(m2)
  m3w<-lapply(m1w,function(x){
    r1<-x-r
    r2<-x+r
    r3<-c(r1:r2)
  })
  m1r<-unique(unlist(m3w))
  m4<-m2w%in%m1r
  sum(m4)
  m4w<-m2w[m4]
  m41<-lapply(m4w,function(x){
    r1<-x-window
    r2<-x+window
    r3<-c(r1:r2)
    t<-pos.df$token[r3]
  })
  
  return(m41)

  
  }
scr.tokens<-get.st.range(pos.df,qmin4,qa,20,20)
scr.tokens
m<-pos.df$lemma=="r"
mw<-which(m)
pos.df$sentence[mw]
sum(m,na.rm = T)
show.window<-function(pos.df,q,window){
  m<-pos.df$lemma==q
  mw<-which(m)
  #r<-c((mw-window):(mw+window))
  trange<-pos.df$sentence[r]
}
tx<-show.window(pos.df,"che",10)
tx

