
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
"console"                   return  'console_'
"log"                       return  'log_'
"graficar_ts"               return  'graficar_ts'


"<="					return	'menor_igual'
"<"						return	'menor'
">="					return	'mayor_igual'
">"						return	'mayor'
"=="					return	'igual_igual'
"!="					return	'diferente'
"++"					return 	'incremento_'
"--"					return 	'decremento_'


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

/*OPERATORS*/
"+="                   	return 'mas_igual'
"-="                   	return 'menos_igual'
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
"`"[^''\n]*"`" 				return 'str'
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
%right 'dos_puntos'

%start S

%% /* language grammar */


/*********************************************************************************************/
/*********************************************************************************************/
/***********************************	S	**************************************************/
/*********************************************************************************************/
/*********************************************************************************************/


S
    : SENTENCIAS EOF
                {{
                    hijos = [];
                    hijos.push($1);
                    hijos.push(new Nodo(EOF,undefined,undefined,yystate,DataType.UNTYPED));
                    $$=new Nodo("S=>SENTENCIAS EOF",0,hijos,yystate);
                    _backEnd.root = $$;
                }}
    ;

/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++SENTENCIAS++++++++++++*/

SENTENCIAS: SENTENCIA SENTENCIAS
                {{
                    hijos = [];
                    hijos.push($1);
                    hijos.push($2);
                    $$=new Nodo("SENTENCIAS=>SENTENCIA SENTENCIAS",0,hijos,yystate);
                }}
			|
                {{
                    hijos = [];
                    hijos.push(new Nodo(EPSILON,undefined,undefined,yystate,DataType.EPSILON));
                    $$=new Nodo("SENTENCIAS=>",0,hijos,yystate);
                }}
			;

/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/

