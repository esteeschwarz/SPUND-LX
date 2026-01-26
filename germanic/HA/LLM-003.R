# 20250125(15.03)
# 16042.gemini.corpus.btt
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
r2<-r
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

range<-c("2021-01-01","2021-03-31")
tdf1<-getdf(range)
range<-c("2021-04-01","2021-12-31")
tdf2<-getdf(range)
range<-c("2021-04-01","2021-05-30")
tdf3<-getdf(range)
range<-c("2021-06-01","2021-07-31")
tdf4<-getdf(range)
ptdf<-rbind(tdf1,tdf2,tdf3,tdf4)
#save(ptdf,file = paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/huening/ptdf_btt01.RData"))
}

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
############################################################
### get gpt keywords: gpt preferred words vs. human language
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
load(paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/huening/btt.summaries.RData"))

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
# ?unnest_tokens
  stops<-stopwords("de")
stops.m<-c("dass","a","ab")
stops.j<-c(stops,stops.m)
m<-tokens$word%in%stops.j
tokens.r<-tokens[!m,]
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
fh<-freq.list(tokens.r$word[tokens.r$target=="human"])
fg<-freq.list(tokens.r$word[tokens.r$target=="gpt"])
fa<-freq.list(tokens.r$word)
fj<-join.freqs(fg,fa)
fs<-fj%>%mutate(p=fg/fa)
### wks., joined frequencies of target=gpt+target=all, score for gpt
head(fs,10)
library(clipr)
write_clip(head(fs,10))
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
library(udpipe)
model<-udpipe::udpipe_load_model(paste(Sys.getenv("HKW_TOP"),"data/german-gsd-ud-2.5-191206.udpipe",sep = "/"))
##################################
## test
# df.ann<-as.data.frame(udpipe::udpipe_annotate(model,df_combined$text,doc_id = df_combined$id,target=df_combined$target))
# df.sub<-df_combined[1,]
# df.ann<-udpipe::udpipe_annotate(model,df.sub$text,doc_id = df.sub$id,target=df.sub$target,parser = "none")
# df.ann<-udpipe::udpipe_annotate(model,df_combined$text,doc_id = df_combined$id,target=df_combined$target,parser = "none",trace = T)
# tu<-unique(tokens.2$word)

df.ann<-udpipe::udpipe_annotate(model,fj$WORD,trace = T,parser = "none")

dfa.pos<-as.data.frame(df.ann)
#save(dfa.pos,file = paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/huening/btt-dfa.pos.RData"))

#?udpipe_annotate






