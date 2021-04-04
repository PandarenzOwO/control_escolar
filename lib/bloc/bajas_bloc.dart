import 'package:control_escolar/bloc/alumnos_bloc.dart';
import 'package:control_escolar/models/estudiante.dart';
import 'package:flutter/material.dart';

class BajasPage extends StatefulWidget {
  @override
  _BajasPageState createState() => _BajasPageState();
}

class _BajasPageState extends State<BajasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alumnos dados de baja',
            style: TextStyle(
              fontSize: 26.0,
              fontWeight: FontWeight.bold,
            )),
      ),
      body: streamCarrito(),
    );
  }

  Widget streamCarrito() {
    return StreamBuilder<List<Estudiante>>(
      initialData: estudiantesBloc.carrito,
      stream: estudiantesBloc.carritoEstudiantesStream,
      builder: (context, snapshot) {
        return listCarrito(snapshot);
      },
    );
  }

  Widget listCarrito(AsyncSnapshot<List<Estudiante>> snapshot) {
    return snapshot.data.length == 0
        ? Center(child: Text("No hay alumnos dados de baja actualmente"))
        : Column(children: [
            Expanded(
              child: ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, i) {
                  Estudiante p = snapshot.data[i];
                  return Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Card(
                      elevation: 5.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(5.0),
                            child: Image.network(
                              p.foto,
                              fit: BoxFit.cover,
                              width: 100.0,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  p.nombre + " " + p.apellidos,
                                  style: TextStyle(
                                      fontSize: 22.0,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Grado: " + p.grado.toString(),
                                  style: TextStyle(fontSize: 16.0),
                                ),
                                Text('Grupo: ' + p.grupo,
                                    style: TextStyle(fontSize: 16.0)),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  iconSize: 45.0,
                                  icon: Icon(Icons.refresh_outlined,
                                      color: Colors.blue[800]),
                                  onPressed: () {
                                    if (p.activo == true) {
                                      estudiantesBloc
                                          .quitarEstudiantesCarritoSink
                                          .add(p);
                                    }
                                  },
                                ),
                                Text(
                                  "Reintegrar \na la escuela",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: p.activo == true
                                        ? Colors.blue[800]
                                        : Colors.red[800],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ]);
  }
}
