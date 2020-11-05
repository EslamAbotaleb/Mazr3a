import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:primaxproject/model/results.dart';

ShowTopicModel showTopicModelFromJson(String str) => ShowTopicModel.fromJson(json.decode(str));

String showTopicModelToJson(ShowTopicModel data) => json.encode(data.toJson());

class ShowTopicModel {
    String statusCode;
    int pageNumber;
    String message;
    List<Result> results;

    ShowTopicModel({
       @required this.statusCode,
        this.pageNumber,
      @required  this.message,
      @required  this.results,
    });

    factory ShowTopicModel.fromJson(Map<String, dynamic> json) => ShowTopicModel(
        statusCode: json["statusCode"],
        pageNumber: json["pagesNumber"],
        message: json["message"],
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "pagesNumber": pageNumber,
        "message": message,
        "results": List<Result>.from(results.map((x) => x.toJson())),
    };
}
