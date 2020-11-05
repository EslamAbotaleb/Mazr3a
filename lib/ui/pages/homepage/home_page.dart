import 'dart:async';
import 'dart:io' show InternetAddress, Platform, SocketException;
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:primaxproject/common/debouncer.dart';
import 'package:primaxproject/common/language.dart';
import 'package:primaxproject/common/my_connectivity.dart';
import 'package:primaxproject/localization/demo_localization.dart';
import 'package:primaxproject/localization/localization_constants.dart';
import 'package:primaxproject/main.dart';
import 'package:primaxproject/model/api_response.dart';
import 'package:primaxproject/model/checksubscription.dart';
import 'package:primaxproject/model/models.dart';
import 'package:primaxproject/res/sizeconfig.dart';
import 'package:primaxproject/res/textsytlewidget/text_style.dart';
import 'package:primaxproject/res/themeApp/themeprimax.dart';
import 'package:primaxproject/services/app_services.dart';
import 'package:primaxproject/ui/pages/SearchPage/search_page.dart';
import 'package:primaxproject/widgets/common_widget/common_widget.dart';
import 'package:primaxproject/widgets/drawerwidget/drawer_widget.dart';
import 'package:primaxproject/widgets/homewidget/content_home/content_home_widget.dart';
import 'package:primaxproject/widgets/widgets.dart';
import 'package:connectivity/connectivity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transparent_image/transparent_image.dart';

class HomePage extends StatefulWidget {
  String userId;
  String mobileNumber;
  String operatorCode;
  HomePage({Key key, String userId, String mobileNumber, String operatorCode})
      : this.userId = userId,
        this.mobileNumber = mobileNumber,
        this.operatorCode = operatorCode,
        super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  Map _source = {ConnectivityResult.none: false};
  MyConnectivity _connectivity = MyConnectivity.instance;
  final _debouncer = Debouncer(milliseconds: 500);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  AppServices get service => GetIt.I<AppServices>();
  APIResponse<ShowTopicModel> _apiResponse;
  APIResponse<ShowTopicModel> getTopicAfterUserSearchedOnSpesficTopic;
  APIResponse<ShowTopicModel> getTopicMovie;
  APIResponse<CheckSubscriptionModel> _checkSubscriptionResponse;

  bool selected = false;
  bool _isLoading = false;
  var connected = false;
  String keyword;
  AnimationController _controller;
  Animation<double> _animation;
  Timer timeHandle;
  bool upDown = true;
  var heightspace = 15.0;
  var widthSpace = 15.0;
  var widthSpaceText = 7.0;
  var wifiBSSID;
  var wifiIP;
  var wifiName;
  bool iswificonnected = false;
  bool isInternetOn = true;
  var operatorCode;
  var mobileNumber;
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

