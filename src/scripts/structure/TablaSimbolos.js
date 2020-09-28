class TablaSimbolos{
    constructor() {
        this.listaSimbolos = new ListaSimbolos();
        this.listaFunciones = new ListaFunciones();
    }
}

TablaSimbolos.prototype.getListaSimbolos = function (){
    return this.listaSimbolos;
}
TablaSimbolos.prototype.setListaSimbolos = function (listaSimbolos){
    this.listaSimbolos = listaSimbolos;
}
TablaSimbolos.prototype.getListaFunciones = function (){
    return this.listaFunciones;
}
TablaSimbolos.prototype.setListaFunciones = function (listaFunciones){
    this.listaFunciones = listaFunciones;
}