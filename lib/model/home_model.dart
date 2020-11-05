
import 'dart:convert';

import 'package:primaxproject/model/results.dart';

HomeModel homeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));

String homeModelToJson(HomeModel data) => json.encode(data.toJson());

class HomeModel {
    String statusCode;
    String message;
    List<Result> results;

    HomeModel({
        this.statusCode,
        this.message,
        this.results,
    });

    factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
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



// enum PortalId { PRIMAX }

// final portalIdValues = EnumValues({
//     "primax": PortalId.PRIMAX
// });

// enum Type { SERIES }

// final typeValues = EnumValues({
//     "series": Type.SERIES
// });

// class EnumValues<T> {
//     Map<String, T> map;
//     Map<T, String> reverseMap;

//     EnumValues(this.map);

//     Map<T, String> get reverse {
//         if (reverseMap == null) {
//             reverseMap = map.map((k, v) => new MapEntry(v, k));
//         }
//         return reverseMap;
//     }
// }
