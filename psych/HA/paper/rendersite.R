library(rmarkdown)
render_site(paste0(Sys.getenv("GIT_TOP"),"/open-lx/content/LX-psych/"))
#render_site(paste0(Sys.getenv("GIT_TOP"),"/open-lx/content/LX-psych/folio"))
render_site(paste0(Sys.getenv("GIT_TOP"),"/open-lx/content/LX-psych/"),output_format = "bookdown::markdown_document2")
