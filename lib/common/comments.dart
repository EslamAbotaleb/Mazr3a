// Future<APIResponse<ShowTopicModel>> getTopTen() async {

//   try {
//     final response =
//         await http.get('http://www.json-generator.com/api/json/get/coRKHltbnm?indent=2', headers: headers);
//     if (response.statusCode == 200) {
//       final ShowTopicModel results = showTopicModelFromJson(response.body);
//       print('topTenSuccesstoreachtodata');
//       // print(results.results.length);

//       return APIResponse<ShowTopicModel>(data: results);
//     } else {
//       print('notfetchdatatopten');
//       return APIResponse<ShowTopicModel>(
//           error: true, errorMessage: 'An error occured');
//     }
//   } catch (error) {
//     print(error);
//     return APIResponse<ShowTopicModel>(error: true, errorMessage: error);
//   }
// }
// st
// // static url
// Future<APIResponse<HomeModel>> getTopTen() async {

//   try {
//     final response =
//         await http.get('http://www.json-generator.com/api/json/get/coRKHltbnm?indent=2', headers: headers);
//     if (response.statusCode == 200) {
//       final HomeModel results = homeModelFromJson(response.body);
//       print('topTenSuccesstoreachtodata');
//       // print(results.results.length);
//       return APIResponse<HomeModel>(data: results);
//     } else {
//       print('notfetchdatatopten');
//       return APIResponse<HomeModel>(
//           error: true, errorMessage: 'An error occured');
//     }
//   } catch (error) {
//     return APIResponse<HomeModel>(error: true, errorMessage: error);
//   }
// }
// Future<APIResponse<HomeModel>> getItemAfterSearch(String keyowrd)  async {
//     try {
//     final response =
//         await http.get(API + 'search?keyword=$keyowrd', headers: headers);
//     if (response.statusCode == 200) {
//       final HomeModel results = homeModelFromJson(response.body);
//       print('searchIsDisplayed');
//       return APIResponse<HomeModel>(data: results);
//     } else {
//       print('notfetchdataadftersearch');
//       return APIResponse<HomeModel>(
//           error: true, errorMessage: 'An error occured');
//     }
//   } catch (error) {
//     print(error);
//     return APIResponse<HomeModel>(error: true, errorMessage: error);
//   }
// }

// Future<APIResponse<ShowTopicModel>> getShowTopicSerivce(int pageNumber, String absolutePath) async {
//   Map seriesbody = {
//     // 'portalId': 'primax',
//     'pageNumber': pageNumber,
//   };
//   var bodyData = json.encode(seriesbody);
//   try {
//     final response = await http.post(API + absolutePath,
//         headers: headers, body: bodyData);
//     if (response.statusCode == 200) {

//       final ShowTopicModel results = showTopicModelFromJson(response.body);
//       print(results.results.length);
//       return APIResponse<ShowTopicModel>(data: results);
//     } else {
//       return APIResponse<ShowTopicModel>(
//           error: true, errorMessage: 'An error occured');
//     }
//   } catch (error) {
//     return APIResponse<ShowTopicModel>(error: true, errorMessage: error);
//   }
// }getLatestMoviesOrSeriesHomeService
// Future<APIResponse<GenresModel>> getGenresService() async {
// Map genresBody = {
//         'portalId': 'primax',
// };
// var bodyData = json.encode(genresBody);
//   try {
//     final response = await http.post(API + '/genres', headers: headers, body: bodyData);
//     if (response.statusCode == 200) {
//       final GenresModel results = genresModelFromJson(response.body);
//       return APIResponse<GenresModel>(data: results != null ? results : 0);
//     } else {
//       return APIResponse<GenresModel>(error: true, errorMessage: 'An error occured');
//     }
//   } catch (error) {
//     print(error);
//     return APIResponse<GenresModel>(error: true, errorMessage: error);
//   }
// }

//   Future<APIResponse<ShowTopicModel>>
//     getLatestSeriesHomeService() async {
//   try {
//     final response =
//         await http.get(API + "get/latest/series", headers: headers);
//     if (response.statusCode == 200) {
//       final ShowTopicModel results =
//           showTopicModelFromJson(response.body);
//       return APIResponse<ShowTopicModel>(data: results);
//     } else {
//       return APIResponse<ShowTopicModel>(
//           error: true, errorMessage: "An error occurred");
//     }
//   } catch (error) {
//     return APIResponse<ShowTopicModel>(
//         error: true, errorMessage: error);
//   }
// }

