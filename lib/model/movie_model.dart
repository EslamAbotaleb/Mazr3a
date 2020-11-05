
class Movie {
    Movie({
        this.id,
        this.title,
        this.description,
        this.image,
        this.cover,
        this.video,
        this.promo,
        this.displayAt,
        this.duration,
        this.viewsNum,
        this.position,
        this.avgWatchTime,
        this.likesNum,
        this.portalId,
        this.program,
        this.createdAt,
        this.updatedAt,
        this.tags,
    });

    int id;
    String title;
    String description;
    String image;
    String cover;
    String video;
    String promo;
    DateTime displayAt;
    String duration;
    int viewsNum;
    int position;
    double avgWatchTime;
    int likesNum;
    String portalId;
    String program;
    DateTime createdAt;
    DateTime updatedAt;
    List<dynamic> tags;

    factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        id: json["id"],
        title: json["title"],
        description: json["description"] == null ? null : json["description"],
        image: json["image"],
        cover: json["cover"] == null ? null : json["cover"],
        video: json["video"],
        promo: json["promo"] == null ? null : json["promo"],
        displayAt: json["displayAt"] == null ? null : DateTime.parse(json["displayAt"]),
        duration: json["duration"],
        viewsNum: json["viewsNum"],
        position: json["position"],
        avgWatchTime: json["avgWatchTime"],
        likesNum: json["likesNum"],
        portalId: json["portalId"],
        program: json["program"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        tags: List<dynamic>.from(json["tags"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description == null ? null : description,
        "image": image == null ? null : image,
        "cover": cover == null ? null : cover,
        "video": video,
        "promo": promo == null ? null : promo,
        "displayAt": displayAt == null ? null : displayAt.toIso8601String(),
        "duration": duration,
        "viewsNum": viewsNum,
        "position": position,
        "avgWatchTime": avgWatchTime,
        "likesNum": likesNum,
        "portalId": portalId,
        "program": program == null ? null : program,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "tags": List<dynamic>.from(tags.map((x) => x)),
    };
}