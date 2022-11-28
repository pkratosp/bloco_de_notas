import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:bloco_notas/models/CadNotaModel.dart';
import 'dart:io';
import 'package:get/get.dart';

class CadNotaController extends GetxController{

  static Database _database;
  static CadNotaController _cadNotaController;

  CadNotaController._createInstance();

  factory CadNotaController(){
    if(_cadNotaController == null){
      _cadNotaController = CadNotaController._createInstance();
    }
    return _cadNotaController;
  }

  int selecionado = -1;

  //estrutura da tabela
  String nomeTabela = 'tb_nota';
  String idTabela = 'id';
  String titleTabela = 'title';
  String notaTabela = 'nota';
  String status = 'status';

  //criando tabela
  void _CriarTable(Database db,int version) async{

    String sql = """
      CREATE TABLE $nomeTabela 
        (
          $idTabela INTEGER PRIMARY KEY AUTOINCREMENT,
          $titleTabela varchar(255),
          $notaTabela LONGTEXT,
          $status INTEGER
        )
    """;
    return await db.execute(sql);
  }

  //inicia nosso banco na memoria
  Future<Database> iniciarBanco() async{
    Directory directory = await getApplicationDocumentsDirectory();
    String caminho = directory.path+'bdnotas.bd';
    var banco = await openDatabase(caminho,version: 1,onCreate: _CriarTable);
    return banco;
  }

  //verific se o banco foi criado
  Future<Database> get database async{
    if(_database == null){
      _database = await iniciarBanco();
    }
    return _database;
  }

  String title;
  String nota;
  int statusDefault = 1;

  //cira o registro
  Future<int> cadNota(CadNotaModel obj) async{
    Database db = await this.database;

    var response = db.insert(nomeTabela, obj.toMap());
    return response;
  }

  List ListaNotas;

  var waiting = true.obs;
  getListarNotas() async{
    waiting.value = true;

    var resp = await listarNotas();
    waiting.value = false;
    return resp;
  }

  //busca os registros do banco
  listarNotas() async{
    Database db = await this.database;

    String sql = "select * from $nomeTabela where status = 1 order by id desc";
    List list = await db.rawQuery(sql);
    if(list != null){
      ListaNotas = list;
      return true;
    }
  }


  //lista uma unica nota
  // String titleEdit;
  // String notaEdit;
  int idEdit;
  List NotaEdit;
  getNota() async{
    waiting.value = true;
    var resp = await _getNota();
    waiting.value = false;
    return resp;
  }

  _getNota() async{
    Database db = await this.database;
    var sql = "select * from $nomeTabela where id = $idEdit";
    List _list = await db.rawQuery(sql);
    NotaEdit = _list;
    return true;
  }


  //edita a nota
  editNota() async{
    waiting.value = true;
    var resp = await _editNota();
    waiting.value = false;
    return resp;
  }

  String titleEdit;
  String notaEdit;
  int IdEdit;
  _editNota() async{
    Database db = await this.database;
    var sql = "update $nomeTabela set title = '$titleEdit', nota = '$notaEdit' where id = '$IdEdit' ";
    List _list = await db.rawQuery(sql);
    return true;
  }

  //arquiva uma nota
  int IdArquiNota;
  ArquivaNota() async{
    waiting.value = true;
    var resp = await _arquivaNota();
    waiting.value = false;
    return _arquivaNota();
  }

  _arquivaNota() async{
    Database db = await this.database;
    var arquivaSql = "update $nomeTabela set status = 0 where id = $IdArquiNota";
    List _list = await db.rawQuery(arquivaSql);
    return true;
  }

  //lista as notas aqruivadas
  List ListaNotasArquivadas;

  getArquivadoNota() async {
    waiting.value = true;
    var resp = await _listaArquivadoNota();
    waiting.value = false;
    return resp;
  }

  _listaArquivadoNota () async {
    Database db = await this.database;
    var sql = "select * from $nomeTabela where status = 0 order by id desc";
    List _list = await db.rawQuery(sql);
    if(_list != null){
      ListaNotasArquivadas = _list;
      return true;
    }
  }

  //deleta uma nota
  //primeira parte ira somente mudar o status, para listar na pagina de deletados
  DeletePrimeiraNota() async{}


  //após isso a nota depois que excluir la, ira ser apagado do banco de dadis
  DeletarNotaPermanente() async{}
}