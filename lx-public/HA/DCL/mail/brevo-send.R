library(httr)
library(jsonlite)
library(rmarkdown)


setwd(paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/lx-public/HA/DCL/mail"))

render("newsletter.md")
rmarkdown::pandoc_convert(
  input = "newsletter.md",
  to = "html",
  output = "newsletter.html",
  options = c(
    "--standalone",
    "--css=email.css",
    "--metadata=title="
  )
)
html <- paste(
  readLines("newsletter.html", warn = FALSE),
  collapse = "\n"
)


api_key <- Sys.getenv("BREVO_API_KEY")
# res<-GET("https://api.brevo.com/v3/senders",
#   add_headers(
#     "api-key" = api_key
#   ))
# content(res)
res <- POST(
  "https://api.brevo.com/v3/emailCampaigns",
  add_headers(
    "api-key" = api_key,
    "Content-Type" = "application/json"
  ),
  body = toJSON(list(
    name = "Weekly Update",
    subject = "Weekly Report",
    sender = list(
      name = "stephan schwarz",
      id = 1
    ),
    type = "classic",
    htmlContent = html,
    recipients = list(
      listIds = I(list(4))
    )
  )
  , auto_unbox = TRUE)

)
#print(body)
#cat(body)
content(res)
#writeLines(content(res,"text"),"r.html")
campaign_id <- content(res)$id
POST(
  paste0(
    "https://api.brevo.com/v3/emailCampaigns/",
    campaign_id,
    "/sendNow"
  ),
  add_headers("api-key" = api_key)
)
