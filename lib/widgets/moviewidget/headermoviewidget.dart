import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:primaxproject/localization/demo_localization.dart';
import 'package:primaxproject/model/api_response.dart';
import 'package:primaxproject/model/favorite_status_model.dart';
import 'package:primaxproject/model/genre.dart';
import 'package:primaxproject/model/genres_result.dart';
import 'package:primaxproject/model/models.dart';
import 'package:primaxproject/res/sizeconfig.dart';
import 'package:primaxproject/res/textsytlewidget/text_style.dart';
import 'package:primaxproject/res/themeApp/themeprimax.dart';
import 'package:primaxproject/services/app_services.dart';
import 'package:primaxproject/ui/pages/chewiePlayer/chewie_player.dart';
import 'package:transparent_image/transparent_image.dart';

import '../widgets.dart';

class HeaderMovieWidget extends StatefulWidget {
  final String poster;
  final String cover;
  final String description;
  final String name;
  final String video;
  final int id;
  final String userId;
  final List<Genre> genreList;
  final String duration;
  const HeaderMovieWidget({
    Key key,
    String poster,
    String cover,
    String description,
    String name,
    String video,
    String userId,
    int id,
    String duration,
    List<Genre> genreList,
  })  : this.poster = poster,
        this.cover = cover,
        this.description = description,
        this.name = name,
        this.video = video,
        this.id = id,
        this.userId = userId,
        this.genreList = genreList,
        this.duration = duration,
        super(key: key);
  @override
  _HeaderMovieWidgetState createState() => _HeaderMovieWidgetState();
}

class _HeaderMovieWidgetState extends State<HeaderMovieWidget> {
  bool descTextShowFlag = false;
  bool favoriteStatus = false;
  bool _isLoading;
  APIResponse<FavouriteStatusModel>
      _apiResponseForAddOrRemoveTopicFromFavoriteList;
  APIResponse<ListFavouriteModel> _apiResponseForretreiveFavoriteList;
  APIResponse<ShowTopicModel> _apiResponse;
  AppServices get service => GetIt.I<AppServices>();
  _addThisTopicToFavroite(String userId) async {
    setState(() {
      _isLoading = true;
    });

    _apiResponseForAddOrRemoveTopicFromFavoriteList = await service
        .addOrRemoveTopicFavorite('favourite/add', 'movie', widget.id, userId);
    setState(() {
      favoriteStatus = true;
      _isLoading = false;
    });
  }

  _removehisTopicToFavroite(String userId) async {
    setState(() {
      _isLoading = true;
    });

    _apiResponseForAddOrRemoveTopicFromFavoriteList =
        await service.addOrRemoveTopicFavorite(
            'favourite/delete', 'movie', widget.id, userId);
    setState(() {
      favoriteStatus = false;

      _isLoading = false;
    });
  }

