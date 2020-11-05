import 'package:primaxproject/model/trailers.dart';
import 'cast.dart';
import 'episodes.dart';
import 'genre.dart';

class Result {
    Result({
        this.id,
        this.views,
        this.name,
        this.nameEn,
        this.description,
        this.descriptionEn,
        this.age,
        this.releaseDate,
        this.displayAt,
        this.isPortalDisplayed,
        this.rating,
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
        this.genres,
        this.casts,
        this.mainStars,
        this.trailers,
        this.episodes,
        this.duration,
        this.position,
        this.video,
        this.videoCover,
    });




    int id;
    int views;
    String name;
    String nameEn;
    String description;
    String descriptionEn;
    String age;
    DateTime releaseDate;
    dynamic displayAt;
    bool isPortalDisplayed;
    int rating;
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
    List<Genre> genres;
    List<Cast> casts;
    List<Cast> mainStars;
    List<Trailer> trailers;
    List<Episode> episodes;
    dynamic duration;
    dynamic position;
    dynamic video;
    dynamic videoCover;


    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        views: json["views"],
        name: json["name"],
        nameEn: json["nameEn"],
        description: json["description"],
        descriptionEn: json["descriptionEn"] == null ? null : json["descriptionEn"],
        age: json["age"],
        releaseDate: json["releaseDate"] == null ? null : DateTime.parse(json["releaseDate"]),
        displayAt: json["displayAt"],
        isPortalDisplayed: json["isPortalDisplayed"],
        rating: json["rating"],
        cCover1: json["cCover1"],
        cCover2: json["cCover2"],
        cPoster1: json["cPoster1"],
        cPoster2: json["cPoster2"],
        mCover1: json["mCover1"], 
        mCover2: json["mCover2"],
        mPoster1: json["mPoster1"],
        mPoster2: json["mPoster2"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        type: json["type"],
        genres: json["genres"] == null ? [] : List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))),
        casts: json["casts"] == null ? [] : List<Cast>.from(json["casts"].map((x) => Cast.fromJson(x))),
        mainStars: json["main_stars"] == null ? [] : List<Cast>.from(json["main_stars"].map((x) => Cast.fromJson(x))),
        trailers: json["trailers"] == null ? [] : List<Trailer>.from(json["trailers"].map((x) => Trailer.fromJson(x))),
        episodes: json["episodes"] == null ? [] : json["type"] == 'series' ? List<Episode>.from(json["episodes"].map((x) => Episode.fromJson(x))) : null,
        duration: json["duration"] == null ? null : json["duration"],
        position: json["position"] == null ? null : json["position"],
        video: json["video"] == null ? null : json["video"],
        videoCover: json["videoCover"] == null ? null : json["videoCover"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "views": views,
        "name": name,
        "nameEn": nameEn,
        "description": description,
        "descriptionEn": descriptionEn == null ? null : descriptionEn,
        "age": age,
        "releaseDate": releaseDate == null ? null : releaseDate.toIso8601String(),
        "displayAt": displayAt,
        "isPortalDisplayed": isPortalDisplayed,
        "rating": rating,
        "cCover1": cCover1,
        "cCover2": cCover2,
        "cPoster1": cPoster1,
        "cPoster2": cPoster2,
        "mCover1": mCover1,
        "mCover2": mCover2,
        "mPoster1": mPoster1,
        "mPoster2": mPoster2,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "type": type,
        "genres": genres == null ? [] : List<Genre>.from(genres.map((x) => x)),
        "casts":  casts == null ? [] : List<Cast>.from(casts.map((x) => x)),
        "main_stars": mainStars == null ? [] : List<Cast>.from(mainStars.map((x) => x.toJson())),
        "trailers": trailers == null ? [] : List<Trailer>.from(trailers.map((x) => x.toJson())),
        "episodes": episodes == null ? [] : List<Episode>.from(episodes.map((x) => x.toJson())),
        // "duration": duration,
        "position": position,
        "video": video,
        "videoCover": videoCover,
    };
}
