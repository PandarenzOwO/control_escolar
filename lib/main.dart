import 'package:control_escolar/bloc/agregar_bloc.dart';
import 'package:control_escolar/bloc/bajas_bloc.dart';
import 'package:control_escolar/bloc/lista_bloc.dart';
import 'package:control_escolar/home_page.dart';
import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => HomePage(),
          'lista': (context) => ListaPage(),
          'bajas': (context) => BajasPage(),
          'agregar': (context) => AgregarEstudiantePage(),
        });
  }
}
