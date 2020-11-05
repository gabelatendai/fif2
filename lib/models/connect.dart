
import 'dart:convert';

List<Connect> connectFromJson(String str) => List<Connect>.from(json.decode(str).map((x) => Connect.fromJson(x)));

String connectToJson(List<Connect> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Connect {
  String id;
  String title;
  String contact;
  String location;
  String description;
  String date;
  String profile;
  String status;
  String views;


  Connect({
    this.id,
    this.title,
    this.contact,
    this.location,
    this.description,
    this.date,
    this.profile,
    this.status,
    this.views,
  });

  factory Connect.fromJson(Map<String, dynamic> json) => Connect(
    id: json["id"],
    title: json["title"],
    contact: json["contact"],
    location: json["location"],
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
    "location": location,
    "description": description,
    "date": date,
    "profile": profile,
    "status": status,
    "views": views,
  };
}
