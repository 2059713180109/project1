class ListaFunciones{
    constructor() {
        this.funcionHashtable = new TablaHash();
    }
}



//FUNCIONES Y METODOS
ListaFunciones.prototype.agregarFuncion = function (funcion) {
    let idFuncion = funcion.getId();
    let tmp = this.funcionHashtable.get(idFuncion);
    if(tmp!=null){
        throw new CreatorException("Funcion '"+idFuncion+"' ya definida. ");
    }
    this.funcionHashtable.put(idFuncion,funcion);
}

ListaFunciones.prototype.obtenerFuncion = function (idFuncion)  {
    let id = idFuncion.getValor();
    let tmp = this.funcionHashtable.get(id);
    if(tmp==null){
        throw AnalisisException(idFuncion.getFila(),idFuncion.getColumna(),"Funcion '"+idFuncion+
            "' no se encuentra definida. ");
    }
    return tmp;
}

ListaFunciones.prototype.existeFuncion = function (idFuncion){
    let tmp = this.funcionHashtable.get(idFuncion);
    return tmp!=null;
}
