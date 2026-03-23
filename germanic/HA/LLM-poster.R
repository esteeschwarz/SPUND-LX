# 2025023(17.04)
# 16133.poster.eval-script(LLM-eval.R excerpt)
##############################################

### df_agg in plist.RData
load(paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/germanic/HA/drafts/plist2.RData"))
df_agg<-plist$df_agg
lemma_post_trends.off <- df_agg %>%
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

totals <- df_t %>%
  group_by( post,target)%>% 
  
  summarise(total = sum(n), .groups = "drop")

# --- total tokens per target (across all dates/post) ---
df_both<-df_t
totals_target <- df_both %>%
  group_by(target) %>%
  summarise(total_target = sum(n), .groups = "drop")
# --- Step 1: total n per lemma per target ---
lemma_target <- df_both %>%
  group_by(lemma, target) %>%
  summarise(n = sum(n), .groups = "drop")
# df_human <- df_both %>%
#   filter(target == "human",
#          lemma %in% gpt_lemmas$lemma)


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

#library(tidyverse)
#library(ggrepel)
library(ggplot2)
lemma_post_trends.off %>%
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
#dfs<-df_agg[df_agg$target=="human",]
dfs<-df_agg
#dfs$in.gp<-dfs$lemma%in%gpt_lemmas$lemma
#lemma_pref<-plist$lemma_pref
# gpt_lemmas <- lemma_pref %>%
#   filter(n_gpt >= 10) %>%       # drop hapax / very rare
#   slice_max(log_odds, n = 50)     # top 50 gpt-preferred lemmas
dfs$gp <- lemma_pref$log_odds[match(dfs$lemma,lemma_pref$lemma)]
#dfa.pos$lemma[match(tokens.r$word, dfa.pos$token)]
#save(dfs,file = paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/huening/dfs.RData"))
### not normalised:
lm1<-lmer(rel_freq~post+gp+(1|lemma),dfs)
summary(lm1)
lm2<-lm(rel_freq~post+gp,dfs)
summary(lm2)
### not real...
###############
## 16133.
gpt_lemmas
m<-df_agg$lemma%in%gpt_lemmas$lemma
df_p.post <- df_agg[m,] %>%
  filter(target == "human"&post) %>%
  group_by(lemma)
df_p.pre <- df_agg[m,] %>%
  filter(target == "human"&!post) %>%
  group_by(lemma)
#mtp<-df_p.post$rel_freq[match(df_p.post$lemma,df_p.pre$lemma)]>df_p.pre$rel_freq[match(df_p.pre$lemma,df_p.post$lemma)]
#mtc<-df_p.post$lemma[match(df_p.post$lemma,df_p.pre$lemma)]==df_p.pre$lemma[match(df_p.pre$lemma,df_p.post$lemma)]
#sum(mtp)
#head(mtc)
#mtc
sum(df_p.post$lemma==df_p.pre$lemma)==length(gpt_lemmas$lemma)
### TRUE, true matrix
mg<-df_p.post$lemma%in%gpt_lemmas$lemma
mg<-df_p.post$rel_freq>df_p.pre$rel_freq
sum(df_p.post$rel_freq[mg])-sum(df_p.pre$rel_freq[mg])
df_lg<-df_p.post[mg,]
df_lg$lemma
lg.diff<-sum(df_p.post$rel_freq[mg])-sum(df_p.pre$rel_freq[mg])
lg.diff # 0.003937 relative freq increase of gpt lemma in post corpus
df_lgc<-cbind(df_p.post,rel_f.pre=df_p.pre$rel_freq)%>%mutate(
  diff = rel_freq - rel_f.pre,
  post.increase = rel_freq > rel_f.pre
)
m<-df_lgc$post.increase
lgm<-df_lgc$diff[m]>(mean(df_lgc$diff[m]))
sum(lgm)
df_lgc.x<-df_lgc[which(m)[lgm],]
par(las=2.5)
barplot(diff~as.character(lemma),df_lgc.x,xlab="",main="lemma rel. freq. absolute increase pre-post onset")
#boxplot(rel_freq~post,df_agg[df_agg$target=="human"&df_agg$lemma%in%gpt_lemmas$lemma,],outline=F,notch=T)
par(las=1)
pb<-boxplot(rel_freq~post,dfs[dfs$target=="human"&dfs$lemma%in%gpt_lemmas$lemma,],outline=F,notch=T,main="GPT preferred lemma rel. freq. pre vs. post (TRUE) onset corpus")
pb$stats
### normalize freq
corpus_sizes <- df_agg |>
  distinct(lemma, post) |>        # one row per document
  count(post, name = "corpus_size")  # total tokens per condition

# Or if each row IS a token:
# corpus_sizes <- df |>
#   count(post, name = "corpus_size")

lemma_counts <- df_agg

df_lg.norm<-lemma_counts |>
  left_join(corpus_sizes, by = "post") |>
  mutate(freq_pmw = n / corpus_size * 1e6)
pb<-boxplot(freq_pmw~post,df_lg.norm,outline=F,notch=T)
pb$stats
df_lg.norm$gp <- lemma_pref$log_odds[match(df_lg.norm$lemma,lemma_pref$lemma)]

lm1<-lmer(freq_pmw~post+gp+(1|lemma),df_lg.norm)
summary(lm1)
lm2<-lm(freq_pmw~post+gp,df_lg.norm)
summary(lm2)

#load("~/Documents/GitHub/SPUND-LX/germanic/HA/drafts/plist.RData")
# plist$totals<-totals
# plist$df_agg<-df_agg
# plist$lemma_pref<-lemma_pref

# save(plist,file="plist2.RData")

