#!/bin/bash

cd /data
echo "contents of /data"
ls -l "${PWD}"

PDF_FILE=presentation
if test "$#" -eq 1; then
    PDF_FILE="${1:-}";
fi

if [ -f "main.tex" ]; then
    latexmk -pdf -silent -jobname="${PDF_FILE}" -pdflatex="xelatex -interaction=nonstopmode" main.tex
    chmod 0777 /data/${PDF_FILE}*
else
    echo "Please bind directory with main.tex to /data"
fi
