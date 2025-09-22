# Analyse des relations anaphoriques et coréférences dans un corpus Reddit
# Packages nécessaires
library(tidyverse)
library(igraph)
library(visNetwork)
library(quanteda)
library(stringdist)
library(DT)
load(paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/stef_psych/dcorpus.df.cpt-012c.RData"))

# ====== 1. PRÉPARATION DES DONNÉES ======
# Fonction pour charger et nettoyer les données pos-taggées
load_reddit_corpus <- function(tdb) {
  # Assumons un format : text_id, sentence_id, word, pos_tag, lemma
  #data <- read.csv(file_path, stringsAsFactors = FALSE)
#  data<-tdb$obs
  tdba<-tdba.1.15303
  rm(tdba.1.15303)
  colnames(tdba)
  cns<-c(1,3,5,6,7,15,17,18)
  tdbs<-tdba[cns]
  colnames(tdbs)
  colnames(tdbs)<-c("word","sentence_id","lemma","pos_tag","xpos","com_id","target","text_id")
  colnames(tdbs)
  data<-tdbs
  unique(data$pos_tag)
  unique(data$xpos)
  # Filtrer les noms (NN, NNS, NNP, NNPS)
  nouns <- data %>%
    filter(str_detect(pos_tag, "NOUN")) %>%
    mutate(
      text_id = as.character(text_id),
      position = row_number()
    )
  
  return(nouns)
}

# ====== 2. EXTRACTION DES ENTITÉS ET SYNONYMES ======

# Fonction pour identifier les entités nommées potentielles
extract_named_entities <- function(nouns_data) {
  named_entities <- nouns_data %>%
    # filter(str_detect(pos_tag, "NNP")) %>%  # Noms propres
    filter(str_detect(xpos, "NNP")) %>%  # Noms propres
    group_by(text_id) %>%
    mutate(entity_position = row_number()) %>%
    ungroup()
  
  return(named_entities)
}

# Fonction pour détecter les synonymes/variations par similarité de chaînes
find_similar_nouns <- function(nouns_data, threshold = 0.8) {
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
    group_by(text_id, lemma) %>%
    filter(n() > 1) %>%  # Noms qui apparaissent plusieurs fois
    mutate(
      mention_order = row_number(),
      total_mentions = n()
    ) %>%
    ungroup()
  
  # Calculer les distances entre mentions successives
  distances <- anaphora_candidates %>%
    group_by(text_id, lemma) %>%
    mutate(
      next_position = lead(position),
      distance_to_next = next_position - position,
      is_anaphora = !is.na(distance_to_next)
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
    type = c("FALSE","TRUE")
  ) %>%
    mutate(
      label = id,
      frequency = map_dbl(id, ~ sum(anaphora_data$lemma == .x))
    )
  
  # Arêtes : relations anaphoriques
  anaphora_edges <- anaphora_data %>%
    select(from = lemma, to = lemma, weight = distance_to_next, type = "is_anaphora") %>%
    distinct()
  
  # Arêtes : similarités
  similarity_edges <- similarity_data %>%
    select(from = noun1, to = noun2, weight = similarity, type = "similarity")
  
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
    left_join(original_corpus, by = c("text_id", "position")) %>%
    group_by("text_id", "lemma") %>%
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
  nouns_data <- load_reddit_corpus("none")
  
  # 2. Extraire les entités
  cat("Extraction des entités nommées...\n")
  entities <- extract_named_entities(nouns_data)
  #none
  # 3. Trouver les synonymes/similaires
  cat("Recherche de noms similaires...\n")
  similar_nouns <- find_similar_nouns(nouns_data)
  
  # 4. Détecter les anaphores
  cat("Détection des anaphores...\n")
  anaphora_distances <- calculate_anaphora_distance(nouns_data)
  coreference_chains <- detect_coreference_chains(nouns_data)
  
  # 5. Créer le réseau
  cat("Création du réseau sémantique...\n")
  network <- create_semantic_network(anaphora_distances, similar_nouns)
  
  # 6. Analyser les patterns
  cat("Analyse des patterns...\n")
  patterns <- analyze_anaphora_patterns(anaphora_distances)
  
  # 7. Cartographier sur les textes
  cat("Cartographie des relations...\n")
  data$position<-1:length(data$word)
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
visualize_network(network)
#write.csv(network$)


