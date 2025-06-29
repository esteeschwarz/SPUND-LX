
### preliminaries
library(reticulate)
 reticulate::conda_list()
 py_version()
 use_miniconda(reticulate::conda_list()[4,2])
 reticulate::conda_update()
 py_version()
 #reticulate::use_python_version("3.13")
 #use_python("3.13")
 conda_python()
 py_available()
 py_config()
 py_version()
 conda_create("renv",python_version = "3.13")
 conda_create("renv-11",python_version = "3.11")
 install_python(version = "3.12.3")
# install_python(list = TRUE)
# bash zprofile: 
### Use Homebrew Python 3.13 as default
### export PATH="/opt/homebrew/opt/python@3.13/bin:$PATH"
system("python3 --version")
system("source /Users/guhl/Library/r-miniconda/envs/r-reticulate/activate")
system("ls /Users/guhl/Library/r-miniconda/envs/renv/bin")
# reticulate::conda_python(all = T)
# pyenv_python()
# system("brew install python@3.13") 
#system("sh ~/documents/github/r-essais/scripts/check-env.sh")
system("pip3 install --upgrade pip setuptools wheel")
system("pip3 install pyarrow")
#system("pip install torch==2.4.1") #kraken 5.3.0 need torch 2.4.0 
# > on linux installs 2.4.1 auto with kraken 5.2.9, kraken get <model>, apt install libvips (missing)
py_install("kraken[pdf]")
system("which python3")
system("python --version")
system("pip install kraken[pdf]==5.3.0 --use-pep517")
system("pip3 install kraken[pdf] --use-pep517")
system("pip install kraken[pdf] --use-pep517")
#system("pip3 install kraken") # on mini installed 2.0.8, doesnt work. copied from lapsi 5.2.9 
system("kraken list") #wks.
system("kraken --version") #wks.
system("kraken get 10.5281/zenodo.10519596") #german model
###########################
library(reticulate)
system("kraken --version")
system("kraken -f pdf -i caillois-steine.pdf caillois-steine.txt segment -bl ocr -m ~/boxHKW/21S/DH/local/OCR/models/german_print_best.mlmodel") # output to files, ...txt obsolete

system("kraken -f pdf -i caillois-die-schrift-der-steine.pdf caillois-steine-schrift.txt segment -bl ocr -m german_print.mlmodel") # output to files, ...txt obsolete
