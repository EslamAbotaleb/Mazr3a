import 'package:flutter/material.dart';

import '../sizeconfig.dart';
// 4.0 * SizeConfigs.textMultiplier
class AppTextStyle {
  static const textStyleheaderApp = TextStyle(color: Color.fromRGBO(255, 255, 255, 1.0,),height: 2.0, fontSize: 16,fontFamily: 'NunitoSans');
  static const textStyleApp = TextStyle(color: Color.fromRGBO(255, 255, 255, 1.0,),height: 1.3, fontSize: 16);
    static var textCardStyle = TextStyle(color: Color.fromRGBO(255, 255, 255, 1.0,),height: 1.4, fontSize: 14.0);

  static const titleAppBarColor = TextStyle(color: Color.fromRGBO(255, 191, 0, 1.0),);
    static const titleStyleHeaderSectionSearchBar = TextStyle(fontSize: 22 ,color: Colors.white,fontFamily: 'NunitoSans',fontWeight: FontWeight.bold, letterSpacing: 2);
  static const titleStyleHeaderSectionHome = TextStyle(fontSize: 30 ,color: Colors.white,fontFamily: 'NunitoSans',fontWeight: FontWeight.bold, letterSpacing: 2);
  static const subTitleStyleHeaderSectionHome = TextStyle(color: Color.fromRGBO(119, 119, 119, 1.0), fontFamily: 'NunitoSans-Reguar', fontSize: 15,);

  static const titleWithUnderline = TextStyle(
    color: Color.fromRGBO(255, 191, 0, 1.0,),
    letterSpacing: 2.1,
  fontFamily: 'NunitoSans-Regular', fontSize: 15,
  decoration: TextDecoration.underline
  
  );
  static const textStyleColorSubscription = TextStyle(color: Color.fromRGBO(255, 255, 255, 0.5), fontFamily: 'NunitoSans-Regular', fontSize: 15);
  static const textloggedInStyleColorSubscription = TextStyle(color: Color.fromRGBO(255, 255, 255, 1.0), fontFamily: 'NunitoSans',fontWeight: FontWeight.bold);
  static const textStylefortermsSubscription = TextStyle(color: Color.fromRGBO(255, 255, 255, 1.0), fontFamily: 'NunitoSans-Regular', fontSize: 14);
  static const colorButtonSubscription = TextStyle(color: Color.fromRGBO(30, 30, 30, 1.0), fontFamily: 'NunitoSans-Bold',fontWeight: FontWeight.bold, fontSize: 17,);
}