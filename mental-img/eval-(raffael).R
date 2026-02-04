# Group 2: Protokoll
# 
# 
# * used English speaking corpus
# * generated CLIP scores 
# 
# 
# 
# 
# 
# 
# R- Script: 
  install.packages("arrow")
library(arrow)
df <- read_parquet("clip_results.parquet")
str(df)
library(dplyr)
library(ggplot2)
df$group <- factor(df$group, levels = c("hc", "scz"))
df$filename <- factor(df$filename)
anyNA(df)


ggplot(df, aes(x = mean_clip, fill = group)) +
  geom_density(alpha = 0.4) +
  labs(
    x = "Mean CLIP score",
    y = "Density",
    fill = "Group"
  ) +
  theme_minimal()














install.packages("lme4")
install.packages("lmerTest")
library(lme4)
library(lmerTest)


model <- lmer(
  mean_clip ~ group + (1 | filename),
  data = df
)


summary(model)
# 
# 
# -> Nun: z-Standardisierung der Koeffizienten zwecks Vergleichbarkeit


#Z-Standardisation for mean_clip
df$mean_clip_z <- scale(df$mean_clip)


#Mixed Model with Z-Standardised mean_clip_z


model_z <- lmer(
  mean_clip_z ~ group + (1 | filename),
  data = df
)


summary(model_z)

# 
# -> Hr. Nenchev übers WE: generiert CLIP-scores für den deutschen Corpus (dort kann man auch Symptomatiken betrachten) 
# - voraussichtlich nächste Woche fertige Ergebnisse
# 
# 
# SKRIPT 2.0
# 

#install.packages("readr")
library(readr)
df <- read_csv("~/Desktop/RR/Master/11_BUA Modules & Research/Mental Images & Schizophrenia (Charité Berlin)/00_DATA/clip_results.csv")


#install.packages("dplyr")
#install.packages("ggplot2")


library(dplyr)
library(ggplot2)
df$group <- factor(df$group, levels = c("hc", "scz"))
df$filename <- factor(df$filename)
anyNA(df)


ggplot(df, aes(x = mean_clip, fill = group)) +
  geom_density(alpha = 0.4) +
  labs(
    x = "Mean CLIP score",
    y = "Density",
    fill = "Group"
  ) +
  theme_minimal()


#install.packages("lme4")
#install.packages("lmerTest")
library(lme4)
library(lmerTest)


model <- lmer(
  mean_clip ~ group + (1 | filename),
  data = df
)


summary(model)




#Z-Standardisation for mean_clip
df$mean_clip_z <- scale(df$mean_clip)


#Mixed Modell with Z-Standardised mean_clip_z


model_z <- lmer(
  mean_clip_z ~ group + (1 | filename),
  data = df
)


summary(model_z)


# WMatrix-full-clinical-raw.txt ist extrem groß (1843 Einträge) und beinhaltet lediglich Wiederholungen


df_no_big <- df %>% filter(filename != "WMatrix-full-clinical-raw.txt")


lmer(mean_clip_z ~ group + (1 | filename), data = df_no_big)


ggplot(df_no_big, aes(x = mean_clip, fill = group)) +
  geom_density(alpha = 0.4) +
  labs(
    x = "Mean CLIP score",
    y = "Density",
    fill = "Group"
  ) +
  theme_minimal()


# Validierung der Personenebene


df_pers <- aggregate(mean_clip ~ filename + group, data = df_no_big, FUN = mean)


t.test(mean_clip ~ group, data = df_pers)


library(ggplot2)


ggplot(df_pers, aes(x = group, y = mean_clip)) +
  geom_point(position = position_jitter(width = 0.1), size = 2) +
  geom_boxplot(alpha = 0.3) +
  labs(y = "Mean CLIP score (per interview)")


# Effektgrößen auf Personenebene


# Cohen's d
m1 <- mean(df_pers$mean_clip[df_pers$group == "hc"])
m2 <- mean(df_pers$mean_clip[df_pers$group == "scz"])
sd_pooled <- sqrt((sd(df_pers$mean_clip[df_pers$group == "hc"])^2 +
                     sd(df_pers$mean_clip[df_pers$group == "scz"])^2) / 2)


d <- (m2 - m1) / sd_pooled
d


# Varianzvergleich auf Personen ebene


df_pers_var <- aggregate(var_clip ~ filename + group, data = df_no_big, FUN = mean)


t.test(var_clip ~ group, data = df_pers_var)


ggplot(df_pers_var, aes(x = group, y = var_clip)) +
  geom_point(position = position_jitter(width = 0.1), size = 2) +
  geom_boxplot(alpha = 0.3) +
  labs(y = "Variance of CLIP score within interview")




# Varianzvergleich auf Chunk ebene


t.test(var_clip ~ group, data = df_no_big)


ggplot(df_no_big, aes(x = group, y = var_clip)) +
  geom_point(position = position_jitter(width = 0.1), size = 2) +
  geom_boxplot(alpha = 0.3) +
  labs(y = "Variance of CLIP score within interview")


# Verlaufsanalyse


df_no_big$chunk_index <- ave(df_no_big$mean_clip,
                             df_no_big$filename,
                             FUN = seq_along)


df_no_big$chunk_rel <- ave(df_no_big$chunk_index,
                           df_no_big$filename,
                           FUN = function(x) x / max(x))


