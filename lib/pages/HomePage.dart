import 'package:bloco_notas/controllers/NotaController.dart';
import 'package:bloco_notas/routes.dart';
import 'package:bloco_notas/widgets/DrawerMenu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{

  CadNotaController cadNotaController = Get.put(CadNotaController());

  var waiting = false.obs;

  //lista minhas notas
  List notas;
  realoadNota() async{
    waiting.value = true;
    var resp = await cadNotaController.getListarNotas();

    if(resp){
      cadNotaController.selecionado = -1;
      notas = cadNotaController.ListaNotas;
    }
  }

   List<Widget> listaNotas(context){

    List<Widget> itens = [];
    if(notas != null){
      setState(() {
        notas.forEach((element) {

          itens.add(
              Card(
                color: cadNotaController.selecionado == element['id'] ? Colors.blueAccent : Colors.white,
                child: TextButton(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Text(
                          element['title'].toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.grey
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                        child: Text(
                          element['nota'].toString(),
                          maxLines: 4,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      )
                    ],
                  ),
                  onPressed: (){
                    cadNotaController.idEdit = element['id'];
                    Get.toNamed(Routes.EditNota);
                  },
                  onLongPress: (){
                    cadNotaController.selecionado = element['id'];
                    print('selecionar e jogar botao');
                    showActions(element['id']);
                  },
                ),
              )
          );
          print(element['title']);
        });
      });

    }else{
      itens = [];
    }

    return itens;
  }

  List listaNotas1;
  ArquivaNota() async{
    waiting.value = true;
    var resp = await cadNotaController.ArquivaNota();
    if(resp){
      listaNotas1 = cadNotaController.ListaNotas;
      print('nota atualizad');
      print(listaNotas);
    }
    waiting.value = false;
  }

  //lista meus actions selecionados
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

  @override
  Widget build(BuildContext context) {
    realoadNota();
    return Scaffold(
      appBar: AppBar(
        title: Text('Minhas notas'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: listAction,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: GestureDetector(
          onTap: (){
            setState(()=>{
              listAction = []
            });
          },
          child: RefreshIndicator(
            onRefresh: () async {
              //carrego minhas notas e limpo meus actions
              await realoadNota();
              listaNotas(context);
              listAction = [];
              return Future<void>.delayed(const Duration(seconds: 3));
            },
            child: GridView.count(
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                children: listaNotas(context)
            ),
          ),
        )
      ),
      drawer: MenuDrawer(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Get.toNamed(Routes.CADNOTA);
        },
      ),
    );
  }
}
