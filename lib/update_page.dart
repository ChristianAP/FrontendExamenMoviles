import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'model.dart';

class UpdatePage extends StatefulWidget {
  UpdatePage({Key? key}) : super(key: key);

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  String titulo = '';
  String descripcion = '';
  List<Model> update = [];

  Future<http.Response> updatePost(Model m, String id) async {
    final url = Uri.parse('http://localhost:3000/post/update/${id}');
    final response = await http.put(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(m.toJson()));

    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print(response.body);
      print('A network error occurred');
    }

    this.update.add(m);
    return response;
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> data =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(
        title: Text("MODIFICAR - " + data['titulo']),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 20.0,
          ),
          titleInput(data['titulo']),
          SizedBox(
            height: 20.0,
          ),
          descripcionInput(data['descripcion']),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () async {
              print("EN EL ONPRESED !");
              print(this.titulo);
              print(this.descripcion);
              print(data["idposts"]);
              final postObjeto =
                  new Model(titulo: this.titulo, descripcion: this.descripcion);
              final dataEnviar = await updatePost(postObjeto, data["idposts"]);
              print(dataEnviar);
              Navigator.pushNamed(context, '/home');
            },
            child: const Text('GUARDAR CAMBIOS'),
          ),
        ],
      ),
    );
  }

  Widget titleInput(String titulo) {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapchot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextFormField(
          initialValue: titulo,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
              icon: Icon(Icons.title),
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

  Widget descripcionInput(String descripcion) {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapchot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextFormField(
          initialValue: descripcion,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
              icon: Icon(Icons.description),
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
