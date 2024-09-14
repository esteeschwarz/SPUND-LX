# 20240902(09.31)
# 14363.HA.discourse
# discourse analysis corpus building
####################################
init<-function(){
library(RSelenium)
library(rvest)
library(httr)
library(xml2)
library(netstat)
library(wdman)
library(binman)
library(utils)
library(stringi)
library(clipr)
library(jsonlite)
  site.base<-"https://zeit.de"
site.art<-"https://www.zeit.de/politik/deutschland/2024-09/wahlverhalten-landtagswahlen-sachen-thueringen-alter-beteiligung"
voyant.getzip<-"https://raw.githubusercontent.com/esteeschwarz/SPUND-LX/main/DA/14363-HA/zeit-comments.zip"
voyant.page<-"https://voyant-tools.org/?corpus=e3d47e51618f70599ac74f2ade304d99" # 3
write_clip(voyant.getzip)
rd<-rsDriver(browser = "firefox",port = free_port())
remdr<-rd$client
#remdr$navigate(site.art)
#remdr$navigate("https://zeit.de")
#remdr$navigate(page)
return(remdr)
}

art.comments<-read.csv("data/comments-links.csv")
page.navi<-art.comments$link[2]

#################
remdr<-init(4,page.navi)
run<-4


# the scrape doesnt work with this site, there is an accept button which cannot
# be handled
### workaround:
# click accept button, click <comments>, scroll down, then get page source
get.page.text<-function(){
# click comments
  com_button_fire.css<-'.article-actions > .z-text-button:nth-child(1)'
  com_button<-remdr$findElement(using = "css selector", com_button_fire.css)
  #com_button_fire.xpath = '/html/body/div[4]/div/main/article/header/div[4]/a'
  #com_button<-remdr$findElement(using = "xpath", com_button_fire.xpath)
  com_button$clickElement()
  
# click <more> button
  #button.more<-'//*[@id="comments"]/div/div[2]/button'
  #   bm.2<-'#comments > div > div.comments__body > button'
  #   button.more<-'//*[@id="comments"]/div/div[2]/button'
     bm.3<-'//*[@data-ct-ck4="thread_loadmore_click"]'
 # more.button<-remdr$findElement(using = "xpath", button.more)
     remdr$executeScript("window.scrollTo(0,document.body.scrollHeight);")
     
     more.button<-remdr$findElement(using = "xpath", bm.3)
  #   more.button<-remdr$findElement(using = "class","comments__body")
     more.button$clickElement()
# scroll to bottom
  for (k in 1:50){
     remdr$executeScript("window.scrollTo(0,document.body.scrollHeight);")
     Sys.sleep(5)
}
          for (k in 1:180){
       remdr$executeScript("window.scrollTo(0,document.body.scrollHeight);")
       Sys.sleep(5)
       
  }
    # gets 24 comments
  # try with manual scroll > 88
  # with loop max 195, correct
# >

#remdr$getSessions()
art.htm<-remdr$getPageSource()
run<-1
#save(art.htm,file = paste0("article-",run,".htm.Rdata"))
load("article-1.htm.Rdata")
#############################
## run with different htm src
create.txt.csv<-function(){
htm.raw<-unlist(art.htm)
#writeLines(htm.raw,paste0("~/boxhkw/21s/dh/local/spund/da/14363-ha/htm-",run,".raw.html"))
#htm.in<-read_html("htm.raw.html")
#write_html(htm.in,"htm.test.html")
art.htm.x<-read_html(art.htm[[1]])
all.div<-xml_find_all(art.htm.x,"//div")
div.att<-xml_attrs(all.div)
m<-grep("comment__body comment__user-input",div.att)
# m<-grep("comments_thread",div.att)
text<-xml_text(all.div[m])
# grep title
ttl<-xml_find_first(art.htm.x,"//title") 
ttl.tx<-xml_text(ttl)
ttl.json<-stri_extract_all_regex(htm.raw,'content: \\{"id":.*\\}')
ttl.json<-gsub("content:","",ttl.json)
#write_clip(ttl.json)
ttl.df<-fromJSON(ttl.json[[1]])
ttl.json
ttl.date<-ttl.df$publishing_date
date()
ttl.date
strptime(ttl.date,format = "")
#Sys.time()
#format(ttl.date, "%a %b %e %H:%M:%S %Y")
# grep comments meta
x<-all.div[m[4]]
get.comment.meta<-function(x){
  c0<-xml_parent(x)
  c1<-xml_text(xml_child(c0,1))
  c2<-strsplit(c1,"\n")[[1]][1]
  c2
  c3<-gsub(" Beitrag melden","",c2)
  c3
  #c3<-gsub("  ")
  # get widest whitespace
  c3.w<-strsplit(c3," ")[[1]]
  c3.w
  c3.mid<-which(c3.w%in%"")
  c3.mid<-c3.mid[c3.mid!=1]
  c3.mid.m<-max(c3.mid)
  c3.mid.p<-c3.mid.m+1
  c3.u<-paste0(c3.w[1],"//",paste0(c3.w[2:c3.mid[1]],collapse = " ")) 
  c3.u
  c3.d.s<-length(c3.w)-5
  c3.d.s<-c3.mid.p
  c3.d<-paste0(c3.w[c3.d.s:length(c3.w)],collapse =  " ")
  c3.d
  c4<-strsplit(c3," ")
  c4
 # names(c4[[1]])[[1]]<-"user"
  #names(c4[[1]])[[2]]<-"date"
  c5<-data.frame(t(unlist(c4)))
  m.n<-c5[1,]!=""
#  c5[,3]
 # cat(unlist(c5))
  m.n
  c5<-c5[,m.n]
  c5<-data.frame(user=c3.u,date=c3.d)
  c5
  # colnames(c5)<-c("user","date")
#  data.frame(t(c4))
  return(c5)
}
#c4
#c6<-data.frame(unlist(c5))
comments.meta.user<-lapply(all.div[m], get.comment.meta)
#head(comments.meta)
c6<-data.frame(t(matrix(unlist(comments.meta.user),nrow  = 2)))
#c6<-data.frame(matrix(unlist(comments.meta.user),nrow  = 2))
colnames(c6)<-c("user","date")
#comments.meta<-c6
#comments.meta.2<-array()
#text
text.m<-paste0('{"textID": ',1:length(text),',"commentMeta": "["user": "',c6$user,'","date": "',c6$date,'"} ',text)
head(text.m)

# # grep title
# ttl<-xml_find_first(art.htm.x,"//title") 
# ttl.tx<-xml_text(ttl)
# ttl.json<-stri_extract_all_regex(htm.raw,'content: \\{"id":.*\\}')
# ttl.json<-gsub("content:","",ttl.json)
# #write_clip(ttl.json)
# ttl.df<-fromJSON(ttl.json[[1]])
# ttl.json
text.3<-c(ttl.json[[1]],text.m)
#writeLines(text.3,paste0("data/comments.r-",1,".txt"))
writeLines(text.3,paste0("data/comments.r-",run,".txt"))
###
# try as table
text.4<-c(ttl.json[[1]],text)
lt<-length(text.4)
lt<-lt-1
text.id<-0:lt
comments.meta.p<-rbind(c('"creator": "esteeschwarz"',paste0('"date of creation": "',Sys.time(),'"')),c6)
text.df<-data.frame(article.id=run,text.id,date=comments.meta.p$date,user=comments.meta.p$user,comment=text.4)
write.csv(text.df,paste0("data/comments.df-",run,".csv"))
} # end create /write txt/csv
###
run<-4
load(paste0("article-",run,".htm.Rdata"))

create.txt.csv()
f<-list.files("data")
m.tx<-grep(".txt|.csv",f)
zip("zeit-comments.zip",paste("data",f[m.tx],sep="/"))
#zip("zeit-comments.zip",f[m.tx])
 html.2<-(all.div[m])
 #html
 html.3<-xml_new_document("html")
 #html.3$doc<-html.2
 html.4<-xml_new_root("html")
 lc<-length(html.2)
 for (k in 1:lc){
   xml_add_child(html.4,"comment")
 }
 html.4[2][1][1]
 #html.4
all.c<- xml_find_all(html.4,"//comment")
for (k in 1:length(all.c)){ 
xml_replace(all.c[k],html.2[k][[1]])
}
k
html.2[k][[1]]
k<-2
 write_xml(html.4,"data/comments.htm-3.xml")
   html.4[1][[1]]<-html.2[1][[1]]
   comment<-1
 for (comment in 1:3){
   # xml_add_child(html.4,"comment",xml_find_all(html.2[[comment]],"//p"))
   #xml_add_child(html.4,"node",html.2[comment][[1]])
   xml_replace(html.4[[1]],html.2[comment][[1]])
   xml_text(html.2[comment][[1]])
   html.2[comment][[1]]
#   print(xml_text(xml_find_all(comment,"//p")))
 }
# xml_text(html.4)
 # #html.4$doc<-html.2
 xml_add_child(html.4,"comments")
 xml_replace(html.4[[1]],html.3)
 # com<-xml_find_all(html.4,"//comments")
# 
# xml_replace(com,all.div[m])
# xml_add_child(html.3,"comments")
# 
# #html.2$doc<-html
# #write_xml(html.4,"comments.r.html")
# htm_paste<-paste0(unlist(html.2),collapse = "")
#writeLines(htm_paste,"comments.r.html")
}
run<-readline(prompt = "ready? now process pagesource? (y/n)")
if (run=="y")
  get.page.text()

