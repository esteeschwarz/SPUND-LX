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
# target-Specific Length Normalization
library(dplyr)

# ============================================================================
# target-SPECIFIC NORMALIZATION FUNCTION
# ============================================================================

normalize_by_target_length <- function(df, reference_target = "obs") {
  # Calculate mean URL length for each target
  target_means <- df %>%
    group_by(target) %>%
    summarise(mean_range = mean(range, na.rm = TRUE), .groups = 'drop')
  
  # Get reference target mean (default: obs)
  ref_mean_length <- target_means$mean_range[target_means$target == reference_target]
  
  if(length(ref_mean_length) == 0) {
    stop(paste("Reference target", reference_target, "not found in data"))
  }
  
  # Method 1: Standardize to reference target mean
  df_norm1 <- df %>%
    mutate(
      normalized_dist_to_ref = dist * (ref_mean_length / range)
    )
  
  # Method 2: Standardize each target to its own mean (within-target normalization)
  df_norm2 <- df %>%
    left_join(target_means, by = "target") %>%
    mutate(
      normalized_dist_within_cat = dist * (mean_range / range)
    )
  
  # Method 3: Your suggested approach - standardize to target target means
  df_final <- df_norm1 %>%
    left_join(target_means, by = "target") %>%
    mutate(
      # Add the within-target version
      normalized_dist_within_cat = dist * (mean_range / range),
      
      # Add target mean info for reference
      target_mean_length = mean_range
    ) %>%
    select(-mean_range)  # clean up duplicate column
  
  return(list(
    data = df_final,
    target_means = target_means,
    reference_used = reference_target,
    ref_mean_length = ref_mean_length
  ))
}

# ============================================================================
# COMPARISON FUNCTION FOR target-SPECIFIC NORMALIZATION
# ============================================================================

compare_target_normalized <- function(df, reference_target = "obs") {
  # Get normalized data
  norm_result <- normalize_by_target_length(df, reference_target)
  df_norm <- norm_result$data
  
  # Compare different normalization approaches
  comparison <- df_norm %>%
    group_by(target) %>%
    summarise(
      # Original values
      raw_mean = mean(dist, na.rm = TRUE),
      raw_median = median(dist, na.rm = TRUE),
      raw_sd = sd(dist, na.rm = TRUE),
      
      # Normalized to reference target length
      norm_to_ref_mean = mean(normalized_dist_to_ref, na.rm = TRUE),
      norm_to_ref_median = median(normalized_dist_to_ref, na.rm = TRUE),
      norm_to_ref_sd = sd(normalized_dist_to_ref, na.rm = TRUE),
      
      # Normalized within target (to own mean length)
      norm_within_mean = mean(normalized_dist_within_cat, na.rm = TRUE),
      norm_within_median = median(normalized_dist_within_cat, na.rm = TRUE),
      norm_within_sd = sd(normalized_dist_within_cat, na.rm = TRUE),
      
      # URL length info
      mean_range = mean(range, na.rm = TRUE),
      
      n = n(),
      .groups = 'drop'
    )
  
  # Calculate differences between categories
  if(nrow(comparison) == 2) {
    obs_row <- comparison[comparison$target == "obs", ]
    ref_row <- comparison[comparison$target == "ref", ]
    
    differences <- data.frame(
      method = c("Raw", "Normalized_to_ref", "Normalized_within"),
      
      obs_median = c(obs_row$raw_median, obs_row$norm_to_ref_median, obs_row$norm_within_median),
      ref_median = c(ref_row$raw_median, ref_row$norm_to_ref_median, ref_row$norm_within_median),
      
      difference = c(
        obs_row$raw_median - ref_row$raw_median,
        obs_row$norm_to_ref_median - ref_row$norm_to_ref_median,
        obs_row$norm_within_median - ref_row$norm_within_median
      ),
      
      ratio = c(
        obs_row$raw_median / ref_row$raw_median,
        obs_row$norm_to_ref_median / ref_row$norm_to_ref_median,
        obs_row$norm_within_median / ref_row$norm_within_median
      ),
      
      obs_higher = c(
        obs_row$raw_median > ref_row$raw_median,
        obs_row$norm_to_ref_median > ref_row$norm_to_ref_median,
        obs_row$norm_within_median > ref_row$norm_within_median
      )
    )
  } else {
    differences <- NULL
  }
  
  return(list(
    comparison_stats = comparison,
    differences = differences,
    target_means = norm_result$target_means,
    normalized_data = df_norm
  ))
}

# ============================================================================
# STATISTICAL TESTING
# ============================================================================

test_target_normalization <- function(df, method = "to_ref", reference_target = "obs") {
  norm_result <- normalize_by_target_length(df, reference_target)
  df_norm <- norm_result$data
  
  # Choose which normalized values to test
  if(method == "to_ref") {
    obs_values <- df_norm$normalized_dist_to_ref[df_norm$target == "obs"]
    ref_values <- df_norm$normalized_dist_to_ref[df_norm$target == "ref"]
    method_name <- paste("Normalized to", reference_target, "mean length")
  } else if(method == "within_cat") {
    obs_values <- df_norm$normalized_dist_within_cat[df_norm$target == "obs"]
    ref_values <- df_norm$normalized_dist_within_cat[df_norm$target == "ref"]
    method_name <- "Normalized within target"
  } else {
    obs_values <- df_norm$dist[df_norm$target == "obs"]
    ref_values <- df_norm$dist[df_norm$target == "ref"]
    method_name <- "Raw distances"
  }
  
  # Perform tests
  t_test <- t.test(obs_values, ref_values)
  wilcox_test <- wilcox.test(obs_values, ref_values)
  
  # Effect size
  pooled_sd <- sqrt(((length(obs_values) - 1) * var(obs_values) + 
                       (length(ref_values) - 1) * var(ref_values)) / 
                      (length(obs_values) + length(ref_values) - 2))
  cohens_d <- (mean(obs_values) - mean(ref_values)) / pooled_sd
  
  return(list(
    method = method_name,
    t_test = t_test,
    wilcoxon = wilcox_test,
    cohens_d = cohens_d,
    obs_median = median(obs_values),
    ref_median = median(ref_values),
    difference = median(obs_values) - median(ref_values)
  ))
}

