# Compiladores

## Introducão
> Disciplina de Compiladores - Universidade de Brásilia 2022/01
Wellington Stanley 110143981
Walyson Maxwel - 140087851\
Gabriel Crespo 140139982\
Rodrigo Neris 140161597\

> Desenvolvimento de um tradutor

### Estrutura do projeto

    .
    ├── bin                     # Pasta de saída da compilação do tradutor
    ├── build                   # Arquivos intermediários de compilação
    ├── src_flex                # Pasta que deve conter o arquivo fonte léxico.c com as definições do tradutor
    ├── src_test                # Pasta que deve conter o arquivo fonte test.c com o código C a ser testado no tradutor
    ├── makefile                # MakeFile para facilitar a compilação/execução
    └── README.md

## Dependências
Código desenvolvido para linux
- FLEX - Fast Lexical Analyzer Generator
- C

## Compilação
Para compilação é necessário o utilitário MAKE\
4 comandos principais são disponibilizados e podem ser executados a partir do diretório root do projeto

| Comando | Função |
| ------ | ------ |
|**make flex**|   Traduz e expande o código fornecido em lexico.l|
|**make compile**|  Realiza a compilação do léxico expandido |
|**make run**|  Roda o tradutor utilizando o arquivo test.c como entrada |
|**make**|  clear + flex + compile - Realiza todas as etapas anteriores|
*Para comandos adicionais consulte o arquivo makefile no diretório root*

## Execução
**make** ou **make run**

