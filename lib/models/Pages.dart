// To parse this JSON data, do
//
//     final pages = pagesFromJson(jsonString);

import 'dart:convert';

List<Pages> pagesFromJson(String str) => List<Pages>.from(json.decode(str).map((x) => Pages.fromJson(x)));

String pagesToJson(List<Pages> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Pages {
  Pages({
    this.id,
    this.profile,
    this.title,
    this.views,
    this.date,
  });

  String id;
  String profile;
  String title;
  String views;
  String date;

  factory Pages.fromJson(Map<String, dynamic> json) => Pages(
    id: json["id"],
    profile: json["profile"],
    title: json["title"],
    views: json["views"],
    date: json["date"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "profile": profile,
    "title": title,
    "views": views,
    "date": date,
  };
}
