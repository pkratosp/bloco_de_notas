import 'package:bloco_notas/controllers/NotaController.dart';
import 'package:bloco_notas/models/CadNotaModel.dart';
import 'package:bloco_notas/routes.dart';
import 'package:bloco_notas/widgets/DrawerMenu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CadNotaPage extends StatefulWidget {
  const CadNotaPage({Key key}) : super(key: key);

  @override
  State<CadNotaPage> createState() => _CadNotaPageState();
}

class _CadNotaPageState extends State<CadNotaPage> {

  CadNotaController cadNotaController = Get.put(CadNotaController());

  var waiting = true.obs;
  salvarNota() async{
    waiting.value = true;

    CadNotaModel obj = CadNotaModel(null, cadNotaController.title,cadNotaController.nota, cadNotaController.statusDefault);
    int response = await cadNotaController.cadNota(obj);

    if(response != null){
      print('cad: '+response.toString());
      Get.offAllNamed(Routes.HOME);
    }else{
      print(response.toString());
      Get.defaultDialog(
        title: 'Ocorreu um erro ao salvar nota',
        content: Text('Ops, não foi possivel salvar a nota'),
        radius: 10
      );
    }

    waiting.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MenuAppBar('Adicionar nova nota'),
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
                      onChanged: (value){
                        cadNotaController.title = value;
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
                      onChanged: (value){
                        cadNotaController.nota = value;
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
        child: Icon(Icons.add),
        onPressed: (){
          salvarNota();
        },
      ),
    );
  }
}
