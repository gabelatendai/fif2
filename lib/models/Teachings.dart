// To parse this JSON data, do
//
//     final TeachingsModel = TeachingsModelFromJson(jsonString);

import 'dart:convert';

List<TeachingsModel> TeachingsModelFromJson(String str) => List<TeachingsModel>.from(json.decode(str).map((x) => TeachingsModel.fromJson(x)));

String TeachingsModelToJson(List<TeachingsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TeachingsModel {
  String id;
  String vidio;
  String profile;
  String date;
  String title;
  String category;
  String description;
  String name;

  TeachingsModel({
    this.id,
    this.vidio,
    this.profile,
    this.date,
    this.title,
    this.category,
    this.description,
    this.name,
  });

  factory TeachingsModel.fromJson(Map<String, dynamic> json) => TeachingsModel(
    id: json["id"],
    vidio: json["vidio"],
    profile: json["profile"],
    date: json["date"],
    title: json["user_id"],
    category: json["category"],
    description: json["description"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "vidio": vidio,
    "profile": profile,
    "date": date,
    "user_id": title,
    "category": category,
    "description": description,
    "name": name,
  };

}
