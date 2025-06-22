#install.packages("DBI")
#install.packages("RSQLite")

library(DBI)
library(RSQLite)
# To save to a file:
# con <- dbConnect(RSQLite::SQLite(),paste0(Sys.getenv("HKW_TOP"),"/",subject.dir,"/reddit_com.df.",tstamp,".sqlite"))
con <- dbConnect(RSQLite::SQLite(),"~/db/reddit_com.df.15242.sqlite")
dbListTables(con)
tdb.pos<-dbGetQuery(con,"SELECT * FROM reddit_com_pos")
tdb.com<-dbGetQuery(con,"SELECT * FROM redditpsych")
### initiate:
#dbWriteTable(con, "redditpsych", url.sub.df[0, ], overwrite = TRUE, row.names = FALSE)
dbExecute(con,"ALTER TABLE redditpsych ADD COLUMN initialAuth INTEGER")
dbExecute(con,"DELETE FROM redditpsych")
dbExecute(con,"DELETE FROM sqlite_sequence")
dbExecute(con,"DELETE FROM reddit_com_pos")
dbCreateTable(con,"reddit_com_pos",df.ex)
# Or, for an in-memory database (not persistent):
# con <- dbConnect(RSQLite::SQLite(), ":memory:")
# Example:
# df_list <- list(df1 = data.frame(...), df2 = data.frame(...), ...)
# Or just df_list[[1]], df_list[[2]], ..., df_list[[1000]]

# Loop through the list and write each data frame to a table
# for (i in seq_along(df_list)) {
#   table_name <- paste0("table_", i)  # or names(df_list)[i] if names are meaningful
#   dbWriteTable(con, name = table_name, value = df_list[[i]], overwrite = TRUE)
# }
# dbGetQuery(con,"select * from meta")
 #dbHasCompleted()
 dbDisconnect(con)

 
 
 
 
 