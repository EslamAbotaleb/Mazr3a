import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:primaxproject/localization/demo_localization.dart';
import 'package:primaxproject/model/api_response.dart';
import 'package:primaxproject/model/show_topic_model.dart';
import 'package:primaxproject/res/sizeconfig.dart';
import 'package:primaxproject/res/themeApp/themeprimax.dart';
import 'package:primaxproject/services/app_services.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../widgets.dart';

class ShowMovieWidgetHome extends StatefulWidget {
  String titleSection;
  String userId;

  ShowMovieWidgetHome({
    Key key,
    String userId,
    String titleSection,
  })  : titleSection = titleSection,
        this.userId = userId,
        super(key: key);

  @override
  _ShowMovieWidgetHomeState createState() => _ShowMovieWidgetHomeState();
}

class _ShowMovieWidgetHomeState extends State<ShowMovieWidgetHome> {
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  AppServices get service => GetIt.I<AppServices>();
  APIResponse<ShowTopicModel> _apiResponse;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchDataHomeFromRemoteServer();
  }

  _fetchDataHomeFromRemoteServer() async {
    setState(() {
      _isLoading = true;
    });

    _apiResponse =
        await service.getLatestMoviesOrSeriesHomeService("get/latest/movies");

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('moviesssss');
    print(_apiResponse?.data?.results);
    if (_apiResponse?.data?.results?.length == 0) {
      print('arrayIsEmpty');
    } else {
      print('arraynottttempty');
    }
    return Container(
      width: SizeConfigs.screenWidth * 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 0.4 * SizeConfigs.heightMultiplier),
            child: _apiResponse?.data?.results?.length == 0
                ? Container()
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: SizeConfigs.screenWidth * 0.1,
                        // MediaQuery.of(context).size.width <= 375.0
                        //     ? 8.2 * SizeConfigs.widthMultiplier
                        //     : MediaQuery.of(context).size.width <= 768.0
                        //         ? 0.17 * MediaQuery.of(context).size.width
                        //         : 0.12 * MediaQuery.of(context).size.width,
                        height: 0.2 * SizeConfigs.heightMultiplier,
                        color: AppColorsStyle.commoncolor,
                      ),
                      Container(
                        width: (SizeConfigs.screenWidth * 0.14),
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            widget.titleSection,
                            style: TextStyle(
                                // fontSize: 2.2 * SizeConfigs.textMultiplier,
                                color: AppColorsStyle.commoncolor),
                          ),
                        ),
                      ),
                      Container(
                          width: SizeConfigs.isPortrait
                              ? (SizeConfigs.screenWidth) -
                          ((SizeConfigs.screenWidth * 0.1) +
                              (SizeConfigs.screenWidth * 0.14))
                              //  SizeConfigs.screenWidth * 0.68
                              : SizeConfigs.screenWidth * 1.4,
                          height: 0.2 * SizeConfigs.heightMultiplier,
                          color: AppColorsStyle.commoncolor),
                    ],
                  ),
          ),
          Container(
            width: _apiResponse?.data?.results?.length == 0
                ? 0.0
                : 100 * SizeConfigs.screenWidth,
            // height: _apiResponse?.data?.results?.length == 0 ? 0.0 :   266.8,
            height: _apiResponse?.data?.results?.length == 0
                ? 0.0
                : DemoLocalization.of(context).locale.languageCode == 'en'
              ? SizeConfigs.screenHeight * 0.31
              : SizeConfigs.screenHeight * 0.325,

            // 0.40 * MediaQuery.of(context).size.height,
            // MediaQuery.of(context).size.height <= 667.0
            //     ? 0.29 * MediaQuery.of(context).size.height
            //     : 0.31 * MediaQuery.of(context).size.height,
            color: Color.fromRGBO(10, 10, 10, 1.0),
            child: ListView.builder(
                itemCount: _apiResponse?.data?.results?.length == null
                    ? 0
                    : _apiResponse?.data?.results?.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: ScrollPhysics(),
                itemExtent: SizeConfigs.screenWidth * 0.4,
                //  MediaQuery.of(context).size.width <= 375.0
                //     ? 0.40 * MediaQuery.of(context).size.width
                //     : 0.45 * MediaQuery.of(context).size.width,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MyCustomRoute(
                              widgetBuilder: (context) =>
                                  SelectedTopicSeriesOrMovie(
                                type: _apiResponse.data.results[index].type,
                                poster:
                                    _apiResponse.data.results[index].mCover1,
                                description: _apiResponse
                                    .data.results[index].descriptionEn,
                                cover:
                                    _apiResponse.data.results[index].mPoster1,
                                title: _apiResponse.data.results[index].nameEn,
                                position: index,
                                id: _apiResponse.data.results[index].id,
                                listEpisodes:
                                    _apiResponse.data.results[index].type ==
                                            'series'
                                        ? _apiResponse.data.results[index]
                                                    .episodes ==
                                                null
                                            ? 0
                                            : _apiResponse
                                                ?.data?.results[index]?.episodes
                                        : [],
                                listCast: _apiResponse
                                            .data.results[index].casts ==
                                        null
                                    ? 0
                                    : _apiResponse?.data?.results[index]?.casts,
                                listMainStars: _apiResponse
                                            .data.results[index].mainStars ==
                                        null
                                    ? 0
                                    : _apiResponse
                                        ?.data?.results[index]?.mainStars,
                                listTrailers:
                                    _apiResponse.data.results[index].trailers ==
                                            []
                                        ? []
                                        : _apiResponse
                                            ?.data?.results[index]?.trailers,
                                genreList:
                                    _apiResponse.data.results[index].genres ==
                                            []
                                        ? []
                                        : _apiResponse
                                            ?.data?.results[index]?.genres,
                                video:
                                    _apiResponse?.data?.results[index]?.video,
                                releaseDate: _apiResponse
                                    .data.results[index].releaseDate,
                                userId: widget.userId,
                              ),
                            ));
                      },
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              width: SizeConfigs.imageSizeMultiplier * 45,
                              // height:  220.11,
                              height: SizeConfigs.screenHeight * 0.25,

                              // 0.33 * MediaQuery.of(context).size.height,
                              // MediaQuery.of(context).size.height <=
                              //         667.0
                              //     ? 0.23 * MediaQuery.of(context).size.height
                              //     : 0.25 * MediaQuery.of(context).size.height,
                              child:
                              Stack(
                            children: [
                                 Positioned(
                                  left: SizeConfigs.screenWidth * 0.158,
                                  top: SizeConfigs.screenWidth * 0.158,
                                  child:  Icon(Icons.error)),
                            Center(
                              child: Container(
                                width: SizeConfigs.imageSizeMultiplier * 45,
                                height: SizeConfigs.screenHeight * 0.25,
                                child: FadeInImage.memoryNetwork(
                                  placeholder: kTransparentImage,
                                  image: 'http://vod.appcorp.mobi/storage/' +
                                      _apiResponse
                                          ?.data?.results[index]?.mPoster1,
                                ),
                              ),
                            ),
                          ]),
                              //  CachedNetworkImage(
                              //   imageUrl: _apiResponse.data != null
                              //       ? 'http://vod.appcorp.mobi/storage/' +
                              //           _apiResponse
                              //               ?.data?.results[index]?.mPoster1
                              //       : "",
                              //   fit: BoxFit.fitHeight,
                              //   placeholder: (context, url) => Container(
                              //       width: 50,
                              //       height: 50,
                              //       child: Center(
                              //           child: CircularProgressIndicator(
                              //               valueColor:
                              //                   AlwaysStoppedAnimation<Color>(
                              //                       Colors.orange)))),
                              //   errorWidget: (context, url, error) =>
                              //       new Icon(Icons.error),
                              // ),
                            ),
                            FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Padding(
                                padding: EdgeInsets.all(
                                    2.7 * SizeConfigs.widthMultiplier),
                                child: Text(
                                  DemoLocalization.of(context).locale.languageCode == 'en' 
                                  ?
                                  _apiResponse.data != null
                                      ? _apiResponse?.data?.results[index].nameEn
                                      : ""
                                  :
                                  _apiResponse.data != null
                                      ? _apiResponse?.data?.results[index].name
                                      : ""
                                      ,
                                  // style: TextStyle(
                                  //     // fontSize: 1.9 * SizeConfigs.textMultiplier,
                                  //     ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}