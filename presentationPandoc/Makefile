pres.html: pres.md Makefile
	pandoc $< -t revealjs --bibliography=biblio.bib --citeproc --filter pandoc-eqnos --shift-heading-level=0 -s --slide-level 2 --toc -V theme=simple -V fontsize=14pt -o $@
