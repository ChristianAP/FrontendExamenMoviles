import 'dart:convert';

import 'package:app_examen/model.dart';
import 'package:app_examen/text_box.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CreatePage extends StatefulWidget {
  //CreatePage({Key? key}) : super(key: key);

  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  String titulo = '';
  String descripcion = '';
  List<Model> model = [];
  late TextEditingController _nombre;
  late TextEditingController controllerPost;

  @override
  void initState() {
    _nombre = new TextEditingController();
    controllerPost = new TextEditingController();
  }

  Future<http.Response> createPost(Model m) async {
    final url = Uri.parse('http://localhost:3000/post/create');

    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(m.toJson()));

    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print('A network error occurred');
    }

    this.model.add(m);
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registrar Nuevo Post"),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 20.0,
          ),
          titleInput(),
          SizedBox(
            height: 20.0,
          ),
          descripcionInput(),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () async {
              final postObjeto =
                  new Model(titulo: this.titulo, descripcion: this.descripcion);
              final dataEnviar = await createPost(postObjeto);
              Navigator.pushNamed(context, '/home');
            },
            child: const Text('GUARDAR CAMBIOS'),
          ),
        ],
      ),
    );
  }

  Widget titleInput() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapchot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              icon: Icon(Icons.email),
              hintText: "Ingrese título ...",
              labelText: "TÍTULO: "),
          onChanged: (value) {
            setState(() {
              this.titulo = value;
            });
          },
        ),
      );
    });
  }

  Widget descripcionInput() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapchot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              icon: Icon(Icons.email),
              hintText: "Ingrese la descripción...",
              labelText: "DESCRIPCIÓN: "),
          onChanged: (value) {
            setState(() {
              this.descripcion = value;
            });
          },
        ),
      );
    });
  }
}
