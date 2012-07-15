#VPATH=src/genomes
GENOMESSRCS=$(wildcard src/genomes/*.flam3)
GENOMESOBJS=$(patsubst src/genomes/%.flam3,bin/genomes/%.png, $(GENOMESSRCS))
GALLERIESSRCS=$(wildcard src/galleries/*/*.flam3)
GALLERIESOBJS=$(patsubst src/galleries/%.flam3,bin/galleries/%.png, $(GALLERIESSRCS))
GALLERIESDIRS=$(patsubst src/galleries/%,bin/galleries/%, $(wildcard src/galleries/*))
#OBJS=$(patsubst %.flam3,%.png, $(SRCS))
#OBJS=$(SRCS:.flam3=.png)


#.SUFFIXES: .png .flam3

# From .flam3 to .png
bin/genomes/%.png: src/genomes/%.flam3
	env out=$@.part in=$< flam3-render && mv $@.part $@

bin/galleries/%.png: src/galleries/%.flam3
	ln -s ../../genomes/$(@F) $@

all: genomes galleries
	
genomes: $(GENOMESOBJS)

galleries: $(GALLERIESOBJS)

clean:
	rm -rf bin

$(GENOMESOBJS): | bin/genomes

$(GALLERIESOBJS): | $(GALLERIESDIRS)

bin/genomes:
	mkdir -p bin/genomes

$(GALLERIESDIRS):
	mkdir -p $@

.PHONY: all genomes galleries clean
