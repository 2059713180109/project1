const CONSOLE_LINE_MARK = '->';
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
        let root = analyzer.parse(cadEntrada);
        //console.log(new Date());
        print(CONSOLE_MESSAGE_SUCCESSFULL);
    }catch (e){
        alert(e);
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