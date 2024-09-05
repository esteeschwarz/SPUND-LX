# 20240902(09.31)
# 14363.HA.discourse
# discourse analysis corpus building
####################################
library(RSelenium)
library(rvest)
library(httr)
library(xml2)
library(netstat)
library(wdman)
library(binman)
library(utils)
library(stringi)
site.base<-"https://zeit.de"
site.art<-"https://www.zeit.de/politik/deutschland/2024-09/wahlverhalten-landtagswahlen-sachen-thueringen-alter-beteiligung"
voyant.getzip<-"https://raw.githubusercontent/esteeschwarz/main/SPUND-LX/DA/14363-HA/zeit-comments.zip"
rd<-rsDriver(browser = "firefox",port = free_port())
remdr<-rd$client

#remdr$navigate(site.art)
run<-2


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
  for (k in 1:30){
     remdr$executeScript("window.scrollTo(0,document.body.scrollHeight);")
     Sys.sleep(5)
    
  }
    # gets 24 comments
  # try with manual scroll > 88
  # with loop max 195, correct
# >


art.htm<-remdr$getPageSource()
save(art.htm,file = paste0("article-",run,".htm.Rdata"))
#load("article-2.htm.Rdata")
htm.raw<-unlist(art.htm)
#writeLines(htm.raw,paste0("htm-",run,".raw.html"))
#htm.in<-read_html("htm.raw.html")
#write_html(htm.in,"htm.test.html")
art.htm.x<-read_html(art.htm[[1]])
all.div<-xml_find_all(art.htm.x,"//div")
div.att<-xml_attrs(all.div)
m<-grep("comment__body comment__user-input",div.att)
# m<-grep("comments_thread",div.att)
text<-xml_text(all.div[m])
text
text.m<-paste0('{"textID:"',1:length(text),'} ',text)
head(text.m)
# grep title
ttl<-xml_find_first(art.htm.x,"//title") 
ttl.tx<-xml_text(ttl)
ttl.json<-stri_extract_all_regex(htm.raw,'content: \\{"id":.*\\}')
ttl.json
text.3<-c(ttl.json[[1]],text.m)
#writeLines(text.3,paste0("data/comments.r-",1,".txt"))
writeLines(text.3,paste0("data/comments.r-",run,".txt"))

f<-list.files("data")
m.tx<-grep(".txt",f)
zip("zeit-comments.zip",paste("data",f[m.tx],sep="/"))
#zip("zeit-comments.zip",f[m.tx])
 html.2<-(all.div[m])
 #html
 html.3<-xml_new_document("html")
 #html.3$doc<-html.2
 html.4<-xml_new_root("html")
 lc<-length(html.2)
 for (k in 1:lc){
   xml_add_child(html.4,"node")
 }
   html.4["node"][[1]]
   comment<-1
 for (comment in 1:3){
   # xml_add_child(html.4,"comment",xml_find_all(html.2[[comment]],"//p"))
   #xml_add_child(html.4,"node",html.2[comment][[1]])
   xml_replace(html.4[[1]],html.2[comment][[1]])
   xml_text(html.2[comment][[1]])
   html.2[comment][[1]]
#   print(xml_text(xml_find_all(comment,"//p")))
 }
 xml_text(html.4)
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
