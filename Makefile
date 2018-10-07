# get the basename of the containing directory
# this will be used to name othe output document
BUILD_DIR := $(shell basename $(abspath $(dir $(lastword $(MAKEFILE_LIST)))))

all: ${BUILD_DIR}.pdf

view:
	atom ${BUILD_DIR}.pdf

sview:
	gnome-open ${BUILD_DIR}.pdf 2>/dev/null

mmore500-presentation-template-master-latest.simg:
	singularity pull shub://mmore500/presentation-template

${BUILD_DIR}.pdf: main.tex mmore500-presentation-template-master-latest.simg
	rm -f ${BUILD_DIR}.pdf
	sudo singularity exec \
		--bind ..:/mnt \
		--pwd /mnt/${BUILD_DIR} \
		mmore500-presentation-template-master-latest.simg \
			latexmk -pdf -silent \
    		-jobname=${BUILD_DIR} \
    		-pdflatex="xelatex -interaction=nonstopmode" main.tex

clean:
	rm -f ${BUILD_DIR}.pdf

cleaner:
	latexmk -CA
	# remove auxillary files, excepting .tex and .bib files
	find . -type f -name ${BUILD_DIR}"*" ! -name '*.simg*' ! -name '*.tex' ! -name '*.bib' -delete
	rm -f main.nav main.snm

.PHONY:  ${BUILD_DIR}.pdf
