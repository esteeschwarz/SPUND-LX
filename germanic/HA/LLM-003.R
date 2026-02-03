# 20250125(15.03)
# 16052.gemini.corpus.btt
#########################
# wtf: huening germanic languages im vergleich: create gemini chat corpus - extract keywords 
############################################################################################
get.btt<-function(){
library(httr)
library(jsonlite)
url<-'https://search.dip.bundestag.de/api/v1/plenarprotokoll-text?f.aktualisiert.start=2022-12-06T10%3A00%3A00&f.aktualisiert.end=2022-12-06T20%3A00%3A00&f.datum.start=2021-01-11&f.datum.end=2021-01-15&f.vorgangstyp=Gesetzgebung&f.vorgangstyp_notation=100&format=json&apikey=OSOegLs.PR2lwJ1dwCeje9vTj7FPOt3hvpYKtwKkhw'
url<-'https://search.dip.bundestag.de/api/v1/plenarprotokoll-text?f.aktualisiert.start=2022-12-06T10%3A00%3A00&f.aktualisiert.end=2022-12-06T20%3A00%3A00&f.datum.start=2021-01-11&f.datum.end=2021-01-15&f.vorgangstyp=Gesetzgebung&f.vorgangstyp_notation=100&format=json&apikey=OSOegLs.PR2lwJ1dwCeje9vTj7FPOt3hvpYKtwKkhw'
url<-'https://search.dip.bundestag.de/api/v1/plenarprotokoll-text?f.aktualisiert.start=2022-12-06T10%3A00%3A00&f.aktualisiert.end=2022-12-06T20%3A00%3A00&f.datum.start=2021-01-11&f.datum.end=2021-01-15&f.vorgangstyp=Gesetzgebung&f.vorgangstyp_notation=100&format=json&apikey=OSOegLs.PR2lwJ1dwCeje9vTj7FPOt3hvpYKtwKkhw'
qs<-"f.aktualisiert.start=2022-12-06T10%3A00%3A00&f.aktualisiert.end=2022-12-06T20%3A00%3A00&f.datum.start=2021-01-11&f.datum.end=2021-01-15&f.vorgangstyp=Gesetzgebung&f.vorgangstyp_notation=100&format=json&apikey=OSOegLs.PR2lwJ1dwCeje9vTj7FPOt3hvpYKtwKkhw"
baseurl<-"https://search.dip.bundestag.de/api/v1/plenarprotokoll-text"
turl<-"https://search.dip.bundestag.de/api/v1/plenarprotokoll-text?f.datum.start=2021-01-11&f.datum.end=2021-01-15&format=json&apikey=OSOegLs.PR2lwJ1dwCeje9vTj7FPOt3hvpYKtwKkhw"
qs<-unlist(strsplit(turl,"\\?"))
qx<-qs[2]
baseurl<-qs[1]
apikey<-"OSOegLs.PR2lwJ1dwCeje9vTj7FPOt3hvpYKtwKkhw"
qx<-strsplit(qs,"=|&")
qx
qdf<-data.frame(matrix(qx[[2]],ncol = 2,byrow = T))
colnames(qdf)<-c("key","value")
qdf
#######################################
get.q<-function(baseurl,qdf,d.start,d.end){
#qdf$value[1:2]<-""
m<-grep("datum.start",qdf$key)
qdf$value[m]<-d.start
m<-grep("datum.end",qdf$key)
qdf$value[m]<-d.end
qdf$value[grep("key",qdf$key)]<-Sys.getenv("DIP_APIKEY")
#params<-list(qdf)

#params<-qdf$value
q<-list()
for(k in 1:length(qdf$key)){
q[qdf$key[k]]<-qdf$value[k]  
}
q
#params
#names(params)<-qdf$key
print(q)
print(baseurl)
#params<-list(params)
#params
r<-GET(baseurl,query=q)
}
#r2<-r
getdf<-function(range){
d.start<-range[1]
d.end<-range[2]
r2<-get.q(baseurl,qdf,d.start,d.end)
#r2<-GET(turl)
r2
t<-fromJSON(content(r2,"text"))
#t$documents$text
tdf1<-data.frame(date=t$documents$datum,text=t$documents$text)        
}

# range<-c("2021-01-01","2021-03-31")
# tdf1<-getdf(range)
# range<-c("2021-04-01","2021-12-31")
# tdf2<-getdf(range)
# range<-c("2021-04-01","2021-05-30")
# tdf3<-getdf(range)
# range<-c("2021-06-01","2021-07-31")
# tdf4<-getdf(range)
# ptdf<-rbind(tdf1,tdf2,tdf3,tdf4)

### first dataset
###################################
range<-c("2025-01-01","2025-31-03")
tdf1<-getdf(range)
range<-c("2025-04-01","2025-12-31")
tdf2<-getdf(range)
range<-c("2025-04-01","2025-05-30")
tdf3<-getdf(range)
range<-c("2025-06-01","2025-07-31")
tdf4<-getdf(range)
range<-c("2025-08-01","2025-11-30")
tdf5<-getdf(range)
ptdf.2<-rbind(tdf1,tdf2,tdf3,tdf4,tdf5)

#save(ptdf,file = paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/huening/ptdf_btt01.RData"))
}
#ptdf.2<-get.btt()

#save(ptdf.2,file = paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/huening/ptdf_btt02.RData"))

