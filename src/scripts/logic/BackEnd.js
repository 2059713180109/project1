

var BackEnd=(function() {
    /*
    Constructor
     */
    function BackEnd() {
        this.listaErrores =new ListaErrores();
        this.root = undefined;
        this.numeroNodo=1;
        this.ts = new TablaSimbolos();
        this.listaFunciones = undefined;
    }

    return BackEnd;
}());

BackEnd["__class"] = "BackEnd";

BackEnd.prototype.cargar=function (){
    if(this.root == undefined){
        throw "BackEnd.root es nulo";
    }
    let sent = new Sentencia(this.ts.getListaSimbolos(),
                            this.ts.getListaSimbolos(),
                            this.ts.getListaFunciones(),
                            this.root);
    sent.cargarS();
    this.listaFunciones = this.ts.getListaFunciones();
};
