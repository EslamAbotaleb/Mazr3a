class Episode {
  Episode({
  this.id,
        this.title,
        this.description,
        this.displayAt,
        this.duration,
        // this.tags,
        this.video,
        this.videoCover,
        this.promo,
        this.promoUrl,
        this.seriesId,
        this.episodeNumber,
        this.createdAt,
        this.updatedAt,
  });
  int id;
  String title;
  String description;
  dynamic displayAt;
  String duration;
  // dynamic tags;
  String video;
  String videoCover;
  String promo;
  String promoUrl;
  int seriesId;
  int episodeNumber;
  DateTime createdAt;
  DateTime updatedAt;
  // int id;
  // String title;
  // String description;
  // String image;
  // String cover;
  // String video;
  // String promo;
  // DateTime displayAt;
  // String duration;
  // int viewsNum;
  // int position;
  // double avgWatchTime;
  // int likesNum;
  // String portalId;
  // String program;
  // DateTime createdAt;
  // DateTime updatedAt;
  // List<dynamic> tags;
  // "id": 1,
  //                   "title": "title",
  //                   "description": null,
  //                   "displayAt": null,
  //                   "duration": "sdf",
  //                   "video": "videos/Episodes/2020-09-28/20200928085345_n6HIa.jpeg",
  //                   "videoCover": "images/Episodes/2020-09-28/20200928085345_5dcjg.jpeg",
  //                   "episodeNumber": 1,
  //                   "created_at": "2020-09-28T08:53:45.000000Z",
  //                   "updated_at": "2020-09-28T08:53:45.000000Z"
  factory Episode.fromJson(Map<String, dynamic> json) => Episode(
         id: json["id"],
        title: json["title"],
        description: json["description"] == null ? "" : json["description"],
        displayAt: json["displayAt"],
        duration: json["duration"] == null ? "0:0" : json["duration"],
        video: json["video"] == null ? null : json["video"],
        videoCover: json["videoCover"] == null ? null : json["videoCover"],
        episodeNumber: json["episodeNumber"] == null ? null : json["episodeNumber"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
           "id": id,
        "title": title,
        "description": description,
        "displayAt": displayAt,
        "duration": duration == null ? null : duration,
        "video": video == null ? null : video,
        "videoCover": videoCover == null ? null : videoCover,
        "episodeNumber": episodeNumber == null ? null : episodeNumber,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
