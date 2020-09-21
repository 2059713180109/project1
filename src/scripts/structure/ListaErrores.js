
var Err=(function(){
    function Err(fila, columna, tipoError, mensaje){
        this.fila=fila;
        this.columna=columna;
        this.tipoError=tipoError;
        this.mensaje=mensaje;
    }
    return Err;
}());
Err["__class"] = "Err";


var ListaErrores=(function(){
    function ListaErrores(){
        this.errores=[];
        this.addError=function(fila,columna, tipoError,mensaje){
            this.errores.push(new Err(fila, columna,tipoError,mensaje));
            this.size=function(){
                return this.errores.length;
            };
            this.clear=function(){
                this.errores=[];
            };
        };
    }
    return ListaErrores;
}());
ListaErrores["__class"] = "ListaErrores";