SENTENCIA:	    DEC_DECLAVAR punto_coma
                {{
                    hijos = [];
                    hijos.push($1);
                    hijos.push(new Nodo($2,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    $$=new Nodo("SENTENCIA=>DEC_DECLAVAR punto_coma",0,hijos,yystate);
                }}
                |DEC_FUN
                {{
                    hijos = [];
                    hijos.push($1);
                    $$=new Nodo("SENTENCIA=>DEC_FUN",0,hijos,yystate);
                }}
                |DEC_TYPE punto_coma
                {{
                    hijos = [];
                    hijos.push($1);
                    $$=new Nodo("SENTENCIA=>DEC_TYPE punto_coma",0,hijos,yystate);
                }}
                |ASIGNACION punto_coma
                {{
                    hijos = [];
                    hijos.push($1);
                    hijos.push(new Nodo($2,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    $$=new Nodo("SENTENCIA=>ASIGNACION punto_coma",0,hijos,yystate);
                }}
                |IF
                {{
                    hijos = [];
                    hijos.push($1);
                    $$=new Nodo("SENTENCIA=>IF",0,hijos,yystate);
                }}
                |WHILE
                {{
                    hijos = [];
                    hijos.push($1);
                    $$=new Nodo("SENTENCIA=>WHILE",0,hijos,yystate);
                }}
                |DO_WHILE punto_coma
                {{
                    hijos = [];
                    hijos.push($1);
                    hijos.push(new Nodo($2,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    $$=new Nodo("SENTENCIA=>DO_WHILE punto_coma",0,hijos,yystate);
                }}
                |SWITCH
                {{
                    hijos = [];
                    hijos.push($1);
                    $$=new Nodo("SENTENCIA=>SWITCH",0,hijos,yystate);
                }}
                |FOR
                {{
                    hijos = [];
                    hijos.push($1);
                    $$=new Nodo("SENTENCIA=>FOR",0,hijos,yystate);
                }}
                |BREAK punto_coma
                {{
                    hijos = [];
                    hijos.push($1);
                    hijos.push(new Nodo($2,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    $$=new Nodo("SENTENCIA=>BREAK punto_coma",0,hijos,yystate);
                }}
                |CONTINUE punto_coma
                {{
                    hijos = [];
                    hijos.push($1);
                    hijos.push(new Nodo($2,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    $$=new Nodo("SENTENCIA=>CONTINUE punto_coma",0,hijos,yystate);
                }}
                |RETURN punto_coma
                {{
                    hijos = [];
                    hijos.push($1);
                    hijos.push(new Nodo($2,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    $$=new Nodo("SENTENCIA=>RETURN punto_coma",0,hijos,yystate);
                }}
                |OBJETO_FUNCION UNARIO punto_coma
                {{
                    hijos = [];
                    hijos.push($1);
                    hijos.push(new Nodo($2,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    $$=new Nodo("SENTENCIA=>OBJETO_FUNCION UNARIO punto_coma",0,hijos,yystate);
                }}
                |CONSOLA punto_coma
                {{
                    hijos = [];
                    hijos.push($1);
                    hijos.push(new Nodo($2,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    $$=new Nodo("SENTENCIA=>CONSOLA punto_coma",0,hijos,yystate);
                }}
                |GRAFICAR punto_coma
                {{
                    hijos = [];
                    hijos.push($1);
                    hijos.push(new Nodo($2,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    $$=new Nodo("SENTENCIA=>GRAFICAR punto_coma",0,hijos,yystate);
                }}
                |error
                {{
                    hijos = [];
                    hijos.push(new Nodo(ERROR,undefined,undefined,yystate,DataType.ERROR));
                    $$=new Nodo("SENTENCIA=>error",0,hijos,yystate);
                    _backEnd.listaErrores.addError(this._$.last_line,this._$.last_column,ErrorType.SYNTACTIC,"No se esperaba: '"+yytext+"'.");
                }}
				;



/*++++++++++++++++++++++++++++++++++++++++++++++++++++++++ DECLARACION DE TIPOS +*/

DEC_TYPE:       type_ id igual llave_abre LIST_ATRIBUTOS llave_cierra
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push(new Nodo($2,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push(new Nodo($3,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push(new Nodo($4,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push($5);
                    hijos.push(new Nodo($6,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    $$=new Nodo("DEC_TYPE=>type_ id igual llave_abre LIST_ATRIBUTOS llave_cierra",0,hijos,yystate);
                }}
                ;

LIST_ATRIBUTOS: DEC_ATRIBUTO  LIST_ATRIBUTOS_P
                {{
                    hijos = [];
                    hijos.push($1);
                    hijos.push($2);
                    $$=new Nodo("LIST_ATRIBUTOS=>DEC_ATRIBUTO  LIST_ATRIBUTOS_P",0,hijos,yystate);
                }}

                ;

LIST_ATRIBUTOS_P:   coma_ DEC_ATRIBUTO LIST_ATRIBUTOS_P
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push($2);
                    hijos.push($3);
                    $$=new Nodo("LIST_ATRIBUTOS_P=>coma_ DEC_ATRIBUTO LIST_ATRIBUTOS_P",0,hijos,yystate);
                }}
                    |
                {{
                    hijos = [];
                    hijos.push(new Nodo(EPSILON,undefined,undefined,yystate,DataType.EPSILON));
                    $$=new Nodo("LIST_ATRIBUTOS_P=>",0,hijos,yystate);
                }}
                    ;

DEC_ATRIBUTO:       id dos_puntos TDATO
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push(new Nodo($2,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push($3);
                    $$=new Nodo("DEC_ATRIBUTO=>id dos_puntos TDATO",0,hijos,yystate);
                }};

/*++++++++++++++++++++++++++++++++++++++++++++++++++++++++ DECLARACION DE VARIABLES +*/


DEC_DECLAVAR:	const_ D_VAR LIST_VAR
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push($2);
                    hijos.push($3);
                    $$=new Nodo("DEC_DECLAVAR=>const_ D_VAR LIST_VAR",0,hijos,yystate);
                }}
                |let_ D_VAR LIST_VAR
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push($2);
                    hijos.push($3);
                    $$=new Nodo("DEC_DECLAVAR=>let_ D_VAR LIST_VAR",0,hijos,yystate);
                }}
				;

LIST_VAR:       coma_  D_VAR  LIST_VAR
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push($2);
                    hijos.push($3);
                    $$=new Nodo("LIST_VAR=>coma_  D_VAR  LIST_VAR",0,hijos,yystate);
                }}
                |
                {{
                    hijos = [];
                    hijos.push(new Nodo(EPSILON,undefined,undefined,yystate,DataType.EPSILON));
                    $$=new Nodo("LIST_VAR=>",0,hijos,yystate);
                }}
                ;


D_VAR:          id  D_VAR_P1
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push($2);
                    $$=new Nodo("D_VAR=>id  D_VAR_P1",0,hijos,yystate);
                }}

                ;

D_VAR_P1:       igual CONDICION_TER
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push($2);
                    $$=new Nodo("D_VAR_P1=>igual CONDICION_TER",0,hijos,yystate);
                }}
                |dos_puntos TDATO D_VAR_P2
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push($2);
                    hijos.push($3);
                    $$=new Nodo("D_VAR_P1=>dos_puntos TDATO D_VAR_P2",0,hijos,yystate);
                }}
                |
                {{
                    hijos = [];
                    hijos.push(new Nodo(EPSILON,undefined,undefined,yystate,DataType.EPSILON));
                    $$=new Nodo("D_VAR_P1=>",0,hijos,yystate);
                }}
                ;

D_VAR_P2:       igual CONDICION_TER
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push($2);
                    $$=new Nodo("D_VAR_P2=>igual CONDICION_TER",0,hijos,yystate);
                }}

                |
                {{
                    hijos = [];
                    hijos.push(new Nodo(EPSILON,undefined,undefined,yystate,DataType.EPSILON));
                    $$=new Nodo("D_VAR_P2=>",0,hijos,yystate);
                }}
                ;





/*++++++++++++++++++++++++++++++++++++++++++++++++++++++++ DECLARACION DE FUNCIONES +*/

DEC_FUN:        function_ id par_abre LIST_PAR par_cierra dos_puntos TDATO llave_abre SENTENCIAS llave_cierra
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push(new Nodo($2,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push(new Nodo($3,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push($4);
                    hijos.push(new Nodo($5,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push(new Nodo($6,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push($7);
                    hijos.push(new Nodo($8,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push($9);
                    hijos.push(new Nodo($10,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    $$=new Nodo("DEC_FUN=>function_ id par_abre LIST_PAR par_cierra dos_puntos TDATO llave_abre SENTENCIAS llave_cierra",0,hijos,yystate);
                }}
                ;

LIST_PAR:       PARAM LIST_PAR_P
                {{
                    hijos = [];
                    hijos.push($1);
                    hijos.push($2);
                    $$=new Nodo("LIST_PAR=>PARAM LIST_PAR_P ",0,hijos,yystate);
                }}
                |
                {{
                    hijos = [];
                    hijos.push(new Nodo(EPSILON,undefined,undefined,yystate,DataType.EPSILON));
                    $$=new Nodo("LIST_PAR=>",0,hijos,yystate);
                }}
                ;

LIST_PAR_P:     coma_ PARAM LIST_PAR_P
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push($2);
                    hijos.push($3);
                    $$=new Nodo("LIST_PAR_P=>coma_ PARAM LIST_PAR_P",0,hijos,yystate);
                }}
                |
                {{
                    hijos = [];
                    hijos.push(new Nodo(EPSILON,undefined,undefined,yystate,DataType.EPSILON));
                    $$=new Nodo("LIST_PAR_P=>",0,hijos,yystate);
                }}
                ;

PARAM:          id  dos_puntos  TDATO
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push(new Nodo($2,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push($3);
                    $$=new Nodo("PARAM=>id  dos_puntos  TDATO",0,hijos,yystate);
                }}
                ;


/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*****************CONDICION++*/

CONDICION_TER:  CONDICION_OR TERNARIO
                {{
                    hijos = [];
                    hijos.push($1);
                    hijos.push($2);
                    $$=new Nodo("CONDICION_TER=>CONDICION_OR TERNARIO",0,hijos,yystate);
                }}
                ;

CONDICION_OR:   CONDICION_AND CONDICION_OR_P
                {{
                    hijos = [];
                    hijos.push($1);
                    hijos.push($2);
                    $$=new Nodo("CONDICION_OR=>CONDICION_AND CONDICION_OR_P",0,hijos,yystate);
                }}
                ;

CONDICION_OR_P: or_ CONDICION_OR
                |
                {{
                    hijos = [];
                    hijos.push(new Nodo(EPSILON,undefined,undefined,yystate,DataType.EPSILON));
                    $$=new Nodo("",0,hijos,yystate);
                }}
                ;

CONDICION_AND:  CONDICION CONDICION_AND_P
                {{
                    hijos = [];
                    hijos.push($1);
                    hijos.push($2);
                    $$=new Nodo("CONDICION_AND=>CONDICION CONDICION_AND_P",0,hijos,yystate);
                }}
                ;

CONDICION_AND_P:    and_ CONDICION_AND
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push($2);
                    $$=new Nodo("CONDICION_AND_P=>and_ CONDICION_AND",0,hijos,yystate);
                }}
                    |
                {{
                    hijos = [];
                    hijos.push(new Nodo(EPSILON,undefined,undefined,yystate,DataType.EPSILON));
                    $$=new Nodo("CONDICION_AND_P=>",0,hijos,yystate);
                }}
                    ;

TERNARIO:       interrogacion_ CONDICION_TER dos_puntos CONDICION_TER
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push($2);
                    hijos.push(new Nodo($3,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push($4);
                    $$=new Nodo("TERNARIO=>interrogacion_ CONDICION_TER dos_puntos CONDICION_TER",0,hijos,yystate);
                }}
                |
                {{
                    hijos = [];
                    hijos.push(new Nodo(EPSILON,undefined,undefined,yystate,DataType.EPSILON));
                    $$=new Nodo("TERNARIO=>",0,hijos,yystate);
                }}
                ;

CONDICION:	    E SIG_REL E
                {{
                    hijos = [];
                    hijos.push($1);
                    hijos.push($2);
                    hijos.push($3);
                    $$=new Nodo("CONDICION=>E SIG_REL E",0,hijos,yystate);
                }}
			    |E
                {{
                    hijos = [];
                    hijos.push($1);
                    $$=new Nodo("CONDICION=>E",0,hijos,yystate);
                }}
			    ;



/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*********************EXPRESION++*/
//======================== E => E + E | E - E ;

E:          F  E_P
                {{
                    hijos = [];
                    hijos.push($1);
                    hijos.push($2);
                    $$=new Nodo("E=>F  E_P",0,hijos,yystate);
                }}
                ;

E_P:        mas F E_P
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push($2);
                    hijos.push($3);
                    $$=new Nodo("E_P=> mas F E_P",0,hijos,yystate);
                }}
            |menos F E_P
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push($2);
                    hijos.push($3);
                    $$=new Nodo("E_P=>menos F E_P",0,hijos,yystate);
                }}
            |
                {{
                    hijos = [];
                    hijos.push(new Nodo(EPSILON,undefined,undefined,yystate,DataType.EPSILON));
                    $$=new Nodo("E_P=>",0,hijos,yystate);
                }}
            ;

//======================== E => E * E | E / E | E % E ;
F:          R  F_P
                {{
                    hijos = [];
                    hijos.push($1);
                    hijos.push($2);
                    $$=new Nodo("F=>R  F_P",0,hijos,yystate);
                }}
                ;

F_P:        por R F_P
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push($2);
                    hijos.push($3);
                    $$=new Nodo("F_P=>por R F_P",0,hijos,yystate);
                }}
            |div R F_P
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push($2);
                    hijos.push($3);
                    $$=new Nodo("F_P=>div R F_P",0,hijos,yystate);
                }}
            |mod R F_P
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push($2);
                    hijos.push($3);
                    $$=new Nodo("F_P=>mod R F_P",0,hijos,yystate);
                }}
            |
                {{
                    hijos = [];
                    hijos.push(new Nodo(EPSILON,undefined,undefined,yystate,DataType.EPSILON));
                    $$=new Nodo("F_P=>",0,hijos,yystate);
                }}
            ;

//======================== E = E ^ E ;
R:          T R_P
                {{
                    hijos = [];
                    hijos.push($1);
                    hijos.push($2);
                    $$=new Nodo("R=>T R_P",0,hijos,yystate);
                }}
                ;

R_P:        pot T R_P
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push($2);
                    hijos.push($3);
                    $$=new Nodo("R_P=>pot T R_P",0,hijos,yystate);
                }}
            |
                {{
                    hijos = [];
                    hijos.push(new Nodo(EPSILON,undefined,undefined,yystate,DataType.EPSILON));
                    $$=new Nodo("R_P=>",0,hijos,yystate);
                }}

            ;


/*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*********+********** VALORES ++++*/

T:              T_P
                {{
                    hijos = [];
                    hijos.push($1);
                    $$=new Nodo("T=>T_P",0,hijos,yystate);
                }}
                |menos T_P
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.UNTYPED));
                    hijos.push($2);
                    $$=new Nodo("T=>menos T_P",0,hijos,yystate);
                }}
                |not_ T_P
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.UNTYPED));
                    hijos.push($2);
                    $$=new Nodo("T=>not_ T_P",0,hijos,yystate);
                }}
                ;

