
import 'dart:convert';

FavouriteStatusModel favouriteStatusModelFromJson(String str) => FavouriteStatusModel.fromJson(json.decode(str));

String favouriteStatusModelToJson(FavouriteStatusModel data) => json.encode(data.toJson());

class FavouriteStatusModel {
    FavouriteStatusModel({
        this.statusCode,
        this.message,
        this.isFavourite,
    });

    String statusCode;
    String message;
    String isFavourite;

    factory FavouriteStatusModel.fromJson(Map<String, dynamic> json) => FavouriteStatusModel(
        statusCode: json["statusCode"],
        message: json["message"],
        isFavourite: json["isFavourite"],
    );

    Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "isFavourite": isFavourite,
    };
}
