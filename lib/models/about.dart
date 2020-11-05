
import 'dart:convert';

List<About> aboutFromJson(String str) => List<About>.from(json.decode(str).map((x) => About.fromJson(x)));

String aboutToJson(List<About> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class About {
  String id;
  String title;
  String contact;
  String name;
  String description;
  String date;
  String profile;
  String status;
  String views;


  About({
    this.id,
    this.title,
    this.contact,
    this.name,
    this.description,
    this.date,
    this.profile,
    this.status,
    this.views,
  });

  factory About.fromJson(Map<String, dynamic> json) => About(
    id: json["id"],
    title: json["title"],
    contact: json["contact"],
    name: json["name"],
    description: json["description"],
    date:json["date"],
    profile: json["profile"],
    status: json["status"],
    views: json["views"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "contact": contact,
    "name": name,
    "description": description,
    "date": date,
    "profile": profile,
    "status": status,
    "views": views,
  };
}
