library(rmarkdown)
render_site(paste0(Sys.getenv("GIT_TOP"),"/open-lx/content/LX-psych/"))
#render_site(paste0(Sys.getenv("GIT_TOP"),"/open-lx/content/LX-psych/folio"))
render_site(paste0(Sys.getenv("GIT_TOP"),"/open-lx/content/LX-psych/"),output_format = "bookdown::markdown_document2")
render_site(paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/germanic/HA/"))
rmarkdown::render_site("index.Rmd", output_format = "bookdown::markdown_document2")
render_site()
bookdown::render_book("001.Rmd", "bookdown::markdown_document2")

#bookdown::render_book("002.Rmd", "bookdown::markdown_document2")
render_site(paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/germanic/HA/"))
file.copy(paste0(Sys.getenv("GIT_TOP"),"/open-lx/essais/germanic/shibboleth-a.md"),paste0(Sys.getenv("GIT_TOP"),"/open-lx/_posts/2025-11-15-germanic-ha.md"),overwrite = T)

render_site(paste0(Sys.getenv("GIT_TOP"),"/wg-sebald/content/001/"))
file.copy(paste0(Sys.getenv("GIT_TOP"),"/wg-sebald/archive/001/001-a.md"),paste0(Sys.getenv("GIT_TOP"),"/wg-sebald/_posts/2025-11-16-samling.md"),overwrite = T)

render_site(paste0(Sys.getenv("GIT_TOP"),"/open-lx/content/cites/"))
