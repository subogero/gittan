all: gittan.html5
	midori gittan.html5

gittan.html5: gittan.md ~/.pandoc/s5/* Makefile
	pandoc -s -t s5 --slide-level 2 --self-contained -o gittan.html5 gittan.md
