# 16491.openlx.newpost
######################
library(yaml)
#############
## setwd() to where index.qmd is
setwd("/Users/guhl/Documents/GitHub/SPUND-LX/lx-public/HA/DCL/pages")
getwd()
################################
src.index<-paste0(getwd(),"/index.qmd")
src.csv<-paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/_data/postmeta.csv")
post.ns.dir<-paste0(Sys.getenv("GIT_TOP"),"/open-lx/_posts")
workflow.ns<-paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/.github/workflows")
head.index.sample.qmd<-read_yaml(paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/public/openlx-template/index.qmd"))
#head.index.project.qmd<-read_yaml(src.index)
head.post.md<-read_yaml(paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/public/openlx-template/2025-11-29-template.md"))
workflow.yml<-read_yaml(paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/public/openlx-template/quarto-render-sample.yml"))
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
q
list.dirs(q) # wks.
q.dir<-paste0(q,"/",postmeta$wd)
q.dir
### wks.
#d1<-list.dirs("../../.."),d1)
quarto.yml$project$`output-dir`<-q.dir
quarto.yml$website$title<-head.index.qmd$site_title
quarto.yml$website$navbar$left[[1]]$href<-paste0("https://esteeschwarz.github.io/open-lx/posts/",head.index.qmd$ids)
quarto.yml$website$navbar$right[[2]]$href<-paste0("https://github.com/esteeschwarz/SPUND-LX/tree/main/",head.index.qmd$project_dir)
## post.md
#head.post.md$site_link<-paste0("[",head.index.qmd$site_link_text,"](../../essais/",head.index.qmd$id,")")
head.post.md$site_link_text<-head.index.qmd$site_link_text
head.post.md$date<-as.character(Sys.Date())
head.post.md$categories<-head.index.qmd$cats_md
head.post.md$tags<-head.index.qmd$tags_md
head.post.md$author<-head.index.qmd$author
head.post.md$title<-head.index.qmd$title
head.post.md$subtitle<-head.index.qmd$subtitle
head.post.md$class<-head.index.qmd$class
head.post.md$task<-head.index.qmd$task
head.post.md$ids<-head.index.qmd$ids
head.post.md$description<-head.index.qmd$description

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
#writeLines(post.md,paste0("cp/",head.post.md$date,"-",head.index.qmd$id,".md"))
writeLines(post.md,paste0(post.ns.dir,"/",head.post.md$date,"-",head.index.qmd$ids,".md"))
## workflow.yml
workflow.yml$`on`$push$paths<-paste0(head.index.qmd$input_dir,"/**")
workflow.yml$jobs$render$steps[2][[1]]
workflow.yml$jobs$render$steps[2][[1]]$run<-paste0("quarto render ",head.index.qmd$input_dir," -P reload:false\nls q")
workflow.yml$name<-paste0("Render quarto (",head.index.qmd$ids,")")
workflow.yml$jobs$deploy$steps[[4]]$run<-gsub("SMI",head.index.qmd$ids,workflow.yml$jobs$deploy$steps[[4]]$run)
write_yaml(workflow.yml,paste0(workflow.ns,"/quarto-",head.index.qmd$ids,".yml"))
write_yaml(workflow.yml,paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/public/openlx-template/cp/quarto-",head.index.qmd$ids,".yml"),handlers=handlers)
write_yaml(quarto.yml,"_quarto.yml",handlers=handlers)
filename <- tempfile()
con <- file("_quarto.yml", "w")
write_yaml(quarto.yml, con,fileEncoding = "UTF-8",handlers=handlers)
close(con)
write_yaml(quarto.yml,paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/public/openlx-template/cp/_quarto.yml"),handlers=handlers)