T_P:             par_abre CONDICION_TER par_cierra
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.UNTYPED));
                    hijos.push($2);
                    hijos.push(new Nodo($3,this._$.last_line,this._$.last_column,yystate,DataType.UNTYPED));
                    $$=new Nodo("T_P=>par_abre CONDICION_TER par_cierra",0,hijos,yystate);
                }}
                |num
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.NUMBER,yystate));
                    $$=new Nodo("T_P=>num",0,hijos,yystate);
                }}
                |bool
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.BOOLEAN));
                    $$=new Nodo("T_P=>bool",0,hijos,yystate);
                }}
                |str
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.STRING));
                    $$=new Nodo("T_P=>str",0,hijos,yystate);
                }}
                |null_
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    $$=new Nodo("T_P=>null_",0,hijos,yystate);
                }}
                |ARREGLO
                {{
                    hijos = [];
                    hijos.push($1);
                    $$=new Nodo("T_P=>OBJETO_FUNCION ARREGLO",0,hijos,yystate);
                }}
                |OBJETO_FUNCION UNARIO
                {{
                    hijos = [];
                    hijos.push($1);
                    hijos.push($2);
                    $$=new Nodo("T_P=>OBJETO_FUNCION UNARIO",0,hijos,yystate);
                }}
                |OBJETO_TYPE
                {{
                    hijos = [];
                    hijos.push($1);
                    $$=new Nodo("T_P=>OBJETO_TYPE",0,hijos,yystate);
                }}
                ;

