
var Nodo = (function (){
    function Nodo(){
        /*
        ATRIBUTOS
         */
        this.produccion="";
        this.noProduccion=-1;
        this.columna=-1;
        this.fila=-1;
        this.hijos=[];
        this.tipoToken="";


        /*
        GETTERS AND SETTERS
         */
        this.noProduccion = function(){
            return this.noProduccion;
        }

        this.getTipoToken = function(){
            return this.tipoToken;
        }

        this.getProduccion = function(){
            return this.produccion;
        }

        this.getColumna = function() {
            return this.columna;
        }

        this.setColumna = function (columna) {
            this.columna = columna;
        }

        this.getFila = function() {
            return this.fila;
        }

        this.setFila = function (fila) {
            this.fila = fila;
        }

        this.hijo = function (index){
            return hijos[index];
        }

        this.noHijos = function(){
            return hijos.length;
        }

        this.tipoToken = function(){
            return tipoToken;
        }

        this.tieneHijos = function(){
            if(hijos!=null){
                return true;
            }
            return false;
        }
    }
    return Nodo;
}());
Nodo["__class"] = "Nodo";

