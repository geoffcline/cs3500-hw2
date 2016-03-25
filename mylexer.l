		               /* ---- PROLOGUE ---- */
%{
#include <iostream>
using namespace std;

int no_lines = 0;
%}
		              /* ---- DEFINITIONS ---- */
%option noyywrap
DIGIT		[0-9]
OPERATORS 	"+"|"-"|"*"|"/"|"<"|">" |"&"
KEYWORD		"if"|"else"| "func"|"let"|"print"|"while"

%%  		              /* ---- REGULAR EXPRESSIONS ---- */

[ \t]           ;
\n              { no_lines++; }
[+-]?{DIGIT}+        						{ cout << "#" << no_lines << ": TOKEN: INTCONST: " << yytext << endl; }
[+-]?{DIGIT}+\.{DIGIT}+        					{ cout << "Found an DECCONST: " << yytext << endl; }
[+-]?{DIGIT}+\.{DIGIT}+E[+-]?{DIGIT}+        			{ cout << "Found an SCICONST: " << yytext << endl; }
[A-F0-9]+H    							{ cout << "Found a HEXCONST: " << yytext << endl; }
[0-1]+B    							{ cout << "Found a BINCONST: " << yytext << endl; }
"if" | "else" | "func" | "let" | "print" | "while"    		{ cout << "Found a KEYWORD: " << yytext << endl; }
[a-zA-Z][a-zA-Z0-9]+    					{ cout << "Found a IDENT: " << yytext << endl; }
\"[a-zA-Z0-9 ]*\"    						{ cout << "Found a STRCONST: " << yytext << endl; }
{OPERATORS}  							{ cout << "Found a OPERATOR: " << yytext << endl; }


%%  		              /* ---- EPILOGUE ---- */

int main()
{
    cout << "Hello FLEX" << endl;
    yylex();
    cout << "Done!" << endl;
    return 0;
}
