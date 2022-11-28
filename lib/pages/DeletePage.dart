import 'package:bloco_notas/widgets/DrawerMenu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bloco_notas/controllers/NotaController.dart';

class DeletePage extends StatefulWidget {
  // const DeletePage({Key? key}) : super(key: key);

  @override
  State<DeletePage> createState() => _DeletePageState();
}

class _DeletePageState extends State<DeletePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MenuAppBar('Lixeira'),
      body: Container(),
    );
  }
}