# ============================================================================
# SIMPLE USAGE FUNCTIONS
# ============================================================================

# Quick target-specific normalization (YOUR SUGGESTED APPROACH)
quick_target_normalize <- function(df, reference_target = "obs") {
  # Calculate mean URL length for reference target
  ref_mean <- df %>%
    filter(target == reference_target) %>%
    summarise(mean_length = mean(range, na.rm = TRUE)) %>%
    pull(mean_length)
  
  # Normalize all distances to this reference length
  df %>%
    mutate(
      normalized_dist = dist * (ref_mean / range)
    ) %>%
    group_by(target) %>%
    summarise(
      raw_median = median(dist),
      normalized_median = median(normalized_dist),
      difference_from_raw = normalized_median - raw_median,
      .groups = 'drop'
    )
}

# Alternative: normalize each target to its own mean
normalize_within_categories <- function(df) {
  df %>%
    group_by(target) %>%
    mutate(
      cat_mean_length = mean(range, na.rm = TRUE),
      normalized_dist = dist * (cat_mean_length / range)
    ) %>%
    ungroup() %>%
    group_by(target) %>%
    summarise(
      raw_median = median(dist),
      raw_mean = mean(dist),
      normalized_median = median(normalized_dist),
      normalized_mean = mean(normalized_dist),
      mean_range = first(cat_mean_length),
      .groups = 'drop'
    )
}

# ============================================================================
# VISUALIZATION
# ============================================================================

plot_target_normalization <- function(df, reference_target = "obs") {
  # Remove outliers in 'y' using IQR
  Q1 <- quantile(df$dist, 0.25)
  Q3 <- quantile(df$dist, 0.75)
  IQR <- Q3 - Q1
  
  # df_no_outliers <- subset(df, dist > (Q1 - 1.5 * IQR) & dist < (Q3 + 1.5 * IQR))
  # df_no_outliers <- subset(df, dist < limit)
  # df<-df_no_outliers
  norm_result <- normalize_by_target_length(df, reference_target)
  df_norm <- norm_result$data
  df <- df_norm
  
  
  # Plot without outliers
  library(ggplot2)
  library(tidyr)
  
  # Prepare data for plotting
  # plot_data <- df_no_outliers %>%
  
  plot_data <- df_norm %>%
    select(target, dist, normalized_dist_to_ref, normalized_dist_within_cat) %>%
    pivot_longer(cols = c(dist, normalized_dist_to_ref, normalized_dist_within_cat),
                 names_to = "method", values_to = "distance") %>%
    mutate(
      method = case_when(
        method == "dist" ~ "Raw",
        method == "normalized_dist_to_ref" ~ paste("Normalized to", reference_target),
        method == "normalized_dist_within_cat" ~ "Normalized within target"
      )
    )
  
  # Create comparison plot
  p <- ggplot(plot_data, aes(x = target, y = distance, fill = target)) +
    geom_boxplot(alpha = 0.7) +
    stat_summary(fun = median, geom = "point", shape = 23, size = 3, 
                 fill = "white", color = "black") +
    facet_wrap(~ method, scales = "free_y", ncol = 3) +
    labs(
      title = "Distance Comparison: Raw vs target-Normalized",
      subtitle = "Diamond = median",
      y = "Distance",
      x = "target"
    ) +
    theme_minimal() +
    theme(legend.position = "none")
  
  return(p)
}

# ============================================================================
# EXAMPLE USAGE
# ============================================================================

# Example workflow:
# 
# # Your suggested approach - normalize to obs target mean
df<-tdb6
# colnames(df)[colnames(df)=="dist"]<-"dist_norm"
# colnames(df)[colnames(df)=="dist_abs"]<-"dist"
mode(df$dist)
df<-df[!is.na(df$token),]

limit<-3000 
df2<-subset(df,dist < limit)
df<-df2
results_to_obs <- quick_target_normalize(df, reference_target = "obs")
print(results_to_obs)

# # Alternative - normalize to ref target mean  
results_to_ref <- quick_target_normalize(df, reference_target = "ref")
print(results_to_ref)
# 
# # Full comparison of methods
full_comparison <- compare_target_normalized(df, reference_target = "obs")
print(full_comparison$differences)

dfnorm<-full_comparison$normalized_data
# 
# # Statistical testing
test_results <- test_target_normalization(df, method = "to_ref", reference_target = "ref")
print(paste("Obs median:", round(test_results$obs_median, 1),
            "Ref median:", round(test_results$ref_median, 1),
            "Difference:", round(test_results$difference, 1)))

normalize_within_categories(df)
# # Visualization
plot_target_normalization(df, reference_target = "obs")



# ============================================================================
# Usage example:
### rm outliers
limit<-5000
# m<-tdb4$dist <limit
# sum(m,na.rm = T)
 tdb5<-dfa
 mode(tdb)
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
 