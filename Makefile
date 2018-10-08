# get the basename of the containing directory
# this will be used to name othe output document
BUILD_DIR := $(shell basename $(abspath $(dir $(lastword $(MAKEFILE_LIST)))))
BUILD_DIR ?= presentation

all: ${BUILD_DIR}.pdf

view: ${BUILD_DIR}.pdf
	[ "$(shell uname)" = "Darwin" ] && open ${BUILD_DIR}.pdf \
		|| xdg-open ${BUILD_DIR}.pdf 2>/dev/null

mmore500-presentation-template-master-latest.simg:
	singularity pull shub://mmore500/presentation-template

${BUILD_DIR}.pdf: main.tex bibl.bib \
									$(wildcard img/**/*) fig/* tex/* \
									mmore500-presentation-template-master-latest.simg
	singularity run \
		--bind ${PWD}:/data \
		--pwd /data \
		mmore500-presentation-template-master-latest.simg \
		${BUILD_DIR}

debug:
	singularity exec \
		--bind ${PWD}:/data \
		--pwd /data \
		mmore500-presentation-template-master-latest.simg \
			xelatex -jobname=${BUILD_DIR} main.tex

clean:
	rm -f ${BUILD_DIR}.pdf

cleaner:
	latexmk -CA
	# remove auxillary files, excepting .tex and .bib files
	find . -type f -name ${BUILD_DIR}"*" ! -name '*.simg*' ! -name '*.tex' ! -name '*.bib' -delete
	rm -f main.nav main.snm

.PHONY: view debug clean cleaner
