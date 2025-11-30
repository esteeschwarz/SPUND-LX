# 16491.openlx.newpost
######################
library(yaml)
post.ns.dir<-paste0(Sys.getenv("GIT_TOP"),"/open-lx/_posts")
workflow.ns<-paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/.github/workflows")
head.index.qmd<-read_yaml("index.qmd")
head.post.md<-read_yaml(paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/public/openlx-template/2025-11-29-template.md"))
workflow.yml<-read_yaml(paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/public/openlx-template/quarto-smi.yml"))
quarto.yml<-read_yaml(paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/public/openlx-template/_quarto.yml"))
# adapt
## quarto.yml
quarto.yml$project$`output-dir`<-head.index.qmd$
quarto.yml$website$title<-head.index.qmd$site_title
quarto.yml$website$navbar$left[[1]]$href<-paste0("https://esteeschwarz.github.io/open-lx/posts/",head.index.qmd$id)
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
head.post.md$id<-head.index.qmd$id
head.post.md$description<-head.index.qmd$description


#write_yaml(head.post.md,paste0("cp/",head.post.md$date,"-",head.index.qmd$id,".md"))
post.tmp<-tempfile("post.md")
write_yaml(head.post.md,post.tmp)
post.tx<-readLines(post.tmp)
library(xfun)
yaml_body(head.post.md)

post.md<-c("---",post.tx,"---")
post.md
#writeLines(post.md,paste0("cp/",head.post.md$date,"-",head.index.qmd$id,".md"))
writeLines(post.md,paste0(post.ns.dir,"/",head.post.md$date,"-",head.index.qmd$id,".md"))
## workflow.yml
workflow.yml$`TRUE`$push$paths<-paste0(head.index.qmd$input_dir,"/**")
workflow.yml$jobs$render$steps[2][[1]]
workflow.yml$jobs$render$steps[2][[1]]$run<-paste0("quarto render ",head.index.qmd$input_dir," -P reload:false\nls q")
workflow.yml$name<-paste0("Render quarto (",head.index.qmd$id,")")
workflow.yml$jobs$deploy$steps[[4]]$run<-gsub("SMI",head.index.qmd$id,workflow.yml$jobs$deploy$steps[[4]]$run)
write_yaml(workflow.yml,paste0(workflow.ns,"/quarto-",head.index.qmd$id,".yml"))

           