### get comment meta
#all.div<-xml_find_all(art.htm.x,"//div")
div.att<-xml_attrs(all.div)
m<-grep("comment__body comment__user-input",div.att)
comment.parent<-xml_parent(  all.div[m])
comment.meta<-xml_text(xml_child(comment.parent,1))
meta.split<-strsplit(comment.meta,"\n")
x<-comment.parent
# get.comment.meta<-function(x){
#   c0<-xml_parent(x)
#   c1<-xml_text(xml_child(c0,1))
#   c2<-strsplit(c1,"\n")[[1]][1]
#   c3<-gsub(" Beitrag melden","",c2)
#   c4<-strsplit(c3,"  ")
#   names(c4[[1]])<-c("user","date")
#   return(c4)
# }
# c4
# c3
# comments.meta<-lapply(all.div[m], get.comment.meta)
comments.meta[[3]]

### get epub
#remdr<-init(4,page.navi)

#remdr$navigate(page.navi)
id1<-"year"
xp1<-"//option[. = '2016']"
css1<-"#year > option:nth-child(4)"
id2<-"issue"
xp2<-"//option[. = '02']"
css2<-"#issue > option:nth-child(3)"
  css3<-".btn-default-when-collapsed"
css4<-".col-sm-1-5:nth-child(1) img"
css5<-".btn-link"
LINK_TEXT_1<- "EPUB FÜR E-READER LADEN"
# 'arg' should be one of “xpath”, “css selector”, 
# “id”, “name”, “tag name”, “class name”, “link text”, “partial link text”
art.comments<-read.csv("data/comments-links.csv")
page.navi<-art.comments$link[2]
remdr<-init()
remdr$navigate(page.navi)

