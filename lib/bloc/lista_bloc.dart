import 'package:control_escolar/bloc/alumnos_bloc.dart';
import 'package:control_escolar/models/estudiante.dart';
import 'package:flutter/material.dart';

class ListaPage extends StatefulWidget {
  @override
  _ListaPageState createState() => _ListaPageState();
}

class _ListaPageState extends State<ListaPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'Lista de Alumnos',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontStyle: FontStyle.italic,
                fontSize: 28.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          // actions: [
          //   IconButton(
          //     icon: Icon(Icons.shopping_cart_rounded),
          //     onPressed: () {
          //       Navigator.pushNamed(context, "bajas");
          //     },
          //   )
          // ],
        ),
        body: streamProductos(),
      ),
    );
  }

  Widget streamProductos() {
    return StreamBuilder(
      initialData: estudiantesBloc.lista,
      stream: estudiantesBloc.listaEstudiantesStream,
      builder: (context, snapshot) {
        return listProductos(snapshot);
      },
    );
  }

  Widget listProductos(AsyncSnapshot<List<Estudiante>> snapshot) {
    return ListView.builder(
      itemCount: snapshot.data.length,
      itemBuilder: (context, i) {
        Estudiante p = snapshot.data[i];
        return Padding(
          padding:
              EdgeInsets.only(left: 12.0, right: 12.0, top: 5.0, bottom: 5.0),
          child: Card(
            elevation: 5.0,
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(5.0),
                  child: Image.network(
                    p.foto,
                    fit: BoxFit.fill,
                    width: 100.0,
                    height: 100.0,
                  ),
                ),
                SizedBox(width: 5),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      p.nombre + " " + p.apellidos,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.blue[900],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                        "Semestre: " +
                            p.grado.toString() +
                            ", Grupo: " +
                            p.grupo,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        )),
                    Text("Numero de control: " + p.id.toString(),
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                        )),
                    //Text("Precio", style: TextStyle(fontSize: 16.0)),
                    Text("Edad: " + p.edad.toString() + " años",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                        ))
                  ],
                )),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    children: [
                      IconButton(
                        icon: Icon(Icons.archive_outlined,
                            color: p.activo == true
                                ? Colors.green[900]
                                : Colors.red[900]),
                        onPressed: () {
                          if (p.activo == true) {
                            estudiantesBloc.agregarEstudiantesCarritoSink
                                .add(p);
                          } else {
                            print("Ese alumno ya esta dado de baja");
                          }
                        },
                        iconSize: 45.0,
                      ),
                      // Text(
                      //   //p.activo.toString(),
                      //   p.activo == true ? "-" : "+",
                      //   textAlign: TextAlign.center,
                      //   style: TextStyle(
                      //       fontSize: 30.0,
                      //       fontWeight: FontWeight.bold,
                      //       color: p.activo == true
                      //           ? Colors.green[600]
                      //           : Colors.red[600]),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
