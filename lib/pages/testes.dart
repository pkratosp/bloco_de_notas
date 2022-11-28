import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bloco_notas/controllers/NotaController.dart';

class Testes extends StatefulWidget {
  // const Testes({Key? key}) : super(key: key);

  @override
  State<Testes> createState() => _TestesState();
}

class _TestesState extends State<Testes> {

  CadNotaController cadNotaController = Get.put(CadNotaController());

  //resgata as minhas notas
  var waiting = false.obs;
  List listaNotas;
  LoadNota() async{
    waiting.value = true;
    var resp = await cadNotaController.getListarNotas();
    if(resp){
      listaNotas = cadNotaController.ListaNotas;
      // print(listaNotas);
    }
    waiting.value = false;
  }

  ArquivaNota() async{
    waiting.value = true;
    var resp = await cadNotaController.ArquivaNota();
    if(resp){
      listaNotas = cadNotaController.ListaNotas;
      print('nota atualizad');
      print(listaNotas);
    }
    waiting.value = false;
  }

  List<Widget> listAction = [];
  List<Widget> showActions(int id){

   setState(() {
     print(id);
     if(listAction.length == 0){
       listAction.add(IconButton(
         icon: const Icon(
           Icons.archive,
           color: Colors.white,
         ),
         onPressed: () {
            cadNotaController.IdArquiNota = id;
            print('id ___ $id');
            ArquivaNota();
         },
       ));
       listAction.add(
           IconButton(
             icon: const Icon(
               Icons.delete,
               color: Colors.white,
             ),
             onPressed: () {

             },
           ));
     }
     return listAction;
   });
  }


  // set an int with value -1 since no card has been selected
  int selectedCard = -1;

  @override
  Widget build(BuildContext context) {
    LoadNota();
    return Scaffold(
      appBar: AppBar(
        title: Text('teste'),
        actions: listAction,
      ),
      body: Container(
        child: GridView.builder(
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemCount: listaNotas.length,
                shrinkWrap: false,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index){
                  return GestureDetector(
                    onLongPress: () {
                      showActions(listaNotas[index]['id']);
                      setState(() {
                        selectedCard = index;
                      });
                    },
                    child: Card(
                      // check if the index is equal to the selected Card integer
                      color: selectedCard == index ? Colors.blue : Colors.amber,
                      child: Container(
                        height: 200,
                        width: 200,
                        child: Center(
                          child: Text(
                            listaNotas[index]['title'],
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }
        )
      ),
    );
  }
}
