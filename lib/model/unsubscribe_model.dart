import 'dart:convert';
UnSubscriptionModel unSubscriptionModelFromJson(String str) => UnSubscriptionModel.fromJson(json.decode(str));

String unSubscriptionModelToJson(UnSubscriptionModel data) => json.encode(data.toJson());

class UnSubscriptionModel {
    UnSubscriptionModel({
        this.statusCode,
        this.statusMessage,
    });

    int statusCode;
    String statusMessage;

    factory UnSubscriptionModel.fromJson(Map<String, dynamic> json) => UnSubscriptionModel(
        statusCode: json["statusCode"],
        statusMessage: json["statusMessage"],
    );

    Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "statusMessage": statusMessage,
    };
}
