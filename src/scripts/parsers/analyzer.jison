
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
"."    return 'punto_'
"function"  return 'function_'
"if"						return	'if_'
"else"						return	'else_'
"switch"					return	'switch_'
"case"						return	'case_'
"default"					return	'default_'
"while"						return	'while_'
"do"						return	'do_'
"for"						return	'for_'
"in"						return	'in_'
"of"						return	'of_'
"return"					return	'return_'
"break"						return	'break_'
"continue"					return	'continue_'



"["						return	'cor_abre'
"]"						return	'cor_cierra'
"{"						return	'llave_abre'
"}"						return	'llave_cierra'
"("						return	'par_abre'
")"						return	'par_cierra'
"&&"					return	'and_'
"||"					return	'or_'
"!"						return	'not_'
"?"						return	'interrogacion_'

"<="					return	'menor_igual'
"<"						return	'menor'
">="					return	'mayor_igual'
">"						return	'mayor'
"=="					return	'igual_igual'
"!="					return	'diferente'
"++"					return 	'incremento_'
"--"					return 	'decremento_'

/*OPERATORS*/
"="                   	return 'igual'
":"                   	return 'dos_puntos'
";"                   	return 'punto_coma'
/*ARITHMETIC OPERATORS */
"**"                   	return 'pot'
"*"                   	return 'por'
"/"                   	return 'div'
"-"                   	return 'menos'
"+"                   	return 'mas'
"%"                   	return 'mod'


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


%left 'mas' 'menos'
%left 'por' 'div' 'mod'
%right 'pot'
%left 'or_'
%left 'and_'

%left 'not_'

%right 'interrogacion_'
%right 'return_'

%start S

%% /* language grammar */


/*********************************************************************************************/
/*********************************************************************************************/
/***********************************	S	**************************************************/
/*********************************************************************************************/
/*********************************************************************************************/


S
    : SENTENCIAS EOF
        {   }
    ;

/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++SENTENCIAS++++++++++++*/

SENTENCIAS: SENTENCIA SENTENCIAS
			|
			;

/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/

SENTENCIA:	    DEC_DECLAVAR punto_coma
                |DEC_FUN punto_coma
                |DEC_TYPE punto_coma
                |ASIGNACION punto_coma
                |IF
                |WHILE
                |DO_WHILE punto_coma
                |SWITCH
                |FOR
                |BREAK punto_coma
                |CONTINUE punto_coma
                |RETURN punto_coma
				;



/*++++++++++++++++++++++++++++++++++++++++++++++++++++++++ DECLARACION DE TIPOS +*/

DEC_TYPE:       type_ id igual llave_abre LIST_ATRIBUTOS llave_cierra
                ;

LIST_ATRIBUTOS: id dos_puntos TDATO  LIST_ATRIBUTOS_P
                ;

LIST_ATRIBUTOS_P:   coma_ id dos_puntos TDATO LIST_ATRIBUTOS_P
                    |
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

D_VAR_P2:       igual CONDICION_OR
                |
                ;





/*++++++++++++++++++++++++++++++++++++++++++++++++++++++++ DECLARACION DE FUNCIONES +*/

DEC_FUN:        function_ id par_abre LIST_PAR par_cierra dos_puntos TDATO llave_abre SENTENCIAS llave_cierra
                ;

LIST_PAR:       PARAM LIST_PAR_P
                |
                ;

LIST_PAR_P:     coma_ PARAM LIST_PAR_P
                |
                ;

PARAM:          id  dos_puntos  TDATO
                ;


/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*****************CONDICION++*/


CONDICION_OR:   CONDICION_AND CONDICION_OR_P
                ;

CONDICION_OR_P: or_ CONDICION_OR
                |
                ;

CONDICION_AND:  CONDICION CONDICION_AND_P
                ;

CONDICION_AND_P:    and_ CONDICION_AND
                    |
                    ;

CONDICION:       COND TERNARIO
                ;

TERNARIO:       interrogacion_ COND dos_puntos COND
                |
                ;

COND:	    E SIG_REL E
			|E
			;


/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*********************EXPRESION++*/
//======================== E => E + E | E - E ;

E:          F  E_P;

E_P:        mas F E_P
            |menos F E_P
            |
            ;

//======================== E => E * E | E / E | E % E ;
F:          R  F_P;

F_P:        por R F_P
            |div R F_P
            |mod R F_P
            |
            ;

//======================== E = E ^ E ;
R:          T   R_P     ;

R_P:        pot T R_P
            |
            ;


/*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*********+********** VALORES ++++*/

T:              T_P
                |menos T_P
                |not_ T_P
                ;

