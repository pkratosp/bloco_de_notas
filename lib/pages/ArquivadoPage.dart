import 'package:bloco_notas/widgets/DrawerMenu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bloco_notas/controllers/NotaController.dart';
import 'package:get/get.dart';
import 'package:bloco_notas/routes.dart';

class ArquivadoPage extends StatefulWidget {
  // const ArquivadoPage({Key? key}) : super(key: key);

  @override
  State<ArquivadoPage> createState() => _ArquivadoPageState();
}

class _ArquivadoPageState extends State<ArquivadoPage> {

  CadNotaController cadNotaController = Get.put(CadNotaController());

  var waiting = false.obs;

  List notas;
  
  reloadNotas() async{
    waiting.value = true;
    var resp = await cadNotaController.getArquivadoNota();
    waiting.value = false;
    if(resp){
      notas = cadNotaController.ListaNotasArquivadas;
    }
  }

  List<Widget> listaNotas(context){
    List<Widget> itens = [];
    
    if(notas != null){
      setState(() {
        
        notas.forEach((element) { 
          
          itens.add(
            Card(
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
                        padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                        child: Text(
                          element['nota'].toString(),
                          maxLines: 4,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black
                          ),
                          textAlign: TextAlign.left,
                        ),
                    ),
                  ],
                ),
                onPressed: (){
                  cadNotaController.idEdit = element['id'];
                  Get.toNamed(Routes.EditNota);
                },
                onLongPress: (){
                  print('selecionar aqueles botoes');
                },
              ),
            )
          );
          
        });
        
      });
    }else{
      itens = [];
    }
    
    return itens;
  }

  

  @override
  Widget build(BuildContext context) {
    reloadNotas();
    listaNotas(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Arquivados'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: RefreshIndicator(
          onRefresh: () async {
            // função para carregar as notas
            await reloadNotas();
            await listaNotas(context);
            return Future<void>.delayed(const Duration(seconds: 3));
          },
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: listaNotas(context),
          ),
        ),
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
