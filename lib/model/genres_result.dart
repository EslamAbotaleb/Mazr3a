import 'package:primaxproject/model/media_list_result.dart';

class ResultGenres {
    ResultGenres({
        this.nameAr,
        this.nameEn,
        // this.portalId,
        this.id,
        this.position,
        this.mediaList,
        // this.isPortalDisplayed,
    });
 
    String nameAr;
    String nameEn;
    int id;
    int position;
    List<MediaListResult> mediaList;
    // bool isPortalDisplayed;

    factory ResultGenres.fromJson(Map<String, dynamic> json) => ResultGenres(
        nameAr: json["nameAr"],
        nameEn: json["nameEn"],
        id: json["id"],
        position: json["position"],
        mediaList: List<MediaListResult>.from(json["mediaList"].map((x) => MediaListResult.fromJson(x))),
        // isPortalDisplayed: json["isPortalDisplayed"],
    );

    Map<String, dynamic> toJson() => {
        "nameAr": nameAr,
        "nameEn": nameEn,
        // "portalId": portalId,
        'id' : id,
        "position": position,
        "mediaList": List<MediaListResult>.from(mediaList.map((x) => x.toJson())),
        // "isPortalDisplayed": isPortalDisplayed,
    };
}

