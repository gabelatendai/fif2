// To parse this JSON data, do
//
//     final dashboard = dashboardFromJson(jsonString);

import 'dart:convert';

List<Dashboard> dashboardFromJson(String str) => List<Dashboard>.from(json.decode(str).map((x) => Dashboard.fromJson(x)));

String dashboardToJson(List<Dashboard> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Dashboard {
  Dashboard({
    this.id,
    this.profile,
    this.title,
    this.views,
    this.date,
    this.description,
  });

  String id;
  String profile;
  String title;
  String views;
  String date;
  String description;

  factory Dashboard.fromJson(Map<String, dynamic> json) => Dashboard(
    id: json["id"],
    profile: json["profile"],
    title: json["title"],
    views: json["views"],
    date: json["date"],
    description: json["description"] == null ? null : json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "profile": profile,
    "title": title,
    "views": views,
    "date": date,
    "description": description == null ? null : description,
  };
}
