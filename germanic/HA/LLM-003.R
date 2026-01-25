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
save(btt.summaries,file = paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/huening/btt.summaries.RData"))
# curl<-'curl \
# -X POST \
# -H "Content-Type: application/json" \
# "https://${API_ENDPOINT}/v1/publishers/google/models/${MODEL_ID}:${GENERATE_CONTENT_API}?key=${API_KEY}" -d "@request.json"'
# 
# 





