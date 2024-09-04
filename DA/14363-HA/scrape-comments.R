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

# g.simple<-GET(site.comments)
# r1<-content(g.simple,"text")
# r1.htm<-read_html(r1)
# xp<-'//*[@id="comments"]/div'
# com<-xml_find_all(r1.htm,'//main/section')
### no.
###########
# selenium:
# com.button<-'//*[@id="js-article"]/header/div[4]/a'
# rD <- rsDriver(browser = "firefox") #4567L
# rD <- rsDriver()
# # Latest
# wdman::selenium(retcommand = TRUE, check = FALSE)
# binman::list_versions("chromedriver")
# rsDriver(browser = c("chrome"),
#          chromever = "latest")
# remDr <- rD$client
# remDr$navigate("https://www.zeit.de")
# remDr$initialize
# remDr$navigate(url =   site.comments)
# Sys.sleep(5)
# 
# ###
# rD <- rsDriver(browser =    "firefox")
# remDr <- rD[["client"]]
# remDr$navigate("http://www.google.com/ncr")
# remDr$navigate("http://www.bbc.com")
# remDr$close()
# rD[["server"]]$stop
# comments_button <- remDr$findElement(using = "xpath", com.button)
# comments_button$clickElement()
# 
# library(reticulate)
# use_python("3.12.5")
# install_python("3.12")
# py_version()
# miniconda_update()
# conda_python()
# conda_version()
# python_version("3.12")
# conda_install(envname="selenium",python_version = "3.12",packages = c("bs4","selenium","webdriver-manager"))
# #conda_install()
# conda_list_packages()
# conda_list()
# py_install("bs4")
# writeLines(soup,"ha-comments.temp.html")
# 

###
#install.packages("netstat")
#install.packages("wdman")
# library(RSelenium)
# library(netstat)
# library(wdman)
# library(binman)
# library(xml2)
#selenium()
#sel.object<-selenium(retcommand = T,check = F)
#sel.object
#rD
# rD<-rsDriver(browser = c("chrome"),
#          chromever = "114.0.5735.90",
#          port = free_port())
#rD$server$stop()
#chrome_ver<-"128.0.6613.114 (Offizieller Build) (x86_64) "
#binman::list_versions("chromedriver")
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
#load("article-1.htm.Rdata")
htm.raw<-unlist(art.htm)
writeLines(htm.raw,paste0("htm-",run,".raw.html"))
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
ttl.json
text<-c(ttl.json[[1]],text)
#writeLines(text,paste0("comments.r-",1,".txt"))
writeLines(text,paste0("comments.r-",run,".txt"))

f<-list.files()
m.tx<-grep(".txt",f)
zip("zeit-comments.zip",f[m.tx])
# html.2<-(all.div[m])
# html.3<-xml_new_document("html")
# html.4<-xml_new_root("html")
# #html.4$doc<-html.2
# xml_add_child(html.4,"comments")
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

temp.fun<-function(){
id.window<-remdr$getWindowHandles()
id.window
remdr$switchToFrame(Id=1)
# frame.button<-remdr$findElement("css selector", ".message-button:nth-child(1)")
# frame.button$clickElement()
# remdr$switchToWindow(id.window)
#cookie_frame="https://consent-cdn.zeit.de/index.html?message_id=1138846&consentUUID=undefined&preload_message=true&hasCsp=true&version=v1&consent_origin=https%3A%2F%2Fconsent-cdn.zeit.de%2Fconsent%2Ftcfv2&mms_origin=https%3A%2F%2Fconsent-cdn.zeit.de%2Fmms%2Fv2"
#remdr$navigate(cookie_frame)
art.htm<-remdr$getPageSource()
art.htm.x<-read_html(art.htm[[1]])
#comments = soup.find_all('div', class_='comment__body comment__user-input')
all.div<-xml_find_all(art.htm.x,"//div")
button<-xml_find_all(art.htm.x,"//button")
xml_text(button)
button<-remdr$findElements(using = "tag name","button")
button[[1]]$clickElement()
#id.window<-remdr$getWindowHandles()
id.window
remdr$switchToWindow(id.window)
remdr$switchToFrame(Id=NULL)
remdr$refresh()
# act<-remdr$getActiveElement()
# act
# button$describeElement
# button$findElements
#xml_text(button)
#xml_text(all.div)
#print x
#remdr$open
#remdr$navigate(site.art)
################
# STOP
#rd$server$stop()
################
#com_button <- '//*[@id="js-article"]/header/div[4]/a'
com_button_fire = '/html/body/div[4]/div/main/article/header/div[4]/a'
#art_button_accept<- '/html/body/div/div[2]/div[4]/div[1]/button'
#accept_button <- remdr$findElement(using = "xpath", art_button_accept)
# accept.button.class<-'message-component message-button no-children focusable btn-advisorycolumn green desktop sp_choice_type_11 first-focusable-el'
# accept.button.class.ex<-'sp_choice_type_11'
# remdr$findElement(using="class name",accept.button.class.ex)
# accept.button.find<- paste0('//button[@class="',accept.button.class,'"]')
# accept.button.find<- '//*[@title="Zustimmen und weiter"]'
# accept.button.find<-'//button'
# accept.button.find
# b1<-remdr$findElement(using="xpath",value=accept.button.find)
# b1$buttondown
# b1$clickElement()
com_button<-remdr$findElement(using = "xpath", com_button_fire)
com_button$clickElement()
# cook.button.txt<-"Zustimmen und weiter"
# cook.1<-'/html/body/div/div[2]/div[4]/div[1]/button'
# cook.button<-remdr$findElement(using = "xpath", cook.1)
# remdr$acceptAlert()
# remdr$getCurrentWindowHandle()
# remdr$findElement(using = "class","message-component message-button no-children focusable btn-advisorycolumn green desktop sp_choice_type_11 first-focusable-el")
# get_com_text<-function(){
# #art.htm<-rd$getPageSource
#   button.more<-'//*[@id="comments"]/div/div[2]/button'
#   bm.2<-'#comments > div > div.comments__body > button'
#   button.more<-'//*[@id="comments"]/div/div[2]/button'
#   bm.3<-'//*[@data-ct-ck4="thread_loadmore_click"]'
#   #more.button<-remdr$findElement(using = "xpath", button.more)
#   more.button<-remdr$findElement(using = "xpath", bm.3)
#   more.button<-remdr$findElement(using = "class","comments__body")
#   more.button$clickElement()
  #more.button$click()
  art.htm<-rd$client$getPageSource()
art.htm.x<-read_html(art.htm[[1]])
#comments = soup.find_all('div', class_='comment__body comment__user-input')
all.div<-xml_find_all(art.htm.x,"//div")
#xml_text(all.div)
#com.div<-xml_find_all(all.div,'//*[@data-ct-ck4=""]')
# com.div<-xml_find_all(all.div,'//*[@class="comments__body"]')
# xml_text(com.div)
 div.att<-xml_attrs(all.div)
 m<-grep("comment__body comment__user-input",div.att)
# m<-grep("comments_thread",div.att)
 text<-xml_text(all.div[m])
 writeLines(text,"comments.txt")
#}
### wks.
button.more<-'//*[@id="comments"]/div/div[2]/button'
range<-1:20
com.df<-data.frame(page=range,text=NA)
com.list<-list()
k<-2
for (k in range){
 more.button<-remdr$findElement(using = "xpath", button.more)
 more.button$clickElement()
text<-get_com_text()
com.list$page[[k]]<-text
}


}