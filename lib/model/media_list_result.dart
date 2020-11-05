import 'package:primaxproject/model/cast.dart';
import 'package:primaxproject/model/episodes.dart';
import 'package:primaxproject/model/trailers.dart';

class MediaListResult {
  int id;
  int views;
  String name;
  String nameEn;
  String description;
  String descriptionEn;
  String age;
  // DateTime releaseDate;
  bool isPortalDisplayed;
  int rating;
  DateTime displayAt;
  String duration;
  int position;
  String video;
  String videoCover;
  String cCover1;
  String cCover2;
  String cPoster1;
  String cPoster2;
  String mCover1;
  String mCover2;
  String mPoster1;
  String mPoster2;
  DateTime createdAt;
  DateTime updatedAt;
  String type;
  Pivot pivot;
  List<Trailer> trailers;
  List<Cast> mainStars;
  List<Cast> casts;
  List<Episode> episodes;
  MediaListResult({
    this.id,
    this.views,
    this.name,
    this.nameEn,
    this.description,
    this.descriptionEn,
    this.age,
    // this.releaseDate,
    this.isPortalDisplayed,
    this.rating,
    this.displayAt,
    this.duration,
    this.position,
    this.video,
    this.videoCover,
    this.cCover1,
    this.cCover2,
    this.cPoster1,
    this.cPoster2,
    this.mCover1,
    this.mCover2,
    this.mPoster1,
    this.mPoster2,
    this.createdAt,
    this.updatedAt,
    this.type,
    this.pivot,
    this.trailers,
    this.mainStars,
    this.casts,
    this.episodes,
  });

  factory MediaListResult.fromJson(Map<String, dynamic> json) => MediaListResult(
         id: json["id"],
        views: json["views"],
        name: json["name"],
        nameEn: json["nameEn"],
        description: json["description"],
        descriptionEn: json["descriptionEn"],
        age: json["age"],
        // releaseDate: DateTime.parse(json["releaseDate"]),
        isPortalDisplayed: json["isPortalDisplayed"],
        rating: json["rating"],
        displayAt: DateTime.parse(json["displayAt"]),
        duration: json["duration"],
        position: json["position"],
        video: json["video"],
        videoCover: json["videoCover"],
        cCover1: json["cCover1"],
        cCover2: json["cCover2"],
        cPoster1: json["cPoster1"],
        cPoster2: json["cPoster2"],
        mCover1: json["mCover1"],
        mCover2: json["mCover2"],
        mPoster1: json["mPoster1"],
        mPoster2: json["mPoster2"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        type: json["type"],
        pivot: Pivot.fromJson(json["pivot"]),
        trailers: List<Trailer>.from(json["trailers"].map((x) => Trailer.fromJson(x))),
        mainStars: List<Cast>.from(json["main_stars"].map((x) => Cast.fromJson(x))),
        casts: List<Cast>.from(json["casts"].map((x) => Cast.fromJson(x))),
        episodes: json["episodes"] == null ? null : List<Episode>.from(json["episodes"].map((x) => Episode.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
         "id": id,
        "views": views,
        "name": name,
        "nameEn": nameEn,
        "description": description,
        "descriptionEn": descriptionEn,
        "age": age,
        // "releaseDate": releaseDate.toIso8601String(),
        "isPortalDisplayed": isPortalDisplayed,
        "rating": rating,
        "displayAt": displayAt.toIso8601String(),
        "duration": duration,
        "position": position,
        "video": video,
        "videoCover": videoCover,
        "cCover1": cCover1,
        "cCover2": cCover2,
        "cPoster1": cPoster1,
        "cPoster2": cPoster2,
        "mCover1": mCover1,
        "mCover2": mCover2,
        "mPoster1": mPoster1,
        "mPoster2": mPoster2,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "type": type,
        "pivot": pivot.toJson(),
        "trailers": List<Trailer>.from(trailers.map((x) => x)),
        "main_stars": List<Cast>.from(mainStars.map((x) => x.toJson())),
        "casts": List<Cast>.from(casts.map((x) => x.toJson())),
        "episodes": episodes == null ? null : List<Episode>.from(episodes.map((x) => x)),
      };
}
