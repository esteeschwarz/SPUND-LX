# Token Distance Normalization Approaches in R
library(dplyr)
library(ggplot2)

# Sample data structure (replace with your actual data)
# df <- data.frame(
#   url = c("url1", "url1", "url2", "url2", "url3", "url3"),
#   category = c("obs", "ref", "obs", "ref", "obs", "ref"),
#   dist = c(5, 12, 8, 15, 3, 20),
#   range = c(100, 100, 150, 150, 80, 80)
# )

# ============================================================================
# 1. RELATIVE DISTANCE NORMALIZATION
# ============================================================================
df<-tdb4
normalize_relative <- function(df) {
  df %>%
    mutate(
      # Normalize by segment length
    #  relative_distance = dist / range,
      relative_distance = dist*mean(range,na.rm=T) / range,
      
      # As percentage of segment
      distance_pct = (dist / range) * 100
    )
}

# ============================================================================
# 2. CATEGORY-AWARE Z-SCORE NORMALIZATION
# ============================================================================

normalize_zscore <- function(df) {
  df %>%
    group_by(target) %>%
    mutate(
      category_mean = mean(dist, na.rm = TRUE),
      category_sd = sd(dist, na.rm = TRUE),
      distance_zscore = (dist - category_mean) / category_sd
    ) %>%
    ungroup()
}

# Alternative using scale() function
normalize_zscore_alt <- function(df) {
  df %>%
    group_by(target) %>%
    mutate(distance_zscore = as.numeric(scale(dist))) %>%
    ungroup()
}

# ============================================================================
# 3. DENSITY-BASED NORMALIZATION
# ============================================================================

normalize_density <- function(df) {
  # Calculate URL-level statistics
  url_stats <- df %>%
    group_by(url, target) %>%
    summarise(
      avg_distance = mean(dist, na.rm = TRUE),
      token_density = n() / first(range),  # assuming multiple tokens per URL
      range_first = first(range),
      .groups = 'drop'
    )
  
  # Merge back and normalize
  df %>%
    left_join(url_stats, by = c("url", "target")) %>%
    mutate(
      density_normalized = dist / (token_density * range_first)
    )
}

# ============================================================================
# 4. PERCENTILE-BASED COMPARISON
# ============================================================================

normalize_percentile <- function(df) {
  df %>%
    group_by(target) %>%
    mutate(
      distance_percentile = percent_rank(dist),
      distance_quantile = ntile(dist, 100)  # Convert to 1-100 scale
    ) %>%
    ungroup()
}

# ============================================================================
# 5. RATIO-BASED APPROACH
# ============================================================================

normalize_ratio <- function(df) {
  # Calculate category baselines
  category_stats <- df %>%
    group_by(target) %>%
    summarise(
      category_mean = mean(dist, na.rm = TRUE),
      category_median = median(dist, na.rm = TRUE),
      .groups = 'drop'
    )
  
  # Merge and calculate ratios
  df %>%
    left_join(category_stats, by = "target") %>%
    mutate(
      ratio_to_mean = dist / category_mean,
      ratio_to_median = dist / category_median
    )
}

# ============================================================================
# 6. COMPREHENSIVE NORMALIZATION FUNCTION
# ============================================================================

### this:
comprehensive_normalize <- function(df) {
  df %>%
    # Basic relative normalization
    mutate(
      relative_distance = dist*mean(range,na.rm=T) / range,
      distance_pct = (dist / range) * 100
    ) %>%
    
    # Category-specific z-scores
    group_by(target) %>%
    mutate(
      category_zscore = as.numeric(scale(dist)),
      category_percentile = percent_rank(dist)
    ) %>%
    ungroup() %>%
    
    # Ratio to category means
    left_join(
      df %>% 
        group_by(target) %>% 
        summarise(cat_mean = mean(dist, na.rm = TRUE), .groups = 'drop'),
      by = "target"
    ) %>%
    mutate(ratio_to_category_mean = dist / cat_mean) %>%
    select(-cat_mean)
}

