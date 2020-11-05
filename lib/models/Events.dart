
import 'dart:convert';

List<Events> eventsFromJson(String str) => List<Events>.from(json.decode(str).map((x) => Events.fromJson(x)));

String eventsToJson(List<Events> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Events {
  String id;
  String title;
  String enddate;
  String startdate;
  String description;
  String date;
  String profile;
  String views;


  Events({
    this.id,
    this.title,
    this.enddate,
    this.startdate,
    this.description,
    this.date,
    this.profile,
    this.views,
  });

  factory Events.fromJson(Map<String, dynamic> json) => Events(
    id: json["id"],
    title: json["title"],
    enddate: json["enddate"],
    startdate: json["startdate"],
    description: json["description"],
    date:json["date"],
    profile: json["profile"],
    views: json["views"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "enddate": enddate,
    "startdate": startdate,
    "description": description,
    "date": date,
    "profile": profile,
    "views": views,
  };
}
