
import 'dart:convert';

QuranMp3Model quranMp3ModelFromJson(String str) =>
    QuranMp3Model.fromJson(json.decode(str));

String quranMp3ModelToJson(QuranMp3Model data) => json.encode(data.toJson());

class QuranMp3Model {
  QuranMp3Model({
    this.code,
    this.status,
    this.data,
  });

  int code;
  String status;
  Data data;

  factory QuranMp3Model.fromJson(Map<String, dynamic> json) => QuranMp3Model(
        code: json["code"],
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.surahs,
  });

  List<Surah> surahs;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        surahs: List<Surah>.from(json["surahs"].map((x) => Surah.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "surahs": List<dynamic>.from(surahs.map((x) => x.toJson())),
      };
}

class Surah {
  Surah({
    this.ayahs,
  });

  List<Ayah> ayahs;

  factory Surah.fromJson(Map<String, dynamic> json) => Surah(
        ayahs: List<Ayah>.from(json["ayahs"].map((x) => Ayah.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ayahs": List<dynamic>.from(ayahs.map((x) => x.toJson())),
      };
}

class Ayah {
  Ayah({
    this.audio,
  });

  String audio;

  factory Ayah.fromJson(Map<String, dynamic> json) => Ayah(
        audio: json["audio"],
      );

  Map<String, dynamic> toJson() => {
        "audio": audio,
      };
}
