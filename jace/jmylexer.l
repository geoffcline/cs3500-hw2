%{
#include <iostream>
using namespace std;

int lines = 0;
int tokens = 0;
%}

%option noyywrap
DIGIT [0-9]
ALPHA [a-zA-Z]
HEXA [ABCDEF]
KEY "if"|"else"|"func"|"let"|"print"|"while"
OPERATOR "+"|"-"|"*"|"/"|"<"|">"|"&"

%%

"%"(.)*					{}
[ \t]					{}
{KEY}					{cout << "#" << tokens << ": TOKEN: KEYWORD    LEXEME: " << yytext << endl; ++tokens;}
{OPERATOR}				{cout << "#" << tokens << ": TOKEN: OPERATOR   LEXEME: " << yytext << endl; ++tokens;}
({DIGIT}|{HEXA})+H 			{cout << "#" << tokens << ": TOKEN: HEXCONST   LEXEME: " << yytext << endl; ++tokens;}
(0|1)+B 				{cout << "#" << tokens << ": TOKEN: BINCONST   LEXEME: " << yytext << endl; ++tokens;}
(\+|\-)?{DIGIT}+\.{DIGIT}+E{DIGIT}+ 	{cout << "#" << tokens << ": TOKEN: SCICONST   LEXEME: " << yytext << endl; ++tokens;}
(\+|\-)?{DIGIT}+\.{DIGIT}+ 		{cout << "#" << tokens << ": TOKEN: DECCONST   LEXEME: " << yytext << endl; ++tokens;}
(\+|\-)?{DIGIT}+			{cout << "#" << tokens << ": TOKEN: INTCONST   LEXEME: " << yytext << endl; ++tokens;}
{ALPHA}({ALPHA}|{DIGIT})*		{cout << "#" << tokens << ": TOKEN: IDENT      LEXEME: " << yytext << endl; ++tokens;}
\"([ ]|{DIGIT}|{ALPHA})*\"		{cout << "#" << tokens << ": TOKEN: STRCONST   LEXEME: " << yytext << endl; ++tokens;}
.					{cout << "#" << tokens << ": TOKEN: ?          LEXEME: " << yytext << endl; ++tokens;}
\n					{lines++;}


%%

int main(void) {
    yylex();
    cout << lines << " lines processed." << endl;
    return 0;
}
