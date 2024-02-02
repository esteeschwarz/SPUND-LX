.libPaths(new = "/home/runner/work/SPUND-LX/SPUND-LX/rlibs", include.site = TRUE)
library(rmarkdown)
#library(bookdown)
#library(knitr)


setwd("corpusLX/14015-HA/HA-pages")
render_site()
#render_site(input = "./")