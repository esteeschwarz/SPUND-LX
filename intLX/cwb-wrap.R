# registry directory and cpos_total will be needed in examples
cpos_total <- cl_attribute_size(
  corpus = "REUTERS", attribute = "word",
  attribute_type = "p", registry = get_tmp_registry()
)

# decode the token stream of the corpus (the quick way)
token_stream_str <- cl_cpos2str(
  corpus = "REUTERS", p_attribute = "word",
  cpos = seq.int(from = 0, to = cpos_total - 1),
  registry = get_tmp_registry()
)

# decode the token stream (cpos2id first, then id2str)
token_stream_ids <- cl_cpos2id(
  corpus = "REUTERS", p_attribute = "word",
  cpos = seq.int(from = 0, to = cpos_total - 1),
  registry = get_tmp_registry()
)
token_stream_str <- cl_id2str(
  corpus = "REUTERS", p_attribute = "word",
  id = token_stream_ids, registry = get_tmp_registry()
)

# get corpus positions of a token
token_to_get <- "oil"
id_oil <- cl_str2id(
  corpus = "REUTERS", p_attribute = "word",
  str = token_to_get, registry = get_tmp_registry()
)
cpos_oil <- cl_id2cpos <- cl_id2cpos(
  corpus = "REUTERS", p_attribute = "word",
  id = id_oil, registry = get_tmp_registry()
)

# get frequency of token
oil_freq <- cl_id2freq(
  corpus = "REUTERS", p_attribute = "word", id = id_oil, registry = get_tmp_registry()
)
length(cpos_oil) # needs to be the same as oil_freq

# use regular expressions 
ids <- cl_regex2id(
  corpus = "RGRDF2", p_attribute = "word",
  regex = "M.*", registry = get_tmp_registry()
)
m_words <- cl_id2str(
  corpus = "REUTERS", p_attribute = "word",
  id = ids, registry = get_tmp_registry()
)
m_words <- cl_id2str(
  corpus = "RGRDF2", p_attribute = "c",
  id = ids, registry = get_tmp_registry()
)
check_id(corpus = corpus,"lemma",10)
check_registry(rg)
check_corpus("RGRDF2",rg,T,T)
check_registry(rg)
cpos_total <- cl_attribute_size(
  corpus = "RGRDF2", attribute = "lemma",
  attribute_type = "p", registry = get_tmp_registry()
)
m_words


### from start
library(RcppCWB)
#cfile<-"~/boxHKW/21S/DH/local/SPUND/intLX/com.vrt.1-1000.txt"
data_dir = "~/pro/cwb/indexed/rdf3f"
vrt_dir<-"~/boxHKW/21S/DH/local/SPUND/intLX/vrt2"
list.files(vrt_dir)
dir.create(data_dir)
cwb_encode(
  "RDF2",
  registry = Sys.getenv("CORPUS_REGISTRY"),
  data_dir = data_dir,
  vrt_dir="~/boxHKW/21S/DH/local/SPUND/intLX/vrt2",
  encoding = "utf8",
  p_attributes = c("word", "lemma", "tag"),
  s_attributes = list(text ="id",s=character()),
  skip_blank_lines = TRUE,
  strip_whitespace = TRUE,
  xml = T,
  quietly = FALSE,
  verbose = FALSE
)
# perform cwb_makeall (equivalent to cwb-makeall command line utility)
cwb_makeall(corpus = "BTMIN", p_attribute = c("word"), registry = sysregdir)
cwb_makeall(corpus = "RDF2", p_attribute = c("word"), registry = sysregdir)
cl_load_corpus("RDF2", registry = sysregdir)
cqp_load_corpus("RDF2", registry = sysregdir)
# see whether it works
ids_sentence_1 <- cl_cpos2id(
  corpus = "RDF2", p_attribute = "word", registry = get_tmp_registry(),
  cpos = 0:83
)
tokens_sentence_1 <- cl_id2str(
  corpus = "RDF2", p_attribute = "word",
  registry = get_tmp_registry(), id = ids_sentence_1
)
sentence <- gsub("\\s+([\\.,])", "\\1", paste(tokens_sentence_1, collapse = " "))
sentence
##################
cqp_list_corpora()
cqp_load_corpus("RDF2",sysregdir)
cqp_load_corpus("REUTERS",sysregdir)
cqp_load_corpus("BTMIN",sysregdir)
cqp_load_corpus("REDDIT",pregdir)
query = '[word=".*"&pos="N.*"];'
query<-'[word="fr.*"];'
query = '[word=".*"&lemma="fr.*"][word=".*"&pos=".*"];'
query = '[word=".*"&lemma="fr.*"][pos="PRON.*"];'
cqp_query("REDDIT",pregdir,'show -pos;')
cqp_query("REDDIT",pregdir,query)
# Get the number of matches
num_matches <- cqp_subcorpus_size("REDDIT","QUERY")

