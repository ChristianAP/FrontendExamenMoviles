import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'create_page.dart';
import 'model.dart';

class PrincipalPage extends StatefulWidget {
  //PrincipalPage({Key? key}) : super(key: key);

  @override
  _PrincipalPageState createState() => _PrincipalPageState();
}

class _PrincipalPageState extends State<PrincipalPage> {
  Map<String, dynamic>? listarDatos;
  List posts = [];

  readAll() async {
    final url = Uri.parse('http://localhost:3000/post/');
    final response = await http.get(url);
    this.listarDatos = json.decode(response.body);
    setState(() {
      this.posts = listarDatos!['data'];
      print(listarDatos!['data']);
    });
  }

  Future<http.Response> deleteData(String id) async {
    final url = Uri.parse('http://localhost:3000/post/delete/${id}');

    final response = await http.delete(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    readAll();
    return response;
  }

  @override
  void initState() {
    super.initState();
    readAll();
    print("funciona");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: posts.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                print("${posts[index]}");
                final object = posts[index];
                Navigator.pushNamed(context, '/update', arguments: object);
              },
              onLongPress: () {
                showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                            title: Text("ELIMINAR POST"),
                            content: Text(
                                "Esta seguro de que quiere eliminar ${posts[index]['titulo']}? "),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    setState(() {
                                      deleteData(posts[index]['idposts']);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  '${posts[index]['titulo']} Eliminado !')));
                                    });
                                  },
                                  child: Text(
                                    "ELIMINAR",
                                    style: TextStyle(color: Colors.red),
                                  )),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "CANCELAR",
                                    style: TextStyle(color: Colors.blue),
                                  )),
                            ]));
              },
              child: Card(
                elevation: 15,
                child: ListTile(
                    leading: Icon(Icons.account_balance_sharp),
                    title: Text("${posts[index]['titulo']}"),
                    subtitle: Text("${posts[index]['descripcion']}")),
              ),
            );
          }),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(height: 50.0),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => CreatePage()));
        },
        tooltip: 'INSERTAR NUEVO POST',
        child: const Icon(Icons.add_comment_sharp),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
