################################################################################
# Basic bootstrap definition to build Ubuntu container
################################################################################

Bootstrap: docker
From: ubuntu:18.04

%labels
Maintainer Matthew Andres Moreno
Version 0.2.0

################################################################################
# Copy any necessary files into the container
################################################################################
%files

%post
################################################################################
# Install additional packages
################################################################################
apt-get clean && apt-get update && apt-get install -y \
    locales \
    language-pack-fi  \
    language-pack-en && \
    export LANGUAGE=en_US.UTF-8 && \
    export LANG=en_US.UTF-8 && \
    export LC_ALL=en_US.UTF-8 && \
    locale-gen en_US.UTF-8 && \
    dpkg-reconfigure locales

apt-get install -y dialog
apt-get install -y apt-utils
apt-get install -y texlive
apt-get install -y texlive-full
apt-get install -y curl
apt-get install -y git
apt-get install -y fontconfig
apt-get install -y unzip
apt-get install -y make

# install Sans Forgetica fonts

curl -L http://www.sansforgetica.rmit/Common/Zips/Sans%20Forgetica.zip > sansforgetica.zip
unzip sansforgetica.zip

mkdir -p /usr/share/fonts/opentype/ForgeticaSans
cp Sans\ Forgetica/*.otf /usr/share/fonts/opentype/ForgeticaSans

# install Fira Type fonts

git clone https://github.com/mozilla/Fira

mkdir -p /usr/share/fonts/truetype/FiraSans
mkdir -p /usr/share/fonts/opentype/FiraSans
cp Fira/ttf/*.ttf /usr/share/fonts/truetype/FiraSans/
cp Fira/otf/*.otf /usr/share/fonts/opentype/FiraSans/

# update font cache

fc-cache -f -v

################################################################################
# Run the user's login shell, or a user specified command
################################################################################
%runscript
echo "running runscript!"
