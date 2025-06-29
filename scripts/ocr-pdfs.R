
### preliminaries
library(reticulate)
 reticulate::conda_list()
 use_miniconda(reticulate::conda_list()[4,2])
 py_version()
 reticulate::conda_update()
 conda_python()
 conda_create("renv",python_version = "3.13")
 conda_create("renv-12",python_version = "3.12")
 install_python(version = "3.12")
# install_python(list = TRUE)
# bash zprofile: 
### Use Homebrew Python 3.13 as default
### export PATH="/opt/homebrew/opt/python@3.13/bin:$PATH"
system("python3 --version")
system("source /Users/guhl/Library/r-miniconda/envs/r-reticulate/activate")
system("ls /Users/guhl/Library/r-miniconda/envs/renv/bin")
# reticulate::conda_python(all = T)
 use_python("3.12")
 py_available()
 py_config()
# pyenv_python()
 reticulate::use_python_version("3.12")
 system("brew install python@3.13") 
#system("sh ~/documents/github/r-essais/scripts/check-env.sh")
system("pip3 install --upgrade pip setuptools wheel")
system("pip3 install pyarrow")
#system("pip3 install torchvision0.5.0")
py_install("torchvision")
system("which python3")
system("python --version")
system("pip3 install kraken[pdf]==5.3.0 --use-pep517")
system("pip3 install kraken[pdf] --use-pep517")
#system("pip3 install kraken") # on mini installed 2.0.8, doesnt work. copied from lapsi 5.2.9 
system("kraken list") #wks.
system("kraken version") #wks.
###########################
library(reticulate)
system("kraken --version")
system("kraken -f pdf -i caillois-steine.pdf caillois-steine.txt segment -bl ocr -m ~/boxHKW/21S/DH/local/OCR/models/german_print_best.mlmodel") # output to files, ...txt obsolete

system("kraken -f pdf -i caillois-steine.pdf caillois-steine.txt segment -bl ocr -m ~/boxHKW/21S/DH/local/OCR/models/german_print_best.mlmodel") # output to files, ...txt obsolete
