
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
        this.numeroNodo = _backEnd.numeroNodo++;
    }

    Nodo.prototype.getNumeroNodo = function (){
        return this.numeroNodo
    };

    Nodo.prototype.isTerminal = function (){
        return this.esTerminal;
    };

    Nodo.prototype.getNoTerminal = function (){
        return this.produccion.split("=>")[0];
    };

    Nodo.prototype.getLexVal = function (){
        return this.lexVal;
    };

    Nodo.prototype.getTipoDato = function (){
        return this.tipoDato;
    };


    return Nodo;
}());
Nodo["__class"] = "Nodo";

