// To parse this JSON data, do
//
//     final sermons = sermonsFromJson(jsonString);

import 'dart:convert';

List<Sermons> sermonsFromJson(String str) => List<Sermons>.from(json.decode(str).map((x) => Sermons.fromJson(x)));

String sermonsToJson(List<Sermons> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Sermons {
    Sermons({
        this.id,
        this.vidio,
        this.profile,
        this.title,
        this.name,
        this.category,
        this.description,
        this.date,
        this.views,
        this.status,
    });

    String id;
    String vidio;
    String profile;
    String title;
    String name;
    dynamic category;
    String description;
    String date;
    dynamic views;
    dynamic status;

    factory Sermons.fromJson(Map<String, dynamic> json) => Sermons(
        id: json["id"],
        vidio: json["vidio"],
        profile: json["profile"],
        title: json["title"],
        name: json["name"],
        category: json["category"],
        description: json["description"],
        date: json["date"],
        views: json["views"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "vidio": vidio,
        "profile": profile,
        "title": title,
        "name": name,
        "category": category,
        "description": description,
        "date": date,
        "views": views,
        "status": status,
    };
}
