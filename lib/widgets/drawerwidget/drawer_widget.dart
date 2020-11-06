import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:primaxproject/localization/demo_localization.dart';
import 'package:primaxproject/model/api_response.dart';
import 'package:primaxproject/model/checksubscription.dart';
import 'package:primaxproject/model/unsubscribe_model.dart';
import 'package:primaxproject/res/sizeconfig.dart';
import 'package:primaxproject/res/textsytlewidget/text_style.dart';
import 'package:primaxproject/services/app_services.dart';
import 'package:primaxproject/ui/pages/FavoritesPage/favorite_page.dart';
import 'package:primaxproject/widgets/common_widget/common_widget.dart';
import 'package:primaxproject/widgets/splashwidget/splashScreen.dart';
import 'package:primaxproject/widgets/subscriptionwidget/subscriptionwidget.dart';
import 'package:primaxproject/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerContent extends StatefulWidget {
  final String userId;
  final double widthSpace;
  final double heightspace;
  final String mobileNumber;
  // final String operatorCode;
  const DrawerContent(
      {Key key,
      this.widthSpace,
      this.heightspace,
      String mobileNumber,
       String userId,
      // String operatorCode
      })
      : this.mobileNumber = mobileNumber,
        // this.operatorCode = operatorCode,
        this.userId = userId,
        super(key: key);

  @override
  _DrawerContentState createState() => _DrawerContentState();
}

class _DrawerContentState extends State<DrawerContent> {
  APIResponse<CheckSubscriptionModel> _checkSubscriptionResponse;

  APIResponse<UnSubscriptionModel> _unSubscriptionResponse;

  AppServices get service => GetIt.I<AppServices>();

