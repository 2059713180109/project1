class Declaracion{
    constructor(listaSimbolosGlobal, listaSimbolosLocal, listaFunciones, root) {
        this.listaSimbolosGlobal = listaSimbolosGlobal;
        this.listaSimbolosLocal = listaSimbolosLocal;
        this.listaFunciones = listaFunciones;
        this.root = root;
    }
}

Declaracion.prototype.cargarRoot = function (){
    this.cargar(this.root);
};

Declaracion.prototype.cargar = function (root,inherited){

    switch(root.getProduccion()){
        case "DEC_DECLAVAR=>const_ D_VAR LIST_VAR":
        {
            this.cargar(root.getHijo(1),DeclarationType.CONST);
            this.cargar(root.getHijo(2),DeclarationType.CONST);
            break;
        }
        case "DEC_DECLAVAR=>let_ D_VAR LIST_VAR":
        {
            this.cargar(root.getHijo(1),DeclarationType.LET);
            this.cargar(root.getHijo(2),DeclarationType.LET);
            break;
        }
        case "LIST_VAR=>coma_  D_VAR  LIST_VAR":
        {
            this.cargar(root.getHijo(1),inherited);
            this.cargar(root.getHijo(2),inherited);
            break;
        }
        case "LIST_VAR=>":
        {
            //EPSILON
            break;
        }
        case "D_VAR=>id  D_VAR_P1":
        {

            this.cargar(root.getHijo(1),inherited);
            break;
        }
        case "D_VAR_P1=>igual CONDICION_TER":
        {
            break;
        }
        case "D_VAR_P1=>dos_puntos TDATO D_VAR_P2":
        {
            break;
        }
        case "D_VAR_P1=>":
        {
            break;
        }
        case "D_VAR_P2=>igual CONDICION_TER":
        {
            break;
        }
        case "D_VAR_P2=>":
        {
            break;
        }
        default:
        {
            console.info("Declaracion.cargar: case no found. root.produccion: "+root.getProduccion());
            break;
        }
    }
};

