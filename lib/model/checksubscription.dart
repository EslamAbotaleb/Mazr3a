
import 'dart:convert';
CheckSubscriptionModel checkSubscriptionModelFromJson(String str) => CheckSubscriptionModel.fromJson(json.decode(str));

String checkSubscriptionModelToJson(CheckSubscriptionModel data) => json.encode(data.toJson());

class CheckSubscriptionModel {
    CheckSubscriptionModel({
        this.statusCode,
        this.statusMessage,
        this.subscriptionStatus
    });

    int statusCode;
    String statusMessage;
    String subscriptionStatus;
    factory CheckSubscriptionModel.fromJson(Map<String, dynamic> json) => CheckSubscriptionModel(
        statusCode: json["statusCode"],
        statusMessage: json["statusMessage"],
        subscriptionStatus: json['subscriptionStatus']
    );

    Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "statusMessage": statusMessage,
        "subscriptionStatus": subscriptionStatus
    };
}
