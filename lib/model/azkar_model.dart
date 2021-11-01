import 'dart:convert';

class AzkarModel {
  AzkarModel({
    this.title,
    this.content,
  });

  String title;
  List<Content> content;

  factory AzkarModel.fromJson(Map<String, dynamic> json) => AzkarModel(
    title: json["title"],
    content: List<Content>.from(json["content"].map((x) => Content.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "content": List<dynamic>.from(content.map((x) => x.toJson())),
  };
}

class Content {
  Content({
    this.zekr,
    this.repeat,
    this.bless,
  });

  String zekr;
  int repeat;
  String bless;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
    zekr: json["zekr"],
    repeat: json["repeat"],
    bless: json["bless"],
  );

  Map<String, dynamic> toJson() => {
    "zekr": zekr,
    "repeat": repeat,
    "bless": bless,
  };
}
