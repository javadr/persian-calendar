#!/usr/bin/bash

.ONESHELL:

PKG     := pcalendar
DEMOS   := $(basename $(notdir $(wildcard sample/*.tex)))
DATE    := $(shell grep "pcalendardate{" $(PKG).sty | cut -d'{' -f2 | tr -d '}')
VERSION := $(shell grep "pcalendarversion{" $(PKG).sty | cut -d'{' -f2 | tr -d '}')
YEAR    := $(shell date +%Y)

.PHONY: all
all: readme test doc cleanup

# Compile every sample/*.tex with XeLaTeX (they need xepersian, fonts Parisa/Yas; phd-study also needs
# the quran package). Stops at the first TeX error, so a broken conversion macro fails the build.
.PHONY: sample
sample:
	cd sample && for f in $(DEMOS); do \
	  TEXINPUTS=..: xelatex -interaction=nonstopmode -halt-on-error $$f || exit 1; \
	done

.PHONY: test
test: sample

# Regression tests (testfiles/*.lvt vs *.tlg); use `l3build save <name>` to record a new baseline.
.PHONY: check
check:
	l3build check

# There is no pcalendar-doc.tex yet (the .sty header mentions it); builds it once it exists.
.PHONY: doc
doc:
	@if [ -f $(PKG)-doc.tex ]; then \
	  xelatex $(PKG)-doc && xelatex $(PKG)-doc; \
	else \
	  echo "$(PKG)-doc.tex not found: skipping doc"; \
	fi

# Install the package into the local texmf tree for use from any document.
.PHONY: dev
dev:
	TEXMF_LOCAL=$$(kpsewhich -var-value TEXMFLOCAL) && \
	sudo mkdir -p "$$TEXMF_LOCAL/tex/latex/$(PKG)" && \
	sudo cp -v $(PKG).sty "$$TEXMF_LOCAL/tex/latex/$(PKG)" && \
	sudo mktexlsr

.PHONY: clean
clean:
	@rm -fv ./*.aux ./*.log ./*.toc ./*.out ./*.xdv ./*~
	@rm -rfv build
	@rm -fv sample/*.{aux,log,toc,out,xdv}

.PHONY: cleanup
cleanup: clean

# CTAN layout: pcalendar/{README,tex/,doc/}, zipped as pcalendar.zip (no version in the name).
.PHONY: ctan
ctan: readme
	(cd sample && for i in 1 2; do \
	  TEXINPUTS=..: xelatex -interaction=nonstopmode -halt-on-error pcalendar-test || exit 1; \
	done)
	rm -rf $(PKG) $(PKG).zip
	mkdir -p $(PKG)/tex $(PKG)/doc
	cp -v README $(PKG)
	cp -v $(PKG).sty $(PKG)/tex
	cp -v sample/pcalendar-test.tex sample/pcalendar-test.pdf $(PKG)/doc
	@if [ -f $(PKG)-doc.tex ]; then cp -v $(PKG)-doc.tex $(PKG)-doc.pdf $(PKG)/doc; fi
	zip -r $(PKG).zip $(PKG)
	rm -rf $(PKG)
	$(MAKE) cleanup

# README is generated from the \ProvidesPackage line (version, date); do not edit it by hand.
.PHONY: readme
readme:
	@printf '%s\n' \
	  "_____________________" \
	  "The $(PKG) package" \
	  "v$(VERSION)" \
	  "" \
	  "Provides Persian (Jalali) calendar support for LaTeX: conversion between" \
	  "Jalali and Gregorian dates, Persian month, weekday and year names," \
	  "and Julian-day arithmetic on top of pgfcalendar." \
	  "" \
	  "Release Date of the Current Version: $(DATE)" \
	  "___________________" \
	  "Javad Razavian" \
	  "javadr@gmail.com" \
	  "" \
	  "Copyright © 2015-$(YEAR)" \
	  "This package may be distributed and/or modified under the terms of the LaTeX Project Public License," \
	  "version 1.3c or later (at your option). The latest version of" \
	  "the license is at: http://www.latex-project.org/lppl.txt" \
	  "" \
	  "This work has the LPPL maintenance status 'author-maintained'." > README
