		               /* ---- PROLOGUE ---- */
%{

//HW 2, Lexical Analyser using Flex
//CS3500 Secion A
//GEOFFREY CLINE
//March 25,2016

#include <iostream>

using namespace std;

int no_lines  = 0;
int no_tokens = 0;

void printlex(const string txt, const int type);

const string TYPES[]={"INTCONST","DECCONST","SCICONST","HEXCONST","BINCONST",
                      "KEYWORD","IDENT","STRCONST","OPERATOR","?"};
%}
		              /* ---- DEFINITIONS ---- */
%option noyywrap
DIGIT		[0-9]
OPERATORS 	"+"|"-"|"*"|"/"|"<"|">"|"&"
KEYS		"if"|"else"|"func"|"let"|"print"|"while"

%%  		              /* ---- REGULAR EXPRESSIONS ---- */
"%"(.)*					{}
[ \t]					;
\n					{ no_lines++; }
[+-]?{DIGIT}+				{printlex(yytext,0); no_tokens++;}
[+-]?{DIGIT}+\.{DIGIT}+			{printlex(yytext,1); no_tokens++;}
[+-]?{DIGIT}+\.{DIGIT}+E[+-]?{DIGIT}+	{printlex(yytext,2); no_tokens++;}
[A-F0-9]+H				{printlex(yytext,3); no_tokens++;}
[01]+B    				{printlex(yytext,4); no_tokens++;}
{KEYS}   				{printlex(yytext,5); no_tokens++;}
[a-zA-Z][a-zA-Z0-9]*    		{printlex(yytext,6); no_tokens++;}
\"[a-zA-Z0-9 ]*\"    			{printlex(yytext,7); no_tokens++;}
{OPERATORS}  				{printlex(yytext,8); no_tokens++;}
.					{printlex(yytext,9); no_tokens++;}
%%  		              /* ---- EPILOGUE ---- */

int main()
{
    yylex();
    cout << no_lines << " lines processed."<< endl;
    return 0;
}

void printlex(const string txt, const int type)
{
	cout << "#" << no_tokens << ": TOKEN: " << TYPES[type];
	if(type == 9)
		cout << "\t";
	cout << "\tLEXEME: " <<  txt << endl;

	return;
}
