get_dep<-function(){
library(httr)
library(jsonlite)

url <- "https://frr.wikipedia.org/w/api.php"

u<-"https://frr.wikipedia.org/w/api.php?action=query&generator=allpages&gaplimit=max&prop=extracts&explaintext=1&format=json&exlimit=20"

api<-"https://de.wikipedia.org/w/api.php?action=query&format=json&prop=extracts&titles=Therion&formatversion=2&exlimit=20"
api<-"https://frr.wikipedia.org/w/api.php?action=query&format=json&prop=extracts&pageids=51218&formatversion=2&exlimit=20"
#wks.
u<-"https://frr.wikipedia.org/w/api.php?pageids=4716&action=raw"
u<-"https://frr.wikipedia.org/w/api.php?action=query&generator=allpages&gaplimit=2&gapfilterredir=nonredirects&gapfrom=Re&rvprop=content"
r<-GET(u)
t<-content(r, "text", encoding = "UTF-8")
t
params <- list(
  action = "query",
  generator = "allpages",
  gaplimit = "max",
  prop = "extracts",
  explaintext = 1,
  format = "json"
)

con <- file("frr_wikipedia.txt", open = "w", encoding = "UTF-8")

repeat {
  
  response <- GET(url, query = params)
  data <- fromJSON(content(response, "text", encoding = "UTF-8"))
  
  pages <- data$query$pages
  
  if (!is.null(pages)) {
    for (i in 1:length(pages)) {
      writeLines(
        paste0("\n\n### ", pages$title[i], " ###\n\n"),
        con
      )
      
      writeLines(pages$extract[i], con)
    }
  }
  
  # Handle API pagination
  if (is.null(data$continue)) break
  
  params <- c(params, data$continue)
}

close(con)
}
cat("starting wiki fetch.\n")

# claude
get.wk<-function(){
library(httr2)
library(dplyr)
library(purrr)

api <- "https://frr.wikipedia.org/w/api.php"
ua  <- "ids.R-wiki/0.1"  # use your own contact

api_get <- function(params) {
  request(api) |>
    req_user_agent(ua) |>
    req_url_query(!!!params, format = "json", formatversion = 2) |>
    req_throttle(rate = 5 / 1) |>   # be polite: max 5 requests/sec
    req_retry(max_tries = 3) |>
    req_perform() |>
    resp_body_json()
}

# 1) All article titles (namespace 0, no redirects)
get_all_titles <- function() {
  titles <- character()
  cont <- list()
  repeat {
    res <- api_get(c(list(action = "query", list = "allpages",
                          apnamespace = 0, apfilterredir = "nonredirects",
                          aplimit = 500), cont))
    titles <- c(titles, map_chr(res$query$allpages, "title"))
    if (is.null(res$continue)) break
    cont <- res$continue
  }
  titles
}

# 2) Plain-text extracts, 20 titles per request
get_texts <- function(titles) {
  res <- api_get(list(action = "query", prop = "extracts",
                      explaintext = 1, exlimit = "max",
                      titles = paste(titles, collapse = "|")))
  map_dfr(res$query$pages, \(p) tibble(
    pageid = p$pageid %||% NA_integer_,
    title  = p$title,
    text   = p$extract %||% NA_character_
  ))
}


titles  <- get_all_titles()
batches <- split(titles, ceiling(seq_along(titles) / 20))

articles <- map_dfr(batches, get_texts, .progress = TRUE)
save(articles,file="frr_wiki_articles.RData")
saveRDS(articles, "frr_wikipedia_articles.rds")
}
get.wk()
