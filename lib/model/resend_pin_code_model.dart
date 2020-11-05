import 'dart:convert';

ResendPinCodeModel resendPinCodeModelFromJson(String str) => ResendPinCodeModel.fromJson(json.decode(str));

String resendPinCodeModelToJson(ResendPinCodeModel data) => json.encode(data.toJson());

class ResendPinCodeModel {
    ResendPinCodeModel({
        this.statusCode,
        this.statusMessage,
        this.subscriptionStatus,
    });

    int statusCode;
    String statusMessage;
    String subscriptionStatus;

    factory ResendPinCodeModel.fromJson(Map<String, dynamic> json) => ResendPinCodeModel(
        statusCode: json["statusCode"],
        statusMessage: json["statusMessage"],
        subscriptionStatus: json["subscriptionStatus"],
    );

    Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "statusMessage": statusMessage,
        "subscriptionStatus": subscriptionStatus,
    };
}