get.gpt<-function(){
### load btt corpus
load(paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/huening/ptdf_btt01.RData"))

credcsv<-Sys.getenv("CRED_GEN") # !VIP dont put directly into read.csv()
cred<-read.csv(credcsv) 
e<-parse(text=cred$q[1])
e
# q<-"transkribus"
m<-grep("gemini",cred$q)
q<-cred$q[m]
eval(e)

API_KEY<-api_key<-key
gg.sh<-readLines(paste0(Sys.getenv("GIT_TOP"),"/ulysses/work/API/gemini.sh"))
gg.sh
sh.tx<-strsplit(gg.sh,"\\\\")
sh.tx<-strsplit(gg.sh,"-H|-X|-d")
sh.H1<-strsplit(sh.tx[[2]],":")
sh.H2<-strsplit(sh.tx[[3]],":")
sh.H1<-gsub("[' \\\\]","",sh.H1[[2]])
sh.H1
sh.H2<-gsub("[' \\\\]","",sh.H2[[2]])
sh.H2
h3<-list()
h3[[1]]<-sh.H1[2]
h3[[2]]<-sh.H2[2]
h3

names(h3)[1]<-sh.H1[1]
names(h3)[2]<-sh.H2[1]
h3
gg.json<-fromJSON(paste0(Sys.getenv("GIT_TOP"),"/ulysses/work/API/contents.json"))
gg.json
gg.js<-gg.json
gg.json<-fromJSON(paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/germanic/HA/body.json"))
gg.json<-fromJSON(paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/germanic/HA/contents3.json"))
#library(readtext)
ptx<-readLines(paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/germanic/HA/textfile.txt"))
p.text<-readLines(paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/germanic/HA/g-prompt01.txt"))
p.text<-c(p.text,ptx)
p.text
#gg.json$contents$parts
writeLines(p.text,paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/germanic/HA/textprompt.txt"))
bttx<-ptdf$text[1]
# p.text<-gsub("_bttx_",bttx,ptx)
# p.text<-paste0(p.text,collapse = "\n")
# p.text<-gsub("\n","   ",p.text)
gg.json$contents$parts[[1]]<-p.text
names(gg.json$contents$parts[[1]])<-"text"
write_json(gg.json,paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/germanic/HA/textprompt.json"))
gg.json
gg.js
gg.json<-fromJSON(paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/germanic/HA/contents3.json"))
gg.json$contents$parts
request_body<-gg.json
request_body
url<-gg.sh[1]
url<-gsub("curl ","",url)
url<-gsub('[\\\\ "]',"",url)
baseurl<-strsplit(url,"models/")
model<-strsplit(baseurl[[1]][2],":")
model1<-model[[1]][1]
model2<-model[[1]][2]
baseurl
baseurl<-paste0(baseurl[[1]][1],"models/")
geturl<-paste0(baseurl,model1,":",model2)
geturl
request_body
h3<-unlist(h3)
h3
toJSON(request_body)

response <- POST(geturl, body = toJSON(request_body, auto_unbox = TRUE), encode = "json",add_headers(.headers=h3))
response <- POST(geturl, body = "@request.json",add_headers(.headers=h3))
response <- POST(geturl, body = toJSON(gg.js, auto_unbox = TRUE), encode = "json",add_headers(.headers=h3))
t<-content(response,"text")
t

body<-list(contents = list(
  list(
    role = "user",
    parts = list(
      list(
        fileData = list(
          mimeType = "text/plain",
          fileUri = "textprompt.txt"
        )
      )
    )
  )
)
)
write_json(body,"~/Documents/GitHub/SPUND-LX/germanic/HA/contents2.json")
########################
get.sum<-function(ptdf){
ptdf$summary<-NA
#k<-1
tprompt<-readLines("g-prompt01.txt")
body <- fromJSON("bodytemplate.json", simplifyVector = FALSE)
for(k in 1:length(ptdf$date)){
ptext<-ptdf$text[k]
tbody<-c(tprompt,ptext)
#tbody<-readLines("textprompt.txt")
tbody<-paste0(tbody,collapse = "\n")
#body <- fromJSON("textprompt.json", simplifyVector = FALSE)
body$contents[[1]]$parts[[1]]$text<-tbody
#body<-gg.json
url
body
api_key
res <- POST(
  url = url,
  query = list(key = api_key),
  add_headers(`Content-Type` = "application/json"),
  body = body,
  encode = "json"
)
t<-content(res,"text")
tlist<-fromJSON(t,simplifyVector = T)
tx<-tlist$candidates$content$parts[[1]]$text
tx
ptdf$summary[k]<-tx
#writeLines(tx,"testoutput.txt")
s<-10
cat("processed:",k,"... waiting -",s,"-seconds\n")
Sys.sleep(s)
}
return(ptdf)
}
btt.summaries<-get.sum(ptdf)
# save(btt.summaries,file = paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/huening/btt.summaries.RData"))
# curl<-'curl \
# -X POST \
# -H "Content-Type: application/json" \
# "https://${API_ENDPOINT}/v1/publishers/google/models/${MODEL_ID}:${GENERATE_CONTENT_API}?key=${API_KEY}" -d "@request.json"'
# 
# 
}
############################################################
### get gpt keywords: gpt preferred words vs. human language
############################################################
get.tokens<-function(){
library(quanteda)
# library(devtools)
# install_github("skeptikantin/collostructions")

library(collostructions)
# btt.f<-lapply(btt.summaries$summary,function(x){
#   t<-strsplit(x," ")
#   freq.list(unlist(t))
# })
# dfmat2<-matrix
library(dplyr)
library(tidyr)
#install.packages("tidytext")
library(tidytext)
load(paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/huening/btt.summaries.RData")) # protocols + gpt summary texts 
load(paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/huening/ptdf_btt02.RData")) # protocols after gemini
#load(paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/huening/ptdf_btt01.RData")) # protocols before gemini
df<-btt.summaries
# Add corpus labels for binding
# df_human <- df %>%
#   mutate(corpus = "human") %>%
#   rename(text = text)
# 
# df_gpt <- df %>%
#   mutate(corpus = "gpt") %>%
#   rename(summary = text)
df1<-df[,1:2]
df2<-df[,c(1,3)]
df1<-cbind(df1,"human")
df2<-cbind(df2,"gpt")
colnames(df1)<-c("date","text","target")
colnames(df2)<-c("date","text","target")
df_combined <- bind_rows(df1,df2)
library(stringr)
# Tokenize to words (lowercase, remove punctuation/numbers)
df_combined$id<-1:length(df_combined$date)
#df_combined$text[1]
### step to udpipe
# tokens <- df_combined %>%
#   unnest_tokens(word, text, token = "words") %>%
#   filter(str_detect(word, "^[A-Za-zäöüÄÖÜ]+$")) %>%  # Optional: alphabetic words only
#   mutate(word = tolower(word))
# tokens <- df_combined %>%
#   unnest_tokens(word, text, token = "words")# Optional: alphabetic words only
# tokens<-unlist(strsplit(df_combined$text,"[ .:,;?!\\)\\(\\|\n|\\]|\\["))
# tokens<-tokens[tokens!=""]
tokens.2 <- df_combined %>%
  unnest_tokens(word, text, token = "words",to_lower = F) # Optional: alphabetic words only
  head(tokens.2$word,20)
ptdf.2$target<-"post"
tokens.3<-ptdf.2 %>%
  unnest_tokens(word,text,token = "words",to_lower = F)
# ?unnest_tokens
###########################
#     stops<-stopwords("de")
# stops.m<-c("dass","a","ab")
# stops.j<-c(stops,stops.m)
# m<-tokens$word%in%stops.j
# tokens.r<-tokens[!m,]
# df_freq <- tokens.r %>%
#   group_by(target, word) %>%
#   summarise(docs_with_word = n_distinct(id), .groups = "drop") %>%
#   mutate(total_docs = length(unique(df_combined$id)))  # N same for both corpora
# df_freq <- tokens.r %>%
#   group_by(target, word) %>%
#   summarise(docs_with_word = n_distinct(id), .groups = "drop") %>%
#   mutate(total_docs = length(unique(df_combined$date)))  # N same for both corpora
# ?n_distinct
###################
# for udpipe
tokens.r<-tokens.2
colnames(tokens.r)
# # fh<-freq.list(tokens.r$word[tokens.r$target=="human"])
# # fg<-freq.list(tokens.r$word[tokens.r$target=="gpt"])
# # fa<-freq.list(tokens.r$word)
# # fj<-join.freqs(fg,fa)
# # fs<-fj%>%mutate(p=fg/fa)
# ### wks., joined frequencies of target=gpt+target=all, score for gpt
# head(fs,10)
# library(clipr)
# write_clip(head(fs,10))
#########################################
### fg=freq.gemini,fa=freq.all
# WORD	fg	fa	p
# thema	60	1601	0.0374765771392879
# unsere	49	2203	0.0222423967317295
# liebe	41	3356	0.0122169249106079
# wichtig	39	1607	0.0242688238954574
# parteifreunde	36	39	0.923076923076923
# geben	30	1298	0.0231124807395994
# heute	28	3836	0.0072992700729927
# arbeit	26	1394	0.0186513629842181
# einblick	25	34	0.735294117647059
# geht	24	3692	0.00650054171180932
##########################################
### now with lemma, udpipe pipeline...
# library(udpipe)
# model<-udpipe::udpipe_load_model(paste(Sys.getenv("HKW_TOP"),"data/german-gsd-ud-2.5-191206.udpipe",sep = "/"))
##################################
## test
# df.ann<-as.data.frame(udpipe::udpipe_annotate(model,df_combined$text,doc_id = df_combined$id,target=df_combined$target))
# df.sub<-df_combined[1,]
# df.ann<-udpipe::udpipe_annotate(model,df.sub$text,doc_id = df.sub$id,target=df.sub$target,parser = "none")
# df.ann<-udpipe::udpipe_annotate(model,df_combined$text,doc_id = df_combined$id,target=df_combined$target,parser = "none",trace = T)
# tu<-unique(tokens.2$word)

# df.ann<-udpipe::udpipe_annotate(model,fj$WORD,trace = T,parser = "none")
# 
# dfa.pos<-as.data.frame(df.ann)
# fj$lemma<-NA
# for(k in 1:length(dfa.pos$token)){
#   m<-fj$WORD==dfa.pos$token[k]
#   fj$lemma[m]<-dfa.pos$lemma[k]
# }
#save(dfa.pos,file = paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/huening/btt-dfa.pos.RData"))
# save(fj,file = paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/huening/fj.pos.RData"))
return(list(t1=tokens.r,t2=tokens.3))
}
#?udpipe_annotate
###########################################################################
###########################################################################
### 16062.from here
tokens<-get.tokens()
get.freq<-function(){
load(paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/huening/btt-dfa.pos.RData"))
#load(paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/huening/fj.pos.RData"))
tokens.r<-tokens$t1
tokens.3<-tokens$t2
tokens.r$lemma<-NA
tokens.3$lemma<-NA


#tokens.r$lemma <- fj$lemma[match(tokens.r$word, fj$WORD)]
tokens.r$lemma <- dfa.pos$lemma[match(tokens.r$word, dfa.pos$token)]
tokens.r$lemma[is.na(tokens.r$lemma)]<-tokens.r$word[is.na(tokens.r$lemma)]
tokens.3$lemma <- dfa.pos$lemma[match(tokens.3$word, dfa.pos$token)]
#tokens.3$lemma <- fj$lemma[match(tokens.3$word, fj$WORD)]
tokens.3$lemma[is.na(tokens.3$lemma)]<-tokens.3$word[is.na(tokens.3$lemma)]

stops<-stopwords("de")
stops
stops.m<-c("dass","a","ab","immer","mal","erst","ja") # manual edit
stops.p<-c("linken","beim","daran","geehrt","grünen","spd","cdu","csu","afd","AfD","fdp","dabei") # after modeling, (cmodel)
stops.j<-c(stops,stops.m,stops.p)
#??capitalize
library(Hmisc)
stops.u<-lapply(stops.j, function(x){
  c1<-capitalize(x)
})
stops.u<-unlist(stops.u)
stops.u
stops.j<-c(stops.j,stops.u)
stops.u<-lapply(stops.j, function(x){
  c1<-toupper(x)
})
stops.u<-unlist(stops.u)
stops.u
stops.j<-c(stops.j,stops.u)
stops.j<-unique(stops.j)
m<-tokens.r$word%in%stops.j

tokens.r<-tokens.r[!m,]
m<-tokens.3$word%in%stops.j
sum(m)
tokens.3<-tokens.3[!m,]
m<-tokens.r$lemma%in%stops.j
sum(m)
tokens.r<-tokens.r[!m,]
m<-tokens.3$lemma%in%stops.j
sum(m)
tokens.3<-tokens.3[!m,]
m<-tokens.3$lemma%in%stops.j
sum(m)
m<-tokens.r$lemma%in%stops.j
sum(m)
tok.r2<-tokens.r[tokens.r$word!="",]
tok.r2<-tok.r2[!is.na(tok.r2$word),]
tok.r2<-tok.r2[!is.na(tok.r2$word),]
tok.r2<-tok.r2[!is.na(tok.r2$lemma),]
sum(tok.r2$word=="wir")
sum(tok.r2$lemma=="Die")
tok.r3<-tokens.3[tokens.3$word!="",]
tok.r3<-tok.r3[!is.na(tok.r3$word),]
tok.r3<-tok.r3[!is.na(tok.r3$word),]
tok.r3<-tok.r3[!is.na(tok.r3$lemma),]
sum(grepl("[0-9]",tok.r3$lemma))
sum(grepl("[0-9]",tok.r2$lemma))
tok.r2<-tok.r2[!grepl("[0-9]",tok.r2$lemma),]
tok.r3<-tok.r3[!grepl("[0-9]",tok.r3$lemma),]
# t1<-table(tok.r2$lemma)
# t1[order(t1)]
# t1<-table(tok.r3$lemma)
# t1[order(t1)]
sum(tok.r3$word=="Die")
sum(tok.r2$lemma%in%"Die")
sum(tok.r2$word=="afd")
sum(tok.r2$lemma=="afd")
sum(grepl("AFD",tok.r2$lemma))
tok.r2[grepl("afd",tok.r2$word),]
sum(tok.r3$lemma%in%"Die")
sum(tok.r3$lemma%in%"AFD")

# fh<-freq.list(tok.r2$lemma[tok.r2$target=="human"])
# sum("es"==fh$WORD)
# fg<-freq.list(tok.r2$lemma[tok.r2$target=="gpt"])
# fp<-freq.list(tok.r3$lemma[tok.r3$target=="post"])
# #factor(tok.r2$lemma)
# fa<-freq.list(as.character(tok.r2$lemma))
# fj2<-join.freqs(fg,fa)
# fs2<-fj2%>%mutate(p=fg/fa)
# fj3<-join.freqs(fg,fa)
# sum(tok.r2$target=="gpt")
# fh<-as.data.frame(table(tok.r2$lemma[tok.r2$target=="human"]))
# fg<-as.data.frame(table(tok.r2$lemma[tok.r2$target=="gpt"]))
# fa<-as.data.frame(table(tok.r2$lemma))
# fp<-as.data.frame(freq.list(tok.r3$lemma[tok.r3$target=="post"]))
#fa<-table(tok.r2$lemma)
#fa<-fa[order(fa,decreasing = T)]
#fa
#?freq.list
t1<-table(tok.r2$lemma)
t1[t1=="afd"]
grep("afd",t1)
t1[order(t1)]
mode(tok.r2)
f1p<-data.frame(freq.list(tok.r3$lemma,convert = T))
f1a<-data.frame(freq.list(as.character(tok.r2$lemma),convert = T))
#f1ab<-f1a
#f1ab$lemma<-as.character(f1a$WORD)
f1h<-data.frame(freq.list(tok.r2$lemma[tok.r2$target=="human"],convert = T))
f1g<-data.frame(freq.list(tok.r2$lemma[tok.r2$target=="gpt"],convert = T))
fr.list<-list(a=f1a,h=f1h,g=f1g,p=f1p)
#save(fr.list,file = paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/huening/fr_list.RData"))
#f1a[fa$WORD=="die",]
# t1<-table(tok.r2$lemma)
# t1[order(t1,decreasing = T)]
}
#######################################################################
load(paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/huening/fr_list.RData"))
#######################################################################
get.lmdf<-function(){
f1p<-fr.list$p
f1a<-fr.list$a
f1g<-fr.list$g
f1h<-fr.list$h
f1p1<-data.frame(f1p,target="post",size=sum(f1p$FREQ))
f1a1<-data.frame(f1a,target="all",size=sum(f1a$FREQ))
f1h1<-data.frame(f1h,target="human",size=sum(f1h$FREQ))
f1g1<-data.frame(f1g,target="gpt",size=sum(f1g$FREQ))

######################################################
#f1z1<-f1g1[1,]
#1z1[1,]<-c("intercept",1,"0-intercept",1)
#fz1[1,1]<-"intercept"
#fa2<-rbind(fh1,fp1)
#f1
####################
### out
lmd.out<-function(){
lmdf<-rbind(f1z1,f1a1,f1h1,f1g1,f1p1)
lmdf$WORD<-as.character(lmdf$WORD)
mode(lmdf$WORD)
lmdf$WORD[lmdf$target=="0-intercept"]<-"intercept"
#lmdf$f.rel<-(lmdf$FREQ)/(lmdf$size)
mode(lmdf$FREQ)<-"double"
mode(lmdf$size)<-"double"
lmdf<-lmdf%>%mutate(f.rel=FREQ/size)
head(lmdf)
t1<-table(lmdf$WORD)
t1[order(t1)]
library(lme4)
library(lmerTest)
lm1<-lmer(f.rel~target+(1|WORD),lmdf)
summary(lm1)
# lm3<-lmer(FREQ~target*gu+(1|WORD)+size,fa2)
# summary(lm3)
lm1<-lm(f.rel~target,lmdf)
summary(lm1)
#sum(names(fa)=="Form")
# fj_h_g<-join.freqs(fh,fg,all=T)
# fj_h_p<-join.freqs(fh,fp,all=T)
# fj_g_a<-join.freqs(fa,fg,all = T)
# fs<-fj_g_a%>%mutate(p=(fg/sum(fg))+0.000001/(fa/sum(fa)+0.000001))
# fs5<-fj_h_p%>%mutate(p=(fh/sum(fh))+0.000001/(fp/sum(fp)+0.000001))
# fs<-fs[order(fs$p,decreasing = T),]
# head(fs,20)
# fs2<-fs[order(fs$p,decreasing = T),]
# head(fs2,10)
# gp<-fs2$WORD[fs2$fa<=fs2$fg]
# gp
# unique(lmdf$target)
# #lmdf$g0<-0
# # fa1$gu<-0
# # fh1$gu<-0
# # fp1$gu<-0
# # fg1$gu<-0
f1a1$gus<-0
f1h1$gus<-0
f1p1$gus<-0
f1g1$gus<-0
#fa1$gu<-0
f1a1$gus[f1a1$WORD%in%f1g1$WORD]<-1
f1h1$gus[f1h1$WORD%in%f1g1$WORD]<-1
f1p1$gus[f1p1$WORD%in%f1g1$WORD]<-1
f1g1$gus[f1g1$WORD%in%f1g1$WORD]<-1
f1z1$gus<-0
sum(f1p1$gus)
sum(f1h1$gus)
lmdf<-rbind(f1z1,f1a1,f1h1,f1g1,f1p1)
lmdf$WORD<-as.character(lmdf$WORD)
mode(lmdf$WORD)
mode(lmdf$FREQ)<-"double"
mode(lmdf$size)<-"double"
lmdf$f.rel<-as.double(lmdf$FREQ)/as.double(lmdf$size)
lmdf$WORD[lmdf$target=="0-intercept"]<-"intercept"
head(lmdf)
lmdf$gus<-lmdf$gus*lmdf$f.rel
#fs2$target<-"all"
#fs5$target<-"allpp"
#fs2$e<-"gpt"
#fs2$target[match(fa,fg)]<-"gpt"
#tokens.r$lemma <- fj$lemma[match(tokens.r$word, fj$WORD)]
# fs2$target[fs2$fa==fs2$fg]<-"gpt"
# fs2$target[fs2$fg==0]<-"human"
# fs5$target[fs5$fh==0]<-"post"
# fs5$target[fs5$fp==0]<-"phuman"
# fs6<-rbind(fs2[,c(1,4,5)],fs5[,c(1,4,5)])
get.dist.norm<-function(lmdf){
  #df<-data.frame(dfa)
  dfa<-lmdf
  #  lim<-limit
#  dflim<-subset(df,df$dist<limit)
 # typeof(dflim)
  mode(dfa$size)<-"double"
  mode(dfa$FREQ)<-"double"
  tdb6<-dfa
  #  mode(tdb6$size)<-"double"
  
  target<-unique(tdb6$target)
  tdb6$f.norm_within<-NA
  # tdb6$f.norm_all<-mean(tdb6$FREQ)/tdb6$FREQ
  # tdb6$f.norm_h<-mean(tdb6$FREQ[tdb6$target=="human"])/tdb6$FREQ
  # tdb6$f.norm_g<-mean(tdb6$FREQ[tdb6$target=="gpt"])/tdb6$FREQ
  # tdb6$f.norm_p<-mean(tdb6$FREQ[tdb6$target=="post"])/tdb6$FREQ
  tdb6$f.norm_all<-mean(tdb6$f.rel)/tdb6$f.rel
  tdb6$f.norm_h<-mean(tdb6$f.rel[tdb6$target=="human"])/tdb6$f.rel
  tdb6$f.norm_g<-mean(tdb6$f.rel[tdb6$target=="gpt"])/tdb6$f.rel
  tdb6$f.norm_p<-mean(tdb6$f.rel[tdb6$target=="post"])/tdb6$f.rel
  for(k in target){
    r<-tdb6$target==k
    mr<-mean(tdb6$f.rel[r])/tdb6$f.rel[r]
    tdb6$f.norm_within[r]<-mr
  }
  tdb6$f.rel_within<-tdb6$f.rel*tdb6$f.norm_within
  tdb6$f.rel_all<-tdb6$f.rel*tdb6$f.norm_all
  tdb6$f.rel_all<-tdb6$f.norm_all
  tdb6$f.rel_h<-tdb6$f.rel*tdb6$f.norm_h
  tdb6$f.rel_g<-tdb6$f.rel*tdb6$f.norm_g
  tdb6$f.rel_p<-tdb6$f.rel*tdb6$f.norm_p
  tdb6$range_c<-tdb6$size-mean(tdb6$size,na.rm=T)
#  tdb6$embed_c<-tdb6$embed.score-mean(tdb6$embed.score,na.rm=T)
#  tdb6$f_rel_scaled<-tdb6$FREQ / tdb6$size  # values now in [0,1] relative to each URL’s size
  
  df_norm <- dfa %>%
    group_by(target) %>%
    mutate(
      f.rel   = FREQ / sum(FREQ),          # relative frequency within corpus
      f.pm    = (FREQ / sum(FREQ)) * 1e6  # per million tokens
    ) %>%
    ungroup()
  
  return(df_norm)
}

lmdf.n<-get.dist.norm(lmdf)
#t1<-table(lmdf.n$WORD)
lmdf.c<-lmdf.n[!grepl("intercept|all",lmdf.n$target),]
lmdf.c$target[grep("human",lmdf.c$target)]<-"0-human"
m1 <- lmer(f.pm ~ target + (1 | WORD), data = lmdf.c)
summary(m1)
m2 <- lmer(f.pm ~ target * gus +
             (1 | WORD),
           data = lmdf.c)
summary(m2)
m3<-lm(f.pm~target*gus,lmdf.c)
summary(m3)
#  one row per token with variables: corpus (0/1), lemma, text_id
m <- glmer(target ~ 1 + (1 | lemma),
           data = tok.r2,
           family = binomial)
m <- glmer(target ~ 1 + (1 | lemma),
           data = tok.r2)



############################
library(dplyr)
library(tidyr)

tab <- freq_df %>%
  mutate(target = factor(target, levels = c("human", "gpt"))) %>%
  pivot_wider(
    names_from  = target,
    values_from = freq,
    values_fill = 0
  ) %>%
  rename(
    human_count = human,
    gpt_count   = gpt
  )
} #end out
############################################
### this
lmdf<-data.frame(rbind(f1a1,f1p1,f1g1,f1h1))
mode(lmdf$FREQ)<-"double"
mode(lmdf$target)
lmdf$lemma<-as.character(lmdf$WORD)
m<-colnames(lmdf)%in%c("lemma","FREQ","size","target")
sum(m)
m<-which(m)
m
lmdf.c<-lmdf[,m]
sum(lmdf.c$lemma=="afd")
#mode()
#factor(lmdf$target,levels = c("human", "gpt","all"))
unique(lmdf$target)
mode(lmdf.c$lemma)
mode(lmdf.c$target)
mode(lmdf.c$FREQ)
mode(lmdf.c$size)
lmdf.c<-lmdf.c%>%mutate(freq=as.double(FREQ))
#?pivot_wider
library(tidyr)
tab <- 
  pivot_wider(lmdf.c,
    names_from  = target,
    values_from = FREQ,
    values_fill = 0
    
  ) 
library(lme4)
library(lmerTest)
#################
### get GPT score
#################
# takes bit...
#################
m <- glmer(
  cbind(gpt, human) ~ 1 + (1 | lemma),
  data   = tab,
  family = binomial
)
# ?ranef

re_lemma <- ranef(m)$lemma  # data frame with '(Intercept)'
re_lemma$lemma <- rownames(re_lemma)
# re_lemma$res<-rl[,1]
#save(re_lemma,file=paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/huening/lemma_gpt-human.RData"))
#############################################
# Higher random intercept => more GPT‑typical
gpt_typical  <- re_lemma[order(-re_lemma[["(Intercept)"]]), ]
# gpt_typical  <- re_lemma[order(-re_lemma$res), ]
human_typical <- re_lemma[order(re_lemma[["(Intercept)"]]), ]
# tr<-re_lemma[re_lemma$`(Intercept)`>0,] # useless, simply all gpt lemma?
# tr<-re_lemma[re_lemma$`(Intercept)`>8,] # useless, simply all gpt lemma?
lmdf.c$gus.c<-0
#lmdf.c$gus.c[lmdf.c$lemma%in%tr$lemma]<-1
lmdf.c$gus.c[lmdf.c$lemma%in%lmdf.c$lemma[lmdf.c$target=="gpt"]]<-1 # set predictor=1 if lemma in gpt corpus
lmdf.c$in.gp<- re_lemma$`(Intercept)`[match(lmdf.c$lemma, re_lemma$lemma)] 
lmdf.c$f.rel<-(lmdf.c$freq/lmdf.c$size)*100
lmdf.c$target[grepl("human",lmdf.c$target)]<-"0-human"
save(lmdf.c,file = paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/huening/lm-base_lmdf.c.RData"))
save(lmdf.c,file = paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/germanic/HA/lm-base_lmdf.c.RData"))
}
# qlist<-list(lmdf=lmdf.c,plots=list(bplot=bplot,gplot=gplot),eval=list(gpt.v=gpt_typical))
#?glmer
#######################################
test.lm<-function(){
# lmdf.c$gus.c<-0
# lmdf.c$gus.c[lmdf.c$gus==1]<-lmdf.c$f.rel[lmdf.c$gus==1]
#   #t1[order(t1,decreasing = F)]
#head(lmdf.n,30)
lm1<-lm(f.rel~target*in.gp,lmdf.c)
# lm1<-lm(f.rel~target+in.gp,lmdf.c)
# lm1<-lm(f.rel~target*gus.c,lmdf.c)
summary(lm1)
#lmdf[lmdf$target=="post",]
lm2<-lmer(f.rel~target*in.gp+(1|lemma),lmdf.c)
# lm2<-lmer(f.rel~target*in.gp+(1|size),lmdf.c)
# lm2<-lmer(f.rel~target*gus.c+(1|size),lmdf.c)
# lm2<-lmer(f.rel~target*gus.c+in.gp+(1+gus.c|lemma),lmdf.c)
summary(lm2)
#}
##############################################
### lm with limited set
newdata <- data.frame(
  target = "post",
  # in.gp = c(0, 1),  # human vs GPT typical
  # in.gp = -10:10,  # human vs GPT typical
  in.gp = head(gpt_typical$`(Intercept)`,10),  # human vs GPT typical
  lemma = "dummy"
)

p1<-predict(lm2, newdata, re.form = NA)  # fixed effects only
p1
p1<-data.frame(gp.score=newdata$in.gp,freq=p1)
plot(p1,type="l")

# Base R scatter plot by target group
gpt.pplot<-plot(lmdf.c$in.gp, lmdf.c$f.rel, 
     col  = as.factor(lmdf.c$target), 
     pch  = 19, 
     xlab = "in.gp (GPT typicality score)",
     ylab = "f.rel (relative frequency)",
     main = "GPT scores vs relative frequency by target"

     )
legend("topright", 
            legend = levels(as.factor(lmdf.c$target)),
            col   = 1:length(levels(as.factor(lmdf.c$target))), 
            pch   = 19)
#)
}
#gpt.pplot
# Add legend
# legend("topright", 
#        legend = levels(as.factor(lmdf.c$target)),
#        col   = 1:length(levels(as.factor(lmdf.c$target))), 
#        pch   = 19)
# 
# #gpt.pplot
# # Add regression lines per group (optional)
# targets <- unique(lmdf.c$target)
# colors  <- 1:length(targets)
# 
# for(i in seq_along(targets)) {
#   subset_data <- lmdf.c[lmdf.c$target == targets[i], ]
#   abline(lm(f.rel ~ in.gp, data = subset_data), 
#          col = colors[i], lwd = 2)
# }
###################################
### descriptive stats simple
do.desc<-function(){
load(paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/germanic/HA/lm-base_lmdf.c.RData"))

m<-lmdf.c$gus.c==1
sum(m)
mh<-lmdf.c$target=="0-human"
mp<-lmdf.c$target=="post"
mg<-lmdf.c$target=="gpt"
shc<-sum(which(mh)%in%which(m))
spc<-sum(which(mp)%in%which(m))
sgc<-sum(which(mg)%in%which(m))
sh<-sum(lmdf.c$freq[mh])
sg<-sum(lmdf.c$freq[mg])
sp<-sum(lmdf.c$freq[mp])
mh1<-lmdf.c$gus.c==1&lmdf.c$target=="0-human"
sh1<-sum(lmdf.c$freq[mh1])/sum(lmdf.c$freq[lmdf.c$target=="0-human"])
mp1<-lmdf.c$gus.c==1&lmdf.c$target=="post"
sp1<-sum(lmdf.c$freq[mp1])/sum(lmdf.c$freq[lmdf.c$target=="post"])
mg1<-lmdf.c$gus.c==1&lmdf.c$target=="gpt"
sg1<-sum(lmdf.c$freq[mg1])/sum(lmdf.c$freq[lmdf.c$target=="gpt"])
sp1>sh1 # TRUE!
### > more occurences (rel. frequencies) of gpt vocabular in post gpt corpus
sp1-sh1 # only 0.02587 points
############################################################################
### simple plots
#p.df<-data.frame(gpt=sg1,pregpt=sh1,postgpt=sp1)

#save(lmdf.c,file = paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/germanic/HA/lm-base_lmdf.c.RData"))
# qlist<-list(lmdf=lmdf.c,plots=list(p.df=p.df),eval=list(gpt.v=gpt_typical))


#boxplot(p.df)
p.df<-lmdf.c
#p.df<-data.frame(gpt=lmdf.c$freq[mg1],human=lmdf.c$freq[mh1],postgpt=lmdf.c$freq[mp1])
p.df$target[p.df$target=="0-human"]<-"human"
#?boxplot
boxplot(f.rel~target,p.df[c(which(mh1),which(mp1)),],outline=F,notch=T)
library(ggplot2)
dff2<-p.df[c(which(mh1),which(mp1),which(mg1)),]
#max(p.df$f.rel)
# ggplot(data = dff2, aes(x = f.rel,fill = target)) +
#   geom_density(alpha=0.5) +
#   labs(title = "Density Plot", x = "clip score", y = "Density") +
#   theme_minimal() 
ggplot(data = dff2, aes(x = f.rel, fill = target)) +
  geom_density(alpha = 0.3) +
  coord_cartesian(xlim = c(0, 0.12)) +  # set your range here
  labs(title = "Density Plot", x = "clip score", y = "Density") +
  theme_minimal()
}
#################################################################
### lm with limited subset of corpus
lm.lim<-function(){
  mh<-lmdf.c$target=="0-human"
  mp<-lmdf.c$target=="post"
  sum(mh)
sum(mp)
lmdf.s<-lmdf.c[c(which(mh),which(mp)),]
p.df<-lmdf.c
#p.df<-data.frame(gpt=lmdf.c$freq[mg1],human=lmdf.c$freq[mh1],postgpt=lmdf.c$freq[mp1])
p.df$target[p.df$target=="0-human"]<-"human"
lm1<-lm(f.rel~target*in.gp,lmdf.s)
# lm1<-lm(f.rel~target+in.gp,lmdf.c)
# lm1<-lm(f.rel~target*gus.c,lmdf.c)
summary(lm1)
anova(lm1)
#lmdf[lmdf$target=="post",]
# lm2b<-lmer(f.rel~target*in.gp+(1|lemma),lmdf.s)
 lm2b<-lmer(f.rel~target+in.gp+(1|lemma),lmdf.s)
# lm2a<-lmer(f.rel~target+in.gp+(1|lemma),lmdf.c)
lm2a<-lmer(f.rel~target*in.gp+(1|lemma),lmdf.c) ### this, all targets
#lm2b<-lmer(f.rel~target*gus.c+in.gp+(1|lemma),lmdf.s) ### or this, target pre/post
summary(lm2a)
summary(lm2b)
lm3 <- glmer(f.rel ~ target * in.gp + (1 | lemma), data = lmdf.c, 
                    family = poisson(link = "log"))
lm3 <- glmer(f.rel ~ target + in.gp + (1 | lemma), data = lmdf.c, 
             family = poisson(link = "log"))
lm2a_glmer <- glmer(f.rel ~ target * in.gp + (1 | lemma), 
                    data = lmdf.c, 
                    family = poisson(link = "log"),
                    control = glmerControl(optimizer = "bobyqa", 
                                           optCtrl = list(trace = 1, MAXFUN = 100000)))
lm2a_glmer <- glmer(f.rel ~ target * in.gp + (1 | lemma), 
                    data = lmdf.c, 
                    family = poisson(link = "log"),
                    verbose = 5)  # Levels 0-5; 5 shows everything [web:44]
lm2a_glmer <- glmer(f.rel ~ target + in.gp + (1 | lemma), 
                    data = lmdf.c, 
                    family = poisson(link = "log"),
                    verbose = 5,  # Max debugging output
                    control = glmerControl(
                      optimizer = "bobyqa",
                      optCtrl = list(trace = 1, maxfun = 10),  # Max 5000 fn evaluations
                      calc.derivs = FALSE  # Faster, less precise
                    ))
# 1. Switch optimizer (handles cycling better)
control = glmerControl(optimizer = "Nelder_Mead", 
                       optCtrl = list(maxfun = 5000))

# 2. Better starting values from simpler model
simple <- glmer(f.rel ~ 1 + (1|lemma), family=poisson, data=lmdf.c)
lm2a_glmer <- update(simple, . ~ . + target*in.gp, 
                     control=glmerControl(optimizer="bobyqa", 
                                          optCtrl=list(maxfun=5000)))

# 3. Scale predictors (flattens surface)
lmdf.c$target_s <- scale(lmdf.c$target)[,1]
lmdf.c$in_gp_s <- scale(as.numeric(lmdf.c$in.gp))[,1]
glmer(f.rel ~ target_s * in_gp_s + (1|lemma), family=poisson, data=lmdf.c)

############
tab <- 
  pivot_wider(lmdf.c,
              names_from  = target,
              values_from = FREQ,
              values_fill = 0
              
  ) 
tab2 <- 
  pivot_wider(lmdf.c,
              names_from  = target,
              values_from = f.rel,
              values_fill = 0
              
  )
colnames(tab2)[grep("0",colnames(tab2))]<-"human"
#################
### get GPT score
#################
# takes bit...
#################

m3 <- glmer(
  cbind(gpt, human) ~ 1*gus.c + (1 | lemma)+(1|gus.c),
  data   = tab2,
  family = binomial,
  verbose =5
)
unique(1*lmdf.c$gus.c)
m3 <- glmer(
  f.rel ~ target + (1 | lemma)+(1|gus.c),
  data   = lmdf.c,
  family = poisson("sqrt"),
  verbose =5
)
?glmer
m3 <- glmer(
  cbind(human,post) ~ 1*in.gp + (1 | lemma),
  data   = tab2,
  family = binomial,
  verbose =5
)
simple <- glmer(f.rel ~ 1 + (1|lemma), family=poisson, data=lmdf.c)
summary(m3)
lmran<-ranef(m3)
lran3<-lmran$lemma
lran3$lemma<-rownames(lran3)
lran3<-lran3[order(lran3$`(Intercept)`,decreasing = T),]
head(lran3,30)
tail(lran3,30)

summary(m3)
lmran<-ranef(lm2a)
lran<-lmran$lemma
lran$lemma<-rownames(lran)
lran<-lran[order(lran$`(Intercept)`,decreasing = F),]
# save(lran,file = paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/germanic/HA/lemma-res.lran.RData"))
lres.h<-head(lran,1000)
lres.t<-tail(lran,1000)
lres<-rbind(lres.h,lres.t)
save(lres,file = paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/germanic/HA/lemma-res.lres.RData"))

lres
# lm2<-lmer(f.rel~target*in.gp+(1|size),lmdf.c)
#lm2<-lmer(f.rel~target+in.gp+(1|lemma),lmdf.c)
#lm2<-lmer(f.rel~target+in.gp+(1|lemma),lmdf.s)
#lm2<-lmer(f.rel~target*gus.c+in.gp+(1|lemma),lmdf.s)
#summary(lm2)
s2<-summary(lm2a)
s2$coefficients
s2$varcor
s2$devcomp
s2<-summary.lm(lm1)
s3<-vcov(lm2a)
s3
s2
ingpvar<-s2$vcov@factors$correlation[rownames(s2$vcov@factors$correlation)=="in.gp"]
ingpvar<-s2$vcov@factors$correlation
colnames(ingpvar)
ingpv<-ingpvar[,5]
ingpv[4]
?summary
pc1<-s2$coefficients[8,1]/s2$coefficients[1,1]*100
#+s2$coefficients[1,1]
pc8<-round(s2$coefficients[8,1],6)
pc1<-round(s2$coefficients[1,1],6)
# pcd<-pc1-pc8
# pcd<-round(pcd,5)
#pcd
# pc1<-10
# pc8<-2
pcd<-pc8
p100<-100/pc1
pcdp<-(pcd*p100)
pcdp
pcdp<-round(pcdp,5)
pcdp
#pcdp
#pc1<-s2$coefficients[1,1]
pcp<-round(pc8/pc1*100,2)

}
############
### get responsible lemmata
suh<-lmdf.c[mh1,]
sup<-lmdf.c[mp1,]
lhp<-lapply(suh$lemma, function(x){
  f1<-suh$freq[suh$lemma==x]/sum(suh$freq)
  f2<-sup$freq[sup$lemma==x]/sum(sup$freq)
  ifelse(f2>f1,return(sup[sup$lemma==x,]),return(NA))
  return(NA)
})
library(abind)
lhp<-lhp[!is.na(lhp)]
lpt<-data.frame(abind(lhp,along = 1))
# sum(lhpu)
# lpt<-suh[lhpu,]
# x<-10
# y<-100
# x/(y*100)
lpt[lpt$in.gp>8&lpt$f.rel>=4,]
lpt$f.r2<-as.double(lpt$freq)/as.double(lpt$size)*100
lpt[lpt$in.gp>=6&lpt$f.r2>=0.02,]
#save(lpt,file = paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/germanic/HA/lpt.RData"))

#################################
### how many speakers in plenar?
# relation in.gp / f.rel:
# with
# lc<-lpt[lpt$in.gp>=7&lpt$f.r2>=0.02,]
# # we get n=9 lemma, freq from 303 to 1616
# # ?chisq.test
# lp<-lpt
i<-1
k<-113
k
i<-1
############################################################################
### get lemma responsible for results, by chisquare test on correlation of
### relative frequencies and gpt score of lemma
get.lemmas<-function(pt=0.2){
  mf<-max(lpt$f.r2)
  mf<-ceiling(mf*100)
  mfa<-c(1:mf)
  cmodel<-lapply(seq_along(1:ceiling(as.double(max(lpt$in.gp)))), function(i){
  plist<-list()
  lt<-list(p=1)
  ll<-list()
  
  put.lemma<-function(lt.p,lc){
    ll<-list()
    
  ll$p<-lt.p
  ll$lemmas<-lc$lemma
  return(ll)
  }
  #k
  cat("top run:",i,"\n")
#  mfa
  k<-10
  for(k in mfa){
    cat("run",i,"loop run:\t\t",k,"\r")
    p<-k/100
    lc<-lpt[lpt$in.gp>=i&lpt$f.r2>=p,]
  ifelse(length(lc$FREQ)>1,
  lt<-chisq.test(lc$in.gp,lc$f.r2),
  lt$p.value<-1)
  lt.p<-lt$p.value
  lt.p
  plist[k]<-NA
  if(lt.p<pt&lt.p>0.0000000001){
    plist[k]<-lt.p
    ll[[k]]<-put.lemma(lt.p,lc)
  }
  }
  return(ll)
})
all_lemmas <- unlist(lapply(cmodel, function(L1) {
  l<-lapply(L1, function(L2){L2[["lemmas"]]
  })
}))

lemmas<-all_lemmas[!is.na(all_lemmas)]
# t1<-table(lemmas)
# t1<-t1[order(t1,decreasing = T)]
# t1
t1<-freq.list(lemmas)
}
# t1<-get.lemmas(pt=0.1) # pt = threshold to chisquare valid p-value of freq vs gpt.score, here: p < pt
# t1
### wks.
### turns out that
# afd,cdu,csu,spd,grünen are the topmost responsible lemma for our results at a pt=0.5 threshold
# so these have to be discarded via the stoplist
# if we set pt lower then we get more human terms i.e. we harden the connection between a high score and a high frequency and get more valuable terms.
# put that in a matrix...
t1<-get.lemmas(pt=0.1) # pt = threshold to chisquare valid p-value of freq vs gpt.score, here: p < pt
t2<-get.lemmas(pt=0.2) # pt = threshold to chisquare valid p-value of freq vs gpt.score, here: p < pt
tj<-join.freqs(t1,t2)
tj2<-tj[tj$t1!=tj$t2,]
tj3<-tj2%>%mutate(diff=t2-t1)
#save(tj3,file = paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/germanic/HA/lemma-resp.tj3.RData"))
###########################################################################################
###
#chisq.test(lc$in.gp,lc$f.r2)
# model collapses
# ## Effect of simulating p-values
# x <- matrix(c(12, 5, 7, 7), ncol = 2)
# x
# chisq.test(x)$p.value           # 0.4233
# chisq.test(x, simulate.p.value = TRUE, B = 10000)$p.value
# # around 0.29!
# x <- c(A = 20, B = 15, C = 25)
# x<-matrix(c(sh1,sp1,sg1,sh,sp,sg),ncol = 2)
# x<-c(sh1,sp1,sg1,sh,sp,sg)
# chisq.test(x)
# chisq.test(as.table(x))             # the same
# #x <- c(89,37,30,28,2)
# x<-c(sh1,sp1,sh,sp)
# p <- c(0.05,0.05,0.05,0.05)
# try(
#   chisq.test(x, p = p)                # gives an error
# )
# chisq.test(x, p = p, rescale.p = TRUE)
# 

# # Density plot of in.gp by target
# levels(factor(lmdf.c$target))
# plot(density(lmdf.c$in.gp[lmdf.c$target == levels(factor(lmdf.c$target))], 
#              main = "Distribution of GPT scores (in.gp) by target",
#              xlab = "in.gp (GPT typicality score)",
#              ylab = "Density",
#              col  = 1, 
#              lwd = 2))
#      
#      # Overlay densities for all targets
#      targets <- levels(as.factor(lmdf.c$target))
#      colors  <- rainbow(length(targets))
#      for(i in seq_along(targets)) {
#        dens <- density(lmdf.c$in.gp[lmdf.c$target == targets[i]])
#        lines(dens, col = colors[i], lwd = 2)
#      }
#      
#      # Legend
#      legend("topright", 
#             legend = targets,
#             col    = colors, 
#             lwd    = 2)
# 
#      
#           levels(factor(lmdf.c$target))
#      plot(density(lmdf.c$f.rel[lmdf.c$target == levels(factor(lmdf.c$target))], 
#                   main = "Distribution of GPT scores (in.gp) by target",
#                   xlab = "in.gp (GPT typicality score)",
#                   ylab = "Density",
#                   col  = 1, 
#                   lwd = 2))
#      
#      # Overlay densities for all targets
#      targets <- levels(as.factor(lmdf.c$target))
#      colors  <- rainbow(length(targets))
#      for(i in seq_along(targets)) {
#        dens <- density(lmdf.c$in.gp[lmdf.c$target == targets[i]])
#        lines(dens, col = colors[i], lwd = 2)
#      }
#      
#      # Legend
#      legend("topright", 
#             legend = targets,
#             col    = colors, 
#             lwd    = 2)
#      
#sum(match(fs2$fa,fs2$fg))
#fa1$gu[fa1$WORD%in%gp]<-1
#f#g1$gu[fg1$WORD%in%gp]<-1
#fg1$gu<-fs4$p
#fg1$gu<-fs3$p
#fg1$gus<-fg1$FREQ*fg1$gu
#fh1$gu[fh1$WORD%in%gp]<-1
#fp1$gu[fp1$WORD%in%gp]<-1
sum(fa1$gu)
fa3<-join.freqs(fh,fg)
fa4<-fa3%>%mutate(fa=fh+fg)
fa4<-fa4[,c(1,4)]
fa4
fa5<-join.freqs(fa4,fp)
fa2<-rbind(fh1,fg1,fp1)
f
fa2$target<-"all"
lmdf<-rbind(fa2,fh1,fg1,fp1)
sum(lmdf$gu)
lmdf$f.rel<-lmdf$FREQ/lmdf$size
head(lmdf)
library(lme4)
library(lmerTest)
lm1<-lmer(f.rel~target*gus+(1|WORD),lmdf)
#s1<-lmdf[sample(length(lmdf$WORD),50),]
# lm1<-lmer(FREQ~target*gu+(1|size),lmdf)
summary(lm1)
lm2<-lm(f.rel~target*gus,lmdf)
summary(lm2)
fj5<-join.freqs(fa,fg,all = T)
fj6<-join.freqs(fa,fp,all = T)
fj7<-join.freqs(data.frame(fj6[,c(1,2)]),fg,all = T)
fj8<-join.freqs(data.frame(fj7[,c(1,2)]),data.frame(fj1[,c(1,3)]))
fj9<-join.freqs(data.frame(fj8[,c(1,2)]),data.frame(fj7[,c(1,3)]))
fj10<-join.freqs(data.frame(fj9[,c(1,2)]),data.frame(fj6[,c(1,3)]))
fj9<-cbind(as.character(fj7$Var1),fj7[,c(2,3)],fj4[,3])
fj10<-cbind(factor(fj7$Var1),fj9)
fj10[,1]<-as.character(fj7[,1])
typeof(fj7[,1])
fj3<-fj2
fj3$fg<-NA
fj11<-fj6
fj11$fg<-NA
for(k in 1:length(fg$Var1)){
  cat("processing: ",k,"\r")
  m<-fj11$Var1%in%fg$Var1[k]
  fj11$fg[m]<-fg$Var1[k]
}
fj11$fh<-fj11$fa-fj11$fg
#########################
#save(fj11,file = paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/huening/fj11.f.all.RData"))
#######################################################################################
fj3$fg<-fg$Freq[match(fg$Var1, fj3$Var1)]

fs<-fj1%>%mutate(p=fg/fa)
fs<-fs[order(fs$p,decreasing = T),]
head(fs,10)
fs2<-fs2[order(fs2$p,decreasing = T),]
head(fs2,10)
?join.freqs
fj2<-join.freqs(fg,fa,all = F)
fs3<-fj2%>%mutate(p=fg/fa)
fg1$gu<-fs3$p
fs3<-fs3[order(fs3$p,decreasing = T),]
#fs3<-fs3[fs3$p!=1,]
#fs2<-fs2[order(fs2$p,decreasing = T),]
head(fs3,20)
fs4<-fs3
fs4$ng<-length(fg$WORD)
fs4$na<-length(fa$WORD)
fs4$rfg<-fs4$fg/fs4$ng
fs4$rfa<-fs4$fa/fs4$na
head(fs4,20)
fs4$rp<-fs4$rfg/fs4$rfa
fs4<-fs4[order(fs4$rp,decreasing = T),]

head(fs4,30)
save(fs4,file = paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/huening/freq.fs4.RData"))
save(fs4,file = paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/germanic/HA/freq.fs4.RData"))

### wks.
#######################################
load(paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/germanic/HA/freq.fs4.RData"))
head(fs4,30)
fs4[fs4$fa==0,]


