import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:primaxproject/model/api_response.dart';
import 'package:primaxproject/model/operator_subsription_model.dart';
import 'package:primaxproject/res/sizeconfig.dart';
import 'package:primaxproject/res/textsytlewidget/text_style.dart';
import 'package:primaxproject/res/themeApp/themeprimax.dart';
import 'package:primaxproject/services/app_services.dart';
import 'package:primaxproject/widgets/splashwidget/splashScreen.dart';
import 'package:primaxproject/widgets/subscriptionwidget/subscriptionwidget.dart';

class SelectOperatorPage extends StatefulWidget {
  SelectOperatorPage({Key key}) : super(key: key);

  @override
  _SelectOperatorPageState createState() => _SelectOperatorPageState();
}

class _SelectOperatorPageState extends State<SelectOperatorPage> {
  APIResponse<OperatorSubscriptionModel> _apiResponseTpay;
  APIResponse<OperatorSubscriptionModel> _apiResponseMondiaMedia;
  AppServices get service => GetIt.I<AppServices>();
  bool _isLoading = false;
  String _selectedOperator = 'Please choose a operator';
  List<String> operatorsName = List();
  String idOperator;
  String country_code;
  String dcb;
  // maybe will define one array to append tpay & mondiamedia
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

  String dropdownValue = 'STC';

  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
      backgroundColor: Color.fromRGBO(10, 10, 10, 1.0),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                color: Color.fromRGBO(10, 10, 10, 1.0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: DropdownButton<String>(
                      value: dropdownValue,
                      icon: Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.white),
                      underline: Container(
                        height: 2,
                        color: Colors.orange,
                      ),
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownValue = newValue;
                        });
                        dropdownValue == 'Vodafone' ?
                        dcb = 'mondia'
                        : 
                        dcb =  'tpay';
                      },
                      selectedItemBuilder: 
                            (BuildContext context) {
                              return _apiResponseTpay.data.results.map((item) {
                        idOperator = item.operatorCode;
                        country_code = item.countryCode;
                          
                        return DropdownMenuItem(
                          child: Text(item.resultOperator + '   ' + item.country),
                          value: item.resultOperator,
                        );
                      }).toList();  
                       },
                      items: _apiResponseTpay?.data?.results?.map((item) {
                        idOperator = item.operatorCode;
                        country_code = item.countryCode;
                          
                        return DropdownMenuItem(
                          child: Text(item.resultOperator + '   ' + item.country),
                          value: item.resultOperator,
                        );
                      })?.toList()
                      ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  left: 2.5 * SizeConfigs.widthMultiplier,
                  right: 2.5 * SizeConfigs.widthMultiplier),
              constraints: BoxConstraints(
                minHeight: 6.9 * SizeConfigs.heightMultiplier,
                maxHeight: 7.9 * SizeConfigs.heightMultiplier,
              ),
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MyCustomRoute(

                      widgetBuilder: (context) => SubscriptionScreen(idOperator: this.idOperator, country_code: this.country_code,dcb: this.dcb),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Continue',
                      style: AppTextStyle.colorButtonSubscription,
                    ),
                    SizedBox(width: 10.0),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: 0.4 * SizeConfigs.heightMultiplier),
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.black,
                        size: 3.4 * SizeConfigs.heightMultiplier,
                      ),
                    ),
                  ],
                ),
                color: AppColorsStyle.commoncolor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusDirectional.circular(10.0),
                    side: BorderSide(color: Colors.transparent)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
