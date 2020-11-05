import 'dart:convert';

import 'package:primaxproject/model/models.dart';

ListFavouriteModel listFavouriteModelFromJson(String str) => ListFavouriteModel.fromJson(json.decode(str));

String listFavouriteModelToJson(ListFavouriteModel data) => json.encode(data.toJson());

class ListFavouriteModel {
    ListFavouriteModel({
        this.statusCode,
        this.message,
        this.results,
    });

    String statusCode;
    String message;
    List<ResultFavorite> results;

    factory ListFavouriteModel.fromJson(Map<String, dynamic> json) => ListFavouriteModel(
        statusCode: json["statusCode"],
        message: json["message"],
        results: List<ResultFavorite>.from(json["results"].map((x) => ResultFavorite.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "results": List<ResultFavorite>.from(results.map((x) => x.toJson())),
    };
}
