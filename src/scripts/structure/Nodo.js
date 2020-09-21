
var Nodo = (function (){


    /**
     * Constructor
     * @param par1 => produccion/lexVal
     * @param par2 => noProduccion/fila
     * @param par3 => hijos/columna
     * @param yystate Estando donde fue creado el nodo
     * @param tipoDato tipoDato
     * @constructor
     */
    function Nodo(par1, par2, par3, yystate, tipoDato){
        /*
        ATRIBUTOS
         */
        this.produccion=undefined==tipoDato?par1:undefined;
        this.lexVal=undefined==tipoDato?undefined:par1;
        this.noProduccion=undefined==tipoDato?par2:undefined;
        this.fila=undefined==tipoDato?undefined:par2;
        this.hijos=undefined==tipoDato?par3:undefined;
        this.columna=undefined==tipoDato?undefined:par3;
        this.tipoDato=tipoDato;
        this.esTerminal=tipoDato!=undefined;
        this.yystate = yystate;
    }

    return Nodo;
}());
Nodo["__class"] = "Nodo";

