class CreatorException{
    constructor(message) {
        this.message = message;
    }
    toString(){
        return this.message;
    }
}


class AnalisisException{
    constructor(fila, columna, mensaje) {
        this.fila = fila;
        this.columna = columna;
        this.message = message;
    }
    toString(){
        return this.message;
    }
}


CreatorException.prototype.getMessage = function (){
    return this.message;
};

AnalisisException.prototype.getColumna = function (){
    return this.columna;
};

AnalisisException.prototype.getFila = function (){
    return this.fila;
};

AnalisisException.prototype.getMessage = function (){
    return this.message;
};

