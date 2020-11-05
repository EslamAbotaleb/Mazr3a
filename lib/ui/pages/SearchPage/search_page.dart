import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:primaxproject/common/debouncer.dart';
import 'package:primaxproject/localization/demo_localization.dart';
import 'package:primaxproject/model/api_response.dart';
import 'package:primaxproject/model/show_topic_model.dart';
import 'package:primaxproject/res/sizeconfig.dart';
import 'package:primaxproject/res/textsytlewidget/text_style.dart';
import 'package:primaxproject/res/themeApp/themeprimax.dart';
import 'package:primaxproject/services/app_services.dart';
import 'package:primaxproject/widgets/widgets.dart';
import 'package:transparent_image/transparent_image.dart';

class SearchWidget extends StatefulWidget {
  final _searchQuery = new TextEditingController();
  SearchWidget({
    Key key,
  }) : super(key: key);
  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget>
    with SingleTickerProviderStateMixin {
  APIResponse<ShowTopicModel> getResultAfterUserSearchAboutTopic;

  bool selected = false;
  bool _isLoading = false;
  var connected = false;
  String keyword;
  bool upDown = true;
  AnimationController _controller;
  Animation<double> _animation;
  Timer timeHandle;
  var heightspace = 15.0;
  var widthSpace = 15.0;
  var widthSpaceText = 7.0;
  final _debouncer = Debouncer(milliseconds: 500);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  APIResponse<ShowTopicModel> _apiResponse;
  APIResponse<ShowTopicModel> getTopicAfterUserSearchedOnSpesficTopic;
  AppServices get service => GetIt.I<AppServices>();

  @override
  void initState() {
    super.initState();

    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 180),
    );

