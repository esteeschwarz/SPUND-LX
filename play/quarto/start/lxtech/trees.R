
## ----m2forest
mermaid_chain_to_forest <- function(txt) {
  txt<-gsub("'","$'$",txt)
  txt<-gsub("([0-9]{1,2})","$_\\1$",txt)
  txt <- gsub("\\r", "", txt)
  lines <- trimws(unlist(strsplit(txt, "\n")))
  lines <- lines[nzchar(lines)]

  parse_chain <- function(line) {
    parts <- trimws(unlist(strsplit(line, "-->", fixed = TRUE)))
    parts[nzchar(parts)]
  }

  chains <- lapply(lines, parse_chain)

  edges <- do.call(rbind, lapply(chains, function(x) {
    if (length(x) < 2) return(NULL)
    cbind(parent = x[-length(x)], child = x[-1])
  }))

  edges <- as.data.frame(edges, stringsAsFactors = FALSE)
  names(edges) <- c("parent", "child")

  roots <- setdiff(unique(edges$parent), unique(edges$child))
  children_map <- split(edges$child, edges$parent)

  build_tree <- function(node) {
    kids <- children_map[[node]]
    if (is.null(kids) || length(kids) == 0) {
      return(paste0("[", node, "]"))
    }
    paste0("[", node, " ",
           paste(vapply(kids, build_tree, character(1)), collapse = " "),
           "]")
  }

  paste(vapply(roots, build_tree, character(1)), collapse = " ")
}
f2<-mermaid_chain_to_forest(lines)
# Standalone LaTeX document
tex <- paste0(
'\\documentclass[tikz,border=2pt]{standalone}
\\usepackage{forest}
\\begin{document}
\\begin{forest}
', f2,'
\\end{forest}

\\end{document}
')
# File names
base <- t3
texfile <- paste0(base, ".tex")
pdffile <- paste0(base, ".pdf")
svgfile <- paste0(base, ".svg")

# Write and compile
writeLines(tex, texfile)
tinytex::latexmk(texfile)

# # Convert PDF to SVG for HTML
# if (knitr::is_html_output()) {
# #   system2("pdf2svg", c(pdffile, svgfile))
#   knitr::include_graphics(pdffile)
# } else {
#   knitr::include_graphics(pdffile)
# }

## ----outpdf
if (knitr::is_html_output()) {
  # Read the PDF page size (in inches)
#   info <- pdftools::pdf_info(texfile)
#   width_in  <- info$pages[[1]]$width  / 72   # points -> inches
#   height_in <- info$pages[[1]]$height / 72
  width_in <- pdftools::pdf_pagesize(pdffile)[2] / 72
  height_in <- pdftools::pdf_pagesize(pdffile)[3] / 72
  # Convert to CSS pixels (96 px = 1 inch)
  width_px  <- round(width_in  * 120)
  height_px <- round(height_in * 120)
  outns<-unlist(strsplit(pdffile,"/"))
  #outns
  outns<-outns[length(outns)]
  # Embed at the PDF's natural size
  cat(sprintf(
    '<object data="%s"
             type="application/pdf"
             style="width:%spx; height:%spx; border:none;"></object>',
    outns,width_px, height_px
  ))
} else {
  # Use the PDF directly in PDF output
  knitr::include_graphics(pdffile)
}