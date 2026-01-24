library(httr)
library(jsonlite)
api_key<-key
gemini_vertex <- function(
    image_uri = "gs://cloud-samples-data/generative-ai/image/homework.png",
    prompt = "Seit wann stehst du Nutzern in Deutschland öffentlich zur Verfügung?",
    api_key = key,
    model = "gemini-3-flash-preview",
    endpoint = "aiplatform.googleapis.com"
) {
  # Build request body matching the script
  request_body <- list(
    contents = list(
      list(
        role = "user",
        parts = list(
          # list(
          #   fileData = list(
          #     mimeType = "image/png",
          #     fileUri = image_uri
          #   )
          # ),
          list(text = prompt)
        ),
        generationConfig = list(
          temperature = 1,
          maxOutputTokens = 100,
          topP = 0.95,
          seed = 0,
          thinkingConfig = list(thinkingLevel = "HIGH")
        ),
        safetySettings = list(
          list(category = "HARM_CATEGORY_HATE_SPEECH", threshold = "OFF"),
          list(category = "HARM_CATEGORY_DANGEROUS_CONTENT", threshold = "OFF"),
          list(category = "HARM_CATEGORY_SEXUALLY_EXPLICIT", threshold = "OFF"),
          list(category = "HARM_CATEGORY_HARASSMENT", threshold = "OFF")
        )
      )
    )
  )
  
  url <- sprintf("https://%s/v1/publishers/google/models/%s:streamGenerateContent?key=%s", 
                 endpoint, model, api_key)
  
  response <- POST(url, body = toJSON(request_body, auto_unbox = TRUE), encode = "json")
  
  if (status_code(response) == 200) {
    content <- content(response, "parsed")
    # Extract first candidate's first part text from stream (adapt if multi-chunk)
    text <- content$candidates[[1]]$content$parts[[1]]$text
    return(text)
  } else {
    stop("API error: ", http_status(response)$message)
  }
}
t<-gemini_vertex()
