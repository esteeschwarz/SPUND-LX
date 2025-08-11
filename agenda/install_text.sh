install.packages(c("text","pbapply"))
sudo apt install libxml2-dev
java jdk
Warning: dependency ‘Matrix’ is not available
also installing the dependencies ‘xml2’, ‘text2vec’, ‘rJava’, ‘gridtext’, ‘systemfonts’, ‘textmineR’, ‘mallet’, ‘ggwordcloud’, ‘ggforce’
Warning message:
package ‘Matrix’ is not available for this version of R
‘Matrix’ version 1.7-3 is in the repositories but depends on R (>= 4.4)
‘Matrix’ version 1.7-3 is in the repositories but depends on R (>= 4.6)



conda tos accept --override-channels --channel CHANNEL
https://repo.anaconda.com/pkgs/main
https://repo.anaconda.com/pkgs/r
conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/main
/home/esteeadnim/.local/share/r-miniconda/bin/conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/main

export CONDA_HOME="/home/esteeadnim/.local/share/r-miniconda/bin/conda"  # Replace with your path
echo 'export CONDA_HOME="/home/esteeadnim/.local/share/r-miniconda/bin/conda"' >> ~/.bashrc
echo 'export PATH="$CONDA_HOME/bin:$PATH"' >> ~/.bashrc
conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/r
tmux new -s r_session
Rscript your_script.R
Detach (keep running in background):
Press Ctrl+B, then D.
tmux attach -t r_session
oder: nohup Rscript your_script.R > output.log 2>&1 &
curl -X GET http://mini12:4173/getlog?log.x=embed-log -H "fkuchammaS25"
m<-is.na(t3$embed.score)
length(unique(t3$url[!m]))
15331.17.46:245
0 2-22/4 * * * /path/to/your/command