// Future<APIResponse<ShowTopicModel>>
//     getLatestMoviesHomeService(String absolutePath) async {
//   try {
//     final response =
//         await http.get(API + absolutePath, headers: headers);
//     if (response.statusCode == 200) {
//       final ShowTopicModel results =
//           showTopicModelFromJson(response.body);
//       return APIResponse<ShowTopicModel>(data: results);
//     } else {
//       return APIResponse<ShowTopicModel>(
//           error: true, errorMessage: "An error occurred");
//     }
//   } catch (error) {
//     return APIResponse<ShowTopicModel>(
//         error: true, errorMessage: error);
//   }
// }
// http://192.168.3.51:8000/get/LatestByGenres

// _apiResponse = await service.getShowTopicSerivce(1, 'get/latest/movies');
// constraints: BoxConstraints(
//     minWidth: 7.9 * SizeConfigs.widthMultiplier,
//     maxWidth: SizeConfigs.screenWidth <= 375.0
//         ? 9.2 * SizeConfigs.widthMultiplier
//         : 8.2 * SizeConfigs.widthMultiplier,
//     minHeight: 0.2 * SizeConfigs.heightMultiplier,
//     maxHeight: 0.2 * SizeConfigs.heightMultiplier),

// ConstrainedBox(
//   child: Container(color: AppColorsStyle.commoncolor),
//   constraints: BoxConstraints(
//     minWidth: 30 * SizeConfigs.widthMultiplier,
//     maxWidth: SizeConfigs.widthMultiplier <= 375.0
//         ? 70 * SizeConfigs.widthMultiplier
//         : 80.0 * SizeConfigs.widthMultiplier,
//     minHeight: 0.2 * SizeConfigs.heightMultiplier,
//   ),

//   // color: AppColorsStyle.commoncolor,
// ),

// constraints: BoxConstraints(
//   maxWidth: 100 * SizeConfigs.widthMultiplier,
//   maxHeight: 25.5 * SizeConfigs.heightMultiplier,
//   minHeight: 22.5 * SizeConfigs.heightMultiplier,
// ),
// Color.fromRGBO(10, 10, 10, 1.0)
// width: SizeConfig.safeBlockHorizontal * 100,
// height: MediaQuery.of(context).size.height * 0.29,
// height: SizeConfig.blockSizeVertical * 28 > 255 ? SizeConfig.blockSizeVertical * 27 : SizeConfig.blockSizeVertical * 27,
//     SelectedTopicSeriesOrMovie(
//   apiResponse: _apiResponse,
//   type: _apiResponse?.data?.results[index]?.type,
//   poster: _apiResponse
//       ?.data?.results[index]?.cPoster1,
//   description: _apiResponse
//       ?.data?.results[index]?.description,
//   cover:
//       _apiResponse?.data?.results[index]?.cCover1,
//   // position: index,
//   title: _apiResponse?.data?.results[index]?.name,

//   // listTrailers: _apiResponse?.data
//   //             ?.results[index]?.trailers ==
//   //         null
//   //     ? 0
//   //     : _apiResponse
//   //         ?.data?.results[index]?.trailers),
// )