T_P:             par_abre CONDICION_OR par_cierra
                |num
                |bool
                |str
                |null_
                |ARREGLO
                |OBJETO_FUNCION UNARIO
                ;

NEGATIVO:       menos
                |;

UNARIO:         incremento_
                |decremento_
                |
                ;

/*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*********+********** ARREGLO ++++*/

ARREGLO:        cor_abre ELEMENTOS cor_cierra;

ELEMENTOS:      CONDICION_OR ELEMENTOS_P
                |
                ;

ELEMENTOS_P:     coma_  CONDICION_OR  ELEMENTOS_P
                |
                ;

/*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*********+********** OBJETOS ++++*/
/**
* T => FUNCION | OBJETO ;
* FUNCION:        id PARAMETROS_FUNCION;
* OBJETO:         id DIMENSION ;
*/

OBJETO_FUNCION: id OBJ_FUN_CUERPO;

OBJ_FUN_CUERPO: PARAMETROS_FUNCION SUB_OBJETO
                | DIMENSION SUB_OBJETO
                ;

SUB_OBJETO:     punto_  OB_ATRIBUTO
                |
                ;

OB_ATRIBUTO:    id DIMENSION SUB_OBJETO
                |push_ PARAMETROS_FUNCION SUB_OBJETO
                |pop_ PARAMETROS_FUNCION SUB_OBJETO
                |length_ PARAMETROS_FUNCION SUB_OBJETO
                ;


DIMENSION:      cor_abre CONDICION_OR cor_cierra DIMENSION
                |
                ;



PARAMETROS_FUNCION:     par_abre ARGUMENTOS par_cierra
                        ;


ARGUMENTOS:             CONDICION_OR ARGUMENTOS_P
                        |
                        ;


ARGUMENTOS_P:           coma_  CONDICION_OR  ARGUMENTOS_P
                        |
                        ;



/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ASIGNACION++++++++++++*/

ASIGNACION:             id igual CONDICION_OR;



/*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*********+TIPOS DE DATOS ++++++++*/

TDATO:	number_     {$$=$1;}
		|string_    {$$=$1;}
		|boolean_   {$$=$1;}
		|id         {$$=$1;}
		|void_      {$$=$1;}
		;

/*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++OPERADORES RELACIONALES+*/

 SIG_REL :      menor
                |mayor
                |menor_igual
                |mayor_igual
                |igual_igual
                |diferente
		;



/*********************************************************************************************/
/*********************************************************************************************/
/*******************************	ESTRUCTURAS DE CONTROL	**********************************/
/*********************************************************************************************/


/******************************************************************************************************* IF ***/

IF_SENTENCE:    llave_abre SENTENCIAS llave_cierra;

IF_CONDICION:   par_abre CONDICION_OR par_cierra;

IF_STATEMENT:   if_ IF_CONDICION IF_SENTENCE ;


IF:		        IF_STATEMENT ELSE_IF ;

ELSE_IF:    else_ ELSE_IF_P
            |
            ;

ELSE_IF_P:  IF_STATEMENT ELSE_IF
            |IF_SENTENCE
            ;



/****************************************************************************************************** WHILE ***/

WHILE:      while_ IF_CONDICION IF_SENTENCE ;

DO_WHILE:   do_  IF_SENTENCE while_ IF_CONDICION ;



/****************************************************************************************************** SWITCH ***/

SWITCH:     switch_ IF_CONDICION llave_abre CASOS llave_cierra ;

CASOS:      case_ CONDICION_OR dos_puntos SENTENCIAS CASOS
            |default_ dos_puntos SENTENCIAS
            |
            ;


/****************************************************************************************************** FOR  ***/

FOR:        for_ par_abre FOR_P
            ;

FOR_P:      let_ FOR_LET
            |const_ FOR_CONST
            ;

FOR_LET:    FOR_TRADICIONAL
            |FOR_OF
            ;

FOR_TRADICIONAL:    id igual CONDICION_OR punto_coma CONDICION_OR punto_coma FOR_TRADICIONAL_INC par_cierra IF_SENTENCE;

FOR_TRADICIONAL_INC:    ASIGNACION
                        |CONDICION_OR
                        ;

FOR_OF:                 id of_ id par_cierra IF_SENTENCE;

FOR_CONST:              id in_ id par_cierra IF_SENTENCE;



/****************************************************************************************************** OTHERS ***/

BREAK:                  break_;

CONTINUE:               continue_;

RETURN:                 return_  RETURN_P
                        ;

RETURN_P:               CONDICION_OR
                        |
                        ;