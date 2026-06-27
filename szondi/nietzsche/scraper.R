library(httr)
library(xml2)
Q1<-"http://www.nietzschesource.org/#eKGWB/Za-I"
q0<-"http://www.nietzschesource.org/#eKGWB"
q1<-"Za-I"
q01<-paste(q0,q1,sep="/")
q01

g1<-GET(q01)
t1<-content(g1,"text")
t1
ht<-tempfile("x.html")
writeLines(t1,ht)
h1<-read_html(ht)
h1
xml2::xml_ns_strip(h1)

xp<-'//*[@id="mainInner"]/h4'
sel<-"#visore > div:nth-child(4)"
xp<-'//*[@id="content"]'
cl<-'//[@class="txt_block"]'
c<-xml_find_all(h1,"//body")
d<-xml_find_all(c,"//div")
c
body<-read_html(c)[[1]]
xml_text(d)
?xml_find_all
