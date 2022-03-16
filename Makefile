SRC_FLEX := src_flex
SRC_TEST := src_test
BUILDDIR := build
TARGETDIR := bin

FLEX_FILES := $(wildcard $(SRC_FLEX)/*.c)
TEST_FILES := $(wildcard $(SRC_TEST)/*.c)

OBJ_FILES := $(patsubst $(BUILDDIR)/%.c,$(BUILDDIR)/%.c,$(FLEX_FILES))

FLAGS= -lfl

all: clear flex compile run

flex:
	@echo *Iniciando compilacao
	flex -o $(BUILDDIR)/lex.c $(SRC_FLEX)/lexico.l
	
compile: 
	gcc $(FLAGS)  $(BUILDDIR)/* -o $(TARGETDIR)/tradutor
	@echo *Compilacao concluida. Arquivo de saida: tradutor

run: 
	./$(TARGETDIR)/tradutor src_test/test.c

clear:
	@echo *Limpando diretorios
	rm -rf $(BUILDDIR)/* $(TARGETDIR)/*
