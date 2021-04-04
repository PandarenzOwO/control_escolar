import 'dart:async';

import 'package:control_escolar/models/estudiante.dart';

class EstudiantesBloc {
  final List<Estudiante> lista = [
    Estudiante(
        id: 1,
        nombre: "Fabian",
        apellidos: "Cordero M",
        edad: 22,
        grado: 10,
        grupo: "A",
        foto: "https://img.icons8.com/dusk/64/human-head.png",
        activo: true),
    Estudiante(
        id: 2,
        nombre: "Godie",
        apellidos: "Nomeacuerdo",
        edad: 21,
        grado: 10,
        grupo: "B",
        foto: "https://img.icons8.com/dusk/64/human-head.png",
        activo: true),
    Estudiante(
        id: 3,
        nombre: "Robert",
        apellidos: "Hernandez",
        edad: 20,
        grado: 8,
        grupo: "A",
        foto: "https://img.icons8.com/dusk/64/human-head.png",
        activo: true),
    Estudiante(
        id: 4,
        nombre: "Angel",
        apellidos: "Mendez",
        edad: 12,
        grado: 2,
        grupo: "E",
        foto: "https://img.icons8.com/dusk/64/human-head.png",
        activo: true),
  ];

  //Lista de estudiantes en el carrito de compras
  final List<Estudiante> carrito = [];

  //Regresa la lista de estudiantes
  final _estudiantesStreamController =
      StreamController<List<Estudiante>>.broadcast();

  //Regresa la lista de estudiantes en el carrito
  final _carritoStreamController =
      StreamController<List<Estudiante>>.broadcast();

  //Agrega estudiantes al carrito
  final _agregarCarritoStreamController = StreamController<Estudiante>();

  //Elimina estudiantes del carrito
  final _quitarCarritoStreamController = StreamController<Estudiante>();

  Stream<List<Estudiante>> get listaEstudiantesStream =>
      _estudiantesStreamController.stream;
  StreamSink<List<Estudiante>> get listaEstudiantesSink =>
      _estudiantesStreamController.sink;

  Stream<List<Estudiante>> get carritoEstudiantesStream =>
      _carritoStreamController.stream;
  StreamSink<List<Estudiante>> get carritoEstudiantesSink =>
      _carritoStreamController.sink;

  Stream<Estudiante> get agregarEstudiantesCarrito =>
      _agregarCarritoStreamController.stream;
  Stream<Estudiante> get quitarEstudiantesCarrito =>
      _quitarCarritoStreamController.stream;
  StreamSink<Estudiante> get agregarEstudiantesCarritoSink =>
      _agregarCarritoStreamController.sink;
  StreamSink<Estudiante> get quitarEstudiantesCarritoSink =>
      _quitarCarritoStreamController.sink;

  EstudiantesBloc() {
    listaEstudiantesSink.add(lista);
    agregarEstudiantesCarrito.listen(_agregarEstudiante);
    quitarEstudiantesCarrito.listen(_quitarEstudiante);
  }

  //Sirve para cerrar los stream controllers para que no marquen error
  void dispose() {
    _estudiantesStreamController?.close();
    _carritoStreamController?.close();
    _agregarCarritoStreamController?.close();
    _quitarCarritoStreamController?.close();
  }

  void _agregarEstudiante(Estudiante p) {
    if (carrito.any((x) => x.id == p.id)) {
      p.activo = false;
      //carrito.where((x) => x.id == p.id).first.cantidad++;
      carrito.firstWhere((x) => x.id == p.id).activo = true;
    } else {
      Estudiante ptemp = Estudiante(
          activo: true,
          nombre: p.nombre,
          foto: p.foto,
          id: p.id,
          apellidos: p.apellidos,
          edad: p.edad,
          grado: p.grado,
          grupo: p.grupo);
      p.activo = false;
      carrito.add(ptemp);
    }
    listaEstudiantesSink.add(lista);
    carritoEstudiantesSink.add(carrito);
  }

  void _quitarEstudiante(Estudiante p) {
    if (carrito.any((x) => x.id == p.id)) {
      p.activo = false;
      lista.firstWhere((x) => x.id == p.id).activo = true;
      if (p.activo == false) {
        carrito.remove(p);
      }
      listaEstudiantesSink.add(lista);
      carritoEstudiantesSink.add(carrito);
    }
  }

  void pagarCarrito() {
    carrito.clear();
    carritoEstudiantesSink.add(carrito);
  }
}

final estudiantesBloc = EstudiantesBloc();
