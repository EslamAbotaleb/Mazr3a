import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:primaxproject/localization/demo_localization.dart';
import 'package:primaxproject/model/api_response.dart';
import 'package:primaxproject/model/genres_model.dart';
import 'package:primaxproject/model/models.dart';
import 'package:primaxproject/res/sizeconfig.dart';
import 'package:primaxproject/res/themeApp/themeprimax.dart';
import 'package:primaxproject/services/app_services.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../widgets.dart';

class ShowGenresTopicWidget extends StatefulWidget {
  final String poster;
  final String cover;
  final String description;
  final String type;
  // final int position;
  final String title;
  final int id;
  final String video;
  final List<Episode> listEpisodes;
  final List<Trailer> listTrailers;
  final List<Cast> listCast;
  final List<Cast> listMainStars;
  final List<Genre> genreList;
  final String userId;
  // final DateTime releaseDate;
  APIResponse<GenresHomeModel> _apiResponse;
  ShowGenresTopicWidget({
    Key key,
    String type,
    String poster,
    String cover,
    // int position,
    String title,
    String description,
    String video,
    int id,
    List<Episode> listEpisodes,
    List<Trailer> listTrailers,
    List<Cast> listCast,
    List<Cast> listMainStars,
    APIResponse<GenresHomeModel> apiResponse,
    List<Genre> genreList,
    DateTime releaseDate,
    String userId,
  })  : this.userId = userId,
        this.type = type,
        this.poster = poster,
        this.cover = cover,
        this.description = description,
        // this.position = position,
        this.title = title,
        this.id = id,
        this.listEpisodes = listEpisodes,
        this.listTrailers = listTrailers,
        this.listCast = listCast,
        this.listMainStars = listMainStars,
        this._apiResponse = apiResponse,
        this.video = video,
        this.genreList = genreList,
        // this.releaseDate = releaseDate,
        super(key: key);
  @override
  _ShowGenresTopicWidgetState createState() => _ShowGenresTopicWidgetState();
}

class _ShowGenresTopicWidgetState extends State<ShowGenresTopicWidget> {
  APIResponse<GenresHomeModel> _apiResponse;
  bool _isLoading = false;
  AppServices get service => GetIt.I<AppServices>();
  @override
  void initState() {
    super.initState();
    _fetchGenresFromRemoteServer();
  }

  _fetchGenresFromRemoteServer() async {
    setState(() {
      _isLoading = true;
    });
    _apiResponse = await service.getGenresService();
    setState(() {
      _isLoading = false;
    });
  }

