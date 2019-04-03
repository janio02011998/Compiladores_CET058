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
   enum yytokentype{
    NUMBER = 258,    
    ADD = 259,
    SUB = 260,
    MUL = 261,
    DIV = 262,
    ABS = 263,
    EOL = 264
    };
    
    int yylval;
%}



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
IDENTIFICADOR       [_a-zA-Z][_a-zA-Z0-9]*  
OP_MATEMATICO       "**"|"+"|"\/"|"*"|"-"
INT                 [0-9]+
FLOAT	        	[0-9]+.[0-9]+
OP_REALACIONAL      "=="|">"|">="|"<"|"<="
OP_ATRIBUICAO       "="
VARIAVEL            [$][_a-zA-Z][_a-zA-Z0-9]*
SEPARADORES         "{"|"}"|"("|")"
STRING              \"([^\\\"]|\\.)*\"
PALAVRA_RESERVADA   "system.while"|"system.if"|"return"|"int"

/* FIM DA SEÇÃO DE DEFINIÇÕES */

%%
    /* SEÇAO DE REGRAS 
        Uma entrada por linha no formato:
        
        padrão  ação

    */
{IDENTIFICADOR}        {printf("<IDENTIFICADOR, %s> ", yytext); contador++;}
{OP_MATEMATICO}  {printf("<OP_MATEMATICO, %s> ", yytext); contador++;}
{INT}               {printf("<INT, %s> ", yytext); contador++;}
{FLOAT}               {printf("<FLOAT, %s> ", yytext); contador++;}
{OP_REALACIONAL}               {printf("<OP_REALACIONAL, %s> ", yytext); contador++;}
{OP_ATRIBUICAO}               {printf("<OP_ATRIBUICAO, %s> ", yytext); contador++;}
{VARIAVEL}               {printf("<VARIAVEL, %s> ", yytext); contador++;}
{SEPARADORES}               {printf("<SEPARADORES, %s> ", yytext); contador++;}
{STRING}               {printf("<STRING, %s> ", yytext); contador++;}
{PALAVRA_RESERVADA}               {printf("<PALAVRA_RESERVADA, %s> ", yytext); contador++;}

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