NEGATIVO:       menos
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    $$=new Nodo("NEGATIVO=>menos",0,hijos,yystate);
                }}
                |
                {{
                    hijos = [];
                    hijos.push(new Nodo(EPSILON,undefined,undefined,yystate,DataType.EPSILON));
                    $$=new Nodo("NEGATIVO=>",0,hijos,yystate);
                }}
                ;

UNARIO:         incremento_
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    $$=new Nodo("UNARIO=>incremento_",0,hijos,yystate);
                }}
                |decremento_
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    $$=new Nodo("UNARIO=>decremento_",0,hijos,yystate);
                }}
                |
                {{
                    hijos = [];
                    hijos.push(new Nodo(EPSILON,undefined,undefined,yystate,DataType.EPSILON));
                    $$=new Nodo("UNARIO=>",0,hijos,yystate);
                }}
                ;

/*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*********+********** ARREGLO ++++*/

ARREGLO:        cor_abre ELEMENTOS cor_cierra
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.UNTYPED));
                    hijos.push($2);
                    hijos.push(new Nodo($3,this._$.last_line,this._$.last_column,yystate,DataType.UNTYPED));
                    $$=new Nodo("ARREGLO=>cor_abre ELEMENTOS cor_cierra",0,hijos,yystate);
                }};

