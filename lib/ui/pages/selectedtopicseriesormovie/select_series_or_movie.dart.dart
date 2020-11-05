import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:primaxproject/common/my_connectivity.dart';
import 'package:primaxproject/localization/demo_localization.dart';
import 'package:primaxproject/model/api_response.dart';
import 'package:primaxproject/model/cast.dart';
import 'package:primaxproject/model/episodes.dart';
import 'package:primaxproject/model/genre.dart';
import 'package:primaxproject/model/show_topic_model.dart';
import 'package:primaxproject/model/trailers.dart';
import 'package:primaxproject/res/sizeconfig.dart';
import 'package:primaxproject/res/textsytlewidget/text_style.dart';
import 'package:primaxproject/res/themeApp/themeprimax.dart';
import 'package:primaxproject/services/app_services.dart';
import 'package:primaxproject/widgets/common_widget/common_widget.dart';
import '../../../widgets/widgets.dart';
import 'package:intl/intl.dart';

class SelectedTopicSeriesOrMovie extends StatefulWidget {
 
  final String poster;
  final String cover;
  final String description;
  final String type;
  final int position;
  final String title;
  final int id;
  final String video;
  final List<Episode> listEpisodes;
  final List<Trailer> listTrailers;
  final List<Cast> listCast;
  final List<Cast> listMainStars;
  final List<Genre> genreList;
  final DateTime releaseDate;
  String userId;
  String duration;
  APIResponse<ShowTopicModel> _apiResponse;
  SelectedTopicSeriesOrMovie({
    Key key,
    String type,
    String poster,
    String cover,
    int position,
    String title,
    String description,
    String video,
    int id,
    List<Episode> listEpisodes,
    List<Trailer> listTrailers,
    List<Cast> listCast,
    List<Cast> listMainStars,
    APIResponse<ShowTopicModel> apiResponse,
    List<Genre> genreList,
    DateTime releaseDate,
    String userId,
    String duration,
  })  : this.duration = duration,
        this.type = type,
        this.poster = poster,
        this.cover = cover,
        this.description = description,
        this.position = position,
        this.title = title,
        this.id = id,
        this.listEpisodes = listEpisodes,
        this.listTrailers = listTrailers,
        this.listCast = listCast,
        this.listMainStars = listMainStars,
        this._apiResponse = apiResponse,
        this.video = video,
        this.genreList = genreList,
        this.releaseDate = releaseDate,
        this.userId = userId,
        super(key: key);
  @override
  _SelectedTopicSeriesOrMovieState createState() =>
      _SelectedTopicSeriesOrMovieState();
}

