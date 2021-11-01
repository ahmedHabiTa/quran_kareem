
import 'package:flutter/cupertino.dart';

class AzkarMuslimModel {
  AzkarMuslimModel({
    this.details,
  });

  List<Details> details;

  factory AzkarMuslimModel.fromJson({@required Map<String, dynamic> json,String detailsUrl}) => AzkarMuslimModel(
    details: List<Details>.from(json[detailsUrl].map((x) => Details.fromJson(x))),
  );

  // Map<String, dynamic> toJson() => {
  //   "أذكار النوم": List<dynamic>.from(details.map((x) => x.toJson())),
  // };
}

class Details {
  Details({
    this.id,
    this.arabicText,
    this.languageArabicTranslatedText,
    this.translatedText,
    this.repeat,
    this.audio,
  });

  int id;
  String arabicText;
  String languageArabicTranslatedText;
  String translatedText;
  int repeat;
  String audio;

  factory Details.fromJson(Map<String, dynamic> json) => Details(
    id: json["ID"],
    arabicText: json["ARABIC_TEXT"],
    languageArabicTranslatedText: json["LANGUAGE_ARABIC_TRANSLATED_TEXT"],
    translatedText: json["TRANSLATED_TEXT"],
    repeat: json["REPEAT"],
    audio: json["AUDIO"],
  );

  // Map<String, dynamic> toJson() => {
  //   "ID": id,
  //   "ARABIC_TEXT": arabicText,
  //   "LANGUAGE_ARABIC_TRANSLATED_TEXT": languageArabicTranslatedText,
  //   "TRANSLATED_TEXT": translatedText,
  //   "REPEAT": repeat,
  //   "AUDIO": audio,
  // };
}
