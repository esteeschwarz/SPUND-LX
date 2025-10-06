library(tidyverse)
library(igraph)
library(visNetwork)
library(quanteda)
library(stringdist)
library(DT)
load(paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/stef_psych/tdba.n.RData"))
#tdba<-qltdf
#d<-duplicated(tdba)
#tdb2<-tdba[!d,]
tdba<-tdba.n
# obs<-tdba$obs
# ref<-tdba$ref
# rm(tdba.1.15303)
colnames(tdba.n)

cns<-c(1,3,5,6,7,17,19,20,22,23,24,25,26)
colnames(tdba.n)[cns]
tdba<-tdba.n[cns]

#obs<-obs[cns]
#tdbs<-tdba[cns]
colnames(tdba)
# colnames(tdba)<-c("token","sentence_id","lemma","upos","xpos","target","text_id","author","position","q","url_id")
#ref<-ref[cns]
#tdbs<-tdba[cns]
#colnames(ref)
#colnames(ref)<-c("word","sentence_id","lemma","pos_tag","xpos","com_id","target","text_id","author")
#colnames(tdbs)
data1<-tdba
#tdb$obs$url<-uid2
# url.u.o<-unique(data1$url_id)
# #url.u.t<-unique(data1$text_id)
# data1$range<-NA
# for(k in url.u.o){
#   cat("\r",k)
#   r<-data1$url_id==k
#   data1$range[r]<-sum(r)
# }
# data2<-ref
# data1$position<-1:length(data1$word)
# data2$position<-1:length(data2$word)
### clean up
data1$token<-gsub("[^a-zA-Z]","",data1$token)
data1$lemma<-gsub("[^a-zA-Z]","",data1$lemma)
data1<-data1[data1$token!="",]
### get embed score
# sample
url.u<-unique(data1$url_id)
select<-1:2
for(k in select){
  r<-data1$url_id==k
}
aut.u<-unique(data1$author)
select<-1:length(aut.u)
for(k in select){
  cat("\r",k)
  r<-data1$author==aut.u[k]
  data1$aut_id[r]<-k
}


# data2$word<-gsub("[^a-zA-Z]","",data2$word)
# data2$lemma<-gsub("[^a-zA-Z]","",data2$lemma)
# data2<-data2[data2$word!="",]
# url.u<-unique(data1$text_id)
# url.u
# data1$url_id<-NA
# for (k in 1:length(url.u)){
#   cat("\r",k,"of",length(url.u))
#   r<-data1$text_id==url.u[k]
#   data1$url_id[r]<-k
# }
# data2$url_id<-NA
# url.u<-unique(data2$text_id)
# for (k in 1:length(url.u)){
#   cat("\r",k,"of",length(url.u))
#   r<-data2$text_id==url.u[k]
#   data2$url_id[r]<-k
# }
# obs<-data[data$target=="obs",]
# ref<-data[data$target=="ref",]
# ====== 1. PRÉPARATION DES DONNÉES ======
# Fonction pour charger et nettoyer les données pos-taggées
load_reddit_corpus <- function(data) {
  # Assumons un format : text_id, sentence_id, word, pos_tag, lemma
  #data <- read.csv(file_path, stringsAsFactors = FALSE)
#  data<-tdb$obs
  unique(data$upos)
  unique(data$xpos)
  # Filtrer les noms (NN, NNS, NNP, NNPS)
  nouns <- data %>%
    filter(str_detect(upos, "NOUN")) %>%
    mutate(
      text_id = as.character(url_id),
      position = pos
    )
  
  return(nouns)
}

# ====== 2. EXTRACTION DES ENTITÉS ET SYNONYMES ======

# Fonction pour identifier les entités nommées potentielles
extract_named_entities_dep <- function(nouns_data) {
  named_entities <- nouns_data %>%
    # filter(str_detect(pos_tag, "NNP")) %>%  # Noms propres
    filter(str_detect(xpos, "NNP")) %>%  # Noms propres
    group_by(text_id) %>%
    mutate(entity_position = row_number()) %>%
    ungroup()
  
  return(named_entities)
}

# Fonction pour détecter les synonymes/variations par similarité de chaînes
find_similar_nouns_dep <- function(nouns_data, threshold = 0.8) {
  unique_nouns <- unique(nouns_data$lemma)
  
  # Calculer la distance entre tous les noms
  similarity_matrix <- outer(unique_nouns, unique_nouns, 
                             function(x, y) 1 - stringdist(x, y, method = "jw"))
  
  # Créer un dataframe des paires similaires
  similar_pairs <- expand.grid(noun1 = unique_nouns, noun2 = unique_nouns) %>%
    mutate(similarity = as.vector(similarity_matrix)) %>%
    filter(similarity > threshold, noun1 != noun2) %>%
    arrange(desc(similarity))
  
  return(similar_pairs)
}

# ====== 3. DÉTECTION DES ANAPHORES ======

# Fonction pour calculer la distance entre mentions
calculate_anaphora_distance <- function(nouns_data) {
  anaphora_candidates <- nouns_data %>%
    group_by(text_id, lemma,target) %>%
    filter(n() > 1) %>%  # Noms qui apparaissent plusieurs fois
    mutate(
      mention_order = row_number(),
      total_mentions = n()
    ) %>%
    ungroup()
  
  # Calculer les distances entre mentions successives
  distances <- anaphora_candidates %>%
    group_by(text_id, lemma,target) %>%
    mutate(
      next_position = lead(position),
      next_url = lead(text_id),
      dist = next_position - position,
    #  is_anaphora = !is.na(distance_to_next)
      is_anaphora = next_url == text_id
    ) %>%
    filter(is_anaphora) %>%
    ungroup()
  
  return(distances)
}

# Fonction pour détecter les chaînes de coréférence
detect_coreference_chains <- function(nouns_data, max_distance = 50) {
  # Grouper par texte et chercher les répétitions de noms
  coreference_chains <- nouns_data %>%
    group_by(text_id) %>%
    arrange(position) %>%
    group_by(text_id, lemma) %>%
    mutate(
      chain_id = paste(text_id, lemma, sep = "_"),
      mention_number = row_number(),
      prev_position = lag(position),
      distance_from_prev = position - lag(position, default = 0)
    ) %>%
    filter(mention_number > 1, distance_from_prev <= max_distance) %>%
    ungroup()
  
  return(coreference_chains)
}

# ====== 4. CRÉATION DU RÉSEAU SÉMANTIQUE ======

# Fonction pour créer un graphe des relations
create_semantic_network <- function(anaphora_data, similarity_data) {
  # Nœuds : noms uniques
  nodes <- data.frame(
    id = unique(c(anaphora_data$lemma, similarity_data$noun1, similarity_data$noun2)),
    stringsAsFactors = FALSE,
    type = c(0,1)
  ) %>%
    mutate(
      label = id,
      frequency = map_dbl(id, ~ sum(anaphora_data$lemma == .x))
    )
  
  # Arêtes : relations anaphoriques
  anaphora_edges <- anaphora_data %>%
    select(source = lemma, target = lemma, weight = distance_to_next, type = "is_anaphora") %>%
    distinct()
  
  # Arêtes : similarités
  similarity_edges <- similarity_data %>%
    select(source = noun1, target = noun2, weight = similarity, type = "similarity")
  
  # Combiner les arêtes
  all_edges <- bind_rows(anaphora_edges, similarity_edges) %>%
    mutate(
      color = ifelse(type == "is_anaphora", "red", "blue"),
      width = ifelse(type == "is_anaphora", weight/10, weight*5)
    )
  
  return(list(nodes = nodes, edges = all_edges))
}

# ====== 5. VISUALISATION ======

# Fonction pour visualiser le réseau avec visNetwork
visualize_network <- function(network_data) {
  visNetwork(network_data$nodes, network_data$edges) %>%
    visOptions(highlightNearest = TRUE, selectedBy = "type") %>%
    visPhysics(enabled = TRUE, stabilization = TRUE) %>%
    visLegend() %>%
    visLayout(randomSeed = 123)
}

# Fonction pour cartographier sur les textes originaux
#anaphora_data<-anaphora_distances
#original_corpus<-nouns_data
map_relations_to_texts <- function(anaphora_data, original_corpus) {
  # Créer une vue des relations dans leur contexte
  relation_map <- anaphora_data %>%
    left_join(original_corpus, by = c("text_id", "position","lemma")) %>%
    group_by (text_id,lemma) %>%
    summarise(
      mentions = list(word),
      positions = list(position),
      distances = list(distance_to_next[!is.na(distance_to_next)]),
      avg_distance = mean(distance_to_next, na.rm = TRUE),
      .groups = "drop"
    )
  
  return(relation_map)
}

# ====== 6. ANALYSE STATISTIQUE ======

# Fonction pour analyser les patterns anaphoriques
analyze_anaphora_patterns <- function(anaphora_data) {
  patterns <- anaphora_data %>%
    group_by(lemma) %>%
    summarise(
      total_mentions = n(),
      avg_distance = mean(distance_to_next, na.rm = TRUE),
      min_distance = min(distance_to_next, na.rm = TRUE),
      max_distance = max(distance_to_next, na.rm = TRUE),
      texts_appeared = n_distinct(text_id),
      .groups = "drop"
    ) %>%
    arrange(desc(total_mentions))
  
  return(patterns)
}

# ====== 7. EXEMPLE D'UTILISATION ======

# Exemple de workflow complet
# run_anaphora_analysis <- function(corpus_file) {
  # 1. Charger les données
  cat("Chargement du corpus...\n")
  # nouns_data_obs <- load_reddit_corpus(data1)
  # nouns_data_ref <- load_reddit_corpus(data2)
  nouns_data <- load_reddit_corpus(data1)
  
  # 2. Extraire les entités
  #cat("Extraction des entités nommées...\n")
  #entities <- extract_named_entities(nouns_data)
  #none
  # 3. Trouver les synonymes/similaires
  #cat("Recherche de noms similaires...\n")
  #similar_nouns <- find_similar_nouns(nouns_data)
  
  # 4. Détecter les anaphores
  cat("Détection des anaphores...\n")
  anaphora_distances <- calculate_anaphora_distance(nouns_data)
  url.d.u<-unique(anaphora_distances$text_id)
  nouns.d<-unique(anaphora_distances$lemma)
  url.u<-unique(data1$url_id)
  select<-1:length(url.d.u)
  library(pbapply)
  #for(k in select){
  embeds<-pblapply(seq_along(select),function(x){
    k<-url.d.u[x]
    cat("\r",k,"of",length(select))
    r<-data1$url_id==k
    t<-paste0(data1$token[r],collapse = " ")
    embed<-get.embeds(t)
  })
  save(embeds,file = paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/stef_psych/data1.embeds.RData"))
  select<-1:length(nouns.d)
  nouns.embeds<-pblapply(seq_along(select),function(x){
    t<-nouns.d[x]
    cat("\r",x,"of",length(select))
    #r<-data1$url_id==k
    #t<-paste0(data1$token[r],collapse = " ")
    embed<-get.embeds(t)
  })
  names(nouns.embeds)<-nouns.d
  get.score(nouns.embeds[[1]],embeds[[1]])
  select<-1:length(url.d.u)
  #select<-1:5
  #y<-"dad"
  # nouns.scores<-pblapply(seq_along(select),function(x){
  #   r<-anaphora_distances$url_id==url.d.u[x]
  #   n<-unique(anaphora_distances$lemma[r])
  #   scores<-lapply(n, function(y){
  #     s1<-nouns.embeds[[y]]
  #     s<-get.score(s1,embeds[[x]])
  #   })
  #   names(scores)<-n
  #   return(scores)
  # })
  select<-1:length(anaphora_distances$lemma)
  u<-1
  nouns.scores<-pblapply(seq_along(select),function(x){
   # r<-anaphora_distances$url_id==url.d.u[x]
  #  n<-unique(anaphora_distances$lemma[r])
   # scores<-lapply(n, function(y){
    #  s1<-nouns.embeds[[y]]
    n<-anaphora_distances$lemma[x]
    u<-anaphora_distances$url_id[x]
    ue<-which(url.d.u==u)
    s1<-nouns.embeds[[n]]
      scores<-get.score(s1,embeds[[ue]])
    #})
    names(scores)<-n
    return(scores)
  })
  u
  k
  nouns.scores.c<-unlist(nouns.scores)
  write.csv(data.frame(noun=anaphora_distances$lemma,embed_score=  nouns.scores.c),paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/stef_psych/qltdf_embed.csv"))
  
  anaphora_distances$embed.score<-nouns.scores.c
#  mode(anaphora_distances$embed_score)<-"double"
  
  outliers <- function(df) {
    # Remove outliers in 'y' using IQR
    Q1 <- quantile(df$distance_to_next, 0.25,na.rm = T)
    Q3 <- quantile(df$distance_to_next, 0.75,na.rm = T)
    IQR <- Q3 - Q1
    
    df_no_outliers <- subset(df, distance_to_next > (Q1 - 1.5 * IQR) & distance_to_next < (Q3 + 1.5 * IQR))
  }
  
 # anaphora_distances.oo<-outliers(anaphora_distances)
  #anaphora_distances.oo<-get.dist.norm(  anaphora_distances,T)
  #mode(anaphora_distances)
  # anaphora_distances.oo<-outliers(anaphora_distances.o)
  # anaphora_distances.ro<-outliers(anaphora_distances.r)
  # sum(anaphora_distances.oo$total_mentions==1)
  # sum(anaphora_distances.ro$total_mentions==1)
  # ### test:
  #mean(anaphora_distances$dist)
  # mean(anaphora_distances.oo$distance_to_next)
  # median(anaphora_distances.r$distance_to_next)
  # median(anaphora_distances.o$distance_to_next)
  # sum(anaphora_distances.o$is_anaphora)
 # data3<-rbind(anaphora_distances.oo,anaphora_distances.ro)
  #coreference_chains <- detect_coreference_chains(nouns_data)
  anova.fstr<-paste0("dist"," ~ target*q")
#  data3<-data.frame(anaphora_distances.oo)
 # mode(data3$embed)<-"double"
  colnames(anaphora_distances)[grep("author",colnames(anaphora_distances))]<-"aut"
  qltdf<-anaphora_distances
  save(qltdf,file = paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/stef_psych/eval-013.RData"))
  qltdf.oo<-get.dist.norm(qltdf,T)
  data3<-qltdf.oo
  #colnames(data3)[grep("distance_to_next",colnames(data3))]<-"dist"
  table(data3$q)
  model<-aov(as.formula(anova.fstr),data=data3)
  anova.sum<-summary(model)
  anova.sum
  library(lme4)
  library(lmerTest)
  #lme.str<-paste0("dist ~ target*q+(1|lemma)+(1|author)")
  #lme.str<-paste0("dist ~ target*q")
  lme.str<-paste0("dist ~ target*q+(1|author)")
  lme.str<-paste0("dist_rel_obs ~ target*q+(1|author)")
  lme.str<-paste0("dist_rel_ref ~ target*q+(1|author)")
  d.sel<-"dist_rel_obs"
  d.sel<-"dist_rel_all"
  det.f<-"*det"
  aut.str<-"+(1|aut)"
  r<-F
  em<-T
  l<-F
  lme.str<-paste0(d.sel," ~ target*q",det.f,ifelse(l,"+(1|lemma)",""),aut.str,ifelse(r,"+range",""),ifelse(em,"+embed",""))
  
  lm2<-lmer(eval(expr(lme.str)),data3)
  #lm3<-lmer(eval(expr(lmeform)),dfa)
  summary(lm2)
  lm2.summ<-summary(lm2)
  lm2.summ
  anlm.summ<-anova(lm2)
  anlm.summ
  
  # 5. Créer le réseau
  cat("Création du réseau sémantique...\n")
  #network <- create_semantic_network(anaphora_distances, similar_nouns)
  
  # 6. Analyser les patterns
  cat("Analyse des patterns...\n")
  patterns <- analyze_anaphora_patterns(anaphora_distances.oo)
  
  # 7. Cartographier sur les textes
  cat("Cartographie des relations...\n")
  relation_map <- map_relations_to_texts(anaphora_distances, nouns_data)
  #relation_map <- map_relations_to_texts(anaphora_distances, data)
  
  # # return(list(
  #   network = network,
  #   patterns = patterns,
  #   relation_map = relation_map,
  #   coreference_chains = coreference_chains,
  #   entities = entities
  # # ))
  
# }load(paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/stef_psych/dcorpus.df.cpt-012c.RData"))

# save(network,file = paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/stef_psych/sem-network.RData"))
# write.csv(network$nodes,paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/stef_psych/sem-network.nodes.csv"))
# write.csv(network$edges,paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/stef_psych/sem-network.edges.csv"))
# Pour exécuter l'analyse :
 #results <- run_anaphora_analysis("votre_corpus_reddit.csv")
 # visualize_network(results$network)
#visualize_network(network)
#write.csv(network$)