library(ggplot2)


ggplot(df_no_big, aes(x = chunk_rel, y = mean_clip, color = group)) +
  geom_smooth(se = TRUE) +
  labs(x = "Relative Position in Interview",
       y = "Mean CLIP score")


library(lme4)
library(lmerTest)


model_time <- lmer(mean_clip ~ group * chunk_rel + (1 | filename),
                   data = df_no_big)


summary(model_time)


# Kontrolle nicht-linearität


df_no_big$chunk_rel2 <- df_no_big$chunk_rel^2


lmer(mean_clip ~ group * (chunk_rel + chunk_rel2) + (1 | filename),
     data = df_no_big)


summary(lmer(mean_clip ~ group * (chunk_rel + chunk_rel2) + (1 | filename),
             data = df_no_big))


#Modellvergleich


model_lin <- lmer(mean_clip ~ group * chunk_rel + (1 | filename),
                  data = df_no_big)


model_quad <- lmer(mean_clip ~ group * (chunk_rel + chunk_rel2) + (1 | filename),
                   data = df_no_big)


anova(model_lin, model_quad)


#Random Slopes + Varianzvergleich der Verläufe


model_rs <- lmer(mean_clip ~ group * chunk_rel + (chunk_rel | filename),
                 data = df_no_big)
summary(model_rs)


model_rs0 <- lmer(mean_clip ~ group * chunk_rel + (1 | filename),
                  data = df_no_big)


anova(model_rs0, model_rs)


#Slope-Extraction


slopes <- coef(model_rs)$filename
slopes$filename <- rownames(slopes)


slopes <- merge(slopes,
                unique(df_no_big[, c("filename","group")]),
                by = "filename")


#Mittelwert Steigung
t.test(chunk_rel ~ group, data = slopes)
#Varianz Steigung
var.test(chunk_rel ~ group, data = slopes)
#Levene Test
#install.packages("car")
library(car)
leveneTest(chunk_rel ~ group, data = slopes)


#GAMM Modellierung


#install.packages("mgcv")
library(mgcv)


gamm_mod <- gamm(mean_clip ~ group + s(chunk_rel, by = group),
                 random = list(filename = ~1),
                 data = df_no_big)
summary(gamm_mod$gam)




#Gruppenspezifische GAMM-Verläufe mit Konfidenzbändern


library(mgcv)
library(ggplot2)


pred <- expand.grid(
  chunk_rel = seq(0, 1, length.out = 200),
  group = c("hc", "scz")
)


pred$fit <- predict(gamm_mod$gam, newdata = pred, type = "response", se.fit = TRUE)$fit
pred$se  <- predict(gamm_mod$gam, newdata = pred, type = "response", se.fit = TRUE)$se.fit


pred$upper <- pred$fit + 1.96 * pred$se
pred$lower <- pred$fit - 1.96 * pred$se


ggplot() +
  geom_point(data = df_no_big,
             aes(x = chunk_rel, y = mean_clip, color = group),
             alpha = 0.05, size = 0.8) +
  geom_ribbon(data = pred,
              aes(x = chunk_rel, ymin = lower, ymax = upper, fill = group),
              alpha = 0.2) +
  geom_line(data = pred,
            aes(x = chunk_rel, y = fit, color = group),
            linewidth = 1.3) +
  labs(x = "Relative Position in Interview",
       y = "Mean CLIP score") +
  theme_minimal()


# Individuelle Spaghetti Plots


set.seed(1)
ids <- sample(unique(df_no_big$filename), 10)


ggplot(subset(df_no_big, filename %in% ids),
       aes(chunk_rel, mean_clip, group = filename, color = group)) +
  geom_line(alpha = 0.6) +
  facet_wrap(~ group) +
  labs(x = "Relative Position", y = "Mean CLIP score") +
  theme_minimal()


#Oszillation-Visualisierung


#install.packages("gratia")
library(gratia)


der <- derivatives(gamm_mod$gam, select = "s(chunk_rel):groupscz")


draw(der)


# Tasks today (28.01.2026):
#   -formulate hypothesis
# -materials and methods section (sketch): justify why we’re using clip, why not sth else
#   - 2 clip models are being used as well as stable diffusion
# 
# 
# Model1: text -> diff model -> image
# Model2: vector of text and image similarity = clip score (this is what is calculated)
# “there’s a competing approach which we’re not using because…”
# 
# 
# corpus: describe the participants, language, mention that/how we translated the German corpus
# 
# 
# limitations: translation of german corpus
# 
# 
# HW: write a one-pager including:
#   * this is our hypothesis
# * methods
# * models
# * corpus and how we generated it
# * statistics
# * add justifications wherever possible         
# 
# 
# 
# 
# new data (it’s the german corpus we used last week just more variables added): 
#   * PANS 30 items (complete)
# * complete PANS Score: overall symptom severity 
# * there are no PANS scores for hc: compare positive to negative scz
# * how many variables can you put into a model? -> for us: 5-6 predictors per model (because we have ~65 ppl, rule of thumb 1 predictor per 10 observations)
# * use the following predictors: gender, age, group, cognitive abilities, years of education & start with composite score 
# * think of how to deal with NAs
# 
# 
# Monday evtl. zoom call to discuss data
# till next time run analysis