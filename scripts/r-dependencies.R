#!/usr/bin/env Rscript

# ---- SETTINGS ----
rmd_roots <- c("psych")  # Can be more than one root dir
lib_dir <- Sys.getenv("R_LIBS_USER", unset = "~/.local/lib/R/site-library")

# ---- FUNCTION TO PARSE PACKAGES ----
get_required_packages <- function(files) {
  code <- unlist(lapply(files, readLines, warn = FALSE))
  
  # Matches: library(pkg), require(pkg), library("pkg"), require("pkg")
  lib_calls <- gregexpr("(?<=library\\(|require\\()\\s*\\\"?[a-zA-Z0-9\\.]+\\\"?", code, perl = TRUE)
 # lib_calls <- gregexpr("(?<=library\\(|require\\()\\s*\\\"?[a-zA-Z0-9\\.]+\\\"?", code, perl = TRUE)
  pkgs <- unlist(regmatches(code, lib_calls))
#  pkgs <- gsub('[\\"\\)\\s]', '', pkgs)
  pkgs <- gsub('["\\)]', '', pkgs)
  
  # Also get namespaces: pkg:: or pkg::function
  namespace_calls <- gregexpr("\\b[a-zA-Z0-9\\.]+(?=::)", code, perl = TRUE)
  ns_pkgs <- unlist(regmatches(code, namespace_calls))
  
  unique(c(pkgs, ns_pkgs))
}

# ---- MAIN SCRIPT ----
dir.create(lib_dir, showWarnings = FALSE, recursive = TRUE)

# Recursively find all .Rmd files under each root
all_rmd_files <- unlist(lapply(rmd_roots, function(dir) {
  list.files(path = dir, pattern = "\\.Rmd$", recursive = TRUE, full.names = TRUE)
}))

if (length(all_rmd_files) == 0) {
  message("No Rmd files found in: ", paste(rmd_roots, collapse = ", "))
  quit(status = 0)
}

# Extract required packages
required_pkgs <- get_required_packages(all_rmd_files)
required_pkgs

# Determine which packages are missing
installed <- rownames(installed.packages(lib.loc = lib_dir))
missing_pkgs <- setdiff(required_pkgs, installed)

if (length(missing_pkgs)) {
  message("Installing missing packages: ", paste(missing_pkgs, collapse = ", "))
  install.packages(missing_pkgs, lib = lib_dir, dependencies = TRUE, repos = "https://cloud.r-project.org")
} else {
  message("✅ All required packages already installed.")
}
