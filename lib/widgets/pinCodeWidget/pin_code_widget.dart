import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:primaxproject/model/api_response.dart';
import 'package:primaxproject/model/check_pin_model.dart';
import 'package:primaxproject/model/resend_pin_code_model.dart';
import 'package:primaxproject/res/sizeconfig.dart';
import 'package:primaxproject/res/textsytlewidget/text_style.dart';
import 'package:primaxproject/res/themeApp/themeprimax.dart';
import 'package:primaxproject/services/app_services.dart';
import 'package:primaxproject/widgets/common_widget/common_widget.dart';
import '../widgets.dart';

class SendPinCodeWidget extends StatefulWidget {
  TextEditingController addPinCode = TextEditingController();
  TextEditingController resendPinCode = TextEditingController();
  String idOperator;
  String mobileNumber;
  SendPinCodeWidget(
      {Key key, String idOperator, String mobileNumber, String dropDownValue})
      : this.idOperator = idOperator,
        this.mobileNumber = mobileNumber,
        super(key: key);

  @override
  _SendPinCodeWidgetState createState() => _SendPinCodeWidgetState();
}

class _SendPinCodeWidgetState extends State<SendPinCodeWidget> {
  APIResponse<CheckPinModel> _apiResponse;
  APIResponse<ResendPinCodeModel> _apiResponseForResendPinCodeAgain;
  AppServices get service => GetIt.I<AppServices>();
  bool _isLoading = false;
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  // }

  _fetchPinCodeWhenUserInsertRightPin(String pinCode) async {
    setState(() {
      _isLoading = true;
    });

    //MARK:- case if operatorId is 1 become monida else become tpay
    widget.idOperator != '1'
        ? _apiResponse = await service.checkPinCodeInTheCasePinSendToUser(
            'http://hedaaya.com/api/',
            'checkPin',
            widget.mobileNumber,
            widget.idOperator,
            pinCode)
        : _apiResponse = await service.checkPinCodeInTheCasePinSendToUser(
            'http://hedaaya.com/test/mondia/',
            'checkPin',
            widget.mobileNumber,
            widget.idOperator,
            pinCode);

    setState(() {
      _isLoading = false;
    });
  }

  _resendAgainPinCode() async {
    setState(() {
      _isLoading = true;
    });

    //MARK:- case if operatorId is 1 become monida else become tpay
    widget.idOperator != '1'
        ? _apiResponseForResendPinCodeAgain =
            await service.resendPinCodeInTheCasePinNotSendToUser(
            'http://hedaaya.com/api/',
            'resendPinCode',
            widget.mobileNumber,
            widget.idOperator,
          )
        : _apiResponseForResendPinCodeAgain =
            await service.resendPinCodeInTheCasePinNotSendToUser(
            'http://hedaaya.com/test/mondia/',
            'resendPinCode',
            widget.mobileNumber,
            widget.idOperator,
          );

    setState(() {
      _isLoading = false;
    });
  }

  void navigatePage() {
    DisplayMessage.displayToast('Verified');

    Navigator.push(
      context,
      MyCustomRoute(
        widgetBuilder: (context) => HomePage(
          userId: _apiResponse?.data?.user?.userId,
          mobileNumber: widget.mobileNumber,
          operatorCode: widget.idOperator,
        ),
        // DrawerContent(mobileNumber: widget.mobileNumber, operatorCode: widget.idOperator,),
      ),
    );
  }

  startTime() async {
    var _duration = Duration(seconds: 2);
    return Timer(_duration, navigatePage);
  }

  @override
  Widget build(BuildContext context) {
    print(widget.mobileNumber);
    return Scaffold(
      backgroundColor: Colors.black,
      body: LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        SizeConfigs().init(constraints, orientation);
        return Container(
          // color: Colors.red,
          // width: MediaQuery.of(context).size.width * 1.0,
          // height: MediaQuery.of(context).size.height * 0.5,
          width: SizeConfigs.screenWidth,
          height: SizeConfigs.screenHeight * 0.83,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
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
                        filter: ImageFilter.blur(sigmaX: 1, sigmaY: 2),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                // height: SizeConfig.safeBlockVertical * 7,
                                decoration: BoxDecoration(
                                  color: AppColorsStyle.boxDecorationColor,
                                  borderRadius: new BorderRadius.circular(
                                      1.0 * SizeConfigs.heightMultiplier),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 2.0 * SizeConfigs.widthMultiplier,
                                      right:
                                          2.0 * SizeConfigs.widthMultiplier,
                                      top:
                                          0.5 * SizeConfigs.heightMultiplier),
                                  child: TextFormField(
                                    controller: widget.addPinCode,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter some text';
                                      }
                                    },
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    autofocus: false,
                                    decoration: InputDecoration(
                                      hintText: 'Inser Pin Code',
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: SizeConfigs.screenHeight * 0.16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 180,
                    height: 50,
                    child: RaisedButton(
                      onPressed: () {
                        if (widget.addPinCode.text == '' ||
                            widget.addPinCode.text.isEmpty) {
                          // MARK:- will display toast message
                          DisplayMessage.displayToast(
                              'Please insert your pin code');
                        } else {
                          setState(() {
                            _fetchPinCodeWhenUserInsertRightPin(
                                widget.addPinCode.text);
                          });

                          // Navigator.pop(context);
                          startTime();
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Verify',
                            style: AppTextStyle.colorButtonSubscription,
                          ),
                        ],
                      ),
                      color: AppColorsStyle.commoncolor,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadiusDirectional.circular(10.0),
                          side: BorderSide(color: Colors.transparent)),
                    ),
                  ),
                  SizedBox(width: 15.0),
                  Container(
                    width: 180,
                    height: 50,
                    child: RaisedButton(
                      onPressed: () {
                        // if (widget.addPinCode.text == '' ||
                        //     widget.addPinCode.text.isEmpty) {
                        //   DisplayMessage.displayToast(
                        //       'Please insert your pin code again');

                        // } else {

                        // }
                        setState(() {
                          _resendAgainPinCode();
                        });
                        // startTime();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'resend Code',
                            style: AppTextStyle.colorButtonSubscription,
                          ),
                        ],
                      ),
                      color: AppColorsStyle.commoncolor,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadiusDirectional.circular(10.0),
                          side: BorderSide(color: Colors.transparent)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      });
    }));
  }
}