    _animation = new CurvedAnimation(
      parent: _controller,
      curve: new Interval(0.0, 1.0, curve: Curves.linear),
    );
  }

  _fetchDataWhenUserSearchAboutTopic(String keyword) async {
    setState(() {
      _isLoading = true;
    });
    _apiResponse = await service.getItemAfterSearch(keyword);
    getTopicAfterUserSearchedOnSpesficTopic =
        await service.getItemAfterSearch(keyword);

    setState(() {
      _isLoading = false;
    });
  }

  void textChanged(String inputUser) {
    keyword = inputUser;
    if (timeHandle != null) {
      timeHandle.cancel();
    }
    timeHandle = Timer(Duration(seconds: 1), () {
      _debouncer.run(() {
        setState(() {
          if (keyword == "") {
            setState(() {
              _apiResponse.data.results.clear();
            });
          }
          _fetchDataWhenUserSearchAboutTopic(keyword);

          _apiResponse.data.results = _apiResponse.data.results
              .where((element) =>
                  element.name.toLowerCase().contains(keyword.toLowerCase()) ||
                  element.description
                      .toLowerCase()
                      .contains(keyword.toLowerCase()))
              .toList();
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      // drawer: Theme(
      //   data: Theme.of(context).copyWith(
      //     canvasColor: Colors.black87.withOpacity(0.20),
      //   ),
      //   // child: Container(
      //   //   width: SizeConfigs.screenWidth * 100,
      //   //   child:
      //   //   DrawerContent(
      //   //     widthSpace: 15.0,
      //   //     heightspace: 15.0,
      //   //   ),
      //   // ),
      // ),
      backgroundColor: Color.fromRGBO(17, 17, 17, 1.0),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.orange,
              ),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => HomePage()));
                // _scaffoldKey.currentState.openDrawer();
              },
            ),
            centerTitle: true,
            title: Image.asset(
              'assets/images/primaxPresentationZainWhite01.png',
              fit: BoxFit.cover,
            ),
            expandedHeight: 150,
            floating: true,
            pinned: true,
            snap: true,
            elevation: 50,
            backgroundColor: AppColorsStyle.mainColor,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  new Positioned(
                    // bottom: 0.0,
                    // top: SizeConfigs.heightMultiplier * 10.0,
                    top: MediaQuery.of(context).size.height * 0.10,
                    child: new AnimatedBuilder(
                      animation: _animation,
                      builder: (BuildContext context, Widget child) {
                        return new Container(
                          height: 92.0,
                          width: SizeConfigs.screenWidth * 100.0,
                          color: Color.fromRGBO(255, 191, 0, 0.68),
                          child: SingleChildScrollView(
                            physics: NeverScrollableScrollPhysics(),
                            reverse: true,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 0.0, left: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                   DemoLocalization.of(context).getTransaltedValue('Search'),
                                    style: AppTextStyle
                                        .titleStyleHeaderSectionSearchBar,
                                  ),
                                  TextField(
                                    autofocus: false,
                                    maxLines: 1,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText:
                                          DemoLocalization.of(context).getTransaltedValue('SerachBy')),
                                    onChanged: textChanged,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // Container(
                  //   width: SizeConfigs.screenWidth * 100,
                  //   height: SizeConfigs.screenHeight * 10,
                  //   color: AppColorsStyle.mainColor,
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(bottom: 12.0),
                  //     child: Align(
                  //       alignment: Alignment.bottomCenter,
                  //       child: Text(
                  //         'Search',
                  //         style: AppTextStyle.titleWithUnderline,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Colors.orange,
                    ),
                    onPressed: () {
                      setState(() {
                        _oepnSearchBarContainer();
                      });
                    }),
              ),
            ],
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            Container(
                width: SizeConfigs.screenWidth * 100,
                height: SizeConfigs.screenHeight * 100,
                //  MediaQuery.of(context).size.height <= 667.0
                //     ? MediaQuery.of(context).size.height * 1.0
                //     : MediaQuery.of(context).size.height * 0.24,
                child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: keyword == null
                        ? 0
                        : _apiResponse?.data?.results?.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        color: Color.fromRGBO(10, 10, 10, 1.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MyCustomRoute(
                                    widgetBuilder: (context) =>
                                        SelectedTopicSeriesOrMovie(
                                      type: _apiResponse
                                          ?.data?.results[index]?.type,
                                      poster: getResultAfterUserSearchAboutTopic
                                          ?.data?.results[index]?.cPoster1,
                                      description: _apiResponse
                                          ?.data?.results[index]?.description,
                                      cover: _apiResponse
                                          ?.data?.results[index]?.cCover1,
                                      title: _apiResponse
                                          ?.data?.results[index]?.name,
                                      position: index,
                                      id: _apiResponse
                                          ?.data?.results[index]?.id,
                                      listEpisodes: _apiResponse?.data
                                                  ?.results[index]?.type ==
                                              'series'
                                          ? _apiResponse?.data?.results[index]
                                                      ?.episodes ==
                                                  null
                                              ? 0
                                              : _apiResponse?.data
                                                  ?.results[index]?.episodes
                                          : [],
                                      listCast: _apiResponse?.data
                                                  ?.results[index]?.casts ==
                                              null
                                          ? 0
                                          : _apiResponse
                                              ?.data?.results[index]?.casts,
                                      listMainStars: _apiResponse?.data
                                                  ?.results[index]?.mainStars ==
                                              null
                                          ? 0
                                          : _apiResponse
                                              ?.data?.results[index]?.mainStars,

                                      listTrailers: _apiResponse?.data
                                                  ?.results[index]?.trailers ==
                                              []
                                          ? []
                                          : _apiResponse
                                              ?.data?.results[index]?.trailers,
                                      genreList: _apiResponse?.data
                                                  ?.results[index]?.genres ==
                                              []
                                          ? []
                                          : _apiResponse
                                              ?.data?.results[index]?.genres,
                                      video: _apiResponse
                                          ?.data?.results[index]?.video,
                                      // releaseDate:
                                      //     _apiResponse.data.results[index].releaseDate,
                                    ),
                                  ),
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  _apiResponse?.data?.results == null
                                      ? Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : Container(
                                          color:
                                              Color.fromRGBO(10, 10, 10, 1.0),
                                          width:
                                              // MediaQuery.of(context).size.width,
                                              SizeConfigs.screenWidth,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.22,
                                          child: Stack(children: [
                                            Positioned(
                                                left: SizeConfigs.screenWidth *
                                                    0.158,
                                                top: SizeConfigs.screenWidth *
                                                    0.158,
                                                child: Icon(Icons.error)),
                                            Center(
                                              child: Container(
                                                width: SizeConfigs
                                                        .imageSizeMultiplier *
                                                    45,
                                                height:
                                                    SizeConfigs.screenHeight *
                                                        0.25,
                                                child:
                                                    FadeInImage.memoryNetwork(
                                                  placeholder:
                                                      kTransparentImage,
                                                  image:
                                                      'http://vod.appcorp.mobi/storage/' +
                                                          _apiResponse
                                                              ?.data
                                                              ?.results[index]
                                                              ?.mPoster1,
                                                ),
                                              ),
                                            ),
                                          ]),
                                          //  CachedNetworkImage(
                                          //   imageUrl:
                                          //      'http://vod.appcorp.mobi/storage/' + _apiResponse?.data?.results[index]?.mCover1,
                                          //   fit: BoxFit.fill,
                                          //   placeholder: (context, url) =>
                                          //       Container(
                                          //     width: 50,
                                          //     height: 50,
                                          //     child: Center(
                                          //       child:
                                          //           CircularProgressIndicator(),
                                          //     ),
                                          //   ),
                                          //   errorWidget:
                                          //       (context, url, error) =>
                                          //           new Icon(Icons.error),
                                          // ),
                                        ),
                                  _apiResponse?.data?.results == null
                                      ? Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, top: 3.0),
                                          child: Text(
                                            _apiResponse
                                                ?.data?.results[index]?.name,
                                            style: AppTextStyle.textCardStyle,
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    })),
          ]))
        ],
      ),
    );
  }

  void _oepnSearchBarContainer() {
    setState(() {
      if (upDown) {
        upDown = false;
        _controller.forward(from: 0.0);
      } else {
        upDown = true;
        _controller.reverse(from: 1.0);
      }
    });
  }
  // @override
  // void dispose() {
  //   super.dispose();
  //   timeHandle.cancel();
  //   timeHandle.cancel();
  // }
}
