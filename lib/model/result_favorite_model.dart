
import 'package:primaxproject/model/models.dart';

class ResultFavorite {
    ResultFavorite({
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
        this.isFavourite,
        this.genres,
        this.mainStars,
        this.casts,
        this.trailers,
        this.type,
    });

    int id;
    int views;
    String name;
    String nameEn;
    String description;
    String descriptionEn;
    String age;
    DateTime releaseDate;
    DateTime displayAt;
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
    String isFavourite;
    List<Genre> genres;
    List<Cast> mainStars;
    List<Cast> casts;
    List<Trailer> trailers;
    String type;

    factory ResultFavorite.fromJson(Map<String, dynamic> json) => ResultFavorite(
        id: json["id"],
        views: json["views"],
        name: json["name"],
        nameEn: json["nameEn"],
        description: json["description"],
        descriptionEn: json["descriptionEn"],
        age: json["age"],
        releaseDate: DateTime.parse(json["releaseDate"]),
        displayAt: DateTime.parse(json["displayAt"]),
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
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        isFavourite: json["isFavourite"],
        genres: List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))),
        mainStars: List<Cast>.from(json["main_stars"].map((x) => Cast.fromJson(x))),
        casts: List<Cast>.from(json["casts"].map((x) => Cast.fromJson(x))),
        trailers: List<Trailer>.from(json["trailers"].map((x) => Trailer.fromJson(x))),
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "views": views,
        "name": name,
        "nameEn": nameEn,
        "description": description,
        "descriptionEn": descriptionEn,
        "age": age,
        "releaseDate": releaseDate.toIso8601String(),
        "displayAt": displayAt.toIso8601String(),
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
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "isFavourite": isFavourite,
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "main_stars": List<dynamic>.from(mainStars.map((x) => x.toJson())),
        "casts": List<dynamic>.from(casts.map((x) => x.toJson())),
        "trailers": List<dynamic>.from(trailers.map((x) => x.toJson())),
        "type": type,
    };
}

