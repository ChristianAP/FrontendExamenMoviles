// To parse this JSON data, do
//
//     final model = modelFromJson(jsonString);

import 'dart:convert';

List<Model> modelFromJson(String str) =>
    List<Model>.from(json.decode(str).map((x) => Model.fromJson(x)));

String modelToJson(List<Model> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Model {
  Model({
    this.idposts,
    required this.titulo,
    required this.descripcion,
  });

  int? idposts;
  String titulo;
  String descripcion;

  factory Model.fromJson(Map<String, dynamic> json) => Model(
        idposts: json["idposts"],
        titulo: json["titulo"],
        descripcion: json["descripcion"],
      );

  factory Model.fromMap(Map<String, dynamic> json) => Model(
        idposts: json["idposts"],
        titulo: json["titulo"],
        descripcion: json["descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "idposts": idposts,
        "titulo": titulo,
        "descripcion": descripcion,
      };
}
