class S{
    constructor(root) {
        this.root = root;
    }
}

S.prototype.cargar=function (){
    this.cargar(this.root);
};
