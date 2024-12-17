# 20241216(08.28)
# 15513.szondi.prosepoem.rheiner
################################
Q<-"https://www.projekt-gutenberg.org/rheiner/kokain/chap001.html"
f.list<-array()
for(k in 1:9){
f.list[k]<-gsub("1",k,Q)
}
for(k in 10:40){
  f.list[k]<-gsub("01",k,Q)
}
f.list
library(httr)
library(xml2)
k<-1
rhdf<-data.frame(id=1:length(f.list))
rhtm<-list()
for (k in 1:length(f.list)){
x<-GET(f.list[k])
r<-content(x,"text")

htm<-read_html(r)
all.p<-xml_find_all(htm,"//p")
all.p
rhdf$content[k]<-r
rhtm[[k]]<-all.p
}
rhdf$content[1]
unlist(rhtm[9])
library(abind)
rhtm2<-unlist(lapply(rhtm,function(x)xml_text(x)))
head(rhtm2,30)
dim(rhtm2)
m<-grepl("(gutenberg|Gutenberg)|(email|Email|Das gesuchte Buch fehlt)",rhtm2)
rhtm3<-rhtm2[!m]
m<-rhtm3==""
sum(m)
rhtm3<-rhtm3[!m]
m<-rhtm3==" "
sum(m)
rhtm3<-rhtm3[!m]
m<-grepl(rhtm3[length(rhtm3)],rhtm3)
sum(m)
rhtm4<-rhtm3[!m]
head(rhtm4,250)
x<-GET("https://www.projekt-gutenberg.org/rheiner/kokain/titlepage.html")
r<-content(x,"text")
htm<-read_html(r)
p.ttl<-xml_find_all(htm,"//p")
p.ttl<-xml_text(p.ttl)
p.ttl[1]<-"Walter Rheiner"
p.ttl[2]<-"KOKAIN"
p.ttl[10]<-"Baudelaire: La Mort des Pauvres"
rhtm5<-c(p.ttl,rhtm4)
head(rhtm5,30)
writeLines(rhtm5,"~/boxHKW/21S/DH/local/AVL/2024/rheiner-kokain.txt")