  _fetchTopicBecomeFavorite() async {
    setState(() {
      _isLoading = true;
    });
    _apiResponseForretreiveFavoriteList =
        await service.getFavoriteList(widget.userId);
    _apiResponseForretreiveFavoriteList.data.results.forEach((element) {
      setState(() {
        element.isFavourite == "1"
            ? favoriteStatus = true
            : favoriteStatus = false;
      });
    });
    _apiResponse =
        await service.getLatestMoviesOrSeriesHomeService('get/latest/movies');
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchTopicBecomeFavorite();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Stack(
      children: <Widget>[
        Container(
          width: SizeConfigs.screenWidth * 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Stack(
                fit: StackFit.loose,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MyCustomRoute(
                      //     widgetBuilder: (context) => VideoEpsisodesWidget(
                      //         urlVideo: 'http://vod.appcorp.mobi/storage/' +
                      //             widget?.video),
                      //   ),
                      // );
                      MyCustomRoute(
                          widgetBuilder: (context) => ChewieDemo(
                                pathVideo: 'http://vod.appcorp.mobi/storage/' +
                                    widget?.video,
                              )
                          //  VideoEpsisodesWidget(
                          //     urlVideo: 'http://vod.appcorp.mobi/storage/' +
                          //         widget?.listEpisodes[positon].video),

                          );
                    },
                    child: Container(
                      width: SizeConfigs.screenWidth * 100,
                      height: SizeConfigs.isPortrait
                          ? SizeConfigs.screenHeight * 0.3
                          : SizeConfigs.screenHeight * 0.2,
                      // SizeConfigs.screenHeight <= 667.0
                      //     ? SizeConfigs.imageSizeMultiplier * 49.0
                      //     : MediaQuery.of(context).size.height * 0.27,

                      //  SizeConfig.blockSizeVertical * 50 > 500 ? SizeConfig.blockSizeVertical * 46 : SizeConfig.blockSizeVertical * 24,
                      //http://vod.appcorp.mobi/storage/videos/Movies/2020-10-11/20201011141858_pMCbF.mp4
                      child: Stack(children: [
                        Positioned(
                            left: SizeConfigs.screenWidth * 0.45,
                            top: SizeConfigs.screenWidth * 0.15,
                            child: Icon(Icons.error)),
                        Center(
                          child: Container(
                            width: SizeConfigs.imageSizeMultiplier * 45,
                            height: SizeConfigs.screenHeight * 0.25,
                            child: FadeInImage.memoryNetwork(
                              placeholder: kTransparentImage,
                              image: 'http://vod.appcorp.mobi/storage/' +
                                  widget?.cover,
                            ),
                          ),
                        ),
                      ]),
                      //  CachedNetworkImage(
                      //   imageUrl:
                      //       'http://vod.appcorp.mobi/storage/' + widget?.cover,
                      //   fit: BoxFit.fill,
                      //   placeholder: (context, url) =>
                      //       CircularProgressIndicator(
                      //     valueColor:
                      //         AlwaysStoppedAnimation<Color>(Colors.orange),
                      //   ),
                      //   errorWidget: (context, url, error) =>
                      //       new Icon(Icons.error),
                      // ),
                    ),
                  ),
                  Positioned(
                      top: SizeConfigs.screenHeight * 0.15,
                      left: SizeConfig.blockSizeHorizontal * 44,
                      child: IconButton(
                          icon: Icon(Icons.play_circle_outline,
                              color: Colors.orange),
                          onPressed: () {
                            print('display faviute state');
                            print(favoriteStatus);
                            setState(() {
                              favoriteStatus == false
                                  ? _addThisTopicToFavroite(widget.userId)
                                  : _removehisTopicToFavroite(widget.userId);
                            });
                          })),
                  Positioned(
                    top: 5,
                    // left: MediaQuery.of(context).size.width <= 375.0
                    //     ? MediaQuery.of(context).size.width * 0.85
                    //     : MediaQuery.of(context).size.width * 0.85,
                    // SizeConfig.blockSizeHorizontal * 75,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        DemoLocalization.of(context).locale.languageCode == 'en'
                  ? Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                          icon: new Image.asset(
                            favoriteStatus == false
                                ? 'assets/images/unfollow_icon.png'
                                : 'assets/images/follow_icon.png',
                          ),
                          onPressed: () {
                            print('display faviute state');
                            print(favoriteStatus);
                            setState(() {
                              favoriteStatus == false
                                  ? _addThisTopicToFavroite(widget.userId)
                                  : _removehisTopicToFavroite(widget.userId);
                            });
                          }),
                    )
                  : Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                          icon: new Image.asset(
                            favoriteStatus == false
                                ? 'assets/images/unfollow_icon.png'
                                : 'assets/images/follow_icon.png',
                          ),
                          onPressed: () {
                            print('display faviute state');
                            print(favoriteStatus);
                            setState(() {
                              favoriteStatus == false
                                  ? _addThisTopicToFavroite(widget.userId)
                                  : _removehisTopicToFavroite(widget.userId);
                            });
                          }),
                    ),
                        // IconButton(
                        //     icon: Icon(
                        //       Icons.adb,
                        //       color: Colors.orange,
                        //     ),
                        //     onPressed: () {}),
                        // IconButton(
                        //     icon: new Image.asset(
                        //       favoriteStatus == false
                        //           ? 'assets/images/unfollow_icon.png'
                        //           : 'assets/images/follow_icon.png',
                        //     ),
                        //     onPressed: () {
                        //       print('display faviute state');
                        //       print(favoriteStatus);
                        //       setState(() {
                        //         favoriteStatus == false
                        //             ? _addThisTopicToFavroite(widget.userId)
                        //             : _removehisTopicToFavroite(widget.userId);
                        //       });
                        //     }),
                        // Positioned(
                        //   top: SizeConfigs.screenHeight <= 667.0
                        //       ? MediaQuery.of(context).size.height * 0.04
                        //       : SizeConfigs.heightMultiplier * 10,
                        //   left: 50,
                        //   // top: MediaQuery.of(context).size.height * 0.10,
                        //   // left: MediaQuery.of(context).size.height * 0.35,
                        //   child: IconButton(
                        //       icon: Icon(
                        //         Icons.play_circle_outline,
                        //         color: Colors.orange,
                        //         size: 30,
                        //       ),
                        //       onPressed: () {}),
                        // ),
                        // IconButton(
                        //     icon: Icon(
                        //       Icons.add,
                        //       color: Colors.orange,
                        //     ),
                        //     onPressed: () {}),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: SizeConfigs.screenHeight <= 667.0 ? 12.0 : 15.0),
              Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                ),
                child: Text(
                  _apiResponse?.data?.results == null
                      ? ''
                      : 'Duration ' + _apiResponse?.data?.results[0]?.duration,
                  style: AppTextStyle.textStyleApp,
                ),
              ),
              SizedBox(height: SizeConfigs.screenHeight <= 667.0 ? 15.0 : 10.0),
              // Padding(
              //   padding: const EdgeInsets.only(bottom: 8.0),
              //   child: ListView.builder(
              //     itemCount:
              //         widget.genreList == null ? [] : widget.genreList.length,
              //     itemBuilder: (BuildContext context, int index) {
              //       return Container(
              //         width: 70,
              //         height: 35,
              //         decoration: BoxDecoration(
              //           border: Border.all(color: AppColorsStyle.colorBorder),
              //           borderRadius: BorderRadius.circular(5),
              //         ),
              //         child: Center(
              //           child: Text(widget.genreList[index].nameEn),
              //         ),
              //       );
              //     },
              //     scrollDirection: Axis.horizontal,
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: AppColorsStyle.colorBackgroundContainerHeaderMovie,
                  width: SizeConfigs.screenWidth * 100,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.description,
                              maxLines: descTextShowFlag ? 3 : 1,
                              textAlign: TextAlign.start),
                          InkWell(
                            onTap: () {
                              setState(() {
                                descTextShowFlag = !descTextShowFlag;
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                descTextShowFlag
                                    ? Text(
                                        "Show less",
                                        style: TextStyle(
                                          color: Color.fromRGBO(255, 191, 0, 1),
                                        ),
                                      )
                                    : Text(
                                        "Show More",
                                        style: TextStyle(
                                          color: Color.fromRGBO(255, 191, 0, 1),
                                        ),
                                      )
                              ],
                            ),
                          ),
                        ],
                      ),
                      // RichText(
                      //   maxLines: 5,
                      //   overflow: TextOverflow.clip,
                      //   text: TextSpan(
                      //     text: widget.description,
                      //     style: TextStyle(
                      //       fontSize: 13,
                      //     ),
                      //     children: <TextSpan>[
                      //       TextSpan(
                      //         text: 'see more',
                      //         style: TextStyle(
                      //           color: Color.fromRGBO(255, 191, 0, 1),
                      //           decoration: TextDecoration.none,
                      //         ),
                      //       ),

                      //       // can add more TextSpans here...
                      //     ],
                      //   ),
                      // ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: SizeConfigs.heightMultiplier * 25.5,
          left: 8,
          child: Text(widget.name, style: AppTextStyle.textStyleApp),
        ),
      ],
    );
  }
}