  var totalIt = List<int>();
  var sumTotal = 0.0;
  var countMediaList = 0;
  @override
  Widget build(BuildContext context) {
    _apiResponse?.data?.results?.forEach((element) {
      print(element.mediaList.length);
      sumTotal = (_apiResponse?.data?.results?.length == null
              ? 0.0
              : _apiResponse.data.results.length -
                  element.mediaList.length +
                  1) /
          2.0;
    });
    print(sumTotal);
    print(((sumTotal.toInt()) *
        ((SizeConfigs.screenHeight * 0.178) *
            MediaQuery.of(context).devicePixelRatio)));

    return Container(
      width: SizeConfigs.screenWidth * 1.0,
      height: 
      DemoLocalization.of(context).locale.languageCode == 'en'
      ? sumTotal * (SizeConfigs.screenHeight * 0.35)
      : sumTotal * (SizeConfigs.screenHeight * 0.39),
      // height: ((sumTotal.toInt()) * (
      //   SizeConfigs.screenHeight <= 667.0 ?
      //   SizeConfigs.screenHeight * 0.178 * MediaQuery.of(context).devicePixelRatio
      //   :  SizeConfigs.screenHeight * 0.12 * MediaQuery.of(context).devicePixelRatio )),

      child: 
      ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemExtent:
        DemoLocalization.of(context).locale.languageCode == 'en'
        ?  SizeConfigs.screenHeight * 0.35
        : SizeConfigs.screenHeight * 0.40,
     
        physics: NeverScrollableScrollPhysics(),
        itemCount: _apiResponse?.data?.results?.length == null
            ? 0
            : _apiResponse?.data?.results?.length,
        itemBuilder: (BuildContext context, int position) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: SizeConfigs.screenWidth * 0.1,
                      //SizeConfigs.screenWidth * 0.14,
                      height: 0.2 * SizeConfigs.heightMultiplier,
                      color: AppColorsStyle.commoncolor,
                    ),
                    Container(
                      width: 
                       DemoLocalization.of(context).locale.languageCode == 'en' ? 
                      (SizeConfigs.screenWidth * 0.14)
                      :  (SizeConfigs.screenWidth * 0.1),
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          DemoLocalization.of(context).locale.languageCode == 'en' ? 
                          _apiResponse?.data?.results[position]?.nameEn

                          :
                          _apiResponse?.data?.results[position]?.nameAr,

                          style: TextStyle(
                              // fontSize:
                              color: AppColorsStyle.commoncolor),
                        ),
                      ),
                    ),
                    Container(
                      width: SizeConfigs.isPortrait
                          ? (SizeConfigs.screenWidth) -
                              ((SizeConfigs.screenWidth * 0.1) +
                                  (SizeConfigs.screenWidth * 0.14))
                          // SizeConfigs.screenWidth * 0.60
                          : SizeConfigs.screenWidth * 1.4,
                      height: 0.2 * SizeConfigs.heightMultiplier,
                      color: AppColorsStyle.commoncolor,
                    ),
                  ],
                ),
              ),
              contentTopicGenre(position),
            ],
          );
        },
      ),
    );
  }

  Container contentTopicGenre(int position) {
    return Container(
      height: _apiResponse?.data?.results[position]?.mediaList?.length == 0
          ? 0.0
          : DemoLocalization.of(context).locale.languageCode == 'en'
              ? SizeConfigs.screenHeight * 0.31
              : SizeConfigs.screenHeight * 0.325,
      width: SizeConfigs.screenWidth,
      child: ListView.builder(
        itemExtent: SizeConfigs.screenWidth * 0.4,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: NeverScrollableScrollPhysics(),
        itemCount:
            _apiResponse?.data?.results[position]?.mediaList?.length == null
                ? 0
                : _apiResponse?.data?.results[position]?.mediaList?.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MyCustomRoute(
                  widgetBuilder: (context) => SelectedTopicSeriesOrMovie(
                    type: _apiResponse
                        .data.results[position].mediaList[index].type,
                    poster: _apiResponse
                        .data.results[position].mediaList[index].mCover1,
                    description: 
                      DemoLocalization.of(context).locale.languageCode == 'en'
                      ?
                    _apiResponse
                        .data.results[position].mediaList[index].descriptionEn
                      : 
                      _apiResponse.data.results[position].mediaList[index].description,
                    cover: _apiResponse
                        .data.results[position].mediaList[index].mPoster1,
                    title:
                    DemoLocalization.of(context).locale.languageCode == 'en'
                    ?
                     _apiResponse
                        .data.results[position].mediaList[index].nameEn

                    : _apiResponse.data.results[position].mediaList[index].name,
                    position: index,
                    id: _apiResponse.data.results[position].mediaList[index].id,
                    listEpisodes: _apiResponse
                                .data.results[position].mediaList[index].type ==
                            'series'
                        ? _apiResponse.data.results[position].mediaList[index]
                                    .episodes ==
                                null
                            ? 0
                            : _apiResponse?.data?.results[position]
                                .mediaList[index]?.episodes
                        : [],
                    listCast: _apiResponse.data.results[position]
                                .mediaList[index].casts ==
                            null
                        ? 0
                        : _apiResponse
                            ?.data?.results[position].mediaList[index]?.casts,
                    listMainStars: _apiResponse.data.results[position]
                                .mediaList[index].mainStars ==
                            null
                        ? 0
                        : _apiResponse?.data?.results[position].mediaList[index]
                            ?.mainStars,
                    // video: widget.video == null
                    //     ? widget?._apiResponse?.data != null
                    //         ? widget
                    //             ?._apiResponse?.data?.results[0].video
                    //         : ""
                    //     : widget.video,
                    genreList: widget.genreList == [] ? [] : widget.genreList,
                    // releaseDate: _apiResponse.data.results[position]
                    // .mediaList[index].releaseDate,
                  ),
                ),
              );
            },
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                  child: Container(
                    color: Color.fromRGBO(10, 10, 10, 1.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          width: SizeConfigs.imageSizeMultiplier * 45,
                          // height: 208.6,
                          height: SizeConfigs.screenHeight * 0.25,
                          // width: SizeConfigs.imageSizeMultiplier * 50.0,
                          // // MediaQuery.of(context).size.width * 0.4,
                          // height: SizeConfigs.imageSizeMultiplier * 42.4,
                          // MediaQuery.of(context).size.height <= 667.0
                          //     ? 0.21 * MediaQuery.of(context).size.height
                          //     : 0.22 * MediaQuery.of(context).size.height,
                          child: Stack(children: [
                            Positioned(
                                left: SizeConfigs.screenWidth * 0.158,
                                top: SizeConfigs.screenWidth * 0.158,
                                child: Icon(Icons.error)),
                            Center(
                              child: Container(
                                width: SizeConfigs.imageSizeMultiplier * 45,
                                height: SizeConfigs.screenHeight * 0.25,
                                child: FadeInImage.memoryNetwork(
                                  placeholder: kTransparentImage,
                                  image: 'http://vod.appcorp.mobi/storage/' +
                                      _apiResponse?.data?.results[position]
                                          ?.mediaList[index]?.mPoster1,
                                ),
                              ),
                            ),
                          ]),

                          // CachedNetworkImage(
                          //   imageUrl: 'http://vod.appcorp.mobi/storage/' +
                          // _apiResponse?.data?.results[position]
                          //     ?.mediaList[index]?.mPoster1,
                          //   fit: BoxFit.fill,
                          //   placeholder: (context, url) => Container(
                          //     width: 50,
                          //     height: 50,
                          //     child: Center(
                          //       child: CircularProgressIndicator(
                          //         valueColor: AlwaysStoppedAnimation<Color>(
                          //             Colors.orange),
                          //       ),
                          //     ),
                          //   ),
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
                              _apiResponse?.data?.results[position]
                                  ?.mediaList[index]?.nameEn
                              :
                                _apiResponse?.data?.results[position]
                                  ?.mediaList[index]?.name
                                  ,
                              // style: AppTextStyle.textCardStyle,
                              style: TextStyle(
                                  // fontSize: 1.9 *
                                  //     SizeConfigs.textMultiplier
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