# ============================================================================
# 7. COMPARISON AND ANALYSIS FUNCTIONS
# ============================================================================

compare_categories <- function(df_normalized) {
  # Compare different normalization approaches
  comparison_stats <- df_normalized %>%
    group_by(target) %>%
    summarise(
      # Original metrics
      mean_raw_distance = mean(dist, na.rm = TRUE),
      median_raw_distance = median(dist, na.rm = TRUE),
      
      # Normalized metrics
      mean_relative = mean(relative_distance, na.rm = TRUE),
      mean_zscore = mean(category_zscore, na.rm = TRUE),
      mean_percentile = mean(category_percentile, na.rm = TRUE),
      mean_ratio = mean(ratio_to_category_mean, na.rm = TRUE),
      
      # Variability
      sd_raw = sd(dist, na.rm = TRUE),
      sd_relative = sd(relative_distance, na.rm = TRUE),
      
      .groups = 'drop'
    )
  
  return(comparison_stats)
}

# Statistical significance test
test_category_differences <- function(df_normalized) {
  # T-test on normalized distances
  obs_distances <- df_normalized$relative_distance[df_normalized$target == "obs"]
  ref_distances <- df_normalized$relative_distance[df_normalized$target == "ref"]
  
  t_test_result <- t.test(obs_distances, ref_distances)
  
  # Wilcoxon test (non-parametric alternative)
  wilcox_result <- wilcox.test(obs_distances, ref_distances)
  
  list(
    t_test = t_test_result,
    wilcoxon = wilcox_result
  )
}

# ============================================================================
# 8. VISUALIZATION FUNCTION
# ============================================================================
plot_distance_comparison <- function(df_normalized) {
  # Create comparison plots
  p1 <- df_normalized %>%
    ggplot(aes(x = target, y = relative_distance, fill = target)) +
    geom_boxplot(alpha = 0.7) +
    geom_jitter(width = 0.2, alpha = 0.5) +
    labs(title = "Relative Distance by target",
         y = "Relative Distance (distance/range)",
         x = "target") +
    theme_minimal()
  p3 <-boxplot(relative_distance~target,df_normalized,outline=F)
  p2 <- df_normalized %>%
    ggplot(aes(x = target, y = category_zscore, fill = target)) +
    geom_boxplot(alpha = 0.7) +
    geom_jitter(width = 0.2, alpha = 0.5) +
    labs(title = "Z-Score Normalized Distance by target",
         y = "target-specific Z-score",
         x = "target") +
    theme_minimal()
  
  list(relative_plot = p1, zscore_plot = p2,boxplot=p3)
}

# ============================================================================
# 9. EXAMPLE USAGE
# ============================================================================

# Example workflow:
analyze_dists <- function(df) {
  # Apply comprehensive normalization
  df_normalized <- comprehensive_normalize(df)
  
  # Get comparison statistics
  stats <- compare_categories(df_normalized)
  
  # Test for significant differences
  tests <- test_category_differences(df_normalized)
  
  # Create visualizations
  plots <- plot_distance_comparison(df_normalized)
  
  # Return results
  list(
    normalized_data = df_normalized,
    comparison_stats = stats,
    statistical_tests = tests,
    plots = plots
  )
}

# ============================================================================
# Usage example:
### rm outliers
limit<-5000
m<-tdb4$dist>limit
sum(m,na.rm = T)
tdb5<-tdb4[!m,]
results <- analyze_dists(tdb5)
 print(results$comparison_stats)
 print(results$statistical_tests)
 results$plots$relative_plot
 results$plots$boxplot
 dfnorm<-results$normalized_data
 colnames(dfnorm)[colnames(dfnorm)=="dist"]<-"dist_abs"
 colnames(dfnorm)[grep("relative_dist",colnames(dfnorm))]<-"dist"
 # ============================================================================
 qltdf<-dfnorm
 results$plots$boxplot
 #boxplot(dist_rel~target,dfnorm,outline=F)
 