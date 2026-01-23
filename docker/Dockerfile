# FROM rocker/r-ver:4.3.1
FROM rocker/r-ver:4.3 AS r-base
# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    git \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libfontconfig1-dev \
    fonts-dejavu \
    fonts-noto \
    && rm -rf /var/lib/apt/lists/*

# Install Quarto
# quarto-1.8.26-linux-amd64.deb
RUN wget -q https://github.com/quarto-dev/quarto-cli/releases/download/v1.8.26/quarto-1.8.26-linux-amd64.deb \
    && dpkg -i quarto-1.8.26-linux-amd64.deb \
    && rm quarto-1.8.26-linux-amd64.deb

# Install TinyTeX (user-level!)
#RUN R -e "install.packages('tinytex'); tinytex::install_tinytex(force = TRUE)"
RUN quarto install tinytex
RUN quarto install chromium
RUN export QUARTO_CHROMIUM_PATH="$(quarto env info --json | jq -r '.chromium.path')"
RUN export QUARTO_CHROMIUM_ARGS="--no-sandbox --disable-dev-shm-usage"
# Install some latex packages frequently needed by Quarto/Rmarkdown
# RUN /root/.TinyTeX/bin/*/tlmgr install \
#       latexmk \
#       wrapfig \
#       amsmath \
#       amssymb \
#       unicode-math \
#       xcolor \
#       palatino \
#       mathpazo \
#       oberdiek \
#       upquote \
#       microtype 
#       #      placeins

# Ensure TinyTeX is on PATH
ENV PATH="/root/.TinyTeX/bin/x86_64-linux:$PATH"

# Install common R packages for Quarto
RUN R -e "install.packages(c('jquerylib','xfun','quanteda.textplots','quanteda','googlesheets4','bookdown','rmarkdown','knitr','jsonlite','abind','xml2','remotes','stringi','yaml','officer','bib2df','lme4','ggplot2','tidyr','dplyr','lmerTest'))"
# RUN R -e "rmarkdown::install_pandoc_cli(version = '3.8.3')"

FROM pandoc/latex:3.8.3
COPY --from=r-base /usr/local /usr/local
# Optional: Install your renv base snapshot
# COPY renv.lock /workspace/
# RUN R -e "install.packages('renv'); renv::restore()"

# Use /work as working directory inside the container
WORKDIR /work
