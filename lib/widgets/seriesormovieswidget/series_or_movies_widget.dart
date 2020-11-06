import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:primaxproject/localization/demo_localization.dart';
import 'package:primaxproject/model/api_response.dart';
import 'package:primaxproject/model/cast.dart';
import 'package:primaxproject/model/episodes.dart';
import 'package:primaxproject/model/show_topic_model.dart';
import 'package:primaxproject/model/trailers.dart';
import 'package:primaxproject/res/sizeconfig.dart';
import 'package:primaxproject/res/themeApp/themeprimax.dart';
import 'package:primaxproject/services/app_services.dart';
import 'package:transparent_image/transparent_image.dart';

import '../widgets.dart';

class SeeSeasonsOrRelatedMoviesWidget extends StatefulWidget {
  APIResponse<ShowTopicModel> _apiResponse;

  bool _isLoading;
  int position;
  String type;
  String titleSection;
  final List<Episode> listEpisodes;
  final List<Trailer> listTrailers;
  final List<Cast> listCast;
  final List<Cast> listMainStars;

  SeeSeasonsOrRelatedMoviesWidget(
      {Key key,
      APIResponse<ShowTopicModel> apiResponse,
      bool isLoading,
      int position,
      String type,
      String titleSection,
      List<Episode> listEpisodes,
      List<Trailer> listTrailers,
      List<Cast> listMainStars,
      List<Cast> listCast})
      : _apiResponse = apiResponse,
        _isLoading = isLoading,
        position = position,
        type = type,
        titleSection = titleSection,
        this.listEpisodes = listEpisodes,
        this.listTrailers = listTrailers,
        this.listMainStars = listMainStars,
        this.listCast = listCast,
        super(key: key);

  @override
  _SeeSeasonsOrRelatedMoviesWidgetState createState() =>
      _SeeSeasonsOrRelatedMoviesWidgetState();
}