ELEMENTOS:      CONDICION_TER ELEMENTOS_P
                {{
                    hijos = [];
                    hijos.push($1);
                    hijos.push($2);
                    $$=new Nodo("ELEMENTOS=>CONDICION_TER ELEMENTOS_P",0,hijos,yystate);
                }}
                |
                {{
                    hijos = [];
                    hijos.push(new Nodo(EPSILON,undefined,undefined,yystate,DataType.EPSILON));
                    $$=new Nodo("ELEMENTOS=>",0,hijos,yystate);
                }}
                ;

ELEMENTOS_P:     coma_  CONDICION_TER  ELEMENTOS_P
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.UNTYPED));
                    hijos.push($2);
                    hijos.push($3);
                    $$=new Nodo("ELEMENTOS_P=>coma_  CONDICION_TER  ELEMENTOS_P",0,hijos,yystate);
                }}
                |
                {{
                    hijos = [];
                    hijos.push(new Nodo(EPSILON,undefined,undefined,yystate,DataType.EPSILON));
                    $$=new Nodo("ELEMENTOS_P=>",0,hijos,yystate);
                }}
                ;

/*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*********+******** TIPOS EN MEMORIA ++++*/

OBJETO_TYPE:       llave_abre  ATRIBUTOS  llave_cierra
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push($2);
                    hijos.push(new Nodo($3,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    $$=new Nodo("OBJETO_TYPE=>llave_abre  ATRIBUTOS  llave_cierra",0,hijos,yystate);
                }}
                ;

ATRIBUTOS:       ATRIBUTO ATRIBUTOS_P
                {{
                    hijos = [];
                    hijos.push($1);
                    hijos.push($2);
                    $$=new Nodo("ATRIBUTOS=>ATRIBUTOS_P",0,hijos,yystate);
                }}
                ;

ATRIBUTOS_P:    coma_  ATRIBUTO  ATRIBUTOS_P
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push($2);
                    hijos.push($3);
                    $$=new Nodo("ATRIBUTOS_P=>coma_  ATRIBUTO  ATRIBUTOS_P",0,hijos,yystate);
                }}
                |
                {{
                    hijos = [];
                    hijos.push(new Nodo(EPSILON,undefined,undefined,yystate,DataType.EPSILON));
                    $$=new Nodo("ATRIBUTOS_P=>",0,hijos,yystate);
                }}
                ;

ATRIBUTO:       id dos_puntos CONDICION_TER
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push(new Nodo($2,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push($3);
                    $$=new Nodo("ATRIBUTO=>id dos_puntos CONDICION_TER",0,hijos,yystate);
                }}
                ;

/*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*********+********** OBJETOS ++++*/
/**
* T => FUNCION | OBJETO ;
* FUNCION:        id PARAMETROS_FUNCION;
* OBJETO:         id DIMENSION ;
*/

OBJETO_FUNCION: id OBJ_FUN_CUERPO
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push($2);
                    $$=new Nodo("OBJETO_FUNCION=>id OBJ_FUN_CUERPO",0,hijos,yystate);
                }}
                 ;

OBJ_FUN_CUERPO: PARAMETROS_FUNCION SUB_OBJETO
                {{
                    hijos = [];
                    hijos.push($1);
                    hijos.push($2);
                    $$=new Nodo("OBJ_FUN_CUERPO=>PARAMETROS_FUNCION SUB_OBJETO",0,hijos,yystate);
                }}
                | DIMENSION SUB_OBJETO
                {{
                    hijos = [];
                    hijos.push($1);
                    hijos.push($2);
                    $$=new Nodo("OBJ_FUN_CUERPO=>DIMENSION SUB_OBJETO",0,hijos,yystate);
                }}
                ;

SUB_OBJETO:     punto_  OB_ATRIBUTO
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push($2);
                    $$=new Nodo("SUB_OBJETO=>punto_  OB_ATRIBUTO",0,hijos,yystate);
                }}
                |
                {{
                    hijos = [];
                    hijos.push(new Nodo(EPSILON,undefined,undefined,yystate,DataType.EPSILON));
                    $$=new Nodo("SUB_OBJETO=>",0,hijos,yystate);
                }}
                ;

