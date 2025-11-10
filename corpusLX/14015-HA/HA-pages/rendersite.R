library(rmarkdown)
getwd()
# exclude for local render
# .libPaths(new = "/home/runner/work/SPUND-LX/SPUND-LX/rlibs", include.site = TRUE)
# setwd("corpusLX/14015-HA/HA-pages")
# render("_doku.Rmd") # sbc source not available anymore under Q.2

###########

#library(bookdown)
#library(knitr)


#render("HA-notebook/_doku.Rmd")
render_site()
#setwd("corpusLX/14015-HA/HA-pages/HA-notebook")
file.copy("sbc","/Users/guhl/Documents/GitHub/open-lx/content/",overwrite = T,recursive = T)

#render_site(input = "./")