class _SeeSeasonsOrRelatedMoviesWidgetState
    extends State<SeeSeasonsOrRelatedMoviesWidget> {
  AppServices get service => GetIt.I<AppServices>();
  ScrollController _scrollController = ScrollController();
  int pageNumber = 1;
  int positionEpsiode = 0;
  int positionTrailer = 0;

  @override
  void initState() {
    super.initState();
    _fetchDataSeriesFromRemoteServer();
  }

// _scrollController.position.maxScrollExtent >
//               _scrollController.offset &&
//          _scrollController.position.maxScrollExtent -
//                   _scrollController.offset <=
//               50
  bool onNoitifcation(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        widget.type == 'series'
            ? service
                .getShowTopicSerivce(pageNumber + 1, 'get/series/by-page')
                .then((value) {
                pageNumber = value?.data?.pageNumber;
                setState(() {
                  widget?._apiResponse?.data?.results
                      ?.addAll(value?.data?.results);
                });
              })
            : service
                .getShowTopicSerivce(pageNumber + 1, 'get/movies/by-page')
                .then((value) {
                pageNumber = value?.data?.pageNumber;
                setState(() {
                  widget?._apiResponse?.data?.results
                      ?.addAll(value?.data?.results);
                });
              });
      }
    }
    return true;
  }

  _fetchDataSeriesFromRemoteServer() async {
    setState(() {
      widget._isLoading = true;
    });
    widget.type == 'series'
        ? widget?._apiResponse = await service.getShowTopicSerivce(
            pageNumber, 'get/series/by-page')
        : widget?._apiResponse = await service.getShowTopicSerivce(
            pageNumber, 'get/movies/by-page');

    setState(() {
      widget._isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
      print('gerjglrejlrejglrieghjerighreg');
      print(widget.type);
    return widget.type == 'series'
        ? Padding(
            padding: EdgeInsets.only(
                left: 8.0,
                bottom: SizeConfigs.screenHeight <= 667.0 ? 8.0 : 0.0),
            child: Container(
              width: SizeConfigs.screenWidth * 100,
              height: 278.0,
              decoration: BoxDecoration(
                color: Color.fromRGBO(17, 17, 17, 1.0),
                border: Border(
                  bottom: BorderSide(color: AppColorsStyle.lineColorContainer),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(widget.titleSection),
                  ),
                  Expanded(
                    flex: 1,
                    child: NotificationListener(
                      onNotification: onNoitifcation,
                      child: ListView.builder(
                        controller: _scrollController,
                        shrinkWrap: true,
                        itemExtent: SizeConfigs.screenWidth * 0.4,
                        physics: ScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: widget?._apiResponse?.data != null
                            ? widget?._apiResponse?.data?.results?.length == 0
                                ? 0
                                : widget?._apiResponse?.data?.results?.length
                            : 0,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MyCustomRoute(
                                  widgetBuilder: (context) =>
                                      SelectedTopicSeriesOrMovie(
                                    apiResponse: widget?._apiResponse,
                                    type: widget?._apiResponse?.data
                                        ?.results[index]?.type,
                                    poster: widget?._apiResponse?.data
                                        ?.results[index]?.mCover1,
                                    description:
                                    DemoLocalization.of(context).locale.languageCode == 'en'
                                    ? 
                                     widget?._apiResponse?.data
                                        ?.results[index]?.descriptionEn
                                        :
                                         widget?._apiResponse?.data
                                        ?.results[index]?.description
                                        ,
                                    cover: widget?._apiResponse?.data
                                        ?.results[index]?.mPoster1,
                                    position: index,
                                    title:
                                     DemoLocalization.of(context).locale.languageCode == 'en'
                                    ? 
                                     widget?._apiResponse?.data
                                        ?.results[index]?.nameEn
                                    :
                                      widget?._apiResponse?.data
                                        ?.results[index]?.name
                                    ,
                                    listEpisodes: widget?._apiResponse?.data
                                                ?.results[index]?.episodes ==
                                            null
                                        ? 0
                                        : widget?._apiResponse?.data
                                            ?.results[index]?.episodes,
                                    listCast: widget?._apiResponse?.data
                                                ?.results[index]?.casts ==
                                            null
                                        ? 0
                                        : widget?._apiResponse?.data
                                            ?.results[index]?.casts,
                                    listMainStars: widget?._apiResponse?.data
                                                ?.results[index]?.mainStars ==
                                            null
                                        ? 0
                                        : widget?._apiResponse?.data
                                            ?.results[index]?.mainStars,
                                    listTrailers: widget?._apiResponse?.data
                                                ?.results[index]?.trailers ==
                                            null
                                        ? []
                                        : widget?._apiResponse?.data
                                            ?.results[index]?.trailers,
                                    // releaseDate: widget?._apiResponse?.data
                                    //     ?.results[index].releaseDate,
                                  ),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(0, 0, 0, 0.14),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                  boxShadow: [
                                    BoxShadow(
                                      spreadRadius: 0,
                                      blurRadius: 4,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Container(
                                      width: SizeConfigs.screenWidth * 40.0,
                                      height: 200,
                                      // SizeConfigs.screenHeight <= 667.0 ?
                                      // SizeConfigs.heightMultiplier *
                                      //     23.0
                                      //     :
                                      //     SizeConfigs.heightMultiplier * 24.5,

                                      // SizeConfig.blockSizeVertical * 24,

                                      child: Stack(children: [
                                        Positioned(
                                            left:
                                                SizeConfigs.screenWidth * 0.158,
                                            top:
                                                SizeConfigs.screenWidth * 0.158,
                                            child: Icon(Icons.error)),
                                        Center(
                                          child: Container(
                                            width: SizeConfigs
                                                    .imageSizeMultiplier *
                                                45,
                                            height:
                                                SizeConfigs.screenHeight * 0.25,
                                            child: FadeInImage.memoryNetwork(
                                              placeholder: kTransparentImage,
                                              image:
                                                  'http://vod.appcorp.mobi/storage/' +
                                                      widget
                                                          ?._apiResponse
                                                          ?.data
                                                          ?.results[index]
                                                          ?.mCover1,
                                            ),
                                          ),
                                        ),
                                      ]),
                                      //  CachedNetworkImage(
                                      //   imageUrl:
                                      //       'http://vod.appcorp.mobi/storage/' +
                                      // widget?._apiResponse?.data
                                      //     ?.results[index]?.mCover1,
                                      //   fit: BoxFit.fill,
                                      //   placeholder: (context, url) =>
                                      //        CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),),
                                      //   errorWidget: (context, url, error) =>
                                      //       new Icon(Icons.error),
                                      // ),
                                    ),
                                    FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          DemoLocalization.of(context).locale.languageCode == 'en'
                                          ? widget?._apiResponse?.data
                                              ?.results[index]?.nameEn
                                              :  widget?._apiResponse?.data
                                              ?.results[index]?.name,
                                          maxLines: 1,
                                          style: TextStyle(
                                            // fontSize:
                                            //     SizeConfigs.textMultiplier *
                                            //         1.8,
                                            // fontSize:
                                            //     SizeConfigs.textMultiplier *
                                            //         1.9,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
            child: Container(
              width: SizeConfigs.screenWidth * 100,
              height: 266.8,
              decoration: BoxDecoration(
                color: Color.fromRGBO(17, 17, 17, 1.0),
                border: Border(
                  bottom: BorderSide(color: AppColorsStyle.lineColorContainer),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(widget.titleSection),
                    ),
                    Expanded(
                      flex: 1,
                      child: NotificationListener(
                        onNotification: onNoitifcation,
                        child: ListView.builder(
                          controller: _scrollController,
                          shrinkWrap: true,
                          itemExtent: 0.4 * SizeConfigs.screenWidth,
                          physics: ScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: widget?._apiResponse?.data != null
                              ? widget?._apiResponse?.data?.results?.length == 0
                                  ? 0
                                  : widget?._apiResponse?.data?.results?.length
                              : 0,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MyCustomRoute(
                                    widgetBuilder: (context) =>
                                        SelectedTopicSeriesOrMovie(
                                      type: widget?._apiResponse?.data
                                          ?.results[index]?.type,
                                      poster: widget?._apiResponse?.data
                                          ?.results[index]?.mCover1,
                                      description: 
                                      DemoLocalization.of(context).locale.languageCode == 'en'
                                      ?
                                      widget?._apiResponse?.data
                                          ?.results[index]?.descriptionEn
                                          :
                                          widget?._apiResponse?.data
                                          ?.results[index]?.description
                                            ,
                                      cover: widget?._apiResponse?.data
                                          ?.results[index]?.mPoster1,
                                      position: index,
                                      title: 
                                      DemoLocalization.of(context).locale.languageCode == 'en'
                                      ?
                                       widget?._apiResponse?.data
                                          ?.results[index]?.nameEn
                                      :
                                      widget?._apiResponse?.data
                                          ?.results[index]?.name,
                                      listTrailers: widget?._apiResponse?.data
                                                  ?.results[index]?.trailers ==
                                              null
                                          ? []
                                          : widget?._apiResponse?.data
                                              ?.results[index]?.trailers,
                                      listCast: widget?._apiResponse?.data
                                                  ?.results[index]?.casts ==
                                              null
                                          ? 0
                                          : widget?._apiResponse?.data
                                              ?.results[index]?.casts,
                                      listMainStars: widget?._apiResponse?.data
                                                  ?.results[index]?.mainStars ==
                                              null
                                          ? 0
                                          : widget?._apiResponse?.data
                                              ?.results[index]?.mainStars,
                                    ),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(0, 0, 0, 0.14),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                        spreadRadius: 0,
                                        blurRadius: 4,
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: SizeConfigs.screenWidth,
                                        height: 192.11,
                                        child:
                                        Stack(children: [
                                        Positioned(
                                            left:
                                                SizeConfigs.screenWidth * 0.158,
                                            top:
                                                SizeConfigs.screenWidth * 0.158,
                                            child: Icon(Icons.error)),
                                        Center(
                                          child: Container(
                                            width: SizeConfigs
                                                    .imageSizeMultiplier *
                                                45,
                                            height:
                                                SizeConfigs.screenHeight * 0.25,
                                            child: FadeInImage.memoryNetwork(
                                              placeholder: kTransparentImage,
                                              image:
                                                  'http://vod.appcorp.mobi/storage/' +
                                                      widget
                                                          ?._apiResponse
                                                          ?.data
                                                          ?.results[index]
                                                          ?.mCover1,
                                            ),
                                          ),
                                        ),
                                      ]),
                                        //  CachedNetworkImage(
                                        //   imageUrl:
                                        //       'http://vod.appcorp.mobi/storage/' +
                                        //           widget?._apiResponse?.data
                                        //               ?.results[index]?.mCover1,
                                        //   fit: BoxFit.fill,
                                        //   placeholder: (context, url) =>
                                        //       CircularProgressIndicator(
                                        //     valueColor:
                                        //         AlwaysStoppedAnimation<Color>(
                                        //             Colors.orange),
                                        //   ),
                                        //   errorWidget: (context, url, error) =>
                                        //       new Icon(Icons.error),
                                        // ),
                                      ),
                                      FittedBox(
                                        fit: BoxFit.fill,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            // widget?._apiResponse?.data
                                            //     ?.results[index]?.nameEn,
                                            DemoLocalization.of(context).locale.languageCode == 'en'
                                          ? widget?._apiResponse?.data
                                              ?.results[index]?.nameEn
                                              :  widget?._apiResponse?.data
                                              ?.results[index]?.name,
                                            maxLines: 1,
                                            style: TextStyle(
                                              // fontSize:
                                              //     SizeConfigs.textMultiplier *
                                              //         1.9,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
    // } catch (error) {
    //   return Container(
    //     width: 50,
    //     height: 50,
    //     child: Center(
    //       child: CircularProgressIndicator(),
    //     ),
    //   );
    // }
  }
}
