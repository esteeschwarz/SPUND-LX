# TRANSFORMER DES EMBEDDINGS DE TEXTE EN IMAGES VISUELLES
# Plusieurs approches créatives pour "voir" les embeddings

library(ggplot2)
library(gridExtra)
library(viridis)

set.seed(42)

# ============================================================================
# PRÉPARATION: Créer des embeddings de texte
# ============================================================================

textes_francais <- c(
  "Le chat dort paisiblement",
  "Mon chien joue dehors",
  "Le lion chasse la gazelle",
  "J'adore la pizza italienne",
  "Le pain frais du matin",
  "Le fromage sent fort",
  "Mon ordinateur est rapide",
  "Le téléphone sonne",
  "Internet connecte le monde",
  "Je suis très heureux",
  "La tristesse m'envahit",
  "L'amour est merveilleux"
)

# Simulation d'embeddings (50 dimensions)
create_text_embeddings <- function(texts, dim = 50) {
  n <- length(texts)
  embeddings <- matrix(0, nrow = n, ncol = dim)
  
  # Patterns sémantiques
  for (i in 1:n) {
    text <- tolower(texts[i])
    
    base <- rnorm(dim, mean = 0, sd = 0.3)
    
    # Animaux
    if (grepl("chat|chien|lion", text)) {
      base <- base + rnorm(dim, mean = 3, sd = 0.5)
    }
    # Nourriture
    if (grepl("pizza|pain|fromage", text)) {
      base <- base + rnorm(dim, mean = -2, sd = 0.5)
    }
    # Technologie
    if (grepl("ordinateur|téléphone|internet", text)) {
      base <- base + rnorm(dim, mean = 5, sd = 0.5)
    }
    # Émotions
    if (grepl("heureux|tristesse|amour", text)) {
      base <- base + rnorm(dim, mean = -4, sd = 0.5)
    }
    
    embeddings[i, ] <- base
  }
  
  rownames(embeddings) <- texts
  return(embeddings)
}

#embeddings <- create_text_embeddings(textes_francais, dim = 50)

