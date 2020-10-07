class SimboloAncestor{
    constructor(id, tipoDato) {
        this.id = id;
        this.tipoDato = tipoDato;
        this.indTipoModificable = TipoDato==undefined?Indicador.S:Indicador.N;
    }
}

SimboloAncestor.prototype.clonar= function (){
    JSON.parse(JSON.stringify(this));
};

SimboloAncestor.getId = function (){
    return this.id;
};

SimboloAncestor.setId = function (id){
    this.id = id;
};