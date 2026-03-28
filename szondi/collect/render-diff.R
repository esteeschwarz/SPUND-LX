
library(diffr)
t1<-"https://raw.githubusercontent.com/esteeschwarz/SPUND-LX/1b6bfd5c47cb263080844ea82ffafe91f83aa46a/szondi/collect/m_f.txt"
t2<-"https://raw.githubusercontent.com/esteeschwarz/SPUND-LX/5db0e3015f05a0acc62437d1f04f875681494a60/szondi/collect/m_f.txt"
tt1<-readLines(t1)
tt2<-readLines(t2)
pt1<-tempfile("m.txt")
pt2<-tempfile("f.txt")
writeLines(tt1,pt1)
writeLines(tt2,pt2)
t2m<-unlist(strsplit(tt1,";"))
t2f<-unlist(strsplit(tt2,";"))
t2m<-t2m[order(t2m)]
t2f<-t2f[order(t2f)]
t2m<-gsub("^[^a-zA-Z]{1,5}","",t2m)
t2f<-gsub("^[^a-zA-Z]{1,5}","",t2f)
t2m<-t2m[order(t2m)]
t2f<-t2f[order(t2f)]
q<-c(M1974="https://www.dwds.de/wb/wdg/Mann",F1967="https://www.dwds.de/wb/wdg/Frau")
t2m<-c(q[1],1974,t2m)
t2f<-c(q[2],1967,t2f)
writeLines(t2m,"m.ordered.txt")
writeLines(t2f,"f.ordered.txt")

