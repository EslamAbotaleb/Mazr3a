import 'dart:convert';


Cast castModelFromJson(String str) => Cast.fromJson(json.decode(str));

String castModelToJson(Cast data) => json.encode(data.toJson());


class Cast {
  Cast(
      {this.id,
      this.nameAr,
      this.nameEn,
      this.image,
      this.createdAt,
      this.updatedAt,
      this.pivot
      });

  final int id;
  final String nameAr;
  final String nameEn;
  final String image;
  final DateTime createdAt;
  final DateTime updatedAt;
  Pivot pivot;

  factory Cast.fromJson(Map<String, dynamic> json) => Cast(
        id: json["id"],
        nameAr: json["nameAr"],
        nameEn: json["nameEn"],
        image: json["image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        pivot: Pivot.fromJson(json["pivot"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nameAr": nameAr,
        "nameEn": nameEn,
        "image": image,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "pivot": pivot.toJson(),
      };
}

class Pivot {
  Pivot({
    this.movieId,
    this.actorId,
  });

  int movieId;
  int actorId;

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        movieId: json["movieId"],
        actorId: json["actorId"],
      );

  Map<String, dynamic> toJson() => {
        "movieId": movieId,
        "actorId": actorId,
      };
}
