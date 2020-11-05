
import 'dart:convert';

List<Updates> updatesFromJson(String str) => List<Updates>.from(json.decode(str).map((x) => Updates.fromJson(x)));

String updatesToJson(List<Updates> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Updates {
  String id;
  String title;
  String description;
  String date;
  String views;


  Updates({
    this.id,
    this.title,

    this.description,
    this.date,

    this.views,
  });

  factory Updates.fromJson(Map<String, dynamic> json) => Updates(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    date:json["date"],
    views: json["views"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "date": date,
    "views": views,
  };
}