    // GetConnect(); // calls getconnect method to check which type if connection it
// SystemChannels.textInput.invokeMethod('TextInput.hide');
    _connectivity.initialise();
    _connectivity.myStream.listen((source) {
      setState(() => _source = source);
    });
    _fetchDataHomeFromRemoteServer();
  }

  void textChanged(String inputUser) {
    keyword = inputUser;
    if (timeHandle != null) {
      timeHandle.cancel();
    }
    timeHandle = Timer(Duration(seconds: 1), () {
      // _fetchDataWhenUserSearchAboutTopic(keyword);

      _debouncer.run(() {
        // this.keyword = string;
        setState(() {
          if (keyword == "") {
            // setState(() {
            // });
          }
          getTopicAfterUserSearchedOnSpesficTopic.data.results = _apiResponse
              .data.results
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

  _fetchDataHomeFromRemoteServer() async {
    setState(() {
      _isLoading = true;
    });
    _apiResponse = await service.getTopTen();

    // getTopicAfterUserSearchedOnSpesficTopic = await service.getTopTen();
    setState(() {
      _isLoading = false;
    });
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

  _getMobileNumberAndOperatorCodeUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    operatorCode = prefs.getString('operatorCode') ?? '';
    mobileNumber = prefs.getString('mobileNumber') ?? '';
  }

  @override
  Widget build(BuildContext context) {
    print('heightScreen${SizeConfigs.screenHeight}');
    print('widthScreen${SizeConfigs.screenWidth}');

    _getMobileNumberAndOperatorCodeUser();
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
                          return buildScaffoldWidget(context);
                        } else if (_source.keys.toList()[0] ==
                            ConnectivityResult.wifi) {
                          return buildScaffoldWidget(context);
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

        return buildScaffoldWidget(context);
        break;
      case ConnectivityResult.wifi:
        print("WifiConnection");

        return buildScaffoldWidget(context);
        break;
    }
  }

  Scaffold buildScaffoldWidget(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        key: _scaffoldKey,
        drawer: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.black87.withOpacity(0.20),
          ),
          child: Container(
            // width: SizeConfigs.widthMultiplier * 100,
            width: SizeConfigs.screenWidth * 100.0,
            height: SizeConfigs.screenHeight * 100.0,
            child: DrawerContent(
              widthSpace: widthSpace,
              heightspace: heightspace,
              mobileNumber: mobileNumber,
              // operatorCode: operatorCode,
              userId: widget.userId,
            ),
          ),
        ),
        backgroundColor: Color.fromRGBO(17, 17, 17, 1.0),
        body: _apiResponse?.data?.results?.length == 0
            ? Center(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Platform.isIOS
                      ? CupertinoActivityIndicator()
                      : CircularProgressIndicator(
                          valueColor:
                              new AlwaysStoppedAnimation<Color>(Colors.orange),
                        ),
                  // CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.orange),),
                ),
              )
            : LayoutBuilder(builder: (context, constraints) {
                return OrientationBuilder(builder: (context, orientation) {
                  SizeConfigs().init(constraints, orientation);

                  return isInternetOn
                      ? CustomScrollView(
                          slivers: <Widget>[
                            SliverAppBar(
                              leading: IconButton(
                                icon: Icon(
                                  Icons.menu,
                                  color: Colors.orange,
                                ),
                                onPressed: () {
                                  _scaffoldKey.currentState.openDrawer();
                                },
                              ),

                              centerTitle: true,
                              title: Image.asset(
                                'assets/images/primaxPresentationZainWhite01.png',
                                // fit: BoxFit.fitHeight,
                              ),
                              expandedHeight: 250.0,
                              // expandedHeight: SizeConfigs.screenHeight * 0.3
                              //     : SizeConfigs.screenHeight * 0.4,
                              // MediaQuery.of(context).size.height <= 667.0
                              //     ? MediaQuery.of(context).size.height * 0.27
                              //     : MediaQuery.of(context).size.height * 0.28,
                              floating: true,
                              pinned: true,
                              snap: true,
                              elevation: 50,
                              backgroundColor: Color.fromRGBO(17, 17, 17, 1.0),
                              flexibleSpace: FlexibleSpaceBar(
                                titlePadding: EdgeInsets.zero,
                                centerTitle: true,
                                background: Stack(
                                  fit: StackFit.expand,
                                  children: <Widget>[
                                    _apiResponse?.data == null
                                        ? Center(
                                            child: CircularProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                      Colors.orange),
                                            ),
                                          )
                                        : Container(
                                            width:
                                                SizeConfigs.screenWidth * 1.0,
                                            // MediaQuery.of(context).size.width *
                                            //     1.0,
                                            height:
                                                SizeConfigs.screenHeight * 0.1,
                                            // MediaQuery.of(context).size.height *
                                            //     0.24,
                                            child:
                                                //  CachedNetworkImage(
                                                //   imageUrl:
                                                // 'http://vod.appcorp.mobi/storage/' +
                                                //           _apiResponse?.data?.results[0]?.mCover1,
                                                //   fit: BoxFit.fill,
                                                //   placeholder: (context, url) =>
                                                //       Container(
                                                //     width: 50,
                                                //     height: 50,
                                                //     child: Center(
                                                //       child: CircularProgressIndicator(
                                                //         valueColor:
                                                //             AlwaysStoppedAnimation<Color>(
                                                //                 Colors.orange),
                                                //       ),
                                                //     ),
                                                //   ),
                                                //   errorWidget: (context, url, error) =>
                                                //       new Icon(Icons.error),
                                                // ),
                                                Stack(children: [
                                              Positioned(
                                                  left:
                                                      SizeConfigs.screenWidth *
                                                          0.45,
                                                  top: SizeConfigs.screenWidth *
                                                      0.30,
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
                                                                ?.results[0]
                                                                ?.mCover1,
                                                  ),
                                                ),
                                              ),
                                            ]),
                                          ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left:
                                              SizeConfigs.widthMultiplier * 5.0,
                                          right: SizeConfigs.widthMultiplier *
                                              5.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          Text(
                                            DemoLocalization.of(context)
                                                        .locale
                                                        .languageCode ==
                                                    'en'
                                                ? _apiResponse?.data == null
                                                    ? ''
                                                    : _apiResponse?.data != null
                                                        ? _apiResponse?.data
                                                            ?.results[0]?.nameEn
                                                        : ""
                                                : _apiResponse?.data == null
                                                    ? ''
                                                    : _apiResponse?.data != null
                                                        ? _apiResponse?.data
                                                            ?.results[0]?.name
                                                        : "",
                                            style: AppTextStyle
                                                .titleStyleHeaderSectionHome,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: SizeConfigs
                                                        .widthMultiplier *
                                                    0.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                SizedBox(
                                                    height: SizeConfigs
                                                                .screenHeight <=
                                                            375.0
                                                        ? 4.0 *
                                                            SizeConfigs
                                                                .heightMultiplier
                                                        : SizeConfigs
                                                                .heightMultiplier *
                                                            1.0),

                                                SizedBox(width: widthSpaceText),
                                                // Text('Animation',
                                                //     style: AppTextStyle
                                                //         .subTitleStyleHeaderSectionHome),
                                                // SizedBox(width: widthSpaceText),
                                                // Text('Family',
                                                //     style: AppTextStyle
                                                //         .subTitleStyleHeaderSectionHome),
                                                // SizedBox(width: widthSpaceText),
                                                Container(
                                                  width: 1,
                                                  height: 15,
                                                  color: AppColorsStyle
                                                      .colorVertical,
                                                ),
                                                SizedBox(width: widthSpaceText),
                                                Text(
                                                    _apiResponse?.data == null
                                                        ? ''
                                                        : _apiResponse
                                                                    ?.data
                                                                    ?.results[0]
                                                                    ?.type ==
                                                                'series'
                                                            ? ''
                                                            : _apiResponse
                                                                ?.data
                                                                ?.results[0]
                                                                ?.duration,
                                                    style: AppTextStyle
                                                        .subTitleStyleHeaderSectionHome),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, bottom: 8.0),
                                  child: DropdownButton(
                                    onChanged: (Language language) {
                                      _chanageLanguage(language);
                                    },
                                    items: Language.languageList()
                                        .map<DropdownMenuItem<Language>>(
                                            (lang) => DropdownMenuItem(
                                                  value: lang,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Text(
                                                        lang.name,
                                                        // style: TextStyle(
                                                        //     fontSize: 12),
                                                      ),
                                                      Text(lang.flag)
                                                    ],
                                                  ),
                                                ))
                                        .toList(),
                                    underline: SizedBox(),
                                    icon: Icon(
                                      Icons.language,
                                      color: Colors.orange,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, bottom: 8.0),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.search,
                                      color: Colors.orange,
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MyCustomRoute(
                                          widgetBuilder: (context) => SearchWidget(
                                              // getResultAfterUserSearchAboutTopic:
                                              //     getTopicAfterUserSearchedOnSpesficTopic,
                                              ),
                                        ),
                                      );
                                      // setState(() {
                                      //   _oepnSearchBarContainer();
                                      // });
                                      // Navigator.push(
                                      //     context,
                                      //     MyCustomRoute(
                                      //         widgetBuilder: (context) => SearchPage()));
                                    },
                                  ),
                                ),
                              ],
                            ),
                            new SliverList(
                              delegate: new SliverChildListDelegate(
                                <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      FocusScopeNode currentFocus =
                                          FocusScope.of(context);
                                      if (!currentFocus.hasPrimaryFocus) {
                                        currentFocus.unfocus();
                                      }
                                    },
                                    child: Container(
                                        width: SizeConfigs.screenWidth * 100,
                                        color: Color.fromRGBO(17, 17, 17, 1.0),
                                        child: ContentHomeWidget(
                                            userId: widget.userId)),

                                    // ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : AlertDialog(
                          title: Text(
                            "You are not Connected to Internet",
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                          actions: [
                            FlatButton(
                              child: Text("OK"),
                              onPressed: () {
                                Navigator.of(context).pop(); // dismiss dialog
                              },
                            ),
                          ],
                        );
                });
              }));
  }

  void _chanageLanguage(Language language) async {
    print(language.languageCode);
    Locale _temp = await setLocale(language.languageCode);
    MyApp.setLocale(context, _temp);

    // switch (language.languageCode) {
    //   case 'en':
    //   _temp = Locale(language.languageCode, 'US');
    //   break;
    //   case 'ar':
    //         _temp = Locale(language.languageCode, 'SA');
    //   break;
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

  @override
  void dispose() {
    _connectivity.disposeStream();
    super.dispose();
  }
}
