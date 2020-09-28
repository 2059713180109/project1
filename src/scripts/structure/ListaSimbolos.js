class ListaSimbolos extends SimboloAncestor{

    constructor() {
        super("",DataType.LISTA);
        this.simboloIntHashtable=new TablaHash();
        this.listParametros=[];
        this.displayBreak = 0;
    }
}

ListaSimbolos.prototype.agregarSimbolo = function (simboloInt){
    let tmp = this.simboloIntHashtable.get(simboloInt.getId());
    if(tmp!=null){
        throw new CreatorException("Variable '"+simboloInt.getId()+"' ya existe dentro del contexto actual.");
    }
    this.simboloIntHashtable.put(simboloInt.getId(),simboloInt);
}

ListaSimbolos.prototype.agregarComoParametro = function (simboloInt) {
    this.agregarSimbolo(simboloInt);
    if(this.listParametros == null){
        this.listParametros=[];
    }
    this.listParametros.push(simboloInt.getId());
};



ListaSimbolos.prototype.agregarSimboloFromTerminal = function (nodoTerminal, simboloInt) {
    let tmp = this.simboloIntHashtable.get(nodoTerminal.getValor());
    if(tmp!=null){
        throw new AnalisisException(nodoTerminal.getFila(),nodoTerminal.getColumna(),"Variable '"+simboloInt.getId()+"' ya existe dentro del contexto actual.");
    }
    this.simboloIntHashtable.put(simboloInt.getId(),simboloInt);
};


ListaSimbolos.prototype.reemplazarSimbolo = function (simboloInt){
    this.simboloIntHashtable.put(simboloInt.getId(),simboloInt);
};

ListaSimbolos.prototype.reemplazarSimboloById = function (id, simboloInt){
    this.simboloIntHashtable.put(id,simboloInt);
};

ListaSimbolos.prototype.existeID = function (idSimbolo){
    let tmp = this.simboloIntHashtable.get(idSimbolo);
    return tmp!=null;
}

ListaSimbolos.prototype.obtenerSimbolo = function (idSimbolo) {
    let tmp = this.simboloIntHashtable.get(idSimbolo);
    if(tmp == null){
        throw new CreatorException("Variable '"+idSimbolo+"' no declarada. ");
    }
    tmp.setReference(idSimbolo,this.simboloIntHashtable);
    return tmp;
}

ListaSimbolos.prototype.clonar = function (){
    throw CreatorException("No se ha implementado metodo");
};

ListaSimbolos.prototype.validarBreak = function (breakNodo){
    if(this.displayBreak<1){
        throw new AnalisisException(breakNodo.getFila(),breakNodo.getColumna(),"Break fuera de 'selecciona'. ");
    }
    return true;
};


//GETTERS AND SETTERS

ListaSimbolos.prototype.setListParametros = function (listParametros) {
    this.listParametros = listParametros;
};

ListaSimbolos.prototype.getListParametros = function () {
    return this.listParametros;
};

ListaSimbolos.prototype.downDisplayBreak = function () {
    this.displayBreak--;
};

ListaSimbolos.prototype.upDisplayBreak = function () {
    this.displayBreak++;
};

ListaSimbolos.prototype.getSimbolo = function (key){
    return this.simboloIntHashtable.get(key);
};

ListaSimbolos.prototype.getSimboloIntHashtable = function () {
    return this.simboloIntHashtable;
};