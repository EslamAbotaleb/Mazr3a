import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:primaxproject/model/api_response.dart';
import 'package:primaxproject/model/checksubscription.dart';
import 'package:primaxproject/model/operator_subsription_model.dart';
import 'package:primaxproject/model/subscription_status_model.dart';
import 'package:primaxproject/model/unsubscribe_model.dart';
import 'package:primaxproject/res/sizeconfig.dart';
import 'package:primaxproject/res/textsytlewidget/text_style.dart';
import 'package:primaxproject/res/themeApp/themeprimax.dart';
import 'package:primaxproject/services/app_services.dart';
import 'package:primaxproject/widgets/common_widget/common_widget.dart';
import 'package:primaxproject/widgets/pinCodeWidget/pin_code_widget.dart';
import 'package:primaxproject/widgets/splashwidget/splashScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../alert_dialog.dart';

class SubscriptionScreen extends StatefulWidget {
  //MARK:-
  // will receive country code and id operator after user select type operator
  TextEditingController PhoneNumberUser = TextEditingController();
  String passCountry;
  String idOperator;
  String country_code;
  String dcb;
  SubscriptionScreen({
    Key key,
    String idOperator,
    String country_code,
    String dcb,
  })  : this.country_code = country_code,
        this.idOperator = idOperator,
        this.dcb = dcb,
        super(key: key);

  @override
  _SubscriptionScreenState createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  APIResponse<OperatorSubscriptionModel> _apiResponseTpay;
  APIResponse<OperatorSubscriptionModel> _apiResponseMondiaMedia;
  APIResponse<SubscriptionStatusModel> _apiResponse;
  APIResponse<CheckSubscriptionModel> _checkSubscriptionResponse;
  APIResponse<UnSubscriptionModel> _unSubscriptionResponse;

  AppServices get service => GetIt.I<AppServices>();
  bool _isLoading = false;

  // String mobileNumber;
  _fetchResultSubscribeInTheCaseMondia(String mobileNumber) async {
    setState(() {
      _isLoading = true;
    });
    _apiResponse = await service.getResultAfterSubscription(
        'http://hedaaya.com/test/mondia/',
        'subscribe',
        mobileNumber,
        // widget.idOperator
        holder);

    setState(() {
      _isLoading = false;
    });
  }

  _fetchResultSubscribeInTheCaseTpay(String mobileNumber) async {
    setState(() {
      _isLoading = true;
    });

    _apiResponse = await service.getResultAfterSubscription(
        'http://hedaaya.com/api/',
        'subscribe',
        widget.country_code + '' + mobileNumber,
        holder
        // widget.idOperator
        );

    print(holder);
    setState(() {
      _isLoading = false;
    });
  }

  // I need ( country code + mobile number ) to (one string)
  _fetchOperatorsBasedOnDcbOperator() async {
    setState(() {
      _isLoading = true;
    });
    _apiResponseTpay = await service.getTpayForGetOperatorList();
    _apiResponseMondiaMedia = await service.getMondiaMediaForGetOperatorList();
    _apiResponseTpay.data.results.addAll(_apiResponseMondiaMedia.data.results);

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchOperatorsBasedOnDcbOperator();
  }

  // String dropdownValue = 'STC';
  String operatorCode = '128';
  final _formKey = GlobalKey<FormState>();

  String holder = '';

  void displayDropDownNumbersCountryCode() {
    if (widget.PhoneNumberUser.text == '' ||
        widget.PhoneNumberUser.text.isEmpty) {
    //  DisplayMessage.displayToast('Must insert phone number');
     showDialog(
                context: context,
                builder: (_) => FunkyOverlay(),
              );
    } else {
      setState(() {
        // holder = dropdownValue;
        holder = operatorCode;
        print(widget.PhoneNumberUser.text);
        holder != '1'
            ? _fetchResultSubscribeInTheCaseTpay(widget.PhoneNumberUser.text)
            : _fetchResultSubscribeInTheCaseMondia(widget.PhoneNumberUser.text);
      });
      saveMobileNumberAndOperatorCode();
      
        DisplayMessage.displayToast('Pin code will send to your mobile');
        Navigator.push(
          context,
          MyCustomRoute(
            widgetBuilder: (context) => SendPinCodeWidget(
              mobileNumber: widget.PhoneNumberUser.text,
              idOperator: holder,
            ),
          ),
        );
      
    }
  }

  bool rememberMe = false;

  // Future _onRememberMeChanged(bool newValue) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();

  //   setState(() {
  //     rememberMe = newValue;
  //     if (rememberMe) {
  //       prefs?.setBool("isLoggedIn", true);
  //     } else {
  //       prefs?.clear();
  //     }
  //   });
  // }

  Future saveMobileNumberAndOperatorCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('mobileNumber', widget.PhoneNumberUser.text);
      // prefs.setString('operatorCode', holder);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: LayoutBuilder(builder: (context, constraints) {
          return OrientationBuilder(
            builder: (context, orientation) {
              SizeConfigs().init(constraints, orientation);
              print(SizeConfigs.isPortrait);
              return SafeArea(
                top: false,
                bottom: false,
                left: false,
                right: false,
                child: GestureDetector(
                  onTap: () {
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                  },
                  child: Container(
                    
                    color: Colors.black,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          flex: SizeConfigs.isPortrait ? 4 : 2,
                          child: Container(
                            // width: SizeConfig.blockSizeHorizontal * 100,
                            // height: SizeConfig.blockSizeVertical * 54,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/fogAndMistRollOverTallEvergreenForest.jpg'),
                                fit: BoxFit.fill,
                              ),
                            ),
                            child: Stack(
                              fit: StackFit.expand,
                              children: <Widget>[
                                BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 1, sigmaY: 2),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.62),
                                    ),
                                  ),
                                ),
                                SizeConfigs.isPortrait
                                    ? Center(
                                        child: Image.asset(
                                          'assets/images/primaxPresentationZainWhite01@2x.png',
                                          fit: BoxFit.fill,
                                        ),
                                      )
                                    : Positioned(
                                        top: 1,
                                        left: SizeConfigs.screenWidth * 0.6,
                                        child: Center(
                                          child: Image.asset(
                                            'assets/images/primaxPresentationZainWhite01@2x.png',
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 2.0 * SizeConfigs.widthMultiplier,
                                    right: 2.0 * SizeConfigs.widthMultiplier,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Color.fromRGBO(
                                                    255, 191, 0, 1.0)),
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        // color: Color.fromRGBO(10, 10, 10, 1.0),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 60,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: 
                                          DropdownButtonHideUnderline(
                                            child: DropdownButton<String>(
                                              value: operatorCode,
                                              //dropdownValue,
                                              // icon: Icon(Icons.arrow_downward),
                                              iconSize: 0,
                                              elevation: 16,
                                              style: TextStyle(
                                                  color: Colors.white),

                                              // underline: Container(
                                              //   height: 2,
                                              //   color: Colors.orange,
                                              // ),
                                              onChanged: (String newValue) {
                                                setState(() {
                                                  // dropdownValue = newValue;
                                                  print(newValue);
                                                  operatorCode = newValue;
                                                });
                                              },
                                              items: _apiResponseTpay
                                                  ?.data?.results
                                                  ?.map((item) {
                                                // this.countries_Code.add(item.countryCode);

                                                return DropdownMenuItem(
                                                  child: Text(item.countryCode +
                                                      '  ' +
                                                      item.resultOperator +
                                                      '  ' +
                                                      item.country),
                                                  value: item.operatorCode,
                                                );
                                              })?.toList(),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 1.0),
                                      // Text(
                                      //   "Mobile Number",
                                      //   style: AppTextStyle.textStyleColorSubscription,
                                      // ),
                                      SizedBox(
                                          height: 1.0 *
                                              SizeConfigs.heightMultiplier),
                                      Container(
                                          width: double.infinity,
                                          margin: new EdgeInsets.only(
                                              top: 10.0,
                                              bottom: 10.0,
                                              right: 3.0),
                                          // color: Colors.green,
                                          child: Form(
                                            key: _formKey,
                                            child: TextFormField(
                                              // initialValue: '+20',
                                              controller:
                                                  widget.PhoneNumberUser,
                                              validator: (text) {
                                                if (text == '' ||
                                                    text.isEmpty) {
                                                  return 'Text is empty';
                                                } else {}
                                                return null;
                                              },
                                              keyboardType: TextInputType
                                                  .numberWithOptions(
                                                      signed: true,
                                                      decimal: true),
                                              // TextInputType.number,
                                              decoration: new InputDecoration(
                                                contentPadding:
                                                    const EdgeInsets.all(12.0),
                                                border: new OutlineInputBorder(
                                                    borderSide: new BorderSide(
                                                        color: AppColorsStyle
                                                            .boxDecorationColor,
                                                        width: 0.1)),
                                                fillColor: Colors.red,
                                                // prefixIcon: countryDropDown,
                                                hintText:
                                                    'insert country code before mobile number ',
                                              ),
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: SizeConfigs.isPortrait ? 2 : 1,
                          child: Container(
                            // width: SizeConfig.blockSizeHorizontal * 100,
                            // height: SizeConfig.blockSizeVertical * 40,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.start,
                                //   children: <Widget>[
                                //     Checkbox(
                                //       activeColor: AppColorsStyle.commoncolor,
                                //       checkColor: Colors.black,
                                //       value: rememberMe,
                                //       onChanged: _onRememberMeChanged,
                                //     ),
                                //     Text(
                                //       "Keep me logged in",
                                //       style: AppTextStyle
                                //           .textloggedInStyleColorSubscription,
                                //     ),
                                //   ],
                                // ),
                                SizedBox(
                                    height: 7 * SizeConfigs.heightMultiplier),
                                Center(
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: 2.5 * SizeConfigs.widthMultiplier,
                                        right:
                                            2.5 * SizeConfigs.widthMultiplier),
                                    constraints: BoxConstraints(
                                      minHeight:
                                          6.5 * SizeConfigs.heightMultiplier,
                                      maxHeight:
                                          6.5 * SizeConfigs.heightMultiplier,
                                    ),
                                    child: RaisedButton(
                                      onPressed:
                                          displayDropDownNumbersCountryCode,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            'Subscription',
                                            style: AppTextStyle
                                                .colorButtonSubscription,
                                          ),
                                          SizedBox(width: 10.0),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 0.4 *
                                                    SizeConfigs
                                                        .heightMultiplier),
                                            child: Icon(
                                              Icons.arrow_forward,
                                              color: Colors.black,
                                              size: 3.4 *
                                                  SizeConfigs.heightMultiplier,
                                            ),
                                          ),
                                        ],
                                      ),
                                      color: AppColorsStyle.commoncolor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadiusDirectional.circular(
                                                  10.0),
                                          side: BorderSide(
                                              color: Colors.transparent)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: FittedBox(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    bottom: 5.8 * SizeConfigs.heightMultiplier),
                                child: FittedBox(
                                  child: Text.rich(
                                    TextSpan(
                                      text:
                                          'By signing up, you agree with our ',
                                      style: AppTextStyle
                                          .textStylefortermsSubscription,
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: 'Terms & Conditions',
                                            style: TextStyle(
                                              color: Color.fromRGBO(
                                                  255, 191, 0, 1),
                                              decoration:
                                                  TextDecoration.underline,
                                            )),
                                        // can add more TextSpans here...
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }));
  }
}
