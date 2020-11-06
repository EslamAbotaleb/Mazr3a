import 'dart:ui';
import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:primaxproject/model/api_response.dart';
import 'package:primaxproject/model/checksubscription.dart';
import 'package:primaxproject/res/sizeconfig.dart';
import 'package:primaxproject/services/app_services.dart';
import 'package:primaxproject/widgets/common_widget/common_widget.dart';
import 'package:primaxproject/widgets/subscriptionwidget/subscriptionwidget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets.dart';
import 'dart:async';

Future<void> main() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var status = prefs.getBool('isLoggedIn') ?? false;
  print(status);
  runApp(MaterialApp(home: status == true ? SubscriptionScreen() : HomePage()));
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class MyCustomRoute<T> extends MaterialPageRoute<T> {
  MyCustomRoute({WidgetBuilder widgetBuilder, RouteSettings settings})
      : super(builder: widgetBuilder, settings: settings);
  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // if (settings.isInitialRoute) return child;
    //Fades between routes . if you dont want any animation ,just return child.
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}

class _SplashScreenState extends State<SplashScreen> {
  APIResponse<CheckSubscriptionModel> _checkSubscriptionResponse;
  AppServices get service => GetIt.I<AppServices>();

  void navigatePage() {
    // Navigator.push(
    //   context,
    //   // MyCustomRoute(
    //   //   widgetBuilder: (context) => SubscriptionScreen(),
    //   // ),
    //   MyCustomRoute(
    //     widgetBuilder: (context) => SubscriptionScreen(),
    //   ),
    // );
  }

  startTime() async {
    var _duration = Duration(seconds: 2);
    return Timer(_duration, navigatePage);
  }

  @override
  void initState() {
    super.initState();
    // startTime();
    // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown,DeviceOrientation.portraitUp]);

    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return OrientationBuilder(builder: (context, orientation) {
            SizeConfigs().init(constraints, orientation);
            return Container(
              width: SizeConfigs.screenWidth * 100,
              height: SizeConfigs.screenHeight * 100,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/images/fogAndMistRollOverTallEvergreenForest.jpg'),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.55),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'assets/images/primaxPresentationZainWhite01@2x.png',
                        fit: BoxFit.fill,
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Platform.isIOS
                          ? CupertinoActivityIndicator()
                          : CircularProgressIndicator(
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                  Colors.orange),
                            ),
                    ],
                  ),
                ],
              ),
            );
          });
        },
      ),
    );
  }

  void startTimer() {
    Timer(Duration(seconds: 3), () {
      // navigateUser(); //It will redirect  after 3 seconds
        checkSubscription();
      //  Navigator.pushReplacement(context,
      //     MaterialPageRoute(builder: (BuildContext context) => HomePage()));
    });
  }

  void checkSubscription() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var operatorCode = prefs.getString('operatorCode') ?? '';
    var mobileNumber = prefs.getString('mobileNumber') ?? '';
    print(operatorCode);
    print(mobileNumber);
    mobileNumber == ''
        ? Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => SubscriptionScreen()))
        : operatorCode != '1'
            ? _checkSubscriptionResponse = await service.checkSubscriptionUser(
                'http://hedaaya.com/api/',
                'chekSubscription',
                mobileNumber,
                operatorCode)
            : _checkSubscriptionResponse = await service.checkSubscriptionUser(
                'http://hedaaya.com/test/mondia/',
                'chekSubscription',
                mobileNumber,
                operatorCode);
    /*
    subscriptionStatus
      subscriper
      unsubscriper 
      pendingveritifaction
      
    */
    if (_checkSubscriptionResponse.data.subscriptionStatus == 'subscriber') {
        print('user become subscriber');

      // MARK:- user become subscriber
      // DisplayMessage.displayToast('successVerification');
 Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => HomePage()));
      // var status = prefs.getBool('isLoggedIn') ?? false;
      // print(status);
      // if (status) {
      //   print('statusistrue');
      //   Navigator.pushReplacement(context,
      //       MaterialPageRoute(builder: (BuildContext context) => HomePage()));
      // } else {
      //   print('statusisfalse');
      //   Navigator.pushReplacement(
      //       context,
      //       MaterialPageRoute(
      //           builder: (BuildContext context) => SubscriptionScreen()));
      // }
    } else  if (_checkSubscriptionResponse.data.subscriptionStatus == 'unsubscriber') {
      print('user unsubscriber');
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => SubscriptionScreen()));
    } else if (_checkSubscriptionResponse.data.subscriptionStatus =='pendingVerification') {
      print('user pendingVerification');

      //MARK:- user in step pending vertifcation
      DisplayMessage.displayToast(
          'pending Verification, subscribe again');

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => SubscriptionScreen()));

    } else if (_checkSubscriptionResponse.data.statusMessage == 'Invalid MSISDN.') {
      DisplayMessage.displayToast('Please insert valid phone number');

    } else{
      print("gkeropgeuoregjerjgeijgerjerigjreig");
      print(_checkSubscriptionResponse.data.statusMessage);
       Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => SubscriptionScreen()));
    }
    // else if (_checkSubscriptionResponse.data.statusMessage ==
    //     'User not exists.') {
    //   Navigator.pushReplacement(
    //       context,
    //       MaterialPageRoute(
    //           builder: (BuildContext context) => SubscriptionScreen()));
    // // } 
    // else {
    //   print('vmierhihregirhgihgirgr');
    // }
  }
}
