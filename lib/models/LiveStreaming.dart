// To parse this JSON data, do
//
//     final liveStreaming = liveStreamingFromJson(jsonString);

import 'dart:convert';

List<LiveStreaming> liveStreamingFromJson(String str) => List<LiveStreaming>.from(json.decode(str).map((x) => LiveStreaming.fromJson(x)));

String liveStreamingToJson(List<LiveStreaming> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LiveStreaming {
  LiveStreaming({
    this.id,
    this.profile,
    this.title,
    this.description,
    this.views,
    this.date,
    this.link,
  });

  String id;
  String profile;
  String title;
  String description;
  String views;
  String date;
  String link;

  factory LiveStreaming.fromJson(Map<String, dynamic> json) => LiveStreaming(
    id: json["id"],
    profile: json["profile"],
    title: json["title"],
    description: json["description"],
    views: json["views"],
    date: json["date"],
    link: json["link"] == null ? null : json["link"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "profile": profile,
    "title": title,
    "description": description,
    "views": views,
    "date": date,
    "link": link == null ? null : link,
  };
}
