


import 'dart:async';
import 'dart:io';

import 'package:clean_data/services/logger.service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foody_ui/services/color.service.dart';
import 'package:livingsmart_app/services/color.service.dart';
import 'package:livingsmart_app/services/route.settings.dart' as routes;
import 'package:clean_data/base/clean_app.dart';
import 'config/constants.dart';
import 'pages/splash/splash.page.dart';
import 'package:livingsmart_app/services/route.settings.dart' as config;

class LivingSmartApp extends CleanApp {

  final FirebaseMessaging _fcm = FirebaseMessaging();
  StreamSubscription iosSubscription;

  LivingSmartApp(CleanDataInstantiator dataInstantiator)
      : super(dataInstantiator);



  iosPermission(){
    if (Platform.isIOS) {
            iosSubscription = _fcm.onIosSettingsRegistered.listen((data) {
                // save the token  OR subscribe to a topic here
            });
            _fcm.requestNotificationPermissions(IosNotificationSettings());
    }
    configureFCM();
  }
  configureFCM() async{
     Constants.instance.fcmToken = await _fcm.getToken();
     LoggerService.log("FCM Token Geto!");
     LoggerService.log(Constants.instance.fcmToken);
     _fcm.configure(
          onMessage: (Map<String, dynamic> message) async {
            // LoggerService.logdata("onMessage: $message");
            // LocalPushNotifService.instance.showNotif(1, message['notification']['title'], message['notification']['body']);
        },
        onLaunch: (Map<String, dynamic> message) async {
            print("onLaunch: $message");
            // TODO optional
        },
        onResume: (Map<String, dynamic> message) async {
            print("onResume: $message");
            // TODO optional
        },
      );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    this.iosPermission();
    // SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    return MaterialApp(
      // locale: DevicePreview.of(context).locale, // <--- Add the locale
      // builder: DevicePreview.appBuilder,
      theme: ThemeData(
                      fontFamily: 'Poppins',
                      primaryColor: ColorsService.instance.lightBlue(),
                      floatingActionButtonTheme: FloatingActionButtonThemeData(elevation: 0, foregroundColor: Colors.white),
                      brightness: Brightness.light,
                      accentColor: ColorService.primaryColor(),
                      dividerColor: config.Colors().accentColor(0.1),
                      focusColor: config.Colors().accentColor(1),
                      hintColor: config.Colors().secondColor(1),
                      textTheme: TextTheme(
                        headline5: TextStyle(fontSize: 20.0, color: config.Colors().secondColor(1), height: 1.35),
                        headline4: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: config.Colors().secondColor(1), height: 1.35),
                        headline3: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600, color: config.Colors().secondColor(1), height: 1.35),
                        headline2: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700, color: config.Colors().mainColor(1), height: 1.35),
                        headline1: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w300, color: config.Colors().secondColor(1), height: 1.5),
                        subtitle1: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500, color: config.Colors().secondColor(1), height: 1.35),
                        headline6: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: config.Colors().mainColor(1), height: 1.35),
                        bodyText2: TextStyle(fontSize: 12.0, color: config.Colors().secondColor(1), height: 1.35),
                        bodyText1: TextStyle(fontSize: 14.0, color: config.Colors().secondColor(1), height: 1.35),
                        caption: TextStyle(fontSize: 12.0, color: config.Colors().accentColor(1), height: 1.35),
                      ),
                    ),
      title: 'Living Smart',
      home: SplashPage(),
      onGenerateRoute: routes.generateRoute,
      // onUnknownRoute: (settings) => MaterialPageRoute(
      //     builder: (context) => NotFoundPage(name: settings.name)),
    );
  }
}