import 'package:flutter/material.dart';

class AgregarEstudiantePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ejemplo formulario"),
      ),
      body: AgregarPage(),
    );
  }
}

class AgregarPage extends StatefulWidget {
  AgregarPage({Key key}) : super(key: key);

  @override
  _FormExampleState createState() => _FormExampleState();
}

class _FormExampleState extends State<AgregarPage> {
  final _formKey = GlobalKey<FormState>();
  bool _colorVerde = false;
  String _mensaje = "----";
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Por favor, ingresa un nombre';
                } else if (value.length <= 4) {
                  return 'El valor no puede tener menos de 4 caracteres';
                } else {
                  return null;
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              onPressed: () {
                // devolverá true si el formulario es válido, o falso si
                // el formulario no es válido.
                if (_formKey.currentState.validate()) {
                  // Si el formulario es válido, queremos mostrar un Snackbar
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('ok')));
                }
              },
              child: Text('Validar'),
            ),
          ),
          Text(
            _mensaje,
            style: TextStyle(
              fontSize: 30,
              color: (_colorVerde == true) ? Colors.green[700] : Colors.black,
            ),
          ),
          SwitchListTile(
            value: _colorVerde,
            title: Text("Cambiar color a cadena"),
            onChanged: (value) {
              setState(() {
                _colorVerde = value;
                if (_colorVerde) {
                  _mensaje = "Color Verde";
                } else {
                  _mensaje = "Color Negro";
                }
              });
            },
          )
        ],
      ),
    );
  }
}
