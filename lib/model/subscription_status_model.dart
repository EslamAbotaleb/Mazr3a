import 'dart:convert';

SubscriptionStatusModel subscriptionStatusModelFromJson(String str) => SubscriptionStatusModel.fromJson(json.decode(str));

String subscriptionStatusModelToJson(SubscriptionStatusModel data) => json.encode(data.toJson());

class SubscriptionStatusModel {
    SubscriptionStatusModel({
        this.statusCode,
        this.statusMessage,
        this.subscriptionStatus
    });

    int statusCode;
    String statusMessage;
    String subscriptionStatus;
    factory SubscriptionStatusModel.fromJson(Map<String, dynamic> json) => SubscriptionStatusModel(
        statusCode: json["statusCode"],
        statusMessage: json["statusMessage"],
        subscriptionStatus: json["subscriptionStatus"]
    );

    Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "statusMessage": statusMessage,
        "subscriptionStatus":  subscriptionStatus
    };
}
