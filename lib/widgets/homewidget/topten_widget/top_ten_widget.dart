import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:primaxproject/common/language.dart';
import 'package:primaxproject/localization/demo_localization.dart';
import 'package:primaxproject/main.dart';
import 'package:primaxproject/model/api_response.dart';
import 'package:primaxproject/model/models.dart';
import 'package:primaxproject/res/sizeconfig.dart';
import 'package:primaxproject/res/themeApp/themeprimax.dart';
import 'package:primaxproject/services/app_services.dart';
import '../../widgets.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:intl/intl.dart' as intl;

class TopTenWidget extends StatefulWidget {
  String keyword;
  String userId;
  TopTenWidget({
    Key key,
    String userId,
  })  : this.userId = userId,
        super(key: key);

  @override
  _TopTenWidgetState createState() => _TopTenWidgetState();
}

class _TopTenWidgetState extends State<TopTenWidget> {
  APIResponse<ShowTopicModel> _apiResponse;
  AppServices get service => GetIt.I<AppServices>();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchDataHomeFromRemoteServer();
  }

  _fetchDataHomeFromRemoteServer() async {
    // MyApp.locale("en") ==  "en"  ? print("fkef;kew;fwekf;wefw"): print("aararararar");
    setState(() {
      _isLoading = true;
    });
    _apiResponse = await service.getTopTen();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 2.5 * SizeConfigs.heightMultiplier),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: SizeConfigs. screenWidth * 0.1,
                height: 0.2 * SizeConfigs.heightMultiplier,
                color: AppColorsStyle.commoncolor,
              ),
              Container(
                width: (SizeConfigs.screenWidth * 0.14),
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                   DemoLocalization.of(context).getTransaltedValue('Top10'),
                    style: TextStyle(
                        //  fontSize: 15,
                        color: AppColorsStyle.commoncolor),
                  ),
                ),
              ),
              Container(
                  width: SizeConfigs.isPortrait
                      ? (SizeConfigs.screenWidth) -
                          ((SizeConfigs.screenWidth * 0.1) +
                              (SizeConfigs.screenWidth * 0.14))
                      // SizeConfigs.screenWidth * 0.68
                      : SizeConfigs.screenWidth * 1.4,
                  height: 0.2 * SizeConfigs.heightMultiplier,
                  color: AppColorsStyle.commoncolor),
            ],
          ),
        ),
        Container(
          width: 100 * SizeConfigs.screenWidth,
          height: _apiResponse?.data?.results?.length == 0
              ? 0.0
              : 
              DemoLocalization.of(context).locale.languageCode == 'en'
              ? SizeConfigs.screenHeight * 0.31
              : SizeConfigs.screenHeight * 0.325,
          //  266.2,

          // color: Color.fromRGBO(10, 10, 10, 1.0),
          child: ListView.builder(
              itemCount: _apiResponse?.data == null
                  ? 0
                  : _apiResponse?.data?.results?.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: ScrollPhysics(),
              itemExtent: SizeConfigs.screenWidth * 0.4,
              //  0.40 * MediaQuery.of(context).size.width,
              // MediaQuery.of(context).size.width <= 375.0
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
                            poster: _apiResponse.data.results[index].mCover1,
                            description:
                             DemoLocalization.of(context).locale.languageCode == 'en'
                               ?  _apiResponse.data.results[index].descriptionEn
                               : _apiResponse.data.results[index].description,
                            cover: _apiResponse.data.results[index].mPoster1,
                            title: 
                            DemoLocalization.of(context).locale.languageCode == 'en'
                            ? _apiResponse.data.results[index].nameEn
                            : _apiResponse.data.results[index].name,
                            position: index,
                            id: _apiResponse.data.results[index].id,
                            listEpisodes: _apiResponse
                                        .data.results[index].type ==
                                    'series'
                                ? _apiResponse.data.results[index].episodes ==
                                        null
                                    ? 0
                                    : _apiResponse
                                        ?.data?.results[index]?.episodes
                                : [],
                            listCast:
                                _apiResponse.data.results[index].casts == null
                                    ? 0
                                    : _apiResponse?.data?.results[index]?.casts,
                            listMainStars: _apiResponse
                                        .data.results[index].mainStars ==
                                    null
                                ? 0
                                : _apiResponse?.data?.results[index]?.mainStars,
                            listTrailers:
                                _apiResponse.data.results[index].trailers == []
                                    ? []
                                    : _apiResponse
                                        ?.data?.results[index]?.trailers,
                            genreList:
                                _apiResponse.data.results[index].genres == []
                                    ? []
                                    : _apiResponse
                                        ?.data?.results[index]?.genres,
                            video: _apiResponse?.data?.results[index]?.video,
                            releaseDate: 
                            DemoLocalization.of(context).locale.languageCode == 'en'
                            ?
                                _apiResponse.data.results[index].releaseDate
                                : _apiResponse.data.results[index].releaseDate,
                            userId: widget.userId,
                            duration:
                                _apiResponse?.data?.results[index]?.duration,
                          ),
                        ),
                      );
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
                          FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Padding(
                              padding: EdgeInsets.all(
                                  2.7 * SizeConfigs.widthMultiplier),
                              child: 
                              Text(
                           DemoLocalization.of(context).locale.languageCode == 'en'
                           ? _apiResponse?.data == null
                                    ? ''
                                    : _apiResponse
                                        ?.data?.results[index]?.nameEn
                           : _apiResponse?.data == null
                                    ? ''
                                    : _apiResponse
                                        ?.data?.results[index]?.name,
                                        
                                    
                                
                                style: TextStyle(),
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
    );
  }
}
