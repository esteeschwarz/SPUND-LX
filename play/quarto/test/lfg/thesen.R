q<-"https://storage.googleapis.com/sefaria-export/txt/Tanakh/Torah/Genesis/Hebrew/merged.txt"

library(httr)
r<-GET(q)
t<-content(r,"text")
head(t,5)
length(t)
tt<-strsplit(t,"\n")
tt<-unlist(tt)
length(tt)
head(tt,20)
tk1<-strsplit(tt,"[ .:]")
tk1<-unlist(tk1)
# ts<-gsub("\u05BE", " ",tt)  # maqaf
# ts<-gsub("[\u0591-\u05BD\u05BF\u05C1-\u05C2\u05C4-\u05C5\u05C7]", "", ts)
# ts<-gsub("[^\u05D0-\u05EA\s]", " ", tt)
ts<-gsub("\\p{Mn}","",tt,perl=T)
q1<-"נאמר"
# tk<-strsplit(ts,"[ .:]")
# tk<-unlist(tk)
# length(tk)
# q1<-"נמצא"
# length(m<-grep(q1,tk))
# head(ts,100)
# ut<-"ֹ"

txt <- "שָׁלוֹם עוֹלָם"
#ts<-  gsub("\\p{Mn}", "", tt, perl = TRUE)

tk<-strsplit(ts,"[ .:]")
tk<-unlist(tk)
length(tk)
head(tk,20)
q1<-"^נ[מאר]"
length(m<-grep(q1,tk))
tk[m]
tkt<-table(tt)
tkt<-tkt[order(tkt,decreasing=T)]
head(tkt,10)
tks<-tkt[order(names(tkt))]
head(tks,10)
m<-grepl("[a-z0-9]",names(tks))
length(tks)
sum(m)
tka<-tks[!m]
length(tka)
head(tka,10)
setwd("~/Documents/GitHub/SPUND-LX/play/quarto/test/lfg")
getwd()
write.csv(tka,"genesis-t.csv")

##############################
tkt<-table(tk1)
tkt<-tkt[order(tkt,decreasing=T)]
head(tkt,10)
tks<-tkt[order(names(tkt))]
head(tks,10)
m<-grepl("[a-z0-9]",names(tks))
length(tks)
sum(m)
tka<-tks[!m]
length(tka)
head(tka,10)
head(ts1,10)
ts1<-gsub("\\p{Mn}","",names(tka),perl=T)
ts1<-data.frame(tk=names(tka),tok_clean=ts1,f=tka)
write.csv(ts1,"genesis-t.csv")
# 9403, nmza, gefunden werden
m<-grep("נִמְ",tt)
length(m)
tt[m]
ex1<-tt[m[4:6]]
ex1
#Gen 44.16-17
#"gefunden werden"
t17<-"הָאִ֡ישׁ אֲשֶׁר֩ נִמְצָ֨א הַגָּבִ֜יעַ בְּיָד֗ו"
t17.t<-"der mann in dessen hand der kelch gefunden wurde"