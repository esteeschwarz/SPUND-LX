.libPaths(new = "/home/runner/work/SPUND-LX/SPUND-LX/rlibs", include.site = TRUE)
library(rmarkdown)
#library(bookdown)
#library(knitr)


#setwd("corpusLX/14015-HA/HA-pages")
#render("corpusLX/14015-HA/HA-pages/_doku.Rmd")
#render("HA-notebook/_doku.Rmd")
render_site("corpusLX/14015-HA/HA-pages")
file.copy("corpusLX/14015-HA/HA-pages/_site.doku.yml","corpusLX/14015-HA/HA-pages/_site/_site.yml",overwrite = T)
render("corpusLX/14015-HA/HA-pages/_site/_doku.Rmd")
#setwd("corpusLX/14015-HA/HA-pages/HA-notebook")
sitedir<-paste0("corpusLX/14015-HA/HA-pages/","_site/")
#mdyaml<-yaml_front_matter(paste0(sitedir,"_site.yml"))
rmd<-list.files(sitedir)
m<-grep("\\.Rmd",rmd)
rmd.f<-paste0(sitedir,rmd)[m]

notermd<-readLines(rmd.f)
notermd
#file.copy("corpusLX/14015-HA/HA-pages/_doku.Rmd","corpusLX/14015-HA/HA-pages/_site/_doku.Rmd",overwrite = T)
notermd<-gsub("#replacemask#","#replacemask1#",notermd)
writeLines(notermd,rmd.f)



#render_site(input = "./")