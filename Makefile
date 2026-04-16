OUTPUT = Kevin_Joseph_Resume_2026

all:
	latexmk -pdf -jobname=$(OUTPUT) resume.tex

clean:
	latexmk -C -jobname=$(OUTPUT) resume.tex
