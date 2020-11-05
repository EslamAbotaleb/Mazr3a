import 'dart:convert';
// To parse this JSON data, do

CheckPinModel checkPinModelFromJson(String str) => CheckPinModel.fromJson(json.decode(str));

String checkPinModelToJson(CheckPinModel data) => json.encode(data.toJson());

class CheckPinModel {
    CheckPinModel({
        this.statusCode,
        this.statusMessage,
        this.user,
    });

    int statusCode;
    String statusMessage;
    User user;

    factory CheckPinModel.fromJson(Map<String, dynamic> json) => CheckPinModel(
        statusCode: json["statusCode"],
        statusMessage: json["statusMessage"],
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "statusMessage": statusMessage,
        "user": user.toJson(),
    };
}

class User {
    User({
        this.userId,
        this.msisdn,
        this.subscriptionDate,
        // this.serviceFees,
        this.nextPaymentDate,
        this.operatorId,
    });

    String userId;
    String msisdn;
    DateTime subscriptionDate;
    // dynamic serviceFees;
    DateTime nextPaymentDate;
    String operatorId;

    factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["userId"],
        msisdn: json["msisdn"],
        subscriptionDate:DateTime.parse(json["subscriptionDate"]),
        // serviceFees: json["serviceFees"],
        nextPaymentDate: DateTime.parse(json["nextPaymentDate"]),
        operatorId: json["operatorId"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "msisdn": msisdn,
        "subscriptionDate": subscriptionDate.toIso8601String(),
        // "serviceFees": serviceFees,
        "nextPaymentDate": nextPaymentDate.toIso8601String(),
        "operatorId": operatorId,
    };
}