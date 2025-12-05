FROM rocker/r-ver:4.3.1

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
RUN R -e "install.packages(c('rmarkdown','knitr','jsonlite','xml2','remotes','stringi','yaml'))"

# Optional: Install your renv base snapshot
# COPY renv.lock /workspace/
# RUN R -e "install.packages('renv'); renv::restore()"

# Use /work as working directory inside the container
WORKDIR /work
