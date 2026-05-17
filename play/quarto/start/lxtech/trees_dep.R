find_tree <- function(X) {
  X
  X <- as.matrix(X)
  n <- nrow(X)
  n
  nodes <- rownames(X)
  nodes<-df$t

  size <- rowSums(X)
  parent <- rep(NA, n)

  for (i in seq_len(n)) {
    candidates <- c()
      print(i)

    for (j in seq_len(n)) {
      print(j)
      print("j")
      if (i == j) next

      # Is node i a subset of node j?
      if (all(X[i, ] <= X[j, ]) && any(X[i, ] < X[j, ])) {
        candidates <- c(candidates, j)
      }
    }

    # Choose smallest strict superset
    if (length(candidates) > 0) {
      parent[i] <- candidates[which.min(size[candidates])]
    }
  }

  dft<-data.frame(
    child = nodes,
    parent = ifelse(is.na(parent), NA, nodes[parent]),
    stringsAsFactors = FALSE
  )
}
X
dft
library(dplyr)
library(tidyr)
t4

edges <- t4 |>
  pivot_longer(
    cols = X2:length(t4),
    values_to = "child",
    values_drop_na = TRUE
  ) |>
  select(parent = X1, child)

edges

terminals <- setdiff(edges$child, edges$parent)
terminals

get_terminals <- function(node, edges, terminals) {
  children <- edges$child[edges$parent == node]

  if (length(children) == 0)
    return(node)

  unlist(lapply(children, get_terminals,
                edges = edges,
                terminals = terminals))
}

nodes <- unique(c(edges$parent, edges$child))
nodes <- intersect(nodes, edges$parent)   # non-terminal nodes only

X <- matrix(
  0,
  nrow = length(nodes),
  ncol = length(terminals),
  dimnames = list(nodes, terminals)
)

for (node in nodes) {
  desc <- unique(get_terminals(node, edges, terminals))
  X[node, desc] <- 1
}

X
d <- dist(X, method = "binary")
hc <- hclust(d, method = "complete")
plot(hc)

library(DiagrammeR)

grViz(sprintf("
digraph syntax {
  graph [rankdir=TB]
  node [shape=plaintext]

  %s
}
",
paste(sprintf('"%s" -> "%s"', edges$parent, edges$child),
      collapse = "\n")
))
t4<-c("IP->NP","NP->Det meine",
"NP->N'","N->N schwester",
"IP->I","I->VP","VP->V'","V'->V schreibt",
"V'->PP","PP->P an",
"PP->NP","NP->Det einem",
"NP->N'","N'->AP wichtigen",
"N'->N buch")
t4
plot(t4,layout_as_tree)
grViz(sprintf("
digraph syntax {
  graph [rankdir=TB]
  node [shape=plaintext]
  %s
  }
",paste0('"',t6,'"')))

# grViz('
# digraph syntax {
#   graph [rankdir=TB]
#   node [shape=plaintext]
#   "IP -> NP -> Det meine
# NP -> N'' -> N schwester
# IP -> I -> VP -> V'' -> V schreibt
# V'' -> PP -> P an
# PP -> NP -> Det einem
# NP -> N'' -> AP wichtigen
# N'' -> N buch"
# }'

grViz("
digraph syntax {
graph [rankdir=TB]
node [shape=plaintext]
NP->N->d1
N->d2->d''->d4
N->N''->d3

}")
library(igraph)
?layout_as_tree
?grViz
layout_as_tree(make_tree(tree))

tree2 <- make_tree(10, 3) + make_tree(10, 2)
plot(tree2, layout = layout_as_tree)
plot(tree2, layout = layout_as_tree(tree2,
  root = c(1, 11),
  rootlevel = c(2, 1)
))
install.packages("ggtree")
    install.packages("BiocManager")
BiocManager::install("ggtree")
library(ggtree)
?ggtree
library(ape)
tr<-rtree(10)
ggtree(tr,layout="dendrogram")

library(igraph)
g <- graph.tree(40, 3)
#g <- make_tree(10, 3) + make_tree(10, 2)
arrow_size <- unit(rep(c(0, 3), times = c(27, 13)), "mm")
ggtree(g, arrow = arrow(length=arrow_size)) + 
  # geom_point(size=5, color='steelblue', alpha=.6) + 
  geom_tiplab(hjust=.5,vjust=2) + layout_dendrogram()

library(igraph)
g <- graph.tree(12, 3,4)
arrow_size <- unit(rep(c(0, 3), times = c(27, 13)), "mm")
ggtree(g, arrow = arrow(length=arrow_size)) + 
  # geom_point(size=5, color='steelblue', alpha=.6) + 
  geom_tiplab(hjust=.5,vjust=2) + layout_dendrogram()
?graph.tree


g <- make_tree(10) %du% make_tree(10)
V(g)$id <- seq_len(vcount(g)) - 1
roots <- sapply(decompose(g), function(x) {
  V(x)$id[topo_sort(x)[1] + 1]
})
t1 <- unfold_tree(g, roots = roots)
t1$tree<-t4
t1
plot(t1)
tree2<-gsub("-->","->",tree)
tree2
ggtree(t1$tree)
?igraph
plot(tree$tree, layout = layout_as_tree)
plot(tree$tree, layout = layout_as_tree(tree$tree,
  root = c(1, 11),
  rootlevel = c(2, 1)
))
plot(tree$tree)
plot(tree2)
tree3<-make_tree(tree2)
tree3
plot(t1$tree)
t1
tree<-"IP --> NP --> Det meine
NP --> N' --> N schwester
IP --> I --> VP --> V' --> V schreibt
V' --> PP --> P an
PP --> NP --> Det einem
NP --> N' --> AP wichtigen
N' --> N buch"
plot(t1$tree, layout = layout_as_tree)
plot(t4,layout_as_tree)
t4
t1

library(ape)

txt <- "(((meine)Det,(((schwester)N)N'))NP,(((((schreibt)V,((an)P,(((einem)Det,((wichtigen)AP,(buch)N)N')NP))PP)V')VP)I))IP;"
txt<-gsub("'","\u2032",txt)
txt
txt <- '(
          ((meine)Det,
           (((schwester)N)"N\'"))NP,
          (((((schreibt)V,
              ((an)P,
               (((einem)Det,
                 ((wichtigen)AP,(buch)N)"N\'")NP
               )PP
             )"V\'")VP)I)
        )IP;'

tree <- read.tree(text = txt)

plot(
  tree,
  direction = "downwards",
  use.edge.length = FALSE,
  no.margin = TRUE,
  cex = 0.9
)

nodelabels(tree$node.label, frame = "none", cex = 0.9)