class _SelectedTopicSeriesOrMovieState
    extends State<SelectedTopicSeriesOrMovie> {
  AppServices get service => GetIt.I<AppServices>();
 Map _source = {ConnectivityResult.none: false};
  MyConnectivity _connectivity = MyConnectivity.instance;
  bool _isLoading = false;
  int pageNumber = 1;
  int indexincreement = 0;
  @override
  void initState() {
    super.initState();
     _connectivity.initialise();
    _connectivity.myStream.listen((source) {
      setState(() => _source = source);
    });
    _fetchDataSeriesOrMoviesFromRemoteServer();
  }

  _fetchDataSeriesOrMoviesFromRemoteServer() async {

    setState(() {
      _isLoading = true;
    });

    widget.type == 'series'
        ?
        widget?._apiResponse != null
         ? widget?._apiResponse =
            // MRAK:- get series by page number
            await service.getShowTopicSerivce(pageNumber, 'get/series/by-page')
            : widget?._apiResponse = await service.getTopTen()
        : widget?._apiResponse != null
            ? 
            // MARK:- get movies by page number
            await service.getShowTopicSerivce(pageNumber, 'get/movies/by-page')
            :  widget?._apiResponse = await service.getTopTen();
           
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

    String releaseDate = dateFormat.format(widget?.releaseDate == null
        ? widget?._apiResponse?.data?.results == null
            ? DateTime.now()
            : widget?._apiResponse?.data?.results[0]?.releaseDate
        : widget.releaseDate);

    DateTime dateTime = dateFormat.parse(releaseDate);

    SizeConfig().init(context);
    switch (_source.keys.toList()[0]) {
      case ConnectivityResult.none:
        print("ErrorConnection");
        return Scaffold(
          body: Center(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 150,
              child: Center(
                  child: Column(
                children: [
                  Text(
                    'Connection Failed'),
                  SizedBox(height: 25.0),
                  Container(
                    child: RaisedButton(
                      color: Colors.black,
                      textColor: Colors.white,
                      onPressed: () {
                        if (_source.keys.toList()[0] ==
                            ConnectivityResult.mobile) {
                          return  buildScaffoldWidget(context, dateTime);
                        } else if (_source.keys.toList()[0] ==
                            ConnectivityResult.wifi) {
                          return  buildScaffoldWidget(context, dateTime);

                        } else if (_source.keys.toList()[0] ==
                            ConnectivityResult.none) {
                          DisplayMessage.displayToast('Still connection failed');
                        }
                      },
                      child: Text('Check connection'),
                    ),
                  ),
                ],
              )),
            ),
          ),
        );
        break;
      case ConnectivityResult.mobile:
        print("MobileConnection");

    return buildScaffoldWidget(context, dateTime);
        break;
      case ConnectivityResult.wifi:
        print("WifiConnection");

    return buildScaffoldWidget(context, dateTime);
        break;
    }
  }

  SafeArea buildScaffoldWidget(BuildContext context, DateTime dateTime) {
    return SafeArea(
    top: false,
    bottom: false,
    left: false,
    right: false,
    child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            widget.type == 'series'
                ? 
                DemoLocalization.of(context).locale.languageCode == 'en' ? 
                '${widget?.title != null ? widget?.title : widget?._apiResponse?.data != null ? widget?._apiResponse?.data?.results[0]?.nameEn : "Series"} Series'
                :
                'مسلسل ${widget?.title != null ? widget?.title : widget?._apiResponse?.data != null ? widget?._apiResponse?.data?.results[0]?.name : "Series"} '

                : 
                DemoLocalization.of(context).locale.languageCode == 'en' ?
                '${widget?.title != null ? widget?.title : widget?._apiResponse?.data != null ? widget?._apiResponse?.data?.results[0]?.nameEn : "Movie"}'
                :'${widget?.title != null ? widget?.title : widget?._apiResponse?.data != null ? widget?._apiResponse?.data?.results[0]?.name : "فيلم"}',
            style: AppTextStyle.titleAppBarColor,
            maxLines: 1,
          ),
        ),
        backgroundColor: Colors.black,
        actions: <Widget>[
          // IconButton(
          //     icon: Icon(
          //       Icons.more_vert,
          //       color: Colors.orange,
          //       size: 30,
          //     ),
          //     onPressed: () {})
        ],
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.orange,
            ),
            onPressed: () {
              // Navigator.pop(context);
              Navigator.push(
                context,
                MyCustomRoute(
                  widgetBuilder: (context) => HomePage(),
                ),
              );
            }),
      ),
      body: Container(
        width: SizeConfigs.screenWidth * 100,
        height: SizeConfigs.screenHeight * 100,
        color: AppColorsStyle.backgroundColorScreen,
        child: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: ScrollPhysics(),
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // display header series or movies
                //           poster: _apiResponse.data.results[0].cPoster1,
                // cover: _apiResponse.data.results[0].cCover1,
                // description: _apiResponse.data.results[0].description,
                widget.type == 'series'
                    ? HeaderSeriesWidget(
                      title: widget.title == null 
                      ?
                      DemoLocalization.of(context).locale.languageCode == 'en'
                      ?
                      widget?._apiResponse?.data == null ? '' 
                      : widget?._apiResponse?.data?.results == null ? '' : widget?._apiResponse?.data?.results[0]?.nameEn
                       :  widget?._apiResponse?.data?.results == null ? '' : widget?._apiResponse?.data?.results[0]?.name 
                      //  : ""
                       : widget.title,
                        poster: widget.poster == null
                            ? widget?._apiResponse?.data != null
                                ? widget
                                    ?._apiResponse?.data?.results[0].cPoster1
                                : ""
                            : widget.poster,
                        cover: widget.cover == null
                            ? widget?._apiResponse?.data != null
                                ? widget
                                    ?._apiResponse?.data?.results[0].mCover1
                                : ""
                            : widget.cover,
                        description: 
                        DemoLocalization.of(context).locale.languageCode == 'en'
                        ?
                        widget.description == null
                            ? widget?._apiResponse?.data != null
                                ? widget?._apiResponse?.data?.results[0]
                                    .descriptionEn
                                : ""
                            : widget.description
                            :
                             widget.description == null
                            ? widget?._apiResponse?.data != null
                                ? widget?._apiResponse?.data?.results[0]
                                    .description
                                : ""
                            : widget.description,

                        video: widget.video == null
                            ? widget?._apiResponse?.data != null
                                ? widget?._apiResponse?.data?.results[0].video
                                : ""
                            : widget.video,
                        userId: widget.userId,
                        genreList:
                            widget.genreList == [] ? [] : widget.genreList,
                        releaseDate: widget.releaseDate == null
                            ? widget?._apiResponse?.data != null
                                ? widget?._apiResponse?.data?.results[0]
                                    ?.releaseDate
                                : DateTime.now()
                            : dateTime,
                        id: widget.id,
                      )
                    : widget?._apiResponse?.data == null
                        ? Container()
                        : HeaderMovieWidget(
                            poster: widget.poster == null
                                ? widget?._apiResponse?.data != null
                                    ? widget?._apiResponse?.data?.results[0]
                                        .cPoster1
                                    : ""
                                : widget.poster,
                            cover: widget.cover == null
                                ? widget?._apiResponse?.data != null
                                    ? widget?._apiResponse?.data?.results[0]
                                        .mCover1
                                    : ""
                                : widget.cover,
                            description: widget.description == null
                                ? widget?._apiResponse?.data != null
                                    ? widget?._apiResponse?.data?.results[0]
                                        .description
                                    : ""
                                : widget.description,
                            name:
                            
                            DemoLocalization.of(context).locale.languageCode == 'en'
                            ? 
                             widget.title == null
                                ? widget?._apiResponse?.data != null
                                    ? widget
                                        ?._apiResponse?.data?.results[0].nameEn
                                    : ""
                                : widget.title
                                :
                                 widget.title == null
                                ? widget?._apiResponse?.data != null
                                    ? widget
                                        ?._apiResponse?.data?.results[0].name
                                    : ""
                                : widget.title
                                ,
                            video: widget.video == null
                                ? widget?._apiResponse?.data != null
                                    ? widget
                                        ?._apiResponse?.data?.results[0].video
                                    : ""
                                : widget.video,
                            id: widget.id,
                            genreList: widget.genreList == []
                                ? []
                                : widget.genreList,
                            duration: widget.duration,
                          ),
                //  display cast
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                  child: CastWidget(
                      titleSection:  DemoLocalization.of(context).getTransaltedValue('Cast:')
                      ,
                      listCast: widget?.listCast == null
                          ? widget?._apiResponse?.data?.results == null
                              ? []
                              : widget?._apiResponse?.data?.results[0]?.casts
                          : widget?.listCast),
                ),
                // // display mainStars
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: CastWidget(
                      titleSection: DemoLocalization.of(context).getTransaltedValue('MainStar:'),
                      listCast: widget?.listCast == null
                          ? widget?._apiResponse?.data?.results == null
                              ? []
                              : widget
                                  ?._apiResponse?.data?.results[0]?.mainStars
                          : widget?.listCast),
                ),
                SizedBox(height: 16.0),
                // display trailers
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(17, 17, 17, 1.0),
                      border: Border(
                        bottom: BorderSide(
                            color: AppColorsStyle.lineColorContainer),
                      ),
                    ),
                    child: TrailerWidget(
                        listTrailers: widget?.listTrailers == null
                            ? widget?._apiResponse?.data?.results == null
                                ? []
                                : widget
                                    ?._apiResponse?.data?.results[0]?.trailers
                            : widget?.listTrailers),
                  ),
                ),
                // display seasons
                SizedBox(height: 5.0),
                widget.type == 'series'
                    ? 
                        SeeSeasonsOrRelatedMoviesWidget(
                            apiResponse: widget?._apiResponse,
                            isLoading: _isLoading,
                            position:
                                widget.position == null ? 0 : widget.position,
                            type: widget.type,
                            titleSection: DemoLocalization.of(context).getTransaltedValue('See All Seasons:') ,
                          )
                    : widget?._apiResponse == null
                        ? Container()
                        : SeeSeasonsOrRelatedMoviesWidget(
                            apiResponse: widget?._apiResponse,
                            isLoading: _isLoading,
                            position:
                                widget.position == null ? 0 : widget.position,
                            type: widget.type,
                            titleSection: DemoLocalization.of(context).getTransaltedValue('Related Movies :'),
                          ),
                widget.type == 'series'
                    ? EpisodesWidget(
                        listEpisodes: widget?.listEpisodes == null
                            ? []
                            : widget?.listEpisodes)
                    : Container(
                        width: 0,
                        height: 0,
                        color: Colors.transparent,
                      ),
                // display episodes
              ],
            ),
          ],
        ),
      ),
    ),
  );
  }
}
