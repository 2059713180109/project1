
/* description: Parses and executes mathematical expressions. */

/* lexical grammar */
%lex
%%

\s+                   /* skip whitespace */
"//"([^[\n\r]])*(\r|\n|\r\n)?			/* skip linecoment */
"/*"[^'?']*"*/"			/*skip multi line coment*/
/*WORD RESERVED*/
"let"						    return	'let_'
"const"						    return	'const_'
"number"						return	'number_'
"string"						return	'string_'
"boolean"						return	'boolean_'
"void"						    return  'void_'
"null"  return 'null_'
"type"  return 'type_'
"push"  return 'push_'
"pop"   return 'pop_'
"length"    return 'length_'
","    return 'coma_'



/*OPERATORS*/
"="                   	return 'igual'
":"                   	return 'dos_puntos'
/*OPERATORS*/


/*REGULAR EXPRESSIONS*/

"true"|"false"						return 'bool'
[0-9]+("."[0-9]+)?\b  				return 'num'
"“"[^\"\n]*"”" 				return 'str'
"\""[^\"\n]*"\"" 			return 'str'
"'"[^''\n]*"'" 				return 'str'
"‘"[^''\n]*"’" 				return 'str'
[a-zA-Z]([a-zA-Z0-9]|"_")*			return 'id'
<<EOF>>               return 'EOF'
.                     return 'INVALID'

/lex

/* operator associations and precedence */





%start S

%% /* language grammar */


/*********************************************************************************************/
/*********************************************************************************************/
/***********************************	S	**************************************************/
/*********************************************************************************************/
/*********************************************************************************************/


S
    : DECLARACIOINES EOF
        {   }
    ;

/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/

DECLARACIOINES: DECLARACION DECLARACIOINES
			|
			;

/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/

TDATO:	number_     {$$=$1;}
		|string_    {$$=$1;}
		|boolean_   {$$=$1;}
		|id         {$$=$1;}
		|void_      {$$=$1;}
		;

/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/

DECLARACION:	DEC_DECLAVAR
				;

/*++++++++++++++++++++++++++++++++++++++++++++++++++++++++ DECLARACION DE VARIABLES +*/

DEC_DECLAVAR:	const_ D_VAR LIST_VAR
                |let_ D_VAR LIST_VAR
				;

LIST_VAR:       coma_  D_VAR  LIST_VAR
                |
                ;


D_VAR:          id  D_VAR_P1
                ;

D_VAR_P1:       igual T
                |dos_puntos TDATO D_VAR_P2
                |
                ;

D_VAR_P2:       igual T
                |
                ;


T:              num
                |bool
                |str
                ;