# Extract the matches
matches <- cqp_dump_subcorpus(corpus, 0, num_matches - 1)

# Convert the matches to a data frame
results_df <- as.data.frame(matches, stringsAsFactors = FALSE)

# Print the data frame
print(results_df)
cqp_query("REDDIT",pregdir,query)
cqp_query("BTMIN",pregdir,query)
query = '[word=".*"&pos=".*"];'

cqp_query("BTMIN",sysregdir,'show +lemma;')
cqp_query("BTMIN",sysregdir,query)
sysregdir<-Sys.getenv("CORPUS_REGISTRY")
writeLines(readLines(Sys.getenv("CORPUS_REGISTRY")),"~/pro/cwb/registry/rdftemp")
writeLines(readLines(paste(sysregdir,list.files(sysregdir)[1],sep="/")),"~/pro/cwb/registry/btmin")
### sample encode
library(RcppCWB)
demodata = "~/pro/cwb/indexed/btmintb"
vrt_dir<-"~/boxHKW/21S/DH/local/SPUND/intLX/vrt2"
list.files(vrt_dir)
dir.create(demodata)
pregdir<-"/Users/guhl/pro/cwb/registry"
cwb_encode(
  corpus = "BTMINT",
  registry = pregdir,
  vrt_dir = system.file(package = "RcppCWB", "extdata", "vrt"),
  data_dir = demodata,
  p_attributes = c("word", "pos", "lemma"),
  s_attributes = list(
    plenary_protocol = c(
      "lp", "protocol_no", "date", "year", "birthday", "version",
      "url", "filetype"
    ),
    speaker = c(
      "id", "type", "lp", "protocol_no", "date", "year", "ai_no", "ai_id",
      "ai_type", "who", "name", "parliamentary_group", "party", "role"
    ),
    p = character()
  )
)
pregdir<-"/Users/guhl/pro/cwb/registry"
demodata = "~/pro/cwb/indexed/rdf3h"
vrt_dir<-"~/boxHKW/21S/DH/local/SPUND/intLX/vrt3"
list.files(vrt_dir)
list.files(demodata)
dir.create(demodata)
cwb_encode(
  corpus = "REDDIT",
  registry = pregdir,
  vrt_dir = vrt_dir,
  data_dir = demodata,
  p_attributes = c("word", "pos", "lemma"),
  s_attributes = list(
    doc = c("id"),
    com = c("id"),
    s = c("timestamp","sent_id","author","url","url_id","date")
  ),
  xml = T,
  quietly = F
)
cwb_makeall(corpus = "REDDIT", p_attribute = c("word"), registry = pregdir)

cqp_load_corpus("REDDIT",pregdir)
query = '[word=".*"&pos="N.*"];'
query<-'[word="fre.*"];'
query = '[word=".*"&lemma="fr."][word=".*"&pos="PRON.*"];'
#query = '[word=".*"&lemma="fr.*"][pos="PRON.*"];'
#cqp_query("REDDIT",pregdir,'show -pos;')
query = '[word=".*"&lemma="frau.*"];'
query = '[word=".*"&lemma="frau.*"][word=".*"&lemma="hab.*"];'
query = '[word=".*"&lemma="mann.*"][word=".*"&lemma="hab.*"];'

cqp_query("REDDIT",pregdir,query)
# Get the number of matches
num_matches <- cqp_subcorpus_size("REDDIT","QUERY")
cqp_subcorpus_size("REDDIT",subcorpus = "QUERY")

# Extract the matches
r<-cqp_dump_subcorpus("REDDIT")

# Convert the matches to a data frame
results_df <- as.data.frame(matches, stringsAsFactors = FALSE)

vrt_dir = system.file(package = "RcppCWB", "extdata", "vrt")
vrt_dir
list.files(vrt_dir)
writeLines(readLines(paste(vrt_dir,list.files(vrt_dir)[1],sep="/")),"~/pro/cwb/rcppdemo.xml")

