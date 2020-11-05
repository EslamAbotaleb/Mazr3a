import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:primaxproject/localization/demo_localization.dart';
import 'package:primaxproject/model/api_response.dart';
import 'package:primaxproject/model/favorite_status_model.dart';
import 'package:primaxproject/model/genres_model.dart';
import 'package:primaxproject/model/genres_result.dart';
import 'package:primaxproject/model/models.dart';
import 'package:primaxproject/res/sizeconfig.dart';
import 'package:primaxproject/res/textsytlewidget/text_style.dart';
import 'package:primaxproject/res/themeApp/themeprimax.dart';
import 'package:primaxproject/services/app_services.dart';
import 'package:primaxproject/widgets/common_widget/common_widget.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:intl/date_symbol_data_local.dart';

class HeaderSeriesWidget extends StatefulWidget {
  final String poster;
  final String title;
  final String cover;
  final String description;
  final DateTime releaseDate;
  final String video;
  final int id;
  final String userId;
  final List<Genre> genreList;
  const HeaderSeriesWidget(
      {Key key,
      @required String poster,
      @required String cover,
      @required String description,
      List<Genre> genreList,
      String userId,
      String video,
      int id,
      String title,
      DateTime releaseDate})
      : this.poster = poster,
        this.cover = cover,
        this.description = description,
        this.video = video,
        this.genreList = genreList,
        this.releaseDate = releaseDate,
        this.id = id,
        this.userId = userId,
        this.title = title,
        super(key: key);

  @override
  _HeaderSeriesWidgetState createState() => _HeaderSeriesWidgetState();
}

class _HeaderSeriesWidgetState extends State<HeaderSeriesWidget> {
  APIResponse<FavouriteStatusModel>
      _apiResponseForAddOrRemoveTopicFromFavoriteList;
  APIResponse<ListFavouriteModel> _apiResponseForretreiveFavoriteList;
  APIResponse<ShowTopicModel> _apiResponse;
  AppServices get service => GetIt.I<AppServices>();
  bool favoriteStatus = false;
  double spaceBetweenViews = 5.0;
  bool _isLoading;
  _addThisTopicToFavroite(String userId) async {
    if (userId == '' || userId == null) {
      DisplayMessage.displayToast('Must subscribe to make favorite');
    } else {
      setState(() {
        _isLoading = true;
      });
      _apiResponseForAddOrRemoveTopicFromFavoriteList =
          await service.addOrRemoveTopicFavorite(
              'favourite/add', 'series', widget.id, userId);
      setState(() {
        favoriteStatus = true;
        _isLoading = false;
      });
    }
  }

  _removehisTopicToFavroite(String userId) async {
    if (userId == '' || userId == null) {
      DisplayMessage.displayToast('Must subscribe to remove favorite');
    } else {
      setState(() {
        _isLoading = true;
      });

      _apiResponseForAddOrRemoveTopicFromFavoriteList =
          await service.addOrRemoveTopicFavorite(
              'favourite/delete', 'series', widget.id, userId);
      setState(() {
        favoriteStatus = false;

        _isLoading = false;
      });
    }
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
        await service.getLatestMoviesOrSeriesHomeService('get/latest/series');

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchTopicBecomeFavorite();
  }
String formatted;
String formattedTime;

