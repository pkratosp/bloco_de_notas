class CadNotaModel{

  String title;
  String nota;
  int id;
  int status;

  CadNotaModel(this.id,this.title,this.nota, this.status);

  //converte para map
  Map<String,dynamic> toMap(){
    var dados = Map<String,dynamic>();
    dados['id'] = id;
    dados['title'] = title;
    dados['nota'] = nota;
    dados['status'] = status;
    return dados;
  }

  //conver de map para model
  CadNotaModel.deMapModel(Map<String,dynamic> dados){
    this.id = dados['id'];
    this.title = dados['title'];
    this.nota = dados['nota'];
    this.status = dados['status'];
  }

}