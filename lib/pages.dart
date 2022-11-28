import 'package:bloco_notas/pages/ArquivadoPage.dart';
import 'package:bloco_notas/pages/CadNotaPage.dart';
import 'package:bloco_notas/pages/DeletePage.dart';
import 'package:bloco_notas/pages/EditNotaPage.dart';
import 'package:bloco_notas/pages/HomePage.dart';
import 'package:bloco_notas/pages/testes.dart';
import 'package:get/get.dart';
import 'package:bloco_notas/routes.dart';


class AppPages{
  static final routes = [
    GetPage(name: Routes.HOME, page: ()=> HomePage()),
    GetPage(name: Routes.CADNOTA, page: ()=> CadNotaPage()),
    GetPage(name: Routes.EditNota, page: ()=> EditNota()),
    GetPage(name: Routes.Arquivados, page: ()=> ArquivadoPage()),
    GetPage(name: Routes.deleteNota, page: ()=> DeletePage()),
    GetPage(name: Routes.testes, page: ()=> Testes())
  ];
}