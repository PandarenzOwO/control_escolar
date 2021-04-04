import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Control Escolar",
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(10.0),
          child: ListView(
            children: [
              Column(
                children: [
                  navegadorCartas(
                      context,
                      "Agregar Alumnos",
                      "https://img.icons8.com/dusk/452/add-user-group-man-woman.png",
                      "Aqui podra agregar nuevos alumnos a la escuela",
                      "agregar"),
                  navegadorCartas(
                      context,
                      "Lista de Alumnos",
                      "https://img.icons8.com/dusk/452/list.png",
                      "Aqui podra ver a los alumnos que se encuentran inscritos en la institucion",
                      "lista"),
                  navegadorCartas(
                      context,
                      "Bajas de Alumnos",
                      "https://img.icons8.com/dusk/452/denied.png",
                      "Aqui podra ver a los alumnos que se han dado de baja en esta institucion",
                      "bajas",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget navegadorCartas(BuildContext context, String titulo, String imagen,
      String texto, String ruta) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, ruta);
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        margin: EdgeInsets.all(15.0),
        elevation: 10.0,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Image.network(
                imagen,
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    titulo,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Center(
                      child: Text(
                        texto,
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
