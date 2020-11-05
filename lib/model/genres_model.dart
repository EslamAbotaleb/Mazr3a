
import 'dart:convert';

import 'genres_result.dart';

GenresHomeModel genresModelFromJson(String str) => GenresHomeModel.fromJson(json.decode(str));

String genresModelToJson(GenresHomeModel data) => json.encode(data.toJson());

class GenresHomeModel {
    GenresHomeModel({
        this.statusCode,
        this.message,
        this.results,
    });

    String statusCode;
    String message;
    List<ResultGenres> results;

    factory GenresHomeModel.fromJson(Map<String, dynamic> json) => GenresHomeModel(
        statusCode: json["statusCode"],
        message: json["message"],
        results: List<ResultGenres>.from(json["results"].map((x) => ResultGenres.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "results": List<ResultGenres>.from(results.map((x) => x.toJson())),
    };
}
