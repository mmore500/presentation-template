# get the basename of the containing directory
# this will be used to name othe output document
BUILD_DIR := $(shell basename $(abspath $(dir $(lastword $(MAKEFILE_LIST)))))
PDF_FILE?=mypdf

all: ${PDF_FILE}.pdf

view:
	atom ${PDF_FILE}.pdf

sview:
	gnome-open ${PDF_FILE}.pdf 2>/dev/null

mmore500-presentation-template-master-latest.simg:
	singularity pull shub://mmore500/presentation-template

${BUILD_DIR}.pdf: main.tex mmore500-presentation-template-master-latest.simg
	rm -f ${PDF_FILE}.pdf
	singularity exec \
		--bind ${PWD}:/data \
		--pwd /data \
		mmore500-presentation-template-master-latest.simg \
			latexmk -pdf -silent \
    		-jobname=${PDF_FILE} \
    		-pdflatex="xelatex -interaction=nonstopmode" main.tex

clean:
	rm -f ${PDF_FILE}.pdf

cleaner:
	latexmk -CA
	# remove auxillary files, excepting .tex and .bib files
	find . -type f -name ${PDF_FILE}"*" ! -name '*.simg*' ! -name '*.tex' ! -name '*.bib' -delete
	rm -f main.nav main.snm

.PHONY:  ${PDF_FILE}.pdf