  deletePhoneNumberThisUserFromCache() async {
    // widget.operatorCode != '1'
    //     ? _unSubscriptionResponse = await service.unSubscriptionUser(
    //         'http://hedaaya.com/api/',
    //         'unsubscribe',
    //         widget.mobileNumber,
    //         widget.operatorCode)
    //     : _unSubscriptionResponse = await service.unSubscriptionUser(
    //         'http://hedaaya.com/test/mondia/',
    //         'unsubscribe',
    //         widget.mobileNumber,
    //         widget.operatorCode);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.remove('mobileNumber');
      prefs.remove('operatorCode');
      // if (prefs.getBool('isLoggedIn')) {
      //   prefs.remove('isLoggedIn');
        DisplayMessage.displayToast('Logout Successfully');
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext ctx) => SubscriptionScreen()));
      // } else {
      //   // DisplayMessage.displayToast('Must subscribe to logout');
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        SizeConfigs().init(constraints, orientation);
        return Container(
          width: SizeConfigs.screenWidth * 100.0,
          // height: SizeConfigs.screenHeight * 100.0,
          color: Colors.transparent,
          child: Drawer(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
              child: new Container(
                //      width: SizeConfigs.screenWidth,
                // height: SizeConfigs.screenHeight,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: SizeConfigs.heightMultiplier * 8.0,
                    left: 20.0,
                    right: 20.0
                  ),
                  child:  
                   Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: DemoLocalization.of(context).locale.languageCode == 'en' ? 
                             Align(
                               alignment: Alignment.topRight,
                               child: Icon(Icons.close)) : 
                             Align(
                              alignment: Alignment.topLeft,
                              child: Icon(Icons.close)) ,
                          ),
                        ),
                      ),
                      // SizedBox(height: 50.0),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MyCustomRoute(
                              widgetBuilder: (context) => HomePage(),
                            ),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                new Image.asset(
                                    "assets/images/watchLater24Px.png"),
                                SizedBox(
                                  width: widget.widthSpace,
                                ),
                                Text(
                                  DemoLocalization.of(context).getTransaltedValue('Home'),
                                  style: AppTextStyle.textStyleApp,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: widget.heightspace,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0, left: 4.0, right: 4.0),
                              child: Container(
                                width: SizeConfig.blockSizeHorizontal * 90,
                                height: 1,
                                color: Color.fromRGBO(178, 178, 178, 1.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: widget.heightspace,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MyCustomRoute(
                              widgetBuilder: (context) =>
                                  SelectedTopicSeriesOrMovie(
                                type: 'series',
                              ),
                            ),
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                new Image.asset(
                                    "assets/images/watchLater24Px.png"),
                                SizedBox(
                                  width: widget.widthSpace,
                                ),
                                Text(
                                  DemoLocalization.of(context).getTransaltedValue('Series'),
                                  style: AppTextStyle.textStyleApp,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: widget.heightspace,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0, left: 4.0, right: 4.0),
                              child: Container(
                                width: SizeConfig.safeBlockHorizontal * 90,
                                height: 1,
                                color: Color.fromRGBO(178, 178, 178, 1.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: widget.heightspace,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MyCustomRoute(
                              widgetBuilder: (context) =>
                                  SelectedTopicSeriesOrMovie(
                                type: 'movie',
                              ),
                            ),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                new Image.asset(
                                    "assets/images/watchLater24Px.png"),
                                SizedBox(
                                  width: widget.widthSpace,
                                ),
                                Text(
                                  DemoLocalization.of(context).getTransaltedValue('Movies'),
                                  style: AppTextStyle.textStyleApp,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: widget.heightspace,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 4.0, left: 4.0, right: 4.0),
                              child: Container(
                                width: SizeConfig.safeBlockHorizontal * 90,
                                height: 1,
                                color: Color.fromRGBO(178, 178, 178, 1.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: widget.heightspace,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                new Image.asset("assets/images/user.png"),
                                SizedBox(
                                  width: widget.widthSpace,
                                ),
                                Text(
                                 DemoLocalization.of(context).getTransaltedValue('Profile'),
                                  style: AppTextStyle.textStyleApp,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0, left: 4.0, right: 4.0),
                              child: Container(
                                width: SizeConfig.safeBlockHorizontal * 90,
                                height: 1,
                                color: Color.fromRGBO(178, 178, 178, 1.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: widget.heightspace,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MyCustomRoute(
                                // widgetBuilder: (conetxt) => FavoritePage(userId: userId,),
                                widgetBuilder: (conetxt) => 
                                
                                FavoritePage(),
                              ));
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                // new Image.asset(
                                //     "assets/images/movie24Px.png"),
                                Icon(
                                  Icons.favorite_border,
                                  color: Color.fromRGBO(255, 191, 0, 1.0),
                                ),
                                SizedBox(
                                  width: widget.widthSpace,
                                ),
                                Text(
                                  DemoLocalization.of(context).getTransaltedValue('Favorites'),
                                  style: AppTextStyle.textStyleApp,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0, left: 4.0, right: 4.0),
                              child: Container(
                                width: SizeConfig.safeBlockHorizontal * 90,
                                height: 1,
                                color: Color.fromRGBO(178, 178, 178, 1.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: widget.heightspace,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                new Image.asset(
                                    "assets/images/watchLater24Px.png"),
                                SizedBox(
                                  width: widget.widthSpace,
                                ),
                                Text(
                                  DemoLocalization.of(context).getTransaltedValue('Watch later'),
                                  style: AppTextStyle.textStyleApp,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0, left: 4.0, right: 4.0),
                              child: Container(
                                width: SizeConfig.safeBlockHorizontal * 90,
                                height: 1,
                                color: Color.fromRGBO(178, 178, 178, 1.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: widget.heightspace,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                new Image.asset(
                                    "assets/images/history24Px.png"),
                                SizedBox(
                                  width: widget.widthSpace,
                                ),
                                Text(
                                  DemoLocalization.of(context).getTransaltedValue('Watch History'),
                                  style: AppTextStyle.textStyleApp,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0, left: 4.0, right: 4.0),
                              child: Container(
                                width: SizeConfig.safeBlockHorizontal * 90,
                                height: 1,
                                color: Color.fromRGBO(178, 178, 178, 1.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: widget.heightspace,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          InkWell(
                            onTap: () async {
                              deletePhoneNumberThisUserFromCache();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                new Image.asset(
                                    "assets/images/icons8-export-26.png"),
                                SizedBox(
                                  width: widget.widthSpace,
                                ),
                                Text(
                                  DemoLocalization.of(context).getTransaltedValue('Logout'),
                                  style: AppTextStyle.textStyleApp,
                                ),
                              ],
                            ),
                          ),
                           SizedBox(
                        height: widget.heightspace + 15.0,
                      ),
                          // SizedBox(
                          //   height: 30.0,
                          // ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 20.0, right: 15.0),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.center,
                                crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset(
                                          'assets/images/icons8-facebook-old-24.png'),
                                      SizedBox(width: 10.0),
                                      Image.asset(
                                          'assets/images/icons8-play-button-24.png'),
                                      SizedBox(width: 10.0),
                                      Image.asset(
                                          'assets/images/icons8-twitter-30.png'),
                                      SizedBox(width: 10.0),
                                      Image.asset(
                                          'assets/images/icons8-instagram-24.png'),
                                    ],
                                  ),
                                  SizedBox(height: 15.0),
                                  Text(DemoLocalization.of(context).getTransaltedValue('Terms & Conditions')),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      });
    });
  }
}
