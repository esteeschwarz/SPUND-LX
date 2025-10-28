# Visualisation du processus de Stable Diffusion
# Installation des packages nécessaires si besoin
# install.packages(c("ggplot2", "gridExtra", "viridis"))

library(ggplot2)
library(gridExtra)
library(viridis)

# Fonction pour créer une image simple (un cercle)
create_circle_image <- function(size = 64) {
  img <- matrix(0, nrow = size, ncol = size)
  center <- size / 2
  radius <- size / 4
  
  for (i in 1:size) {
    for (j in 1:size) {
      dist <- sqrt((i - center)^2 + (j - center)^2)
      if (dist <= radius) {
        img[i, j] <- 1
      }
    }
  }
  return(img)
}

# Fonction d'ajout de bruit gaussien
add_noise <- function(image, noise_level) {
  noise <- matrix(rnorm(length(image), mean = 0, sd = noise_level), 
                  nrow = nrow(image), ncol = ncol(image))
  noisy_image <- image + noise
  return(noisy_image)
}

# Fonction pour simuler le débruitage (simplifié)
denoise_step <- function(noisy_image, original_image, strength = 0.3) {
  # Simulation simplifiée : on se rapproche progressivement de l'original
  denoised <- noisy_image + strength * (original_image - noisy_image)
  return(denoised)
}

# Fonction de visualisation d'une matrice comme image
plot_matrix <- function(mat, title) {
  df <- expand.grid(x = 1:ncol(mat), y = 1:nrow(mat))
  df$value <- as.vector(t(mat))
  
  ggplot(df, aes(x = x, y = y, fill = value)) +
    geom_tile() +
    scale_fill_viridis(option = "magma") +
    coord_equal() +
    theme_minimal() +
    theme(
      axis.text = element_blank(),
      axis.ticks = element_blank(),
      panel.grid = element_blank(),
      legend.position = "none"
    ) +
    labs(title = title, x = "", y = "")
}

# === PROCESSUS FORWARD : Ajout progressif de bruit ===
set.seed(42)
original <- create_circle_image(64)
steps_forward <- 5
noise_levels <- seq(0, 1.5, length.out = steps_forward)

forward_plots <- list()
forward_images <- list()

for (i in 1:steps_forward) {
  noisy_img <- add_noise(original, noise_levels[i])
  forward_images[[i]] <- noisy_img
  forward_plots[[i]] <- plot_matrix(noisy_img, 
                                    paste0("Forward t=", i, " (σ=", 
                                           round(noise_levels[i], 2), ")"))
}

# === PROCESSUS REVERSE : Débruitage progressif ===
reverse_plots <- list()
current_img <- forward_images[[steps_forward]]  # On part du bruit maximal

for (i in steps_forward:1) {
  reverse_plots[[steps_forward - i + 1]] <- plot_matrix(
    current_img, 
    paste0("Reverse t=", steps_forward - i + 1)
  )
  # Débruitage progressif
  if (i > 1) {
    current_img <- denoise_step(current_img, original, strength = 0.4)
  }
}

# Affichage du processus forward
cat("=== PROCESSUS FORWARD (Ajout de bruit) ===\n")
grid.arrange(grobs = forward_plots, ncol = 3, 
             top = "Stable Diffusion - Processus Forward")

# Affichage du processus reverse
cat("\n=== PROCESSUS REVERSE (Débruitage) ===\n")
grid.arrange(grobs = reverse_plots, ncol = 3,
             top = "Stable Diffusion - Processus Reverse")

# === VISUALISATION DE L'ÉVOLUTION DU BRUIT ===
noise_evolution <- data.frame(
  step = 1:steps_forward,
  noise_level = noise_levels,
  process = "Forward"
)

noise_evolution_reverse <- data.frame(
  step = 1:steps_forward,
  noise_level = rev(noise_levels),
  process = "Reverse"
)

noise_df <- rbind(noise_evolution, noise_evolution_reverse)

p_noise <- ggplot(noise_df, aes(x = step, y = noise_level, color = process)) +
  geom_line(size = 1.5) +
  geom_point(size = 3) +
  scale_color_manual(values = c("Forward" = "#E63946", "Reverse" = "#06FFA5")) +
  theme_minimal() +
  labs(
    title = "Niveau de bruit au cours du processus de diffusion",
    x = "Étape (t)",
    y = "Niveau de bruit (σ)",
    color = "Processus"
  ) +
  theme(legend.position = "bottom")

print(p_noise)

# === COMPARAISON ORIGINAL VS RECONSTRUCTION ===
comparison_plots <- list(
  plot_matrix(original, "Image Originale"),
  plot_matrix(forward_images[[steps_forward]], "Bruit Pur (t=T)"),
  plot_matrix(current_img, "Reconstruction (t=0)")
)

grid.arrange(grobs = comparison_plots, ncol = 3,
             top = "Comparaison : Original → Bruit → Reconstruction")

cat("\n=== EXPLICATION ===\n")
cat("1. FORWARD: L'image originale est progressivement bruitée\n")
cat("2. REVERSE: Le modèle apprend à retirer le bruit étape par étape\n")
cat("3. En pratique, Stable Diffusion utilise un U-Net entraîné pour prédire le bruit\n")
cat("4. Le texte (via CLIP) guide le processus de débruitage vers l'image désirée\n")