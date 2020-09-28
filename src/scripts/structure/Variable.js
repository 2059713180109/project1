class Variable extends SimboloAncestor {
    constructor(id,tipoDato,valor){
        super(id,tipoDato);
        this.valor = valor;
    }
}

Variable.prototype.getIntValue = function (){
    if(this.tipoDato!=DataType.NUMBER){
        throw new CreatorException(this.id+" no es de tipo"+this.tipoDato
            +", no puede ser tratado como "*DataType.NUMBER+". ");
    }
}
