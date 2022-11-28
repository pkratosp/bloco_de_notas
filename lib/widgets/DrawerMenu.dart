import 'package:bloco_notas/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget MenuAppBar(nome){
  return AppBar(
    title: Text(nome),
    centerTitle: true,
    backgroundColor: Colors.blue,
  );
}

Widget MenuDrawer(){
  return Drawer(
    child: Container(
        child:  ListView(
          padding: const EdgeInsets.fromLTRB(10, 100, 10, 0),
          children: [

            ListTile(
              title: Text('Nova nota'),
              leading: Icon(Icons.add),
              onTap: (){
                Get.toNamed(Routes.CADNOTA);
              },
            ),

            Divider(),

            ListTile(
              title: Text('Home'),
              leading: Icon(Icons.home),
              onTap: (){
                Get.toNamed(Routes.HOME);
              },
            ),

            Divider(),

            ListTile(
              title: Text('Arquivados'),
              leading: Icon(Icons.archive),
              onTap: (){
                Get.toNamed(Routes.Arquivados);
              },
            ),

            Divider(),

            ListTile(
              title: Text('Lixeira'),
              leading: Icon(Icons.delete),
              onTap: (){
                Get.toNamed(Routes.deleteNota);
              },
            ),

            Divider(),

          ],
        )
    ),
  );
}
