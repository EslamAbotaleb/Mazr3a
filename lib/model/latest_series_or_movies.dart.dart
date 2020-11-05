import 'dart:convert';

import 'package:primaxproject/model/results.dart';

LatestSeriesOrMoviesModel latestSeriesModelFromJson(String str) => LatestSeriesOrMoviesModel.fromJson(json.decode(str));

String latestSeriesModelToJson(LatestSeriesOrMoviesModel data) => json.encode(data.toJson());

class LatestSeriesOrMoviesModel {
    LatestSeriesOrMoviesModel({
        this.statusCode,
        this.message,
        this.results,
    });

    String statusCode;
    String message;
    List<Result> results;

    factory LatestSeriesOrMoviesModel.fromJson(Map<String, dynamic> json) => LatestSeriesOrMoviesModel(
        statusCode: json["statusCode"],
        message: json["message"],
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "results": List<Result>.from(results.map((x) => x.toJson())),
    };
}
