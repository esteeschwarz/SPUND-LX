#wget https://github.com/adobe-fonts/source-sans/releases/latest/download/OTF-source-sans-3.zip
wget https://github.com/adobe-fonts/source-sans/releases/download/3.052R/OTF-source-sans-3.052R.zip

ls
unzip OTF-source-sans-3.052R.zip -d ~/.local/share/fonts/SourceSans3/
fc-cache -fv # sudo and nosudo
ls /usr/local/share/fonts
ls
cd dl
# via wget from Google Fonts API
# wget "https://fonts.google.com/download?family=Source+Sans+3" -O sourcesans3.zip
# unzip sourcesans3.zip ~/.local/share/fonts/SourceSans3/
ls
mkdir ~/.local/share/fonts/SourceSans3
sudo fc-cache -fv

cd ~/dl
#wget "https://fonts.google.com/download?family=Alef" -O alef.zip
#wget "https://github.com/google/raw/main/fonts/ofl/alef/Alef-Regular.ttf"
wget "https://github.com/google/fonts/raw/refs/heads/main/ofl/alef/Alef-Regular.ttf"
ls
mkdir ~/.local/share/fonts/Alef
cp Alef-Regular.ttf -d ~/.local/share/fonts/Alef/
sudo fc-cache -fv
fc-cache -fv

# bidi
# check which tlmgr you have
which tlmgr
tlmgr --version
# texlive 2023
# bidi is in texlive-lang-arabic
sudo apt install texlive-lang-arabic

# ucharclasses is in texlive-plain-generic
sudo apt install texlive-plain-generic

# fontspec, unicode-math are in texlive-latex-extra
sudo apt install texlive-latex-extra

# general useful bundle covering most CTAN packages
sudo apt install texlive-full
#/usr/local/texlive/2025/bin/x86_64-linux/tlmgr --version

# install bidi
sudo /usr/local/texlive/2025/bin/x86_64-linux/tlmgr install bidi
sudo /usr/local/texlive/2025/bin/x86_64-linux/tlmgr install ucharclasses