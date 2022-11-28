import 'package:bloco_notas/pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bloco_notas/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'bloco de notas',
      debugShowCheckedModeBanner: false,
      getPages: AppPages.routes,
      initialRoute: Routes.HOME,
    );
  }
}
