# 16491.openlx.newpost
######################
library(yaml)
#############
## setwd() to where index.qmd is
# setwd("/Users/guhl/Documents/GitHub/SPUND-LX/lx-public/HA/DCL/pages")

getwd()
################################
src.csv<-paste0(Sys.getenv("GIT_TOP"),"/DC-LX/_data/postmeta.csv")
postmeta<-read.csv(src.csv)
mp<-postmeta$published
mp<-!mp
mp<-which(mp)
sum(mp)
wd<-postmeta$wd[mp]
wd<-paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/",wd)
setwd(wd)
pub.site<-"DC-LX"
f<-list.files(wd)
ifelse(sum(grepl("index.qmd",f)),src.index<-paste0(getwd(),"/index.qmd"),src.index<-paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/public/openlx-template/index.qmd"))
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

d0<-normalizePath(wd)
dq<-postmeta$level_to_q[mp]
d1<-strsplit(d0,"/")
m<-grep("SPUND-LX",unlist(d1))
p<-length(unlist(d1))-m-1
p<-ifelse(p==dq,p,dq)

p # position of project dir relative to working repo (SPUND-LX)
#q<-list.dirs(paste0(rep("..",p),collapse = "/"))
q<-paste0(paste0(rep("..",p),collapse = "/"),"/q")
q2<-paste0(paste0(rep("..",dq-2),collapse = "/"),"/") # fixed for dclx
q1<-paste0(paste0(rep("..",p+1),collapse = "/"),"/") # fixed for dclx
q0<-paste0(paste0(rep("..",p-1),collapse = "/"),"/")
q1
parent.posts<-q2
parent.posts
list.dirs(q) # wks.
q.dir<-paste0(q,"/",postmeta$wd[mp])
q.dir
mp

post.dir<-postmeta$post.dir[mp]
post.dir
#q.dir<-q.dir[mp]
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
slt<-postmeta$link[mp]!=""
site_link<-ifelse(slt,postmeta$link[mp],paste0(parent.posts,page.dir))
site_link
############################
if(!slt)
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
head.post.md$date<-head.index.project.qmd$date
head.post.md$categories<-dclx.cat
tags<-head.index.project.qmd$tags
tags<-paste0("[",paste0(tags,collapse = ","),"]")
head.post.md$tags<-tags
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
head.post.md
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
post.yml<-read_yaml(post.tmp)
#post.yml<-yaml_body(head.post.md)
#post.yml$body$tags<- structure(post.yml$tags, class = "verbatim")
post.yml
#attr(post.yml$body$tags,"quoted") <- F
str(post.yml$body$tags)
library(xfun)
yaml_body(head.post.md)
yaml_body(post.yml)
post.tx
post.md<-c("---",post.tx,"---")
post.md<-c("---",unlist(post.yml),"---")
# Convert to YAML string
verbatim_handler <- function(x, ...) {
  # Return the string as a raw scalar (no quotes, no escaping)
  yaml::as.yaml.scalar(x, style = "verbatim")
}
#?yaml::as.yaml()
#head
head.post.md
yaml_str <- as.yaml(
  post.yml$body,
  handlers = list(
    verbatim = verbatim_handler
  )
)
# force quotes around a string
port_def <- '["drei","vier"]'
#attr(port_def, "quoted") <- T
x <- list(ports = list(port_def))
cat(as.yaml(x))
post.yml<-head.post.md
#attr(post.yml$body$tags,"quoted")<-T
yaml_str<-as.yaml(post.yml)
yaml_str
#as.yaml(post.yml$body$tags,unicode = )
as.yaml('---\ncat: schwarz\ntags: ["multi","line","string"]\n---')
#read_yaml("[multi\nline\nstring")
#x <- "tag: [thing,ter]"
#attr(x, "tag") <- "!thing"
#attr(x,"quoted") <- F
#as.yaml(x)
# Wrap with frontmatter delimiters
post.yml.md <- paste0(
  "---\n",
  yaml_str,
  "---\n"
)
post.yml.md
post.md
post.yml
quarto.yml
post.dir
post.ns.dir<-paste(post.ns.dir,post.dir,sep = "/")
post.ns.dir
#writeLines(post.md,paste0("cp/",head.post.md$date,"-",head.index.qmd$id,".md"))
#writeLines(post.md,paste0(post.ns.dir,"/",head.post.md$date,"-",post.ids,".md"))
handlers <- list(
  logical = function(x) {
    # Return bare 'true'/'false' without quotes
    val<- ifelse (x, "true","false")
    structure(val, class = "verbatim")
  }
)

write_yaml(post.yml.md,paste0(post.ns.dir,"/",head.post.md$date,"-",post.ids,".md"),handlers=handlers)
writeLines(post.yml.md,post.tmp)
post.tx<-readLines(post.tmp)
m<-grep("tags:",post.tx)
post.tx[m]<-gsub("[']","",post.tx[m])
writeLines(post.tx,paste0(post.ns.dir,"/",head.post.md$date,"-",post.ids,".md"))
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