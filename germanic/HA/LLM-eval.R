library(lme4)
library(tidyverse)

# --- Load & prepare ---
# df <- read.csv("your_data.csv") %>%
dlim<-"2024-01-01"
##################
load(paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/huening/tok.r3.RData"))
df<-tok.r3%>%
# tok.r3%>%
  mutate(
    post      = as.integer(post),               # TRUE=1, FALSE=0
    lemma     = factor(lemma),
    target    = factor(target),
    date      = as.numeric(as.Date(date))-as.numeric(as.Date(dlim)),      # days since epoch
    # date_scaled = scale(date)[,1]               # helps convergence
    date_scaled = date/max(date)
  )
df<-tok.r3%>%
  # tok.r3%>%
  mutate(
  #  post      = as.integer(post),               # TRUE=1, FALSE=0
    lemma     = factor(lemma),
    target    = factor(target),
    date      = as.numeric(as.Date(date))-as.numeric(as.Date(dlim)),      # days since epoch
    # date_scaled = scale(date)[,1]               # helps convergence
    date_scaled = date/max(date)
  )

# df <- df %>%
#   add_count(lemma, name = "freq")
df_agg <- df %>%
  count(lemma, date, target)
m<-lmer(n~target+date+(1|lemma),df_agg)
summary(m)
write.csv (df_agg[sample(length(df_agg$date),50),],"~/Documents/GitHub/temp/dfsample.csv")

ds<-1:25
ds/max(ds)
scale(ds/max(ds),scale = T)
?scale
df <- df %>%
  group_by(lemma) %>%
  filter(n() >= 50) %>%
  ungroup()
# --- Fit model ---
m <- glmer(
  date_scaled ~ lemma + (1|target),
  data    = df,
  family  = binomial,
  control = glmerControl(optimizer = "bobyqa", optCtrl = list(maxfun = 2e5))
)
library(fixest)
m<-lm(date_scaled~target,df)
reference_date <- as.numeric(as.Date("2025-01-01"))
df$date_scaled <- as.numeric(as.Date(df$date)) - reference_date
m<-lmer(date_scaled~target+(1|lemma),df)
fixef(m)
m <- feglm(
  target~date_scaled + 1 | lemma,
  data   = df,
  family = binomial
)

# Extract lemma fixed effects
lemma_fe <- fixef(m)$lemma
sort(lemma_fe, decreasing = TRUE) |> head(20)
summary(m)

# --- Extract lemma typicality ---
lemma_effects <- broom.mixed::tidy(m, effects = "fixed", conf.int = TRUE) %>%
  filter(str_detect(term, "^lemma")) %>%
  mutate(lemma = str_remove(term, "^lemma")) %>%
  arrange(desc(estimate))

# Top lemmas for post=TRUE
head(lemma_effects, 20)

# Top lemmas for post=FALSE
tail(lemma_effects, 20)

###################################################
library(tidyverse)

#df_both <- read.csv("dfsample.csv")
df_both<-df_agg
# --- Step 1: total n per lemma per target ---
lemma_target <- df_both %>%
  group_by(lemma, target) %>%
  summarise(n = sum(n), .groups = "drop")

# --- Step 2: compute gpt preference score ---
lemma_pref <- lemma_target %>%
  group_by(lemma) %>%
  summarise(
    n_gpt   = sum(n[target == "gpt"]),
    n_human = sum(n[target == "human"]),
    n_total = sum(n)
  ) %>%
  mutate(
    prop_gpt   = n_gpt / n_total,          # share of this lemma that comes from gpt
    baseline   = sum(df_both$target == "gpt") / nrow(df_both),  # overall gpt share
    # log-odds: positive = gpt-preferred, negative = human-preferred
    log_odds   = log((n_gpt + 0.5) / (n_human + 0.5))
  ) %>%
  arrange(desc(log_odds))

gpt_lemmas <- lemma_pref %>%
  filter(n_total >= 10) %>%       # drop hapax / very rare
  slice_max(log_odds, n = 50)     # top 50 gpt-preferred lemmas
############################
gpt_lemmas <- lemma_pref %>%
  filter(n_gpt >= 10) %>%       # drop hapax / very rare
  slice_max(log_odds, n = 50)     # top 50 gpt-preferred lemmas
#############################
df_human <- df_both %>%
  filter(target == "human",
         lemma %in% gpt_lemmas$lemma)

# now run the per-lemma Poisson trend as before
lemma_trends <- df_human %>%
  group_by(lemma) %>%
  filter(n() >= 3) %>%
  summarise(
    slope  = coef(glm(n ~ date, family = poisson))[["date"]],
    mean_n = mean(n),
    n_obs  = n()
  ) %>%
  left_join(gpt_lemmas %>% select(lemma, log_odds), by = "lemma") %>%
  arrange(desc(slope))


library(tidyverse)
df_sf<-df
# df <- read.csv("dfsample.csv") %>%
#   filter(target == "human")
df<-df_agg%>%filter(target=="human")
# --- Fit per-lemma Poisson regression, extract date slope ---
lemma_trends <- df %>%
  group_by(lemma) %>%
  filter(n() >= 3) %>%               # need enough time points per lemma
  summarise(
    slope = coef(glm(n ~ date, family = poisson))[["date"]],
    mean_n = mean(n),
    n_obs  = n()
  ) %>%
  arrange(desc(slope))

# --- Top increasing lemmas ---
head(lemma_trends, 20)

# --- Plot: slope vs. mean frequency (bubble = n_obs) ---
lemma_trends %>%
  slice_max(abs(slope), n = 40) %>%
  ggplot(aes(x = slope, y = reorder(lemma, slope), size = mean_n)) +
  geom_point(aes(color = slope > 0), alpha = 0.7) +
  scale_color_manual(values = c("TRUE" = "#2166ac", "FALSE" = "#d6604d"),
                     labels = c("decreasing", "increasing")) +
  labs(
    title = "Lemma trends over time (human corpus)",
    x = "Poisson slope on date (0 = reference point)",
    y = NULL, size = "mean freq", color = NULL
  ) +
  theme_minimal()



##################
lemma_trends %>%
  ggplot(aes(x = log_odds, y = slope, label = lemma)) +
  geom_vline(xintercept = 0, linetype = "dashed", color = "grey60") +
  geom_hline(yintercept = 0, linetype = "dashed", color = "grey60") +
  geom_point(aes(size = mean_n), alpha = 0.6, color = "#2166ac") +
  ggrepel::geom_text_repel(size = 3) +
  labs(
    x = "GPT preference (log-odds)",
    y = "Trend in human corpus (Poisson slope)",
    title = "GPT-typical lemmas rising in human speech?",
    subtitle = "Top-right quadrant = gpt-preferred AND increasing in human corpus"
  ) +
  theme_minimal()

lemma_trends <- df_human %>%
  group_by(lemma) %>%
  filter(n() >= 3) %>%
  summarise(
    model  = list(glm(n ~ date, family = poisson)),
    .groups = "drop"
  ) %>%
  mutate(
    slope    = map_dbl(model, ~ coef(.x)[["date"]]),
    p_value  = map_dbl(model, ~ summary(.x)$coefficients["date", "Pr(>|z|)"]),
    z_value  = map_dbl(model, ~ summary(.x)$coefficients["date", "z value"])
  ) %>%
  select(-model) %>%
  arrange(p_value)

gpt_lemmas_rising <- lemma_trends %>%
  filter(slope > 0, p_value < 0.05)
sum()
##########
### 16113.
###################################################
# --- Aggregate: n per lemma × post × target ---
###################################################
df_t <- df_sf %>%
  count(lemma, post, target)
# --- total tokens per post × target condition ---
totals <- df_t %>%
  group_by( post,target)%>% 

  summarise(total = sum(n), .groups = "drop")

# --- total tokens per target (across all dates/post) ---
totals_target <- df_both %>%
  group_by(target) %>%
  summarise(total_target = sum(n), .groups = "drop")
df_both<-df_agg
# --- Step 1: total n per lemma per target ---
lemma_target <- df_both %>%
  group_by(lemma, target) %>%
  summarise(n = sum(n), .groups = "drop")
df_human <- df_both %>%
  filter(target == "human",
         lemma %in% gpt_lemmas$lemma)


# --- relative frequency per lemma × target ---
lemma_pref <- df_both %>%
  group_by(lemma, target) %>%
  summarise(n = sum(n), .groups = "drop") %>%
  left_join(totals_target, by = "target") %>%
  mutate(rel_freq = n / total_target) %>%
  select(lemma, target, n, rel_freq) %>%
  pivot_wider(
    names_from  = target,
    values_from = c(n, rel_freq),
    values_fill = 0
  ) %>%
  mutate(
    # log-odds on relative frequencies + smoothing
    log_odds = log((rel_freq_gpt   + 1e-9) /
                     (rel_freq_human + 1e-9))
  ) %>%
  arrange(desc(log_odds))
gpt_lemmas <- lemma_pref %>%
  filter(n_gpt >= 10) %>%       # drop hapax / very rare
  slice_max(log_odds, n = 50)     # top 50 gpt-preferred lemmas
#################################################
m<-lemma_pref$n_human==0
sum(m)
### chk:
m2<-lemma_pref$lemma[m]%in%df_sf$lemma[df_sf$target=="human"]
sum(m2)
### TRUE (=0)
#############
head(lemma_pref$lemma,50)
m<-grepl("^wichtige[^r]",df_sf$lemma)
sum(m)
unique(df_sf$lemma[m])
df_sf$lemma[m]<-"wichtig"
m2<-grepl("^wichtige$",df_sf$lemma)
sum(m2)
unique(df_sf$lemma[m2])
df_sf$lemma[m2]<-"wichtig"
#########################
# --- join totals, compute relative frequency ---
df_agg <- df_sf %>%
  count(lemma, post, target) %>%
  left_join(totals, by = c("post", "target")) %>%
  mutate(rel_freq = n / total)         # proportion of all tokens in that slice
df_agg$post<-ifelse(df_agg$post==1,TRUE,FALSE)
unique(df_agg$post)
lemma_post_trends <- df_agg %>%
  filter(target == "human") %>%
  group_by(lemma) %>%
  filter(sum(n) >= 10, n() >= 2) %>%
  summarise(
    model   = list(glm(n ~ post + offset(log(total)), family = poisson)),
    .groups = "drop"
  ) %>%
  mutate(
    slope   = map_dbl(model, ~ coef(.x)[["postTRUE"]]),
    p_value = map_dbl(model, ~ summary(.x)$coefficients["postTRUE", "Pr(>|z|)"]),
    z_value = map_dbl(model, ~ summary(.x)$coefficients["postTRUE", "z value"])
  ) %>%
  select(-model)
################
# --- Filter to human, fit per-lemma logistic-style Poisson ---
unique(df_agg$post)
lemma_post_trends <- df_agg %>%
  filter(target == "human") %>%
  group_by(lemma) %>%
  filter(sum(n) >= 10, n() >= 2) %>%        # needs obs in both post conditions
  summarise(
    model   = list(glm(n ~ post, family = poisson)),
    .groups = "drop"
  ) %>%
  mutate(
    slope   = map_dbl(model, ~ coef(.x)[["postTRUE"]]),
    p_value = map_dbl(model, ~ summary(.x)$coefficients["postTRUE", "Pr(>|z|)"]),
    z_value = map_dbl(model, ~ summary(.x)$coefficients["postTRUE", "z value"])
  ) %>%
  select(-model) %>%
  arrange(p_value)


#library(tidyverse)
#library(ggrepel)

lemma_post_trends %>%
  left_join(gpt_lemmas %>% select(lemma, log_odds), by = "lemma") %>%
  filter(!is.na(log_odds)) %>%
  mutate(
    significant = p_value < 0.05,
    label       = if_else(significant & slope > 0 & log_odds > 1, lemma, NA_character_)
  ) %>%
  ggplot(aes(x = log_odds, y = slope)) +
  geom_vline(xintercept = 0, linetype = "dashed", color = "grey60") +
  geom_hline(yintercept = 0, linetype = "dashed", color = "grey60") +
  geom_point(aes(size = -log10(p_value),        # bigger = more significant
                 color = significant & slope > 0 & log_odds > 0),
             alpha = 0.6) +
  ggrepel::geom_text_repel(aes(label = label), size = 3, max.overlaps = 20) +
  scale_color_manual(values = c("TRUE" = "#2166ac", "FALSE" = "grey70"),
                     labels = c("other", "gpt-typical & rising post-onset")) +
  scale_size_continuous(range = c(1, 6)) +
  labs(
    x     = "GPT preference (log-odds)",
    y     = "Post-onset rate change (Poisson coefficient)",
    title = "GPT-typical lemmas rising after onset in human corpus",
    subtitle = "Top-right quadrant = gpt-preferred AND more frequent post-onset\nPoint size = statistical significance (−log10 p)\n(only TRUE lemmas are labeled)",
    color = NULL,
    size  = "−log10(p)"
  ) +
  theme_minimal()
dfs<-df_agg[df_agg$target=="human",]
dfs<-df_agg
#dfs$in.gp<-dfs$lemma%in%gpt_lemmas$lemma
dfs$gp <- lemma_pref$log_odds[match(dfs$lemma,lemma_pref$lemma)]
#dfa.pos$lemma[match(tokens.r$word, dfa.pos$token)]
#save(dfs,file = paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/huening/dfs.RData"))
lm1<-lmer(rel_freq~post*gp+(1|lemma)+(1|target),dfs)
summary(lm1)
lm2<-lm(rel_freq~post,dfs)
summary(lm2)
