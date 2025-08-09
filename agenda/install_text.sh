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
