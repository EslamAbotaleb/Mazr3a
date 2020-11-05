
class Genre {
    Genre({
        this.id,
        this.nameAr,
        this.nameEn,
        this.createdAt,
        this.updatedAt,
        this.position
        // this.portalDisplayed,
    });

    int id;
    String nameAr;
    String nameEn;
    DateTime createdAt;
    DateTime updatedAt;
    int position;
    // bool portalDisplayed;

    factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json["id"],
        nameAr: json["nameAr"],
        nameEn: json["nameEn"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        position: json["position"],
        // portalDisplayed: json["portalDisplayed"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nameAr": nameAr,
        "nameEn": nameEn,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "position" : position
        // "portalDisplayed": portalDisplayed,
    };
}