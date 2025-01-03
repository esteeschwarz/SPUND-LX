

# Define the path to your scripts
# script_dirs <- list.dirs("/var/snap/nextcloud/common/nextcloud/data/shiny12/files/shiny-server/work")
script_dirs <- list.dirs("../docker/ske")
print(list.files("/home/vscode"))
print("WTF")
print(script_dirs)
#script_dirs <- list.dirs("../work")
libs<-list()
extract_libraries <- function(file) {
  lines <- readLines(file)
  libraries <- unique(gsub(".*library\\((.*)\\).*", "\\1", grep("library\\(", lines, value = TRUE)))
  print(libraries)
  return(libraries)
}
#print(library())
syslib<-Sys.getenv("R_LIBS_USER")
print(syslib)
.libPaths()
for (k in script_dirs){
  print(k)
  script_files <- list.files(path = k, pattern = "\\.R$|\\.Rmd$", full.names = TRUE)
  print(script_files)
  # Function to extract libraries from a script
  
  # Extract all libraries from all scripts
  #all_libraries <- unique(unlist(lapply(script_files, extract_libraries)))
  libs[[k]] <- unique(unlist(lapply(script_files, extract_libraries)))
}
#package<-"xml2"
where<-1
# Function to install missing packages
install_if_missing <- function(package) {
  pkg.installed<-list.files(.libPaths()[where])
 # pkg.installed<-list.files(syslib)
  print(pkg.installed)
  pkg.true<-package%in%pkg.installed
#  if (require(package, character.only = TRUE,lib.loc = .libPaths()[3])) {
  if(!pkg.true)
    install.packages(package)
   # library(package, character.only = TRUE)
  #}
}
#library()
# Install all missing packages
#print(libs)
lapply(unique(unlist(libs)), install_if_missing)
#installed.packages(lib.loc = .libPaths()[1])