OB_ATRIBUTO:    id DIMENSION SUB_OBJETO
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push($2);
                    hijos.push($3);
                    $$=new Nodo("OB_ATRIBUTO=>id DIMENSION SUB_OBJETO",0,hijos,yystate);
                }}
                |push_ PARAMETROS_FUNCION SUB_OBJETO
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push($2);
                    hijos.push($3);
                    $$=new Nodo("OB_ATRIBUTO=>push_ PARAMETROS_FUNCION SUB_OBJETO",0,hijos,yystate);
                }}
                |pop_  SUB_OBJETO
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push($2);
                    $$=new Nodo("OB_ATRIBUTO=>pop_  SUB_OBJETO",0,hijos,yystate);
                }}
                |length_
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    $$=new Nodo("OB_ATRIBUTO=>length_",0,hijos,yystate);
                }}
                ;


DIMENSION:      cor_abre CONDICION_TER cor_cierra DIMENSION
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push($2);
                    hijos.push(new Nodo($3,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push($4);
                    $$=new Nodo("DIMENSION=>cor_abre CONDICION_TER cor_cierra DIMENSION",0,hijos,yystate);
                }}
                |
                {{
                    hijos = [];
                    hijos.push(new Nodo(EPSILON,undefined,undefined,yystate,DataType.EPSILON));
                    $$=new Nodo("DIMENSION=>",0,hijos,yystate);
                }}
                ;



PARAMETROS_FUNCION:     par_abre ARGUMENTOS par_cierra
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push($2);
                    hijos.push(new Nodo($3,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    $$=new Nodo("PARAMETROS_FUNCION=>par_abre ARGUMENTOS par_cierra",0,hijos,yystate);
                }}
                        ;


ARGUMENTOS:             CONDICION_TER ARGUMENTOS_P
                {{
                    hijos = [];
                    hijos.push($1);
                    hijos.push($2);
                    $$=new Nodo("ARGUMENTOS=>CONDICION_TER ARGUMENTOS_P",0,hijos,yystate);
                }}
                        |
                {{
                    hijos = [];
                    hijos.push(new Nodo(EPSILON,undefined,undefined,yystate,DataType.EPSILON));
                    $$=new Nodo("ARGUMENTOS=>",0,hijos,yystate);
                }}
                        ;


ARGUMENTOS_P:           coma_  CONDICION_TER  ARGUMENTOS_P
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push($2);
                    hijos.push($3);
                    $$=new Nodo("ARGUMENTOS_P=>coma_  CONDICION_TER  ARGUMENTOS_P",0,hijos,yystate);
                }}
                        |
                {{
                    hijos = [];
                    hijos.push(new Nodo(EPSILON,undefined,undefined,yystate,DataType.EPSILON));
                    $$=new Nodo("ARGUMENTOS_P=>",0,hijos,yystate);
                }}
                        ;



/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ASIGNACION++++++++++++*/

ASIGNACION:             OBJETO_FUNCION OPERADOR_ASIGNACION CONDICION_TER
                {{
                    hijos = [];
                    hijos.push($1);
                    hijos.push($2);
                    hijos.push($3);
                    $$=new Nodo("ASIGNACION=>OBJETO_FUNCION OPERADOR_ASIGNACION CONDICION_TER",0,hijos,yystate);
                }}
                ;

OPERADOR_ASIGNACION:    igual
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    $$=new Nodo("OPERADOR_ASIGNACION=>igual",0,hijos,yystate);
                }}
                        |menos_igual
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    $$=new Nodo("OPERADOR_ASIGNACION=>menos_igual",0,hijos,yystate);
                }}
                        |mas_igual
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    $$=new Nodo("OPERADOR_ASIGNACION=>mas_igual",0,hijos,yystate);
                }}
                        ;

/*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*********+TIPOS DE DATOS ++++++++*/

TDATO:	number_ TDIMENSION
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push($2);
                    $$=new Nodo("TDATO=>number_ TDIMENSION",0,hijos,yystate);
                }}
		|string_ TDIMENSION
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push($2);
                    $$=new Nodo("TDATO=>string_ TDIMENSION",0,hijos,yystate);
                }}
		|boolean_ TDIMENSION
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push($2);
                    $$=new Nodo("TDATO=>boolean_ TDIMENSION",0,hijos,yystate);
                }}
		|id TDIMENSION
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push($2);
                    $$=new Nodo("TDATO=>id TDIMENSION",0,hijos,yystate);
                }}
		|void_
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    $$=new Nodo("TDATO=>void_",0,hijos,yystate);
                }}
		;

