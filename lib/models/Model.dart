
import 'dart:convert';

List<Model> modelFromJson(String str) => List<Model>.from(json.decode(str).map((x) => Model.fromJson(x)));

String modelToJson(List<Model> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Model {
  String id;
  String title;
  String category;
  String name;
  String description;
  String date;
  String profile;
  String vidio;
  String views;


  Model({
    this.id,
    this.title,
    this.category,
    this.name,
    this.description,
    this.date,
    this.profile,
    this.vidio,
    this.views,
  });

  factory Model.fromJson(Map<String, dynamic> json) => Model(
    id: json["id"],
    title: json["title"],
    category: json["category"],
    name: json["name"],
    description: json["description"],
    date:json["date"],
    profile: json["profile"],
    vidio: json["vidio"],
    views: json["views"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "category": category,
    "name": name,
    "description": description,
    "date": date,
    "profile": profile,
    "vidio": vidio,
    "views": views,
  };
}
