class Arreglo extends SimboloAncestor{
    constructor(valores,id) {
        super(id,DataType.ARRAY);
        this.valores = valores;
    }
}

Arreglo.prototype.getValores = function () {
    return this.valores;
}

Arreglo.prototype.setValores = function (valores) {
    this.valores = valores;
}


/**
 * Determina que todos los valores que contiene el arreglo sean instancias de Varaible,
 * @return
 */
Arreglo.prototype.esArregloPrimitivo = function (){
    for(let si of this.valores){
        if(!(si instanceof Variable))return false;
    }
    return true;
}

/**
 * Retorna el tipo de dato resultate de todos los elementos del arreglo.
 * @return
 */
Arreglo.prototype.getTipoDato = function (){
    let tipoDato;
    if(this.valores == null || this.valores.size()==0){
        return DataType.VACIO;
    }
    tipoDato = this.valores.get(0).getTipoDato();
    for(let si of this.valores){
        if(tipoDato != (si.getTipoDato())) return DataType.VARIOS;
    }
    return tipoDato;
}