TDIMENSION:             cor_abre cor_cierra TDIMENSION
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push(new Nodo($2,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push($3);
                    $$=new Nodo("TDIMENSION=>cor_abre cor_cierra TDIMENSION",0,hijos,yystate);
                }}
                        |
                {{
                    hijos = [];
                    hijos.push(new Nodo(EPSILON,undefined,undefined,yystate,DataType.EPSILON));
                    $$=new Nodo("TDIMENSION=>",0,hijos,yystate);
                }}
                        ;

/*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++OPERADORES RELACIONALES+*/

 SIG_REL :      menor
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    $$=new Nodo("SIG_REL=>menor",0,hijos,yystate);
                }}
                |mayor
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    $$=new Nodo("SIG_REL=>mayor",0,hijos,yystate);
                }}
                |menor_igual
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    $$=new Nodo("SIG_REL=>menor_igual",0,hijos,yystate);
                }}
                |mayor_igual
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    $$=new Nodo("SIG_REL=>mayor_igual",0,hijos,yystate);
                }}
                |igual_igual
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    $$=new Nodo("SIG_REL=>igual_igual",0,hijos,yystate);
                }}
                |diferente
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    $$=new Nodo("SIG_REL=>diferente",0,hijos,yystate);
                }}
		;



/*********************************************************************************************/
/*********************************************************************************************/
/*******************************	ESTRUCTURAS DE CONTROL	**********************************/
/*********************************************************************************************/


/******************************************************************************************************* IF ***/

IF_SENTENCE:    llave_abre SENTENCIAS llave_cierra
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push($2);
                    hijos.push(new Nodo($3,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    $$=new Nodo("IF_SENTENCE=>llave_abre SENTENCIAS llave_cierra",0,hijos,yystate);
                }}
                ;

IF_CONDICION:   par_abre CONDICION_TER par_cierra
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push($2);
                    hijos.push(new Nodo($3,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    $$=new Nodo("IF_CONDICION=>par_abre CONDICION_TER par_cierra",0,hijos,yystate);
                }}
                ;

IF_STATEMENT:   if_ IF_CONDICION IF_SENTENCE
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push($2);
                    hijos.push($3);
                    $$=new Nodo("IF_STATEMENT=>if_ IF_CONDICION IF_SENTENCE ",0,hijos,yystate);
                }}
                ;


IF:		        IF_STATEMENT ELSE_IF
                {{
                    hijos = [];
                    hijos.push($1);
                    hijos.push($2);
                    $$=new Nodo("IF:=>IF_STATEMENT ELSE_IF ",0,hijos,yystate);
                }}
                ;

ELSE_IF:    else_ ELSE_IF_P
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push($2);
                    $$=new Nodo("ELSE_IF=>else_ ELSE_IF_P",0,hijos,yystate);
                }}
            |
                {{
                    hijos = [];
                    hijos.push(new Nodo(EPSILON,undefined,undefined,yystate,DataType.EPSILON));
                    $$=new Nodo("ELSE_IF=>",0,hijos,yystate);
                }}
            ;

ELSE_IF_P:  IF_STATEMENT ELSE_IF
                {{
                    hijos = [];
                    hijos.push($1);
                    hijos.push($2);
                    $$=new Nodo("ELSE_IF_P=>IF_STATEMENT ELSE_IF",0,hijos,yystate);
                }}
            |IF_SENTENCE
                {{
                    hijos = [];
                    hijos.push($1);
                    $$=new Nodo("ELSE_IF_P=>IF_SENTENCE",0,hijos,yystate);
                }}
            ;



/****************************************************************************************************** WHILE ***/

WHILE:      while_ IF_CONDICION IF_SENTENCE
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push($2);
                    hijos.push($3);
                    $$=new Nodo("WHILE=>while_ IF_CONDICION IF_SENTENCE",0,hijos,yystate);
                }}
                ;

DO_WHILE:   do_  IF_SENTENCE while_ IF_CONDICION
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push($2);
                    hijos.push(new Nodo($3,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push($4);
                    $$=new Nodo("DO_WHILE=>do_  IF_SENTENCE while_ IF_CONDICION",0,hijos,yystate);
                }}
                ;



/****************************************************************************************************** SWITCH ***/

