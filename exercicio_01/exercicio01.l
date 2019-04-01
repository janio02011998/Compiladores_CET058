/* 
Crie um Analisador Léxico utilizando Flex que consiga gerar os tokens
do arquivo de entrada "exercicio01.in" que consiste em um código na
linguagem C. O analisador deverá identificar todos os tokens referentes a:

1. Identificadores
2. Números Inteiros
3. Números de Ponto Flutuante
4. Palavras reservadas
5. Operadores Matemáticos e Relacionais
6. Chaves, Colchetes e Chaves

utilize os exemplos no diretório "flex" como ponto de partida.
*/

/*

- Para gerar o fonte digite
$ lex ex01.l

- Para compilar o fonte me C gerado digite
$ gcc ex01.yy.c

- Para executar
$ ./a.out

*/   


/* SEÇÃO DE DEFINIÇÕES */

%{
    /*
        Definições que estarão disponíveis 
            - variáveis
            - constantes
        O que for aqui será copiado para o arquivo *.yy.c
    
        Variáveis declaradas aqui estarão acessível nas funções yylex() e 
        main().
    */
    int contador = 0;
%}

/* Definições de Nomes */
PALAVRAS_RESERVADAS "int"|"float"|"unsigned"|"if"|"include"
IDENTIFICADOR       [_a-zA-Z][_a-zA-Z0-9]*  
OP_MATEMATICO        "**"|"+"|"\/"|"*"|"-"
INT                 [0-9]+
FLOAT	        	[0-9]+.[0-9]+
OP_REALACIONAL      "=="|">"|">="|"<"|"<="
OP_ATRIBUICAO       "="
SEPARADORES         "{"|"}"|"("|")"
FIM_DE_LINHA        ";"

/* FIM DA SEÇÃO DE DEFINIÇÕES */

%%
    /* SEÇAO DE REGRAS 
        Uma entrada por linha no formato:
        
        padrão  ação

    */
{PALAVRAS_RESERVADAS}               {printf("<PALAVRAS_RESERVADAS, %s>", yytext); contador++;}
{IDENTIFICADOR}        {printf("<IDENTIFICADOR, %s>", yytext); contador++;}
{OP_MATEMATICO}  {printf("<OP_MATEMATICO, %s>", yytext); contador++;}
{INT}               {printf("<INT, %s>", yytext); contador++;}
{FLOAT}               {printf("<FLOAT, %s>", yytext); contador++;}
{OP_REALACIONAL}               {printf("<OP_REALACIONAL, %s>", yytext); contador++;}
{OP_ATRIBUICAO}               {printf("<OP_ATRIBUICAO, %s>", yytext); contador++;}

{SEPARADORES}               {printf("<SEPARADORES, %s>", yytext); contador++;}
{FIM_DE_LINHA}               {printf("<FIM_DE_LINHA, %s>", yytext); contador++;}

<<EOF>>                return 0;
    
%%

/*
Seção de Código do Usuário
*/

int yywrap() {}
int main() {
    printf("Iniciando Análise Léxica...\n---\n");
    yylex();
    printf("Foram encontradas %d ocorrências de identificadores.\n", contador);
    printf("---\nÁnalise Finalizada!\n");
    
    return 0;
}
