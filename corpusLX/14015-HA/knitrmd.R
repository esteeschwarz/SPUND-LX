#library(rmarkdown)
library(knitr)
#?render_markdown()
#?knit
#?output_format
knit("treadme.Rmd",output="README.md")#,output_format(knitr = knitr_options(opts_chunk = list(dev = 'png')),
                                       #pandoc = pandoc_options(to = "html"),keep_md = T))