SWITCH:     switch_ IF_CONDICION llave_abre CASOS llave_cierra
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push($2);
                    hijos.push(new Nodo($3,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push($4);
                    hijos.push(new Nodo($5,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    $$=new Nodo("SWITCH=>switch_ IF_CONDICION llave_abre CASOS llave_cierra",0,hijos,yystate);
                }}
                ;

CASOS:      case_ CONDICION_TER dos_puntos SENTENCIAS CASOS
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push($2);
                    hijos.push(new Nodo($3,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push($4);
                    hijos.push($5);
                    $$=new Nodo("CASOS=>case_ CONDICION_TER dos_puntos SENTENCIAS CASOS",0,hijos,yystate);
                }}
            |default_ dos_puntos SENTENCIAS
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push(new Nodo($2,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push($3);
                    $$=new Nodo("CASOS=>default_ dos_puntos SENTENCIAS",0,hijos,yystate);
                }}
            |
                {{
                    hijos = [];
                    hijos.push(new Nodo(EPSILON,undefined,undefined,yystate,DataType.EPSILON));
                    $$=new Nodo("CASOS=>",0,hijos,yystate);
                }}
            ;


/****************************************************************************************************** FOR  ***/

FOR:        for_ par_abre FOR_P
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push(new Nodo($2,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push($3);
                    $$=new Nodo("FOR=>for_ par_abre FOR_P",0,hijos,yystate);
                }}
            ;

FOR_P:      let_ FOR_LET
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push($2);
                    $$=new Nodo("FOR_P=>let_ FOR_LET",0,hijos,yystate);
                }}
            |const_ FOR_CONST
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push($2);
                    $$=new Nodo("FOR_P=>const_ FOR_CONST",0,hijos,yystate);
                }}
            ;

FOR_LET:    FOR_TRADICIONAL
                {{
                    hijos = [];
                    hijos.push($1);
                    $$=new Nodo("FOR_LET=>FOR_TRADICIONAL",0,hijos,yystate);
                }}
            |FOR_OF
                {{
                    hijos = [];
                    hijos.push($1);
                    $$=new Nodo("FOR_LET=>FOR_OF",0,hijos,yystate);
                }}
            ;

FOR_TRADICIONAL:    id igual CONDICION_TER punto_coma CONDICION_TER punto_coma FOR_TRADICIONAL_INC par_cierra IF_SENTENCE
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push(new Nodo($2,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push($3);
                    hijos.push(new Nodo($4,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push($5);
                    hijos.push(new Nodo($6,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push($7);
                    hijos.push(new Nodo($8,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push($9);
                    $$=new Nodo("FOR_TRADICIONAL=>id igual CONDICION_TER punto_coma CONDICION_TER punto_coma FOR_TRADICIONAL_INC par_cierra IF_SENTENCE",0,hijos,yystate);
                }}
                ;

FOR_TRADICIONAL_INC:    ASIGNACION
                {{
                    hijos = [];
                    hijos.push($1);
                    $$=new Nodo("FOR_TRADICIONAL_INC=>ASIGNACION",0,hijos,yystate);
                }}
                        |CONDICION_TER
                {{
                    hijos = [];
                    hijos.push($1);
                    $$=new Nodo("FOR_TRADICIONAL_INC=>ASIGNACION",0,hijos,yystate);
                }}
                        ;

FOR_OF:                 id of_ id par_cierra IF_SENTENCE
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push(new Nodo($2,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push(new Nodo($3,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push(new Nodo($4,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push($5);
                    $$=new Nodo("FOR_OF=>id of_ id par_cierra IF_SENTENCE",0,hijos,yystate);
                }}
                ;

FOR_CONST:              id in_ id par_cierra IF_SENTENCE
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push(new Nodo($2,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push(new Nodo($3,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push(new Nodo($4,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push($5);
                    $$=new Nodo("FOR_CONST=>id in_ id par_cierra IF_SENTENCE",0,hijos,yystate);
                }};



/****************************************************************************************************** OTHERS ***/

BREAK:                  break_
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    $$=new Nodo("BREAK=>break_",0,hijos,yystate);
                }}
                ;

CONTINUE:               continue_
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    $$=new Nodo("CONTINUE=>continue_",0,hijos,yystate);
                }}
                ;

RETURN:                 return_  RETURN_P
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push($2);
                    $$=new Nodo("RETURN=>return_  RETURN_P",0,hijos,yystate);
                }}
                        ;

RETURN_P:               CONDICION_TER
                {{
                    hijos = [];
                    hijos.push($1);
                    $$=new Nodo("RETURN_P=>CONDICION_TER",0,hijos,yystate);
                }}
                        |
                {{
                    hijos = [];
                    hijos.push(new Nodo(EPSILON,undefined,undefined,yystate,DataType.EPSILON));
                    $$=new Nodo("RETURN_P=>",0,hijos,yystate);
                }}
                        ;



/****************************************************************************************************** CONSOLA  ***/

CONSOLA:                console_ punto_ log_ PARAMETROS_FUNCION
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push(new Nodo($2,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push(new Nodo($3,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push($4);
                    $$=new Nodo("CONSOLA=>console_ punto_ log_ PARAMETROS_FUNCION",0,hijos,yystate);
                }}
                ;

GRAFICAR:               graficar_ts par_abre par_cierra
                {{
                    hijos = [];
                    hijos.push(new Nodo($1,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push(new Nodo($2,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    hijos.push(new Nodo($3,this._$.last_line,this._$.last_column,yystate,DataType.NULL));
                    $$=new Nodo("GRAFICAR=>graficar_ts par_abre par_cierra",0,hijos,yystate);
                }}
                ;