// width: SizeConfig.safeBlockHorizontal * 45,
// height: SizeConfig.blockSizeVertical * 22.9,
// constraints: BoxConstraints(
//   maxWidth: 37.0 * SizeConfigs.widthMultiplier,
//   minWidth: 35.0 * SizeConfigs.widthMultiplier,
//   maxHeight: 25.0 * SizeConfigs.heightMultiplier,
//   minHeight: 19.0 * SizeConfigs.heightMultiplier,
// ),
// constraints: BoxConstraints(
//   maxWidth: SizeConfigs.widthMultiplier <= 375.0
//       ? 41.0 * SizeConfigs.widthMultiplier
//       : 37.0 * SizeConfigs.widthMultiplier,
//   minWidth: SizeConfigs.widthMultiplier <= 375.0
//       ? 41.0 * SizeConfigs.widthMultiplier
//       : 37.0 * SizeConfigs.widthMultiplier,
//   maxHeight: SizeConfigs.widthMultiplier <= 375.0
//       ? 20.0 * SizeConfigs.heightMultiplier
//       : 20.0 * SizeConfigs.heightMultiplier,
//   minHeight: SizeConfigs.widthMultiplier <= 375.0
//       ? 20.0 * SizeConfigs.heightMultiplier
//       : 20.0 * SizeConfigs.heightMultiplier,
// ),
// SizeConfig.blockSizeVertical * 50 > 255
//     ? SizeConfig.blockSizeVertical * 23
//     : SizeConfig.blockSizeVertical * 50,
//
// FittedBox(
//     fit: BoxFit.fitWidth,
//     child: Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Text(
//         _apiResponse?.data?.results[index].name,
//         style: TextStyle(
//           fontSize:
//               MediaQuery.of(context).size.height *
//                   0.025,
//         ),
//         // style: AppTextStyle.textCardStyle,
//       ),
//     )),
// SizeConfigs.widthMultiplier <= 375.0
//     ? 2.8 * SizeConfigs.widthMultiplier
//     : 3.7 * SizeConfigs.widthMultiplier