load(paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/stef_psych/tdba.n.RData"))
tdba<-tdba.n
urls<-unique(tdba.n$url_t)
### i am using (instead of the templates) embeddings here from a reddit channel created with nomic-text-embed model using ollama local instance.
load(paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/stef_psych/data1.embeds.RData"))
embeddings<-matrix(unlist(embeds),ncol = length(embeds))
embeddings<-t(embeddings)
cat("=== EMBEDDINGS CRÉÉS ===\n")
cat("Dimensions:", dim(embeddings), "\n")
cat("Textes:", nrow(embeddings), "\n\n")

# ============================================================================
# APPROCHE 1: EMBEDDING → HEATMAP (Carte de Chaleur)
# ============================================================================

cat("=== APPROCHE 1: HEATMAP DES EMBEDDINGS ===\n")
cat("Chaque ligne = un texte, chaque colonne = une dimension\n\n")

# Fonction pour créer une heatmap d'embedding
create_embedding_heatmap <- function(embedding_vector, size = 32, text_label = "") {
  # Redimensionner le vecteur en une matrice carrée
  n_values <- min(length(embedding_vector), size * size)
  values <- embedding_vector[1:n_values]
  
  # Remplir avec des zéros si nécessaire
  if (length(values) < size * size) {
    values <- c(values, rep(0, size * size - length(values)))
  }
  
  # Créer la matrice
  img_matrix <- matrix(values, nrow = size, ncol = size, byrow = TRUE)
  
  # Normaliser entre 0 et 1
  img_matrix <- (img_matrix - min(img_matrix)) / (max(img_matrix) - min(img_matrix))
  
  return(list(matrix = img_matrix, label = text_label))
}

# Créer des heatmaps pour quelques textes
example_texts_idx <- c(1, 4, 2100, 2000)  # Chat, Pizza, Ordinateur, Heureux
heatmap_plots <- list()

for (i in 1:length(example_texts_idx)) {
  idx <- example_texts_idx[i]
  result <- create_embedding_heatmap(embeddings[idx, ], size = 20, 
                                     text_label = textes_francais[idx])
  
  # Créer le dataframe pour ggplot
  df <- expand.grid(x = 1:ncol(result$matrix), y = 1:nrow(result$matrix))
  df$value <- as.vector(t(result$matrix))
  
  p <- ggplot(df, aes(x = x, y = y, fill = value)) +
    geom_tile() +
    scale_fill_viridis(option = "magma") +
    coord_equal() +
    theme_minimal() +
    theme(
      axis.text = element_blank(),
      axis.ticks = element_blank(),
      panel.grid = element_blank(),
      legend.position = "none",
      plot.title = element_text(size = 8)
    ) +
    labs(title = substr(result$label, 1, 25), x = "", y = "")
  
  heatmap_plots[[i]] <- p
}

grid.arrange(grobs = heatmap_plots, ncol = 2,
             top = "APPROCHE 1: Visualisation Directe des Embeddings")

# ============================================================================
# APPROCHE 2: EMBEDDING → PATTERN CIRCULAIRE (comme un radar)
# ============================================================================

cat("\n=== APPROCHE 2: PATTERNS CIRCULAIRES ===\n")
cat("Visualisation polaire des dimensions principales\n\n")

create_circular_pattern <- function(embedding_vector, n_dims = 20, text_label = "") {
  # Prendre les premières dimensions
  values <- embedding_vector[1:n_dims]
  
  # Normaliser
  values <- (values - min(values)) / (max(values) - min(values))
  
  # Créer les coordonnées polaires
  angles <- seq(0, 2 * pi, length.out = n_dims + 1)[1:n_dims]
  
  df <- data.frame(
    angle = angles,
    value = values,
    x = values * cos(angles),
    y = values * sin(angles)
  )
  
  p <- ggplot(df, aes(x = x, y = y)) +
    geom_polygon(fill = "steelblue", alpha = 0.5, color = "darkblue", size = 1) +
    geom_point(size = 2, color = "darkred") +
    coord_equal() +
    theme_void() +
    labs(title = substr(text_label, 1, 25)) +
    theme(plot.title = element_text(size = 8, hjust = 0.5))
  
  return(p)
}

# Créer des patterns circulaires
circular_plots <- list()

for (i in 1:length(example_texts_idx)) {
  idx <- example_texts_idx[i]
  p <- create_circular_pattern(embeddings[idx, ], n_dims = 16,
                               text_label = textes_francais[idx])
  circular_plots[[i]] <- p
}

grid.arrange(grobs = circular_plots, ncol = 2,
             top = "APPROCHE 2: Patterns Circulaires (Radar)")

# ============================================================================
# APPROCHE 3: EMBEDDING → IMAGE GENERATIVE (Style Art Abstrait)
# ============================================================================

cat("\n=== APPROCHE 3: ART GÉNÉRATIF ===\n")
cat("Transformation créative en image abstraite\n\n")

create_generative_image <- function(embedding_vector, size = 64, text_label = "") {
  img <- matrix(0, nrow = size, ncol = size)
  
  # Utiliser différentes dimensions pour différents paramètres
  n_circles <- max(3, min(10, round(abs(embedding_vector[1]) * 10)))
  
  for (c in 1:n_circles) {
    # Position basée sur les embeddings
    center_x <- (embedding_vector[c * 2] + 5) / 10 * size
    center_y <- (embedding_vector[c * 2 + 1] + 5) / 10 * size
    
    # Rayon basé sur une autre dimension
    radius <- max(3, abs(embedding_vector[c * 3]) * 10)
    
    # Intensité
    intensity <- (embedding_vector[c * 4] + 5) / 10
    
    # Dessiner le cercle
    for (i in 1:size) {
      for (j in 1:size) {
        dist <- sqrt((i - center_x)^2 + (j - center_y)^2)
        if (dist <= radius) {
          img[i, j] <- img[i, j] + intensity * (1 - dist / radius)
        }
      }
    }
  }
  
  # Normaliser
  img <- (img - min(img)) / (max(img) - min(img) + 0.001)
  
  # Visualiser
  df <- expand.grid(x = 1:ncol(img), y = 1:nrow(img))
  df$value <- as.vector(t(img))
  
  p <- ggplot(df, aes(x = x, y = y, fill = value)) +
    geom_tile() +
    scale_fill_gradient2(low = "darkblue", mid = "purple", 
                         high = "yellow", midpoint = 0.5) +
    coord_equal() +
    theme_void() +
    theme(legend.position = "none",
          plot.title = element_text(size = 8, hjust = 0.5)) +
    labs(title = substr(text_label, 1, 25))
  
  return(p)
}

# Créer des images génératives
generative_plots <- list()

for (i in 1:length(example_texts_idx)) {
  idx <- example_texts_idx[i]
  p <- create_generative_image(embeddings[idx, ], size = 48,
                               text_label = textes_francais[idx])
  generative_plots[[i]] <- p
}

grid.arrange(grobs = generative_plots, ncol = 2,
             top = "APPROCHE 3: Art Génératif à partir des Embeddings")

# ============================================================================
# APPROCHE 4: EMBEDDING → FORME GÉOMÉTRIQUE (Signature Visuelle)
# ============================================================================

cat("\n=== APPROCHE 4: SIGNATURES GÉOMÉTRIQUES ===\n")
cat("Chaque texte = une forme unique\n\n")

create_geometric_signature <- function(embedding_vector, text_label = "") {
  # Extraire des paramètres géométriques
  n_points <- 8
  
  # Créer une forme fermée basée sur l'embedding
  angles <- seq(0, 2 * pi, length.out = n_points + 1)[1:n_points]
  radii <- abs(embedding_vector[1:n_points])
  radii <- (radii - min(radii)) / (max(radii) - min(radii) + 0.001) * 0.8 + 0.2
  
  x <- radii * cos(angles)
  y <- radii * sin(angles)
  
  # Fermer la forme
  x <- c(x, x[1])
  y <- c(y, y[1])
  
  df <- data.frame(x = x, y = y)
  
  # Couleur basée sur la moyenne de l'embedding
  color_val <- mean(embedding_vector)
  color_map <- if(color_val > 0) "coral" else "steelblue"
  
  p <- ggplot(df, aes(x = x, y = y)) +
    geom_polygon(fill = color_map, alpha = 0.6, color = "black", size = 1.5) +
    geom_point(size = 3, color = "darkred") +
    coord_equal() +
    xlim(-1.2, 1.2) +
    ylim(-1.2, 1.2) +
    theme_void() +
    labs(title = substr(text_label, 1, 25)) +
    theme(plot.title = element_text(size = 8, hjust = 0.5))
  
  return(p)
}

# Créer des signatures géométriques
geometric_plots <- list()
#i<-1
for (i in 1:length(example_texts_idx)) {
  idx <- example_texts_idx[i]
  p <- create_geometric_signature(embeddings[idx, ],
                                  text_label = textes_francais[idx])
  geometric_plots[[i]] <- p
}

grid.arrange(grobs = geometric_plots, ncol = 2,
             top = "APPROCHE 4: Signatures Géométriques Uniques")

# ============================================================================
# APPROCHE 5: COMPARAISON VISUELLE (Différence entre deux textes)
# ============================================================================

cat("\n=== APPROCHE 5: DIFFÉRENCE VISUELLE ENTRE TEXTES ===\n\n")

compare_embeddings_visually <- function(emb1, emb2, label1, label2, size = 32) {
  # Calculer la différence
  diff <- emb1 - emb2
  
  # Créer l'image de différence
  n_values <- min(length(diff), size * size)
  values <- diff[1:n_values]
  
  if (length(values) < size * size) {
    values <- c(values, rep(0, size * size - length(values)))
  }
  
  img_matrix <- matrix(values, nrow = size, ncol = size, byrow = TRUE)
  
  # Visualiser
  df <- expand.grid(x = 1:ncol(img_matrix), y = 1:nrow(img_matrix))
  df$value <- as.vector(t(img_matrix))
  
  p <- ggplot(df, aes(x = x, y = y, fill = value)) +
    geom_tile() +
    scale_fill_gradient2(low = "blue", mid = "white", high = "red", 
                         midpoint = 0) +
    coord_equal() +
    theme_minimal() +
    theme(
      axis.text = element_blank(),
      axis.ticks = element_blank(),
      panel.grid = element_blank(),
      legend.position = "right"
    ) +
    labs(title = sprintf("'%s'\nvs\n'%s'", 
                         substr(label1, 1, 20), substr(label2, 1, 20)),
         x = "", y = "", fill = "Différence")
  
  return(p)
}

# Comparaisons intéressantes
comparison_plots <- list(
  compare_embeddings_visually(embeddings[1, ], embeddings[2, ],
                              textes_francais[1], textes_francais[2]),  # Chat vs Chien
  compare_embeddings_visually(embeddings[4, ], embeddings[7, ],
                              textes_francais[4], textes_francais[7]),  # Pizza vs Ordinateur
  compare_embeddings_visually(embeddings[10, ], embeddings[11, ],
                              textes_francais[10], textes_francais[11]) # Heureux vs Triste
)

grid.arrange(grobs = comparison_plots[1:3], ncol = 3,
             top = "APPROCHE 5: Différences Visuelles entre Embeddings")

# ============================================================================
# APPROCHE 6: ANIMATION (Evolution d'un embedding modifié)
# ============================================================================

cat("\n=== APPROCHE 6: MORPHING ENTRE CONCEPTS ===\n")
cat("Transition visuelle: 'chat' → 'ordinateur'\n\n")

# Créer une séquence de morphing
create_morphing_sequence <- function(emb_start, emb_end, label_start, label_end, 
                                     steps = 6, size = 24) {
  plots <- list()
  
  for (i in 1:steps) {
    # Interpolation linéaire
    alpha <- (i - 1) / (steps - 1)
    emb_current <- (1 - alpha) * emb_start + alpha * emb_end
    
    # Créer l'image
    n_values <- min(length(emb_current), size * size)
    values <- emb_current[1:n_values]
    
    if (length(values) < size * size) {
      values <- c(values, rep(0, size * size - length(values)))
    }
    
    img_matrix <- matrix(values, nrow = size, ncol = size, byrow = TRUE)
    img_matrix <- (img_matrix - min(img_matrix)) / 
      (max(img_matrix) - min(img_matrix))
    
    df <- expand.grid(x = 1:ncol(img_matrix), y = 1:nrow(img_matrix))
    df$value <- as.vector(t(img_matrix))
    
    title_text <- if (i == 1) label_start 
    else if (i == steps) label_end
    else sprintf("%.0f%%", alpha * 100)
    
    p <- ggplot(df, aes(x = x, y = y, fill = value)) +
      geom_tile() +
      scale_fill_viridis(option = "plasma") +
      coord_equal() +
      theme_void() +
      theme(legend.position = "none",
            plot.title = element_text(size = 8, hjust = 0.5)) +
      labs(title = title_text)
    
    plots[[i]] <- p
  }
  
  return(plots)
}

# Morphing de "chat" à "ordinateur"
morphing_plots <- create_morphing_sequence(
  embeddings[1, ], embeddings[7, ],
  "Chat", "Ordinateur",
  steps = 6, size = 24
)

grid.arrange(grobs = morphing_plots, ncol = 3,
             top = "APPROCHE 6: Morphing Visuel - 'Chat' vers 'Ordinateur'")

# ============================================================================
# RÉSUMÉ
# ============================================================================

cat("\n", paste(rep("=", 70), collapse = ""), "\n")
cat("RÉSUMÉ DES APPROCHES DE VISUALISATION\n")
cat(paste(rep("=", 70), collapse = ""), "\n\n")

cat("1. HEATMAP: Vue directe des valeurs d'embedding\n")
cat("   → Bon pour: Comprendre la distribution des activations\n\n")

cat("2. PATTERNS CIRCULAIRES: Visualisation polaire\n")
cat("   → Bon pour: Comparer plusieurs textes rapidement\n\n")

cat("3. ART GÉNÉRATIF: Images abstraites uniques\n")
cat("   → Bon pour: Créer des 'signatures visuelles' mémorables\n\n")

cat("4. SIGNATURES GÉOMÉTRIQUES: Formes caractéristiques\n")
cat("   → Bon pour: Identifier visuellement des concepts\n\n")

cat("5. DIFFÉRENCES: Comparaison directe\n")
cat("   → Bon pour: Voir ce qui distingue deux textes\n\n")

cat("6. MORPHING: Transitions animées\n")
cat("   → Bon pour: Comprendre l'espace sémantique\n\n")

cat("UTILISATION PRATIQUE:\n")
cat("→ Ces techniques transforment des vecteurs abstraits en images\n")
cat("→ Utile pour: Debugging, exploration, communication\n")
cat("→ Combine avec clustering pour créer un 'atlas visuel' de vos textes\n")