  @override
  Widget build(BuildContext context) {

    
    SizeConfig().init(context);
    print(SizeConfigs.heightMultiplier * 5.5);
    initializeDateFormatting("ar_SA", null).then((_) {
      // var now = DateTime.now();
      var formatter = DateFormat.yMMMd('ar_SA');
      //  dateFormat = new DateFormat.yMMMMd('cs');
    var timeFormat = new DateFormat.Hms('ar_SA');
      print(timeFormat.locale);
      print(formatter.locale);
       formatted = formatter.format(widget?.releaseDate);
              formatted = formatter.format(widget?.releaseDate);
       formattedTime = timeFormat.format(widget?.releaseDate);

      print(formatted);
            print(formattedTime);

    });
    return Stack(
      // fit: StackFit.expand,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: SizeConfigs.screenWidth * 100,
              height: SizeConfigs.screenHeight * 0.25,
              child:
                  // CachedNetworkImage(
                  //   imageUrl: 'http://vod.appcorp.mobi/storage/' + widget.poster,
                  //   fit: BoxFit.fill,
                  //   placeholder: (context, url) => Container(
                  //     width: 50,
                  //     height: 50,
                  //     child: Center(
                  //       child: CircularProgressIndicator(
                  //         valueColor:
                  //             new AlwaysStoppedAnimation<Color>(Colors.orange),
                  //       ),
                  //     ),
                  //   ),
                  //   errorWidget: (context, url, error) => new Icon(Icons.error),
                  // ),
                  Stack(children: [
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
                      image: 'http://vod.appcorp.mobi/storage/' + widget.poster,
                    ),
                  ),
                ),
              ]),
            ),
            SizedBox(height: SizeConfigs.heightMultiplier * 4.0),
            Padding(
              padding: EdgeInsets.only(
                  left: 10.0,
                  right: 10.0,
                  top: SizeConfigs.heightMultiplier * 0.2,
                  bottom: 3.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 1.0,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(17, 17, 17, 1.0),
                  border: Border(
                    bottom:
                        BorderSide(color: AppColorsStyle.lineColorContainer),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: spaceBetweenViews),
                    widget?.genreList == null
                        ? Container(
                            width: 0,
                            height: 0,
                            color: Colors.red,
                          )
                        : Padding(
                            padding:
                                const EdgeInsets.only(top: 28.0, bottom: 8.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.06,
                              child: ListView.builder(
                                itemCount: widget.genreList == []
                                    ? 0
                                    : widget.genreList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Container(
                                      width: 70,
                                      height: 35,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColorsStyle.colorBorder),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Center(
                                        child: Text(DemoLocalization.of(context)
                                                    .locale
                                                    .languageCode ==
                                                'en'
                                            ? widget.genreList[index].nameEn
                                            : widget.genreList[index].nameAr),
                                      ),
                                    ),
                                  );
                                },
                                scrollDirection: Axis.horizontal,
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
            SizedBox(height: spaceBetweenViews + 20.0),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Container(
                // width: SizeConfig.blockSizeHorizontal * 100,
                // height: SizeConfig.blockSizeVertical * 15.67,
                width: SizeConfigs.screenWidth * 100,
                height: 70.0,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(17, 17, 17, 1.0),
                  border: Border(
                    bottom:
                        BorderSide(color: AppColorsStyle.lineColorContainer),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0, left: 10.0),
                      child: Container(
                        width: SizeConfig.screenWidth * 100,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  DemoLocalization.of(context).getTransaltedValue('Title'),
                                  style: AppTextStyle.textCardStyle,
                                ),
                                Text(
                                  widget?.title,
                                  style: AppTextStyle.textCardStyle,
                                ),
                              ],
                            ),
                            SizedBox(height: 2.0),

                            SizedBox(height: 2.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  
                                  '${DemoLocalization.of(context).getTransaltedValue('Release Date:')} ${DemoLocalization.of(context).locale.languageCode == 'en' ? widget.releaseDate : ( formatted == null || formattedTime == null)? '' :  formatted +' - '+   formattedTime }',
                                  style: AppTextStyle.textCardStyle,
                                ),
                                // Text(DateFormat("yyyy-MM-dd hh:mm")
                                //     .format(widget?.releaseDate),
                                //     ),
                              ],
                            ),
                            SizedBox(height: 2.0),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.start,
                            //   children: <Widget>[
                            //     Text(
                            //       'Director: ',
                            //       style: AppTextStyle.textCardStyle,
                            //     ),
                            //     Text(
                            //       'Cristopher Nolan',
                            //       style: AppTextStyle.textCardStyle,
                            //     ),
                            //   ],
                            // ),
                            SizedBox(height: 2.0),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 2.0),
                  ],
                ),
              ),
            ),
          ],
        ),
        Positioned(
          top: 10,
          // left: MediaQuery.of(context).size.width <= 375.0
          //     ? MediaQuery.of(context).size.width * 0.85
          //     : MediaQuery.of(context).size.width * 0.85,
          // SizeConfig.blockSizeHorizontal * 75,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              // IconButton(
              //     icon: Icon(
              //       Icons.adb,
              //       color: Colors.orange,
              //     ),
              //     onPressed: () {}),
              DemoLocalization.of(context).locale.languageCode == 'en'
                  ? Align(
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
                    )
                  : Align(
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
                    ),
            ],
          ),
        ),
        Positioned(
          left: 5,
          top: SizeConfigs.isMobilePortrait
              ? SizeConfigs.screenHeight * 0.18
              : SizeConfigs.screenHeight * 35.0,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 120.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(2.0),
                  child: Container(
                    width: SizeConfigs.isPortrait
                        ? SizeConfig.screenWidth * 0.3
                        : SizeConfig.screenWidth * 0.1,
                    //  MediaQuery.of(context).size.width * 0.28,
                    height: 120.0,
                    // width: SizeConfig.blockSizeHorizontal * 25 < 190 ? SizeConfig.blockSizeHorizontal * 25 : SizeConfig.blockSizeHorizontal * 13.8,
                    // height: SizeConfig.blockSizeVertical * 15,
                    child: Stack(
                      children: [
                        Positioned(
                            left: SizeConfigs.screenWidth * 0.14,
                            top: SizeConfigs.screenWidth * 0.14,
                            child: Icon(Icons.error)),
                        Center(
                          child: Container(
                            width: SizeConfigs.imageSizeMultiplier * 45,
                            height: SizeConfigs.screenHeight * 0.25,
                            child: FadeInImage.memoryNetwork(
                              placeholder: kTransparentImage,
                              image: 'http://vod.appcorp.mobi/storage/' +
                                  widget.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                    //  CachedNetworkImage(
                    //   imageUrl:
                    //       'http://vod.appcorp.mobi/storage/' + widget.cover,
                    //   fit: BoxFit.fill,
                    //   placeholder: (context, url) => Container(
                    //     width: 50,
                    //     height: 50,
                    //     child: Center(
                    //       child: CircularProgressIndicator(
                    //         valueColor: new AlwaysStoppedAnimation<Color>(
                    //             Colors.orange),
                    //       ),
                    //     ),
                    //   ),
                    //   errorWidget: (context, url, error) =>
                    //       new Icon(Icons.error),
                    // ),
                  ),
                ),
                SizedBox(width: 5.0),
                Container(
                  //  width: SizeConfigs.widthMultiplier * 100,
                  child: Flexible(
                    child: Text(
                      '${widget.description}',
                      maxLines: 3,
                      style: AppTextStyle.textStyleheaderApp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
        // Positioned(
        // left: 15,
        // top: MediaQuery.of(context).size.height * 0.18,
        //   child: ClipRRect(
        //     borderRadius: BorderRadius.circular(2.0),
        //     child: Container(
        //       width: MediaQuery.of(context).size.width * 0.28,
        //       height: SizeConfigs.screenHeight <= 667.0
        //           ? MediaQuery.of(context).size.height * 0.15
        //           : SizeConfigs.heightMultiplier * 13,
        //       // width: SizeConfig.blockSizeHorizontal * 25 < 190 ? SizeConfig.blockSizeHorizontal * 25 : SizeConfig.blockSizeHorizontal * 13.8,
        //       // height: SizeConfig.blockSizeVertical * 15,
        //       child: CachedNetworkImage(
        //         imageUrl: 'http://vod.appcorp.mobi/storage/' + widget.cover,
        //         fit: BoxFit.fill,
        //         placeholder: (context, url) => Container(
        //           width: 50,
        //           height: 50,
        //           child: Center(
        //             child: CircularProgressIndicator(
        //               valueColor:
        //                   new AlwaysStoppedAnimation<Color>(Colors.orange),
        //             ),
        //           ),
        //         ),
        //         errorWidget: (context, url, error) => new Icon(Icons.error),
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
