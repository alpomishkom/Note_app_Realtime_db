import 'dart:convert';

List<Not> notFromJson(String str) => List<Not>.from(json.decode(str).map((x) => Not.fromJson(x)));

String notToJson(List<Not> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Not {
  String title;
  String subtitle;

  Not({
    required this.title,
    required this.subtitle,
  });

  factory Not.fromJson(Map<String, dynamic> json) => Not(
    title: json["title"],
    subtitle: json["subtitle"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "subtitle": subtitle,
  };
}
