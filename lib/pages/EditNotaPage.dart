import 'package:bloco_notas/widgets/DrawerMenu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bloco_notas/routes.dart';
import 'package:bloco_notas/controllers/NotaController.dart';

class EditNota extends StatefulWidget {
  // const EditNota({Key? key}) : super(key: key);

  @override
  State<EditNota> createState() => _EditNotaState();
}

class _EditNotaState extends State<EditNota> {

  int _indexBarItem = 0;

  CadNotaController cadNotaController = Get.put(CadNotaController());


  List getNota;
  var waiting = true.obs;
  getEditNota() async{
    waiting.value = true;
    var resp = await cadNotaController.getNota();
    waiting.value = false;
    if(resp){
      getNota = cadNotaController.NotaEdit;
      print(getNota);
      cadNotaController.IdEdit = getNota[0]['id'];
      titleVal.text = getNota[0]['title'];
      notaVal.text = getNota[0]['nota'];
    }
  }

  TextEditingController titleVal = TextEditingController();
  TextEditingController notaVal = TextEditingController();

  void EditNota() async{
    cadNotaController.titleEdit = titleVal.text;
    cadNotaController.notaEdit = notaVal.text;
    var resp = await cadNotaController.editNota();
    if(resp){
      print('tudo certo atualizou com sucesso!');
      Get.offAllNamed(Routes.HOME);
    }else{
      print('erro ao atualizar');
      Get.defaultDialog(
        title: 'Erro ao atualizar nota!',
        content: Text('Ops, ocorreu um erro ao editar sua nota'),
        radius: 10
      );
    }
  }

  showModalTheme() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        builder: (BuildContext){
          return Padding(
              padding: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
              child: Container(),
          );
        }
    );
  }

  void carregarEvento(int index,) async {
    setState(() {
      _indexBarItem = index;
      print(_indexBarItem);
      if(_indexBarItem == 1){
        showModalTheme();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    getEditNota();
    return Scaffold(
      appBar: MenuAppBar('Editar nota'),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Form(
              child: Column(
                children: [

                  Padding(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          label: Text('Titulo'),
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none
                          )
                      ),
                      controller: titleVal,
                      onChanged: (value){

                      },
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                          label: Text('Nota...'),
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none
                          )
                      ),
                      controller: notaVal,
                      onChanged: (value){

                      },
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.edit),
        onPressed: EditNota,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.image),
            label: 'teste'
          ),

          BottomNavigationBarItem(
              icon: Icon(Icons.imagesearch_roller_rounded),
            label: 'teste1'
          ),
        ],
        currentIndex: _indexBarItem,
        selectedItemColor: Colors.blueAccent,
        onTap: carregarEvento,
      ),
    );
  }
}
