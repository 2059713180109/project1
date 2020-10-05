const CONSOLE_LINE_MARK = '>';
const CONSOLE_MESSAGE_SUCCESSFULL="OK";
const ENTER = "\n";

var _backEnd;
var _graphicUtil;
var _txtConsola;

/**
 * Metodo que ejecuta la entrada
 * @param entrada
 */
const ejecutar= function (cadEntrada){
    try {
        print("Iniciando ejecucion: "+new Date());
        _backEnd = new BackEnd();

        try {
            let isParseOk = analyzer.parse(cadEntrada);
            if(isParseOk){
                console.info('Se genero correctamente el árbol. ');
            }else{
                throw "No se pudo generar correctamente el árbol. ";
            }
        }catch (e){
            throw ('Error al generar el AST. '+e);
        }
        _backEnd.cargar();
        console.info('Se cargo exitosamente las tabla de simbolos. ');
        if(_backEnd.listaErrores.size>0){
            throw ("Existen errores durante el análisis. ");
        }
        print(CONSOLE_MESSAGE_SUCCESSFULL);
    }catch (e){
        print(e);
        console.log(e);
    }
};


const print = function (strTexto){
    let strCad=_txtConsola.val();
    _txtConsola.val(strCad+strTexto+ENTER+CONSOLE_LINE_MARK);
};



const getStringAst = function (){
    if(_backEnd==undefined || _backEnd.root==undefined){
        print("No existe árbol que graficar.");
    }
    _graphicUtil = new GraphicUtil();
    return _graphicUtil.generarGrafo(_backEnd.root);
};