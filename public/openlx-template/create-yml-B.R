# 16491.openlx.newpost
######################
library(yaml)
#############
## setwd() to where index.qmd is
setwd("/Users/guhl/Documents/GitHub/SPUND-LX/lx-public/HA/DCL/pages")
getwd()
################################
pub.site<-"DC-LX"
src.index<-paste0(getwd(),"/index.qmd")
src.csv<-paste0(Sys.getenv("GIT_TOP"),"/DC-LX/_data/postmeta.csv")
post.ns.dir<-paste0(Sys.getenv("GIT_TOP"),"/",pub.site,"/_posts")
workflow.ns<-paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/.github/workflows")
head.index.tx<-readLines(src.index)
m<-which(head.index.tx=="---")
idx.tmp<-tempfile(fileext = ".qmd")
writeLines(head.index.tx[m[1]:m[2]],idx.tmp)
#read_yaml(idx.tmp)
#head.index.sample.qmd<-read_yaml(paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/public/openlx-template/index.qmd"))
head.index.project.qmd<-read_yaml(idx.tmp)
head.post.md<-read_yaml(paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/public/openlx-template/2025-11-29-template.md"))
workflow.yml<-read_yaml(paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/public/openlx-template/quarto-pages-docker.yml"))
names(workflow.yml)[2]<-"on"
quarto.yml<-read_yaml(paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/public/openlx-template/_quarto.yml"))
postmeta<-read.csv(src.csv)
chk.meta<-function(src.csv){
  t<-readLines(src.csv)
  c<-strsplit(t,",")
  lc<-lapply(c,length)
  unlist(lc)
  f<-which(unlist(lc)!=lc[[1]])
  f
  print(c[[1]])
  print(c[[9]])

}
chk.meta(src.csv)
# adapt
## quarto.yml
# get q dir

d0<-normalizePath(src.index)
d1<-strsplit(d0,"/")
m<-grep("SPUND-LX",unlist(d1))
p<-length(unlist(d1))-m-1
p # position of project dir relative to working repo (SPUND-LX)
#q<-list.dirs(paste0(rep("..",p),collapse = "/"))
q<-paste0(paste0(rep("..",p),collapse = "/"),"/q")
q2<-paste0(paste0(rep("..",2),collapse = "/"),"/") # fixed for dclx
q1<-paste0(paste0(rep("..",p+1),collapse = "/"),"/") # fixed for dclx
q
q2
q1
parent.posts<-q2
list.dirs(q) # wks.
q.dir<-paste0(q,"/",postmeta$wd)
q.dir
mp<-postmeta$published
mp<-!mp
mp<-which(mp)
sum(mp)
mp

post.dir<-postmeta$post.dir[mp]
post.dir
q.dir<-q.dir[mp]
q.dir
#pub.site<-postmeta$pub.site[mp]
#rm(pub.site)
### wks.
#d1<-list.dirs("../../.."),d1)
quarto.yml$project$`output-dir`<-q.dir
quarto.yml$website$title<-head.index.project.qmd$site_title
dclx.cat<-head.index.project.qmd$categories[1]
page.dir<-strsplit(q.dir,"/q/")
page.dir<-page.dir[[1]][2]
page.dir<-paste0("essais/",page.dir)
page.dir
pub.site
parent.posts
post.dir
post.dir<-ifelse(pub.site=="open-lx","posts",post.dir)
post.dir
site_link<-paste0(parent.posts,page.dir)
site_link
############################
postmeta$link[mp]<-site_link
############################
post.dir
post.ids<-postmeta$name[mp]
post.wd<-postmeta$wd[mp]
paste0(q1,post.dir,"/",post.ids)
#quarto.yml$website$navbar$left[[1]]$href<-paste0(parent.posts,post.dir,"/",post.ids)
quarto.yml$website$navbar$left[[1]]$href<-paste0(q1,post.dir,"/",post.ids)
quarto.yml$website$navbar$right[[2]]$href<-paste0("https://github.com/esteeschwarz/SPUND-LX/tree/main/",post.wd)
## post.md
#head.post.md$site_link<-paste0("[",head.index.qmd$site_link_text,"](../../essais/",head.index.qmd$id,")")
head.post.md$date<-as.character(Sys.Date())
head.post.md$categories<-dclx.cat
head.post.md$tags<-""
head.post.md$author<-head.index.project.qmd$author
head.post.md$title<-head.index.project.qmd$title
head.post.md$teaser<-head.index.project.qmd$subtitle
head.post.md$class<-postmeta$class[mp]
head.post.md$task<-postmeta$subject[mp]
#site_link<-paste0(q,postmeta$name[mp])
head.post.md$site_link_text<-postmeta$site_link_text[mp]
head.post.md$site_link<-site_link
head.post.md$ids<-site_link
head.post.md$description<-postmeta$about[mp]
### TODO: priority override: define .csv < index.qmd or vcvs.

handlers <- list(
  logical = function(x) {
    # Return bare 'true'/'false' without quotes
    val<- ifelse (x, "true","false")
    structure(val, class = "verbatim")   # <- prevents quoting!
    
  }
)

# yaml::write_yaml(
#   x,
#   file = "out.yml",
#   handlers = handlers
# )
#write_yaml(head.post.md,paste0("cp/",head.post.md$date,"-",head.index.qmd$id,".md"))
post.tmp<-tempfile("post.md")
write_yaml(head.post.md,post.tmp,handlers=handlers)
post.tx<-readLines(post.tmp)
library(xfun)
yaml_body(head.post.md)

post.md<-c("---",post.tx,"---")
post.md
quarto.yml
post.dir
post.ns.dir<-paste(post.ns.dir,post.dir,sep = "/")
post.ns.dir
#writeLines(post.md,paste0("cp/",head.post.md$date,"-",head.index.qmd$id,".md"))
writeLines(post.md,paste0(post.ns.dir,"/",head.post.md$date,"-",post.ids,".md"))
## workflow.yml
####################################################################
### careful!
############
input_dir<-post.wd
workflow.yml$on$push$paths<-paste0(input_dir,"/**")
workflow.yml$jobs$render$steps[2][[1]]
#workflow.yml$on$workflow_dispatch<-"~"
# workflow.yml$jobs$render$steps[2][[1]]$run<-paste0("quarto render ",head.index.qmd$input_dir," -P reload:false\nls q")
# workflow.yml$name<-paste0("Render quarto (",head.index.qmd$ids,")")
# workflow.yml$jobs$deploy$steps[[4]]$run<-gsub("SMI",head.index.qmd$ids,workflow.yml$jobs$deploy$steps[[4]]$run)
### B
workflow.yml$jobs$render$steps[2][[1]]$run<-paste0("quarto render ",input_dir," -P reload:false\nls q")
workflow.yml$jobs$render$steps[2][[1]]$run<-paste0("quarto render ",input_dir," -P reload:false")
workflow.yml$jobs$render$steps[2][[1]]
workflow.yml$name<-paste0("Render quarto (",post.ids,")")
workflow.yml$jobs$deploy$steps[[4]]$run<-gsub("rsample",post.ids,workflow.yml$jobs$deploy$steps[[4]]$run)
workflow.yml$jobs$deploy$steps[[4]]$run
workflow.yml$jobs$deploy$steps[[7]]$run<-gsub("rsample",post.ids,workflow.yml$jobs$deploy$steps[[7]]$run)
workflow.yml$jobs$deploy$steps[[7]]$run

con <- file(paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/public/openlx-template/cp/quarto-",post.ids,".yml"), "w")
write_yaml(workflow.yml, paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/public/openlx-template/cp/quarto-",post.ids,".yml"),fileEncoding = "UTF-8",handlers=handlers)

write_yaml(workflow.yml,con,handlers=handlers)
close(con)
write_yaml(workflow.yml,paste0(workflow.ns,"/quarto-",post.ids,".yml"),handler=handlers)
#write_yaml(quarto.yml,"_quarto.yml",handlers=handlers)
filename <- tempfile()
#con <- file("_quarto.yml", "w")
#write_yaml(quarto.yml, con,fileEncoding = "UTF-8",handlers=handlers)
#close(con)
write_yaml(quarto.yml,paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/public/openlx-template/cp/_quarto.yml"),handlers=handlers)
library(readr)
write_csv(postmeta,src.csv,na = "")