source(paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/germanic/HA/pos-py.R"))
tdf<-data.frame(sex=c("m","f"),text=c(paste(tt1,collapse = "\n"),paste(tt2,collapse = "\n")))
tpos.m<-get.pos(tdf[1,])
tpos.f<-get.pos(tdf[2,])
adj.f<-tpos.f$lemma[grepl("ADJA",tpos.f$xpos)]
adj.m<-tpos.m$lemma[grepl("ADJA",tpos.m$xpos)]
adj.f<-unique(adj.f)
adj.m<-unique(adj.m)
ac<-list(adj.f,adj.m)
al<-1:length(ac)
g<-which.max(c(length(ac[[1]]),length(ac[[2]])))
m<-adj.f%in%adj.m
wg<-al%in%g
m<-ac[[which(wg)]]%in%ac[[which(!wg)]]
ac[[which(wg)]][m]
ac[[which(wg)]][!m]
g<-which.min(c(length(ac[[1]]),length(ac[[2]])))
m<-adj.f%in%adj.m
wg<-al%in%g
m<-ac[[which(wg)]]%in%ac[[which(!wg)]]
ac[[which(wg)]][m]
ac[[which(wg)]][!m]
library(igraph)
g1 <- graph_from_literal(
  A - B:C:I, B - A:C:D, 
  C - A:B:E:H, 
  D - B:E:F,
  E - C:D:F:H, 
  F - D:E:G, 
  G - F:H, 
  H - C:E:G:I,
  I - A:H
)
r <- make_(ring(10))
l <- make_(lattice(c(3, 3, 3)))

r2 <- make_(ring(10), with_vertex_(color = "red", name = LETTERS[1:10]))
l2 <- make_(lattice(c(3, 3, 3)), with_edge_(weight = 2))
l2<-make_(lattice(c(adj.f,adj.m)), with_edge_(weight = 2))
ran <- sample_(degseq(c(3, 3, 3, 3, 3, 3), method = "configuration"), simplified())
plot(ran)
degree(ran)
is_simple(ran)

plot(l2)
pl<-graph_from_literal(adj.f,adj.m)
plot(pl)
library(igraph)

# Two token vectors (e.g., sentences or documents)
tokens_a <- c("the", "cat", "sat", "on", "the", "mat")
tokens_b <- c("the", "dog", "sat", "on", "the", "floor")
tokens_a<-adj.f
tokens_b<-adj.m
# Build edge list: co-occurring tokens within each vector
make_edges <- function(tokens, doc_id) {
  pairs <- combn(unique(tokens), 2)
  data.frame(
    from   = pairs[1, ],
    to     = pairs[2, ],
    source = doc_id
  )
}

edges <- rbind(
  make_edges(tokens_a, "A"),
  make_edges(tokens_b, "B")
)

# Create graph
g <- graph_from_data_frame(edges, directed = FALSE)

# Node membership: which vector does each token belong to?
# Tokens in both → "both"; otherwise "A" or "B"
in_a <- unique(tokens_a)
in_b <- unique(tokens_b)
all_nodes <- V(g)$name

membership <- ifelse(
  all_nodes %in% in_a & all_nodes %in% in_b, "both",
  ifelse(all_nodes %in% in_a, "A", "B")
)

# Color palette
col_map <- c(A = "#4E79A7", B = "#F28E2B", both = "#59A14F")
V(g)$color <- col_map[membership]

# Edge color by source vector (shared edges get a neutral grey)
E(g)$color <- ifelse(E(g)$source == "A", "#4E79A780",
                     ifelse(E(g)$source == "B", "#F28E2B80", "#99999980"))

# Layout & plot
set.seed(42)
layout <- layout_with_fr(g)

plot(
  g,
  layout        = layout,
  vertex.color  = V(g)$color,
  vertex.label  = V(g)$name,
  vertex.label.color = "white",
  vertex.label.cex   = 0.8,
  vertex.size   = 18,
  edge.color    = E(g)$color,
  edge.width    = 2,
  main          = "Token Network: A (blue) vs B (orange), shared (green)"
)
plot(g,
     layout             = layout,
     vertex.color       = V(g)$color,
     vertex.label       = V(g)$name,
     vertex.label.color = "black",
     vertex.label.cex   = 0.65,        # smaller labels
     vertex.label.dist  = 0.4,         # push label off node centre
     vertex.size        = 3,           # smaller nodes → less occlusion
     vertex.frame.color = NA,
     edge.color         = E(g)$color,  # low-alpha edges recede
     edge.width         = 0.2,         # thin
     edge.curved        = 0.2,  
     rescale =F ,
     xlim               = range(layout[,1]) * 0.7,  # padding around layout bbox
     ylim               = range(layout[,2]) * 1)
#dev.off()
legend(
  "bottomleft",
  legend = c("Vector A", "Vector B", "Shared"),
  fill   = unname(col_map),
  border = NA, bty = "n"
)
layout_sym <- layout_with_sugiyama(g)$layout   # returns x/y matrix

# Optional: rotate 90° so layers flow left→right instead of top→bottom
# (swap columns and flip x to restore reading direction)
layout_lr <- cbind(-layout_sym[, 2], layout_sym[, 1])

# --- Plot ----------------------------------------------------------------
par(bg = "#1e1e2e", mar = c(2, 2, 3, 2))

plot(
  g,
  layout        = layout_lr,
  vertex.color  = V(g)$color,
  vertex.label  = V(g)$name,
  vertex.label.color = "white",
  vertex.label.cex   = V(g)$label.cex,
  vertex.size   = V(g)$size,
  vertex.frame.color = NA,
  edge.color    = E(g)$color,
  edge.width    = E(g)$width,
  main          = "Token co-occurrence — symmetric (Sugiyama) layout"
)
dhtm<-diffr(pt1,pt2)
library(htmlwidgets)
htm<-createWidget("diff",dhtm)
diff.compare<-function(text,xml){
  # library(diffmatchpatch)
  # library(readtext)
  # library(xml2)
  # dfolder<-"~/Documents/GitHub/temp"
  # f<-list.files(dfolder,full.names = T)
  # f
  # #t1<-readtext("www/goue_iwanette_ezd.txt")$text
  # #t1<-readLines(f)
  # #t2<-xml_text(read_xml("www/r-tempxmlout.xml"))
  # #t1<-readtext(f[5])$text
  # #t2<-xml_text(read_xml(f[4]))
  # t1<-readLines(f[5])
  # #t2<-xml_text(read_xml(f[4]))
  # text1<-t1
  # text1<-readLines(text)
  text1<-text
  text1<-gsub("<pb .+/>","",text1)
  
  #?read_xml()
  doc<-read_xml(paste0(xml,collapse = ""))
  # print("compare...")
  # text1<-gsub("^[ ]{1,}","",text1)
  # text1<-text1[text1!=""]
  #text2 <- paste0(rv$t3,collapse = "<nl>")
  #  doc<-read_xml(f[4])
  
  #  doc<-read_xml(xml)
  #doc<-read_xml(rv$xml.t)
  texts <- xml_text(xml_find_all(doc, "//text()"))
  
  text2 <- texts
  print(head(text2))
  tempapi<-tempfile("api.txt")
  writeLines(text1,tempapi)
  t1<-paste0(text1,collapse = "\n")
  t2<-paste0(text2,collapse = "\n")
  l2<-length(unlist(strsplit(t2,"")))
  l1<-length(unlist(strsplit(t1,"")))
  
  dmp_options(diff_timeout=20)
  # chunks, cluster
  
  l.df<-l2
  vector <- 1:l.df
  vec <- 1:l.df
  chunk_size <- 1000  # Example chunk size
  split_into_chunks <- function(vec, chunk_size) {
    split(vec, ceiling(seq_along(vec) / chunk_size))
  }
  chunks <- split_into_chunks(vector, chunk_size)
  lc<-length(chunks)
  l1c<-l1/lc
  chunks.2 <- split_into_chunks(1:l1,l1c )
  #s<-chunks[[1]][1]
  #e<-chunks[[1]][length(chunks[[1]])]
  #t11<-stri_sub(t1,1,1000)
  #t22<-stri_sub(t2,1,1000)
  # ?diff_make()
  p1<-"dreimalschärzer\nkater"
  p2<-"dreymalschwarzer köter"
  p1<-t1
  p2<-t2
  dx<-diff_make(p1,p2)
  dx<-diff_to_html(dx)
  g<-'<del style="background:#ffe6e6;">hkeit, weniger das, was ich&para;<br>Ihnen schuldig bin, erhalten hat.&para;<br>Stormond.&para;<br>Aber, wenn dieses ist, warum suchten Sie den&para;<br>Umgang verschiedener meines Geschlechts, denen ich&para;<br>eben d...'
  gsub("&para;","#nl#",g)
  
  #dx<-as.character(dx)
  writeLines(dx,"www/tdiff.html")
  #d <- diffmatchpatch::diff_make(t11,t22)
  #dhtm<-diff_to_html(as.character(d))
  dhtm<-"<h1>diff render</h1><hr>"
  dtemp<-tempfile("x.txt")
  for(k in 1:length(chunks)){
    #print(k[1])
    s<-chunks[[k]][1]
    e<-chunks[[k]][length(chunks[[k]])]
    s2<-chunks.2[[k]][1]
    e2<-chunks.2[[k]][length(chunks.2[[k]])]
    t11<-stri_sub(t1,s,e)
    t22<-stri_sub(t2,s2,e2)
    d <- diffmatchpatch::diff_make(t11,t22,checklines = F)
    #d <- diffmatchpatch::diff_make("../www/goue_iwanette_ezd.txt", "../www/r-tempout.xml")
    dhtm2<-diff_to_html(d)
    writeLines(dhtm2,dtemp)
    writeLines(dhtm2,"www/27.html")
    dhtm2<-readtext(dtemp,encoding = "utf-8")$text
    #    writeLines(dhtm2,dtemp)
    #   dhtm2<-readLines(dtemp)
    
    dhtm2<-gsub("&para;","",dhtm2)
    
    dhtm<-paste0(dhtm,dhtm2)
    
  }
  htmtemp<-tempfile("x.html")
  # dhtm<-gsub("&para;","#nl#",dhtm)
  
  #  write(dhtm,htmtemp)
  difft<-read_html("diff-template.html")
  #  difft<-read_html(paste0(dhtm,collapse = ""))
  diffht2<-read_html(paste0(dhtm,collapse = ""))
  b1<-xml_find_all(difft,"//body")
  b2<-xml_find_all(diffht2,"//body")
  xml_replace(b1,b2)
  write_html(difft,htmtemp)
  write_html(difft,"www/diff.html")
  diffsend<-readLines(htmtemp,encoding = "UTF-8")
  return(diffsend)
}

dhtm<-diff.compare(t1,t2)