// FlatButton(
            //   onPressed: () {
            //     _chewieController.enterFullScreen();
            //   },
            //   child: Text('Fullscreen'),
            // ),
            // Row(
            //   children: <Widget>[
            //     Expanded(
            //       child: FlatButton(
            //         onPressed: () {
            //           setState(() {
            //             _chewieController.dispose();
            //             _videoPlayerController2.pause();
            //             _videoPlayerController2.seekTo(Duration(seconds: 0));
            //             _chewieController = ChewieController(
            //               videoPlayerController: _videoPlayerController1,
            //               aspectRatio: 3 / 2,
            //               autoPlay: true,
            //               looping: true,
            //             );
            //           });
            //         },
            //         child: Padding(
            //           child: Text("Video 1"),
            //           padding: EdgeInsets.symmetric(vertical: 16.0),
            //         ),
            //       ),
            //     ),
            //     Expanded(
            //       child: FlatButton(
            //         onPressed: () {
            //           setState(() {
            //             _chewieController.dispose();
            //             _videoPlayerController1.pause();
            //             _videoPlayerController1.seekTo(Duration(seconds: 0));
            //             _chewieController = ChewieController(
            //               videoPlayerController: _videoPlayerController2,
            //               aspectRatio: 3 / 2,
            //               autoPlay: true,
            //               looping: true,
            //             );
            //           });
            //         },
            //         child: Padding(
            //           padding: EdgeInsets.symmetric(vertical: 16.0),
            //           child: Text("Error Video"),
            //         ),
            //       ),
            //     )
            //   ],
            // ),
            // Row(
            //   children: <Widget>[
            //     Expanded(
            //       child: FlatButton(
            //         onPressed: () {
            //           setState(() {
            //             _platform = TargetPlatform.android;
            //           });
            //         },
            //         child: Padding(
            //           child: Text("Android controls"),
            //           padding: EdgeInsets.symmetric(vertical: 16.0),
            //         ),
            //       ),
            //     ),
            //     Expanded(
            //       child: FlatButton(
            //         onPressed: () {
            //           setState(() {
            //             _platform = TargetPlatform.iOS;
            //           });
            //         },
            //         child: Padding(
            //           padding: EdgeInsets.symmetric(vertical: 16.0),
            //           child: Text("iOS controls"),
            //         ),
            //       ),
            //     )
            //   ],
            // )

            //  ListView.builder(
                //   physics: AlwaysScrollableScrollPhysics(),
                //   shrinkWrap: true,
                //   scrollDirection: Axis.horizontal,
                //   itemCount:
                //       widget?.getResultAfterUserSearchAboutTopic?.data?.results?.length,
                //   itemBuilder: (BuildContext context, int index) {
                // return
                //  InkWell(
                //   onTap: () {
                //      Navigator.push(
                //               context,
                //               MyCustomRoute(
                //                 widgetBuilder: (context) =>
                //                     SelectedTopicSeriesOrMovie(
                //                   type: widget?.getResultAfterUserSearchAboutTopic?.data?.results[index]?.type,
                //                   poster: widget?.getResultAfterUserSearchAboutTopic?.data?.results[index]?.cPoster1,
                //                   description:
                //                       widget?.getResultAfterUserSearchAboutTopic?.data?.results[index]?.description,
                //                   cover: widget?.getResultAfterUserSearchAboutTopic?.data?.results[index]?.cCover1,
                //                   title: widget?.getResultAfterUserSearchAboutTopic?.data?.results[index]?.name,
                //                   position: index,
                //                   id: widget?.getResultAfterUserSearchAboutTopic?.data?.results[index]?.id,
                //                   listEpisodes: widget?.getResultAfterUserSearchAboutTopic?.data?.results[index]?.type ==
                //                           'series'
                //                       ? widget?.getResultAfterUserSearchAboutTopic?.data?.results[index]?.episodes ==
                //                               null
                //                           ? 0
                //                           : widget?.getResultAfterUserSearchAboutTopic?.data?.results[index]?.episodes
                //                       : [],
                //                   listCast:
                //                       widget?.getResultAfterUserSearchAboutTopic?.data?.results[index]?.casts == null
                //                           ? 0
                //                           : widget?.getResultAfterUserSearchAboutTopic?.data?.results[index]?.casts,
                //                   listMainStars: widget?.getResultAfterUserSearchAboutTopic?.data?.results[index]?.mainStars ==
                //                           null
                //                       ? 0
                //                       : widget?.getResultAfterUserSearchAboutTopic?.data?.results[index]?.mainStars,

                //                   listTrailers:
                //                       widget?.getResultAfterUserSearchAboutTopic?.data?.results[index]?.trailers == []
                //                           ? []
                //                           : widget?.getResultAfterUserSearchAboutTopic?.data?.results[index]?.trailers,
                //                   genreList:
                //                       widget?.getResultAfterUserSearchAboutTopic?.data?.results[index]?.genres == []
                //                           ? []
                //                           : widget?.getResultAfterUserSearchAboutTopic?.data?.results[index]?.genres,
                //                   video: widget?.getResultAfterUserSearchAboutTopic?.data?.results[index]?.video,
                //                   // releaseDate:
                //                   //     _apiResponse.data.results[index].releaseDate,
                //                 ),
                //               ),
                //             );
                //   },
                //   child: Card(
                //     color: Color.fromRGBO(10, 10, 10, 1.0),
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       mainAxisSize: MainAxisSize.min,
                //       mainAxisAlignment: MainAxisAlignment.start,
                //       children: <Widget>[
                //         widget?.getResultAfterUserSearchAboutTopic?.data?.results == null ? Center(
                //                 child: CircularProgressIndicator(),
                //               )
                //         : Container(
                //           color: Color.fromRGBO(10, 10, 10, 1.0),
                //           width: SizeConfigs.imageSizeMultiplier * 45,
                //           height: SizeConfigs.imageSizeMultiplier * 40,
                //           child: CachedNetworkImage(
                //             imageUrl: 'http://vod.appcorp.mobi/storage/' +
                //                 widget?.getResultAfterUserSearchAboutTopic?.data
                //                     ?.results[index]?.cCover1,
                //             fit: BoxFit.fill,
                //             placeholder: (context, url) => Container(
                //               width: 50,
                //               height: 50,
                //               child: Center(
                //                 child: CircularProgressIndicator(),
                //               ),
                //             ),
                //             errorWidget: (context, url, error) =>
                //                 new Icon(Icons.error),
                //           ),
                //         ),
                //         widget?.getResultAfterUserSearchAboutTopic?.data?.results == null ? Center(
                //                 child: CircularProgressIndicator(),
                //               )
                //         : Padding(
                //           padding: const EdgeInsets.only(left: 8.0, top: 3.0),
                //           child: Text(
                //             widget?.getResultAfterUserSearchAboutTopic?.data
                //                 ?.results[index]?.name,
                //             style: AppTextStyle.textCardStyle,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // );
                // },
                // ),