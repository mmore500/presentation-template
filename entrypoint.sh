#!/bin/bash

# entrypoint.sh
# Author: @vsoch
#   A simple entrypoint to use latexmk to generate a pdf from the main.tex file
#   mounted in the /data folder of the container. If not found, the user is
#   alerted that it should be bound there
#
#   Usage: Given some /data/main.tex
#      /bin/bash entrypoint.sh mypdf
#
#   will generate mypdf.* output files, also in /data

cd /data
echo "contents of /data"
ls -l "${PWD}"

PDF_FILE=presentation
if test "$#" -eq 1; then
    PDF_FILE="${1:-}";
fi

if [ -f "main.tex" ]; then
    latexmk -pdf -silent -jobname="${PDF_FILE}" -pdflatex="xelatex -interaction=nonstopmode" main.tex
    echo "Changing permissions...";
    chmod 0777 /data/${PDF_FILE}*;
else
    echo "Please bind directory with main.tex to /data"
fi
