FROM ubuntu:18.04

# docker build -t presentation-template .

LABEL Maintainer "Matthew Andres Moreno"
LABEL Contributors @vsoch
LABEL Version 1.0.1

ENV DEBIAN_FRONTEND noninteractive
ENV ATOM_VERSION 1.7.4
ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

RUN apt-get clean && apt-get update && apt-get install -y \
        locales \
        language-pack-fi  \
        language-pack-en && \
        locale-gen en_US.UTF-8 && \
        dpkg-reconfigure locales

RUN apt-get install -y dialog \
                       apt-utils \
                       texlive \
                       texlive-full \
                       curl \
                       git \
                       fontconfig \
                       unzip \
                       make

################################################################################
# Install atom editor
################################################################################

RUN apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        gconf2 \
        gvfs-bin \
        libasound2 \
        libgtk2.0-0 \
        libnotify4 \
        libnss3 \
        libxtst6 \
        xdg-utils
    
RUN apt-get install -y wget && \
    apt-get install -y libxkbfile1 && \
    wget https://atom.io/download/deb -O atom.deb && \
    dpkg -i atom.deb && \
    rm -rf atom.deb

################################################################################
# Install Fonts
################################################################################

# install Sans Forgetica fonts

RUN curl -L http://www.sansforgetica.rmit/Common/Zips/Sans%20Forgetica.zip > sansforgetica.zip && \
    unzip sansforgetica.zip

RUN mkdir -p /usr/share/fonts/opentype/ForgeticaSans && \
    cp Sans\ Forgetica/*.otf /usr/share/fonts/opentype/ForgeticaSans

# install Fira Type fonts

RUN git clone https://github.com/mozilla/Fira && \
    mkdir -p /usr/share/fonts/truetype/FiraSans /usr/share/fonts/opentype/FiraSans && \
    cp Fira/ttf/*.ttf /usr/share/fonts/truetype/FiraSans/ && \
    cp Fira/otf/*.otf /usr/share/fonts/opentype/FiraSans/ && \
    fc-cache -f -v && \
    chmod -R u+x /usr/share/fonts

RUN mkdir -p /code /data
ADD entrypoint.sh /code/
RUN chmod u+x /code/entrypoint.sh
ENTRYPOINT ["/code/entrypoint.sh"]
