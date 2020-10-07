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
            this.cargar(root.getHijo(1),TipoDeclacion.CONST);
            this.cargar(root.getHijo(2),TipoDeclacion.CONST);
            break;
        }
        case "DEC_DECLAVAR=>let_ D_VAR LIST_VAR":
        {
            this.cargar(root.getHijo(1),TipoDeclacion.LET);
            this.cargar(root.getHijo(2),TipoDeclacion.LET);
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
            let tipoDato;
            let id;
            id=root.getHijo(0).getLexVal();
            tipoDato = this.cargar(root.getHijo(1),inherited);

            break;
        }
        case "D_VAR_P1=>igual CONDICION_TER":
        {
            return undefined;
        }
        case "D_VAR_P1=>dos_puntos TDATO D_VAR_P2":
        {
            //
            return this.cargar(root.getHijo(1));
        }
        case "D_VAR_P1=>":
        {
            //Epsion
            return undefined;
        }
        case "D_VAR_P2=>igual CONDICION_TER":
        {
            break;
        }
        case "D_VAR_P2=>":
        {
            //EPSILON
            break;
        }
        case "TDATO=>number_ TDIMENSION":
        {
            return {
                tipoDato:TipoDato.NUMBER,
                dimensiones:this.cargar(root.getHijo(1))
            };
        }
        case "TDATO=>string_ TDIMENSION":
        {
            return {
                tipoDato:TipoDato.STRING,
                dimensiones:this.cargar(root.getHijo(1))
            };
        }
        case "TDATO=>boolean_ TDIMENSION":
        {
            return {
                tipoDato:TipoDato.BOOLEAN,
                dimensiones:this.cargar(root.getHijo(1))
            };
        }
        case "TDATO=>id TDIMENSION":
        {
            return {
                tipoDato:root.getHijo(0).getLexVal(),
                dimensiones:this.cargar(root.getHijo(1))
            };
        }
        case "TDATO=>void_":
        {
            return {
                tipoDato:TipoDato.VOID,
                dimensiones:0
            };
        }
        case "TDIMENSION=>cor_abre cor_cierra TDIMENSION":
        {
            return 1+this.cargar(root.getHijo(2));
        }
        case "TDIMENSION=>":
        {
            return 0;
        }
        default:
        {
            console.info("Declaracion.cargar: case no found. root.produccion: "+root.getProduccion());
            break;
        }
    }
};

