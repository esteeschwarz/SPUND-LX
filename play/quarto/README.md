# 16153.info
in this folder some play along essais with renderings

## content

- [start](#): templating render .qmd to pdf with .tex templates and lua filters, wks. 
   - pdf includes header with logo image and motto, title/subtitle, date etc. custom meta defined in the yaml sections of docs and _quarto.yml, footer box with custom link
   - main issue render IPA/ivrit in both html and pdf correctly, uses fonts which have to be on the system; here installed in the runner for use in git actions. u can use that image (ghcr::quarto-r-tex) for render actions, it includes an R installation and tex for convenient render w/o extra stuff to install...

## documentation, knowledge
- if rendering qmd, the yml sections of docs and quarto.yml are hierarchically governing the render process, so if render a doc, quarto searches in the project and parent folder for a quarto.yml and applies configurations top-down (like in CSS), so parameters in the doc itself have priority before settings in quarto.yml (override these). 
