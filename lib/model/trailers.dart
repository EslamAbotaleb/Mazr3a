// class Trailer {
//   Trailer({
//     this.id,
//     this.title,
//     this.description,
//     this.image,
//     this.cover,
//     this.video,
//     this.promo,
//     this.displayAt,
//     this.duration,
//     this.viewsNum,
//     this.position,
//     this.avgWatchTime,
//     this.likesNum,
//     this.portalId,
//     this.program,
//     this.createdAt,
//     this.updatedAt,
//     this.tags,
//   });

//   // int id;
//   // String title;
//   // String description;
//   // String image;
//   // String cover;
//   // String video;
//   // String promo;
//   // DateTime displayAt;
//   // String duration;
//   // int viewsNum;
//   // int position;
//   // double avgWatchTime;
//   // int likesNum;
//   // String portalId;
//   // String program;
//   // DateTime createdAt;
//   // DateTime updatedAt;
//   // List<dynamic> tags;
//   int id;
//   int views;
//   String title;
//   String description;
//   int type;
//   int showId;
//   int trailerNumber;
//   DateTime displayAt;
//   String duration;
//   int position;
//   String video;
//   String videoCover;
//   DateTime createdAt;
//   DateTime updatedAt;

//   factory Trailer.fromJson(Map<String, dynamic> json) => Trailer(
//         id:  json["id"] == null ? null : json["id"],
//         title: json["title"] == null ? null : json["title"],
//         description: json["description"] == null ? null : json["description"],
//         image: json["image"] == null ? null : json["image"],
//         cover: json["cover"] == null ? null : json["cover"],
//         video: json["video"] == null ? null : json["video"],
//         promo: json["promo"] == null ? null : json["promo"],
//         displayAt: json["displayAt"] == null ? null : DateTime.parse(json["displayAt"]),
//         duration: json["duration"] == null ? null : json["duration"],
//         viewsNum: json["viewsNum"] == null ? null : json["viewsNum"] ,
//         position: json["position"] == null ? null : json["position"],
//         avgWatchTime: json["avgWatchTime"],
//         likesNum: json["likesNum"],
//         portalId: json["portalId"],
//         program: json["program"],
//         createdAt: DateTime.parse(json["createdAt"]),
//         // updatedAt: DateTime.parse(json["updatedAt"]),
//         tags: List<dynamic>.from(json["tags"].map((x) => x)),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "title": title,
//         "description": description == null ? null : description,
//         "image": image == null ? null : image,
//         "cover": cover == null ? null : cover,
//         "video": video,
//         "promo": promo == null ? null : promo,
//         "displayAt": displayAt == null ? null : displayAt.toIso8601String(),
//         "duration": duration,
//         "viewsNum": viewsNum,
//         "position": position,
//         "avgWatchTime": avgWatchTime,
//         "likesNum": likesNum,
//         "portalId": portalId,
//         "program": program == null ? null : program,
//         "createdAt": createdAt.toIso8601String(),
//         "updatedAt": updatedAt.toIso8601String(),
//         "tags": List<dynamic>.from(tags.map((x) => x)),
//       };
// }

class Trailer {
    Trailer({
        this.id,
        this.title,
        this.description,
        this.displayAt,
        this.duration,
        this.video,
        this.videoCover,
        this.createdAt,
        this.updatedAt,
        this.views,
        this.trailerNumber,
        this.position,
    });

    int id;
    String title;
    dynamic description;
    dynamic displayAt;
    String duration;
    String video;
    String videoCover;
    DateTime createdAt;
    DateTime updatedAt;
    int views;
    int trailerNumber;
    dynamic position;

    factory Trailer.fromJson(Map<String, dynamic> json) => Trailer(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        displayAt: json["displayAt"],
        duration: json["duration"] == null ? null : json["duration"],
        video: json["video"] == null ? null : json["video"],
        videoCover: json["videoCover"] == null ? null : json["videoCover"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        views: json["views"] == null ? null : json["views"],
        trailerNumber: json["trailerNumber"] == null ? null : json["trailerNumber"],
        position: json["position"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "displayAt": displayAt,
        "duration": duration == null ? null : duration,
        "video": video == null ? null : video,
        "videoCover": videoCover == null ? null : videoCover,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "views": views == null ? null : views,
        "trailerNumber": trailerNumber == null ? null : trailerNumber,
        "position": position,
    };
}