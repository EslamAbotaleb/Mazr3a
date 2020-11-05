import 'dart:convert';

OperatorSubscriptionModel operatorSubscriptionModelFromJson(String str) => OperatorSubscriptionModel.fromJson(json.decode(str));

String operatorSubscriptionModelToJson(OperatorSubscriptionModel data) => json.encode(data.toJson());

class OperatorSubscriptionModel {
    OperatorSubscriptionModel({
        this.status,
        this.message,
        this.dcb,
        this.results,
    });

    int status;
    String message;
    String dcb;
    List<OperatorResult> results;

    factory OperatorSubscriptionModel.fromJson(Map<String, dynamic> json) => OperatorSubscriptionModel(
        status: json["status"],
        message: json["message"],
        dcb: json["dcb"],
        results: List<OperatorResult>.from(json["results"].map((x) => OperatorResult.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "dcb": dcb,
        "results": List<OperatorResult>.from(results.map((x) => x.toJson())),
    };
}

class OperatorResult {
    OperatorResult({
        this.id,
        this.resultOperator,
        this.operatorCode,
        this.disclaimerText,
        this.country,
        this.countryId,
        this.countryCode,
    });

    int id;
    String resultOperator;
    String operatorCode;
    String disclaimerText;
    String country;
    int countryId;
    String countryCode;

    factory OperatorResult.fromJson(Map<String, dynamic> json) => OperatorResult(
        id: json["id"],
        resultOperator: json["operator"],
        operatorCode: json["operator_code"],
        disclaimerText: json["disclaimer_text"],
        country: json["country"],
        countryId: json["country_id"],
        countryCode: json["country_code"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "operator": resultOperator,
        "operator_code": operatorCode,
        "disclaimer_text": disclaimerText,
        "country": country,
        "country_id": countryId,
        "country_code": countryCode,
    };
}