for (k in 34:53){
css2<-paste0("#issue > option:nth-child(",k,")")
com_button<-remdr$findElement(using = "id",id1)
com_button$clickElement()
Sys.sleep(5)
dropdown<-remdr$findElement(using = "id",id1)
#dropdown
com_button<-dropdown$findElement(using = "xpath", xp1)
com_button$clickElement()
Sys.sleep(5)
com_button<-remdr$findElement(using = "css selector", css1)
com_button$clickElement()
dropdown<-remdr$findElement(using = "id", id2)
#com_button<-dropdown$findElement
com_button<-dropdown$findElement(using = "xpath", xp2)
com_button$clickElement()
Sys.sleep(5)
com_button<-remdr$findElement(using = "css selector", css2)
com_button$clickElement()
Sys.sleep(5)
com_button<-remdr$findElement(using = "css selector", css3)
com_button$clickElement()
Sys.sleep(5)
com_button<-remdr$findElement(using = "css selector", css4)
com_button$clickElement()
Sys.sleep(5)
com_button<-remdr$findElement(using = "link text", LINK_TEXT_1)
com_button$clickElement()
Sys.sleep(8)
# get back
com_button<-remdr$findElement(using = "css selector",".btn-link")
#com_button$getElementAttribute("data-wt-click")
#com_button$isElementEnabled()
com_button$clickElement() #!!!
Sys.sleep(5)
#com_button$click()
#com_button<-remdr$findElement(using = "xpath","/html/body/div[2]/div[2]/section/nav/ul/li/a")
#com_button$click()
print(k)
}

id1<-"year"
xp1<-"//option[. = '2014']"
css1<-"#year > option:nth-child(4)"
id2<-"issue"
xp2<-"//option[. = '02']"
css2<-#issue > option:nth-child(3)"
css3<-".btn-default-when-collapsed"
css4<-".col-sm-1-5:nth-child(1) img"
LINK_TEXT_1<- "EPUB FÜR E-READER LADEN"
