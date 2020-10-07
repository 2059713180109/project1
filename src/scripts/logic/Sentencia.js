class Sentencia{
    constructor(listaSimbolosGlobales,
                listaSimbolosLocales,
                listaFunciones,
                root) {
    this.listaSimbolosGlobales = listaSimbolosGlobales;
    this.listaSimbolosLocales = listaSimbolosLocales;
    this.listaFunciones = listaFunciones;
    this.root = root;
    }
}

Sentencia.prototype.cargarS = function (){
    this.cargar(this.root);
};

Sentencia.prototype.cargar=function (root){
    switch(root.getProduccion()) {
        case "S=>SENTENCIAS EOF":
        {
            this.cargar(root.getHijo(0));
            break;
        }
        case "SENTENCIAS=>SENTENCIA SENTENCIAS":
        {
            this.cargar(root.getHijo(0));
            this.cargar(root.getHijo(1));
            break;
        }
        case "SENTENCIAS=>":
        {
            break;
        }
        case "SENTENCIA=>DEC_DECLAVAR punto_coma":
        {
            let declaracion = new Declaracion(this.listaSimbolosGlobales,
                this.listaSimbolosLocales,this.listaFunciones,root.getHijo(0));
            declaracion.cargarRoot();
            break;
        }
        case "SENTENCIA=>DEC_FUN":
        {
            let declaracion = new Declaracion(this.listaSimbolosGlobales,
                this.listaSimbolosLocales,this.listaFunciones,root.getHijo(0));
            declaracion.cargarRoot();
            break;
        }
        case "SENTENCIA=>DEC_TYPE punto_coma":
        {
            let declaracion = new Declaracion(this.listaSimbolosGlobales,
                this.listaSimbolosLocales,this.listaFunciones,root.getHijo(0));
            declaracion.cargarRoot();
            break;
        }
        case "SENTENCIA=>ASIGNACION punto_coma":
        {
            break;
        }
        case "SENTENCIA=>IF":
        {
            break;
        }
        case "SENTENCIA=>WHILE":
        {
            break;
        }
        case "SENTENCIA=>DO_WHILE punto_coma":
        {
            break;
        }
        case "SENTENCIA=>SWITCH":
        {
            break;
        }
        case "SENTENCIA=>FOR":
        {
            break;
        }
        case "SENTENCIA=>BREAK punto_coma":
        {
            break;
        }
        case "SENTENCIA=>CONTINUE punto_coma":
        {
            break;
        }
        case "SENTENCIA=>RETURN punto_coma":
        {
            break;
        }
        case "SENTENCIA=>OBJETO_FUNCION UNARIO punto_coma":
        {
            break;
        }
        case "SENTENCIA=>CONSOLA punto_coma":
        {
            break;
        }
        case "SENTENCIA=>GRAFICAR punto_coma":
        {
            break;
        }
        case "SENTENCIA=>error":
        {
            break;
        }
        case "DEC_TYPE=>type_ id igual llave_abre LIST_ATRIBUTOS llave_cierra":
        {
            break;
        }
        case "LIST_ATRIBUTOS=>DEC_ATRIBUTO  LIST_ATRIBUTOS_P":
        {
            break;
        }
        case "LIST_ATRIBUTOS_P=>coma_ DEC_ATRIBUTO LIST_ATRIBUTOS_P":
        {
            break;
        }
        case "LIST_ATRIBUTOS_P=>":
        {
            break;
        }
        case "DEC_ATRIBUTO=>id dos_puntos TDATO":
        {
            break;
        }
        case "DEC_FUN=>function_ id par_abre LIST_PAR par_cierra dos_puntos TDATO llave_abre SENTENCIAS llave_cierra":
        {
            break;
        }
        case "LIST_PAR=>PARAM LIST_PAR_P ":
        {
            break;
        }
        case "LIST_PAR=>":
        {
            break;
        }
        case "LIST_PAR_P=>coma_ PARAM LIST_PAR_P":
        {
            break;
        }
        case "LIST_PAR_P=>":
        {
            break;
        }
        case "PARAM=>id  dos_puntos  TDATO":
        {
            break;
        }
        case "CONDICION_TER=>CONDICION_OR TERNARIO":
        {
            break;
        }
        case "CONDICION_OR=>CONDICION_AND CONDICION_OR_P":
        {
            break;
        }
        case "":
        {
            break;
        }
        case "CONDICION_AND=>CONDICION CONDICION_AND_P":
        {
            break;
        }
        case "CONDICION_AND_P=>and_ CONDICION_AND":
        {
            break;
        }
        case "CONDICION_AND_P=>":
        {
            break;
        }
        case "TERNARIO=>interrogacion_ CONDICION_TER dos_puntos CONDICION_TER":
        {
            break;
        }
        case "TERNARIO=>":
        {
            break;
        }
        case "CONDICION=>E SIG_REL E":
        {
            break;
        }
        case "CONDICION=>E":
        {
            break;
        }
        case "E=>F  E_P":
        {
            break;
        }
        case "E_P=> mas F E_P":
        {
            break;
        }
        case "E_P=>menos F E_P":
        {
            break;
        }
        case "E_P=>":
        {
            break;
        }
        case "F=>R  F_P":
        {
            break;
        }
        case "F_P=>por R F_P":
        {
            break;
        }
        case "F_P=>div R F_P":
        {
            break;
        }
        case "F_P=>mod R F_P":
        {
            break;
        }
        case "F_P=>":
        {
            break;
        }
        case "R=>T R_P":
        {
            break;
        }
        case "R_P=>pot T R_P":
        {
            break;
        }
        case "R_P=>":
        {
            break;
        }
        case "T=>T_P":
        {
            break;
        }
        case "T=>menos T_P":
        {
            break;
        }
        case "T=>not_ T_P":
        {
            break;
        }
        case "T_P=>par_abre CONDICION_TER par_cierra":
        {
            break;
        }
        case "T_P=>num":
        {
            break;
        }
        case "T_P=>bool":
        {
            break;
        }
        case "T_P=>str":
        {
            break;
        }
        case "T_P=>null_":
        {
            break;
        }
        case "T_P=>OBJETO_FUNCION ARREGLO":
        {
            break;
        }
        case "T_P=>OBJETO_FUNCION UNARIO":
        {
            break;
        }
        case "T_P=>OBJETO_TYPE":
        {
            break;
        }
        case "NEGATIVO=>menos":
        {
            break;
        }
        case "NEGATIVO=>":
        {
            break;
        }
        case "UNARIO=>incremento_":
        {
            break;
        }
        case "UNARIO=>decremento_":
        {
            break;
        }
        case "UNARIO=>":
        {
            break;
        }
        case "ARREGLO=>cor_abre ELEMENTOS cor_cierra":
        {
            break;
        }
        case "ELEMENTOS=>CONDICION_TER ELEMENTOS_P":
        {
            break;
        }
        case "ELEMENTOS=>":
        {
            break;
        }
        case "ELEMENTOS_P=>coma_  CONDICION_TER  ELEMENTOS_P":
        {
            break;
        }
        case "ELEMENTOS_P=>":
        {
            break;
        }
        case "OBJETO_TYPE=>llave_abre  ATRIBUTOS  llave_cierra":
        {
            break;
        }
        case "ATRIBUTOS=>ATRIBUTOS_P":
        {
            break;
        }
        case "ATRIBUTOS_P=>coma_  ATRIBUTO  ATRIBUTOS_P":
        {
            break;
        }
        case "ATRIBUTOS_P=>":
        {
            break;
        }
        case "ATRIBUTO=>id dos_puntos CONDICION_TER":
        {
            break;
        }
        case "OBJETO_FUNCION=>id OBJ_FUN_CUERPO":
        {
            break;
        }
        case "OBJ_FUN_CUERPO=>PARAMETROS_FUNCION SUB_OBJETO":
        {
            break;
        }
        case "OBJ_FUN_CUERPO=>DIMENSION SUB_OBJETO":
        {
            break;
        }
        case "SUB_OBJETO=>punto_  OB_ATRIBUTO":
        {
            break;
        }
        case "SUB_OBJETO=>":
        {
            break;
        }
        case "OB_ATRIBUTO=>id DIMENSION SUB_OBJETO":
        {
            break;
        }
        case "OB_ATRIBUTO=>push_ PARAMETROS_FUNCION SUB_OBJETO":
        {
            break;
        }
        case "OB_ATRIBUTO=>pop_  SUB_OBJETO":
        {
            break;
        }
        case "OB_ATRIBUTO=>length_":
        {
            break;
        }
        case "DIMENSION=>cor_abre CONDICION_TER cor_cierra DIMENSION":
        {
            break;
        }
        case "DIMENSION=>":
        {
            break;
        }
        case "PARAMETROS_FUNCION=>par_abre ARGUMENTOS par_cierra":
        {
            break;
        }
        case "ARGUMENTOS=>CONDICION_TER ARGUMENTOS_P":
        {
            break;
        }
        case "ARGUMENTOS=>":
        {
            break;
        }
        case "ARGUMENTOS_P=>coma_  CONDICION_TER  ARGUMENTOS_P":
        {
            break;
        }
        case "ARGUMENTOS_P=>":
        {
            break;
        }
        case "ASIGNACION=>OBJETO_FUNCION OPERADOR_ASIGNACION CONDICION_TER":
        {
            break;
        }
        case "OPERADOR_ASIGNACION=>igual":
        {
            break;
        }
        case "OPERADOR_ASIGNACION=>menos_igual":
        {
            break;
        }
        case "OPERADOR_ASIGNACION=>mas_igual":
        {
            break;
        }
        case "SIG_REL=>menor":
        {
            break;
        }
        case "SIG_REL=>mayor":
        {
            break;
        }
        case "SIG_REL=>menor_igual":
        {
            break;
        }
        case "SIG_REL=>mayor_igual":
        {
            break;
        }
        case "SIG_REL=>igual_igual":
        {
            break;
        }
        case "SIG_REL=>diferente":
        {
            break;
        }
        case "IF_SENTENCE=>llave_abre SENTENCIAS llave_cierra":
        {
            break;
        }
        case "IF_CONDICION=>par_abre CONDICION_TER par_cierra":
        {
            break;
        }
        case "IF_STATEMENT=>if_ IF_CONDICION IF_SENTENCE ":
        {
            break;
        }
        case "IF:=>IF_STATEMENT ELSE_IF ":
        {
            break;
        }
        case "ELSE_IF=>else_ ELSE_IF_P":
        {
            break;
        }
        case "ELSE_IF=>":
        {
            break;
        }
        case "ELSE_IF_P=>IF_STATEMENT ELSE_IF":
        {
            break;
        }
        case "ELSE_IF_P=>IF_SENTENCE":
        {
            break;
        }
        case "WHILE=>while_ IF_CONDICION IF_SENTENCE":
        {
            break;
        }
        case "DO_WHILE=>do_  IF_SENTENCE while_ IF_CONDICION":
        {
            break;
        }
        case "SWITCH=>switch_ IF_CONDICION llave_abre CASOS llave_cierra":
        {
            break;
        }
        case "CASOS=>case_ CONDICION_TER dos_puntos SENTENCIAS CASOS":
        {
            break;
        }
        case "CASOS=>default_ dos_puntos SENTENCIAS":
        {
            break;
        }
        case "CASOS=>":
        {
            break;
        }
        case "FOR=>for_ par_abre FOR_P":
        {
            break;
        }
        case "FOR_P=>let_ FOR_LET":
        {
            break;
        }
        case "FOR_P=>const_ FOR_CONST":
        {
            break;
        }
        case "FOR_LET=>FOR_TRADICIONAL":
        {
            break;
        }
        case "FOR_LET=>FOR_OF":
        {
            break;
        }
        case "FOR_TRADICIONAL=>id igual CONDICION_TER punto_coma CONDICION_TER punto_coma FOR_TRADICIONAL_INC par_cierra IF_SENTENCE":
        {
            break;
        }
        case "FOR_TRADICIONAL_INC=>ASIGNACION":
        {
            break;
        }
        case "FOR_TRADICIONAL_INC=>ASIGNACION":
        {
            break;
        }
        case "FOR_OF=>id of_ id par_cierra IF_SENTENCE":
        {
            break;
        }
        case "FOR_CONST=>id in_ id par_cierra IF_SENTENCE":
        {
            break;
        }
        case "BREAK=>break_":
        {
            break;
        }
        case "CONTINUE=>continue_":
        {
            break;
        }
        case "RETURN=>return_  RETURN_P":
        {
            break;
        }
        case "RETURN_P=>CONDICION_TER":
        {
            break;
        }
        case "RETURN_P=>":
        {
            break;
        }
        case "CONSOLA=>console_ punto_ log_ PARAMETROS_FUNCION":
        {
            break;
        }
        case "GRAFICAR=>graficar_ts par_abre par_cierra":
        {
            break;
        }
        default:
        {
            console.info("Sentencias.cargar: case no found. root.produccion: "+root.getProduccion());
            break;
        }
    }
};