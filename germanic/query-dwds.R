# 20251201(13.33)
# 16493.query dwds as reference corpus
######################################
# works only if header user agent set to browser agent!

library(jsonlite)
library(httr)
library(readr)
url<-"https://www.dwds.de/r/?q=alphabetisch&view=json&corpus=dtak"
url<-"https://www.dwds.de/r/?q=alphabetisch&view=csv&corpus=dtak"
url<-"https://www.dwds.de/api/frequency?q=alphabetisch&corpus=dtak" # wks, but no corpus selectable
api<-"https://www.dwds.de/api/frequency?"
api<-"https://www.dwds.de/r/?" #q=alphabetisch&view=json&corpus=dtak" # wks. wt user agent set to browser agent
#q=alphabetisch&corpus=dtak"
################
lemma<-"sneaker"
lemma<-"computer"
lemma<-"alphabet"
################
corpus<-"dtak" # 1500-1903
view<-"json"
view<-"csv"
#corpus<-""
url<-paste0(api,"q=",lemma,"&corpus=",corpus,"&view=",view)
url
r<-GET(url,add_headers(
  `User-Agent` = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
))
t<-content(r,"text")
t
df<-data.frame(Hit="no hits")
writeLines(t,"t.csv")
if(view=="csv"){
  tcsv<-tempfile("t.csv")
  writeLines(t,tcsv)
  df<-read_csv(tcsv)
}
#e<-simpleError("no data")
#?tryCatch
t
if(view=="json"&t!='[{\"meta_\":{}}]')
  df<-fromJSON(t)
#print(df)
cat("--------\nnumber of hits:",length(df$Hit),"\n---------\n")
# t
# writeLines(t,"dwds.q.html")
