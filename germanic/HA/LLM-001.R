# 20260107(10.47)
# 16015.germanic.HA.draft-B
# research organisations registry, query, youtube channel extraction
# Q: https://zenodo.org/records/17953395 (dataset)
# Q: https://arxiv.org/abs/2409.01754 (paper)

# 1. query db
#############
prepare.video_df<-function(ins){
src<-"~/boxHKW/UNIhkw/21S/DH/local/SPUND/2025/huening/research-registry/v2.0-2025-12-16-ror-data.csv"
d<-read.csv(src)
colnames(d)
unique(d$locations.geonames_details.country_code)
m<-d$locations.geonames_details.country_code=="DE"
sum(m,na.rm = T)
ds1<-d[m,]
m<-grep("education",ds1$types)
ds2<-ds1[m,]
#save(ds2,file=paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/huening/ds2.RData"))
### subset of german educational institutions
#############################################
# 2. get youtube channels
#########################
# gpt1
# install.packages(c("httr", "jsonlite"))  # run once if needed
library(httr)
library(jsonlite)
#library(gargle)
credcsv<-Sys.getenv("CRED_GEN") # !VIP dont put directly into read.csv()
cred<-read.csv(credcsv) 
e<-parse(text=cred$q[1])
e
# q<-"transkribus"
m<-grep("google",cred$q)
q<-cred$q[m]
eval(e)

API_KEY<-api_key<-key
get.video_df<-function(ds2,ins){
funout<-function(){
#api_key <- "YOUR_API_KEY_HERE"  # <- replace with your key

channel<-ds2$names.types.label[sample(length(ds2$id),1)]
channel
query   <- "samplechannel"
query<-channel
channel<-"ARD"
base_url <- "https://www.googleapis.com/youtube/v3/search/"


# Build query parameters: search for channels only
params <- list(
  part       = "snippet",
  q          = query,
  type       = "channel",
  maxResults = 25,
  key        = api_key
)

# Send GET request
res <- GET(url = base_url, query = params)
#res
stop_for_status(res)  # error if non-2xx
}
#####################
# library(httr)
# library(jsonlite)

#api_key <- "YOUR_API_KEY_HERE"
inst.label<-ds2$names.types.label # 601 institutions categorized
###############################
#query<-ds2$names.types.label[i]
# 1: mannheim : audio downloaded
# 2: hildesheim : try complete
#institution<-query
query<-ds2$names.types.label[ins] # maybe small set to test workflow
###############################
search_query <- query
api_key
query
# Step 1: Get channels
load(paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/huening/videos_df-cpt.RData"))
check.matched<-function(){
  target<-unique(videos_cpt$target)
  target
  m<-target%in%inst.label
  cat(target[m],"already channeled...\n")
  if(sum(m)==length(ins))
    return(F)
  return(T)
}
if(!check.matched())
  return("institution already checked. skipping...")
response <- GET(
  url = "https://www.googleapis.com/youtube/v3/search",
  query = list(
    part = "snippet",
    q = search_query,
    type = "channel",
    maxResults = 20,
    key = api_key
  )
)


if (status_code(response) == 200) {
  channel_data <- content(response, as = "parsed")
  
  # Step 2: For each channel, get videos in date range
  # published_after <- "2024-01-01T00:00:00Z"  # RFC 3339 format
  # published_before <- "2024-12-31T23:59:59Z"
  gpt_onset<-"2022-11-30T23:59:59Z"
  # library(lubridate)
  # library(anytime)
  # date_string <- gpt_onset
  # parsed_date <- ymd_hms(date_string, tz = "UTC")
  # 
  # # Subtract 4 years
  # result <- parsed_date - years(4)
  # 
  # # Format back to RFC 3339
  # published_after <- rfc3339(result)
  published_after <- "2018-12-31T23:59:59Z"
  published_before <- "2025-12-31T23:59:59Z"
  # Parse ISO 8601 timestamp
  # date_string <- "2022-11-30T23:59:59Z"  # Corrected to valid date
  # parsed_date <- ymd_hms(date_string, tz = "UTC")
  # 
  # # Subtract 4 years
  # result <- parsed_date - years(4)
  # result
  # formatted <- format_ISO8601(result, usetz = TRUE)
  # formatted <- rfc3339(result)
  # formatted
  # library(anytime)
  # # [1] "2018-11-30 23:59:59 UTC"
  # 
  # date_obj <- as.POSIXct(gpt_onset, tz = "UTC")
  # result_base <- seq(date_obj, by = "-4 years", length.out = 2)[2]
  # result_base
  # 
  # gpt_onset
  # published_after <- "2020-01-01T00:00:00Z"  # RFC 3339 format
  # published_before <- "2024-12-31T23:59:59Z"
  # 
  all_videos <- list()
  #i<-1
  for (i in seq_along(channel_data$items)) {
    channel_id <- channel_data$items[[i]]$snippet$channelId
    channel_title <- channel_data$items[[i]]$snippet$channelTitle
    channel_lang <- channel_data$regionCode
    
    cat("Channel:", channel_title, "\n")
    
    # Search for videos from this channel in date range
    video_response <- GET(
      url = "https://www.googleapis.com/youtube/v3/search",
      query = list(
        part = "snippet",
        channelId = channel_id,
        # defaultAudioLanguage = "DE",
        type = "video",
        order = "date",
        publishedAfter = published_after,
        publishedBefore = published_before,
        maxResults = 50,
        key = api_key
      )
    )
    
    if (status_code(video_response) == 200) {
      video_data <- content(video_response, as = "parsed")
      
      if (length(video_data$items) > 0) {
        for (j in seq_along(video_data$items)) {
          video <- video_data$items[[j]]
          cat("  -", video$snippet$title, "(", video$snippet$publishedAt, ")\n")
          
          # Store video info for later use
          all_videos[[length(all_videos) + 1]] <- data.frame(
            target = query,
            channelId = channel_id,
            channelTitle = channel_title,
            channelLang = channel_lang,
            videoId = video$id$videoId,
            videoTitle = video$snippet$title,
            publishedAt = video$snippet$publishedAt,
            description = video$snippet$description,
            stringsAsFactors = FALSE
          )
        }
      } else {
        cat("  No videos found in this date range\n")
      }
    } else {
      cat("  Error fetching videos:", status_code(video_response), "\n")
    }
    
    cat("\n")
  }
  
  # Combine all videos into a single data frame
  if (length(all_videos) > 0) {
    videos_df <- do.call(rbind, all_videos)
    print(head(videos_df))
    return(videos_df)
  }
  
} else {
  cat("Error:", status_code(response), "\n")
  cat("Message:", content(response, as = "text"), "\n")
}

}


# for(i in 1:length(ds2$id)){
 for(i in ins){
    videos_df<-get.video_df(ds2,i)

videos_sf<-videos_df
#videos_cpt$target<-"n.a."
#videos_cpt<-videos_df
load(paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/huening/videos_df-cpt.RData"))
videos_cpt<-rbind(videos_cpt,videos_sf)
save(videos_cpt,file = paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/huening/videos_df-cpt.RData"))
}
unique(videos_cpt$channelTitle)
save(videos_cpt,file = paste0(Sys.getenv("GIT_TOP"),"/gitmini/cloud/work/videos_df-cpt.RData"))
return(videos_cpt)
}
##########
################################################
### wks.
# 3. get exact institution channel from channels:
get.videos_match<-function(videos_df,what){
#load(paste0(Sys.getenv("GIT_TOP"),"/gitmini/cloud/work/videos_df-cpt.RData"))

# library(httr)
# library(jsonlite)
library(stringr)
library(dplyr)
library(promises)
library(future)
library(httr)

# Enable async processing for better server performance
plan(multisession)

tlama<-function(){
  turl<-"http://localhost:11434/api/tags"
  r<-GET(turl)
  t<-content(r,"text")
  print(t)
}

# Ollama configuration
OLLAMA_BASE_URL <- Sys.getenv("OLLAMA_URL", "http://localhost:11434")
DEFAULT_MODEL <- Sys.getenv("OLLAMA_MODEL", "llama3.2")

# Cache for Ollama status to avoid repeated checks
#ollama_cache <- reactiveVal(list(last_check = NULL, status = NULL))
#x<-models_info$models
#x$name
#x
# Ollama functions (optimized for Shiny)
check_ollama_status_async <- function() {
  future({
    tryCatch({
      response <- GET(paste0(OLLAMA_BASE_URL, "/api/tags"), timeout(5))
      if (status_code(response) == 200) {
        models_info <- fromJSON(content(response, "text", encoding = "UTF-8"))
        models <- sapply(models_info, function(x) x$name)
        list(running = TRUE, models = models, error = NULL)
      } else {
        list(running = FALSE, models = character(0), error = "Not responding")
      }
    }, error = function(e) {
      list(running = FALSE, models = character(0), error = e$message)
    })
  })
}
#print(check_ollama_status_async())
#library(readtext)

#videos_df<-videos_df[what,]
setwd(paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/germanic/HA"))
p.text<-readtext("yakura-prompt.md")$text
videos_df$target[videos_df$target=="n.a."]<-NA
videos_df<-videos_df[!is.na(videos_df$target),]
target<-unique(videos_df$target)
target<-target[!is.na(target)]
#t<-target[tr]
target
#tr<-1
###############################
get.channel_match<-function(videos_df,tr){
  t<-target[tr]
#  m<-videos_df$target==t
  print(t)
  m<-videos_df$target==t
  print(sum(m))
videos_df<-videos_df[m,]
v.list<-videos_df$channelTitle
v.list<-unique(v.list)
v.list<-paste0(v.list,collapse = "#")
p.text<-gsub("_list_",v.list,p.text)
p.text<-gsub("_target_",t,p.text)
#desc<-videos_df$description[t]
print(p.text)
analyze_with_ollama_async <- function(p.text,model = DEFAULT_MODEL) {
  prompt<-p.text
    request_body <- list(
    model = model,
    prompt = prompt,
    stream = FALSE,
    options = list(temperature = 0.1, num_predict = 500)
  )
  print(prompt)
  tryCatch({
    response <- POST(
      url = paste0(OLLAMA_BASE_URL, "/api/generate"),
      body = toJSON(request_body, auto_unbox = TRUE),
      add_headers("Content-Type" = "application/json"),
      encode = "raw",
      timeout(100)  # 30 second timeout
    )
    # content(GET(paste0(OLLAMA_BASE_URL,"/api/info")),"text")
    print(content(response,"text"))
    
    if (status_code(response) == 200) {
      result <- fromJSON(content(response, "text", encoding = "UTF-8"))
      response_text <- result$response
      return(response_text)
      # print(response_text)
      #  response_text<-'{"Algernon": ["ALGERNON"], "Lane": ["LANE"], "Jack": ["JACK"]}'
      # Extract JSON
      json_pattern <- "\\{[^}]*(?:\"[^\"]*\"\\s*:\\s*\\[[^\\]]*\\][^}]*)*\\}"
      json_match <- str_extract(response_text, json_pattern)
      json_match
      #json<-fromJSON(response_text)
      if (!is.na(json_match)) {
        json_match <- str_replace_all(json_match, "\\\\\\\\", "\\\\")
        return(unique(unlist(fromJSON(json_match))))
      }
    }
    print("not 200")
    return(NULL)
  }, error = function(e) {
    print("error...")
    print(content(response,"text"))
    return(NULL)
  })
  
}
#}
# p.text<-readtext("yakura-prompt.md")$text
# v.list<-videos_df$channelTitle
# v.list<-unique(v.list)
# v.list<-paste0(v.list,collapse = "#")
# p.text<-gsub("_list_",v.list,p.text)
# p.text
r1<-analyze_with_ollama_async(p.text)
### wks. returns channel of interest
print(r1)
#print(head(videos_df))
#m<-videos_df
videos_df$channel_true<-F
ch1<-gsub("# ","",r1)
#ch1<-c(paste0("en: ",ch1),paste0("de: ",ch1))
ch1
target
unique(videos_df$channelTitle)
videos_df$channel_true[videos_df$channelTitle==ch1]<-T
#r1
return(videos_df)
}
####################################
videos_df.m<-videos_df
#channel<-target[t]
for (t in what){
#  channel<-target[t]
  channel<-t
  print(channel)
  videos_df.m<-get.channel_match(videos_df.m,channel)
}
return(videos_df.m)
}

get.text<-function(what){
# 4. transcribe
#install.packages(c("processx"))
#remotes::install_github("bnosac/audio.whisper")
# $brew install cmake !
#remotes::install_github("bnosac/audio.whisper", ref = "0.5.0")
library(audio.whisper)
library(processx)
library(dplyr)

### data:
 # load(paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/huening/videos_df-cpt.RData"))
  #############################
  vtest<-prepare.video_df(1:10)
  #############################
  #head(ds2,50)
  #what<-ds2[1]
  #videos_df<-videos_cpt
  videos_df<-vtest
  tu<-unique(videos_df$target)
what<-tu[3]
videos_df.m<-get.videos_match(videos_df,what)
#$brew install yt-dlp ffmpeg
# on monterey install yt-dlp via macports (missing [deno] in brew install)

#df <- data.frame(channel_id = c("UC_x5XG1OV2P6uZZ5FSM9Ttw", "UCSJ4gkVC6NrvII8umztf0Ow"))
df <- data.frame(channel_id = unique(videos_df$channelId[videos_df$channel_true]))
df
# output_dir <- paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/huening/audio_transcripts/001")
# dir.create(output_dir, showWarnings = FALSE)
whisper_download_model("base",model_dir = paste0(Sys.getenv("HKW_TOP"),"/SPUND/models/"))
model<-whisper(paste0(Sys.getenv("HKW_TOP"),"/SPUND/models/"))

for (id in df$channel_id) {
  output_dir <- paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/huening/audio_transcripts/",id)
  dir.create(output_dir, showWarnings = FALSE)
  cmd <- sprintf('yt-dlp -x --audio-format mp3 -o "%s/%%(channel_id)s_%%(id)s.%%(ext)s" "https://www.youtube.com/channel/%s/videos"', 
                 output_dir, id)
  processx::run("bash", c("-c", cmd))  # downloads latest videos' audio
  
  audio_files <- list.files(output_dir, pattern = paste0(id, ".*mp3"), full.names = TRUE)
  if (length(audio_files)) {
    for (k in 1:length(audio_files)){
    latest <- tail(audio_files)[1]
    latest <- audio_files[k]
    out.ns<-paste0(latest,".wav")
    cmd <- sprintf('ffmpeg -i %s -b:a 16 %s.wav', 
                   latest, latest)
    cmd<-sprintf("ffmpeg -i %s -ar 16000 -ab 16k -f wav %s",latest,out.ns)
    cmd
    processx::run("bash", c("-c", cmd))  # downloads latest videos' audio
    #audio<-system.file(package="audio.whisper",out.ns)
    # audio <- system.file(package = "audio.whisper", "samples", "proficiat.wav")
    
    audio<-out.ns
    audio
    # trans <- whisper_transcribe(latest, model = "base.en")$text  # local model
    # trans <- predict(model,newdata = audio,language = "nl",type = "transcribe")  # local model
    trans <- predict(model,newdata = audio,language = "de",type = "transcribe")  # local model
    trans$tokens
    text<-gsub("\n","",trans$tokens$token)
    writeLines(trans$data$text,paste0(latest,".txt"))
    writeLines(trans$data$text,paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/germanic/HA/utube-audio/transcripts/",
               latest,".txt"))
    cat("Channel", id, ", audio [",k,"] transcribed / extract:", substr(text, 1, 100), "...\n")
    # cat("Channel", id, ":", substr(text, 1, 200), "...\n")
    df[df$channel_id == id, "transcript"] <- text
    }
  }
}
}
### wks.
# gets transcript text from !16Khz/16Kbit! .wav
###############################################



  