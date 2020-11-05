

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:primaxproject/localization/demo_localization.dart';
import 'package:primaxproject/localization/localization_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'services/app_services.dart';
import 'widgets/splashwidget/splashScreen.dart';

void setupLocator() {
  GetIt.I.registerLazySingleton(() => AppServices());
}

void main() {
  setupLocator();
  runApp(new MyApp());
}


class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(locale);
  }


//   static Future<Locale> getLocale() async {
//   SharedPreferences _prefs = await SharedPreferences.getInstance();
//   String languageCode = _prefs.getString(prefSelectedLanguageCode) ?? "en";
//   return locale(languageCode);
// }

// static Locale locale(String languageCode) {
//   return languageCode != null && languageCode.isNotEmpty
//       ? Locale(languageCode, '')
//       : Locale('en', '');
// }
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }
 @override
 void didChangeDependencies() {
   getLocale().then((locale) {
     setState((){
       this._locale = locale;
     });
   });
   super.didChangeDependencies();
   
 }
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
            theme: ThemeData.dark(),


      title: 'Primax',
      locale: _locale,
      supportedLocales: [Locale('en', 'US'), Locale('ar', 'SA')],
      localizationsDelegates: [
        const DemoLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      
      localeResolutionCallback: (deviceLocal, supportedLocales) {

        
        for (var local in supportedLocales) {
          if (local.languageCode == deviceLocal.languageCode && local.countryCode == deviceLocal.countryCode) {
            return deviceLocal;
          }
        }
        return supportedLocales.first;
      },
      home: new MyHomePage(),
    );
  }
  
}

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Text(''
//  DemoLocalization.of(context).getTransaltedValue('hello_world')
            ),
      ),
    );
  }
}
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashScreen(),
    );
  }
}
