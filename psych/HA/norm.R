# Example
df <- data.frame(
  dist = runif(1000, 0, 500),     # token distance
  corpus = rep(c("A", "B"), each = 500),
  url_id = rep(1:100, each = 10),
  range = rep(runif(100, 100, 1000), each = 10)  # size of the URL range
)
library(dplyr)
df<-qltdf
colnames(df)[grep("target",colnames(df))]<-"corpus"
df_norm <- df %>%
  group_by(corpus, url_id) %>%
  mutate(
    dist_z = (dist - mean(dist, na.rm = TRUE)) / sd(dist, na.rm = TRUE),
    dist_scaled = dist / range  # values now in [0,1] relative to each URL’s size
    
  ) %>%
  ungroup()
df_norm <- df %>%
  group_by(corpus,url_id) %>%
  mutate(
    dist_z = (dist - mean(dist, na.rm = TRUE)) / sd(dist, na.rm = TRUE),
    dist_scaled = dist / range  # values now in [0,1] relative to each URL’s size
    
  ) %>%
  ungroup()
# df_norm <- df %>%
#   mutate(
#     dist_scaled = dist / range  # values now in [0,1] relative to each URL’s size
#   )
df_norm <- df_norm %>%
  group_by(corpus) %>%
  mutate(dist_scaled_z = scale(dist_scaled)[,1]) %>%
  ungroup()

library(ggplot2)

ggplot(df_norm, aes(x = dist_z, fill = corpus)) +
  geom_density(alpha = 0.5) +
  theme_minimal() +
  labs(title = "Normalized token distance distributions",
       x = "Z-normalized distance (per URL)",
       y = "Density")
ggplot(df_norm, aes(x = dist, fill = corpus)) +
  geom_density(alpha = 0.5) +
  theme_minimal() +
  labs(title = "Normalized token distance distributions",
       x = "Z-normalized distance (per URL)",
       y = "Density")
ggplot(dfa, aes(x = dist_rel_obs, fill = target)) +
  geom_density(alpha = 0.5) +
  theme_minimal() +
  labs(title = "Normalized token distance distributions",
       x = "Z-normalized distance (per URL)",
       y = "Density")
# Kolmogorov–Smirnov test (nonparametric)
ks.test(df_norm$dist_z[df_norm$corpus == "obs"],
        df_norm$dist_z[df_norm$corpus == "ref"])

# Or Mann–Whitney U (Wilcoxon rank-sum)
wilcox.test(dist_z ~ corpus, data = df_norm)
mean(df_norm$dist_scaled[df$corpus=="obs"])
mean(df_norm$dist_scaled[df$corpus=="ref"])
median(df_norm$dist_scaled[df$corpus=="obs"])
median(df_norm$dist_scaled[df$corpus=="ref"])
mean(df_norm$dist_scaled[df_norm$corpus=="obs"], trim=0.009)
mean(df_norm$dist_scaled[df_norm$corpus=="ref"], trim=0.009)
mean(qltdf$dist[qltdf$target=="obs"], trim=0.1)
mean(qltdf$dist[qltdf$target=="ref"], trim=0.1)
mean(df_norm$dist_scaled[df_norm$corpus=="ref"], trim=0.009)
median(qltdf$dist[qltdf$target=="obs"])
median(qltdf$dist[qltdf$target=="ref"])
mean(qltdf$dist[qltdf$target=="ref"], trim=0.1)


library(lme4)
library(lmerTest)
lm1<-lmer(dist_scaled ~ corpus*q + range + (1|url_id),df_norm)
summary(lm1)
boxplot(dist_scaled ~corpus, df_norm)
boxplot(dist_scaled~corpus,df_norm,outline=F,notch=T,varwidth=T)
