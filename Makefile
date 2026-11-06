#!/usr/bin/bash

.ONESHELL:

PKG     := persian-calendar
DIR     := package
STY     := $(DIR)/tex/$(PKG).sty
DEMOS   := $(basename $(notdir $(wildcard $(DIR)/sample/*.tex)))
DATE    := $(shell grep "pcalendardate{" $(STY) | cut -d'{' -f2 | tr -d '}')
VERSION := $(shell grep "pcalendarversion{" $(STY) | cut -d'{' -f2 | tr -d '}')
YEAR    := $(shell date +%Y)

.PHONY: all
all: readme test doc cleanup

# Compile every package/sample/*.tex with XeLaTeX (they typeset Persian, so they need xepersian and the Parisa font; the package itself does not).
# Stops at the first TeX error, so a broken conversion macro fails the build.
.PHONY: sample
sample:
	cd $(DIR)/sample && for f in $(DEMOS); do \
	  TEXINPUTS=../tex: xelatex -interaction=nonstopmode -halt-on-error $$f || exit 1; \
	done

.PHONY: test
test: sample

# Regression tests (package/testfiles/*.lvt vs *.tlg); use `l3build save <name>` to record a new baseline.
.PHONY: check
check:
	cd $(DIR) && l3build check

# Build the English and Persian manuals (they typeset Persian, so they need xepersian, the Parisa font and XB Niloofar).
.PHONY: doc
doc:
	cd $(DIR)/doc && for f in $(PKG)-doc $(PKG)-doc-fa; do \
	  for i in 1 2; do TEXINPUTS=../tex: xelatex -interaction=nonstopmode -halt-on-error $$f || exit 1; done; \
	done

# Install the package into the local texmf tree for use from any document.
.PHONY: dev
dev:
	TEXMF_LOCAL=$$(kpsewhich -var-value TEXMFLOCAL) && \
	sudo mkdir -p "$$TEXMF_LOCAL/tex/latex/$(PKG)" && \
	sudo cp -v $(STY) "$$TEXMF_LOCAL/tex/latex/$(PKG)" && \
	sudo mktexlsr

.PHONY: clean
clean:
	@rm -fv ./*~
	@rm -rfv $(DIR)/build
	@rm -fv $(DIR)/{sample,doc}/*.{aux,log,toc,out,xdv}

.PHONY: cleanup
cleanup: clean

# CTAN archive: persian-calendar/{README,tex/,doc/}, built from package/, zipped as persian-calendar.zip (no version in the name).
.PHONY: ctan
ctan: readme doc
	(cd $(DIR)/sample && for f in $(DEMOS); do for i in 1 2; do \
	  TEXINPUTS=../tex: xelatex -interaction=nonstopmode -halt-on-error $$f || exit 1; \
	done; done)
	rm -rf $(PKG) $(PKG).zip
	mkdir -p $(PKG)/tex $(PKG)/doc
	cp -v $(DIR)/README $(PKG)
	cp -v $(STY) $(PKG)/tex
	cp -v $(DIR)/sample/*.tex $(DIR)/sample/*.pdf $(PKG)/doc
	cp -v $(DIR)/doc/*.tex $(DIR)/doc/*.pdf $(PKG)/doc
	zip -r $(PKG).zip $(PKG)
	rm -rf $(PKG)
	$(MAKE) cleanup

# Same content as `ctan` (whose zip is kept for ctan.org), packed with maximum compression for archiving,
# as persian-calendar-vVERSION-YYYYMMDD.tar.xz with a top folder of the same name.
ARCHIVE := $(PKG)-v$(VERSION)-$(subst /,,$(DATE)).tar.xz
.PHONY: ctan-archive
ctan-archive: ctan
	rm -rf .archive && mkdir .archive && unzip -q $(PKG).zip -d .archive
	tar -C .archive --transform 's,^$(PKG),$(ARCHIVE:.tar.xz=),' -cf - $(PKG) | xz -9e -T0 > $(ARCHIVE)
	rm -rf .archive
	@echo "Created $(ARCHIVE)"

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
	  "" \
	  "Copyright © 2015-$(YEAR)" \
	  "This package may be distributed and/or modified under the terms of the LaTeX Project Public License," \
	  "version 1.3c or later (at your option). The latest version of" \
	  "the license is at: http://www.latex-project.org/lppl.txt" \
	  "" \
	  "This work has the LPPL maintenance status 'author-maintained'." > $(DIR)/README
