var GraphicUtil = (function (){
    function GraphicUtil(){
        this.cadena="";
    }

    GraphicUtil.prototype.generarGrafo = function (nodoRoot){
        this.cadena = "digraph G {"+ENTER;
        this.recorrerAst(nodoRoot);
        this.cadena += "}";
        return this.cadena;
    };

    GraphicUtil.prototype.recorrerAst = function (root){
        if(root==undefined){
            return;
        }
        let label = 'label="'+(root.isTerminal()?root.getLexVal():root.getNoTerminal())+'",';
        let color = 'color="'+(root.isTerminal()?((root.getTipoDato()===DataType.ERROR)?'red':'greenyellow'):'lightblue3')+'",'
        let tipo = root.getTipoDato();
        this.cadena+="N"+root.numeroNodo+"["+label+color+"];";
        this.cadena+=ENTER;
        if(root.hijos == undefined){
            return;
        }
        for (const subRoot of root.hijos) {
            this.cadena+="N"+root.getNumeroNodo()+" -> N"+subRoot.getNumeroNodo()+";";
            this.cadena+=ENTER;
            this.recorrerAst(subRoot);
        }
    };

    return GraphicUtil;
}());

GraphicUtil["__class"] = "GraphicUtil";
