
### preliminaries
library(reticulate)
reticulate::conda_list()
use_miniconda(reticulate::conda_list()[3,2])
py_version()
system("python3 --version")
#system("sh ~/documents/github/r-essais/scripts/check-env.sh")
system("pip3 install --upgrade pip setuptools wheel")
system("pip3 install pyarrow")
system("pip3 install kraken[pdf] --use-pep517")
system("kraken list") #wks.
###########################
library(reticulate)
system("kraken --version")
system("kraken -f pdf -i caillois-steine.pdf caillois-steine.txt segment -bl ocr -m ~/boxHKW/21S/DH/local/OCR/models/german_print_best.mlmodel") # output to files, ...txt obsolete

system("kraken -f pdf -i caillois-steine.pdf caillois-steine.txt segment -bl ocr -m ~/boxHKW/21S/DH/local/OCR/models/german_print_best.mlmodel") # output to files, ...txt obsolete
