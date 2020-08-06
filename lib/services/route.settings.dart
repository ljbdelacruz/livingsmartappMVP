



import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:livingsmart_app/pages/login/login.page.dart';
import './repo.service.dart' as settingRepo;


Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case "test1":
      return MaterialPageRoute(builder: (context) => LoginPage());
      break;
    default:
      return MaterialPageRoute(builder: (context) => LoginPage());
  } 
}

class Colors {
  Color mainColor(double opacity) {
    try {
      return Color(int.parse(settingRepo.setting.value.mainColor.replaceAll("#", "0xFF"))).withOpacity(opacity);
    } catch (e) {
      return Color(0xFFCCCCCC).withOpacity(opacity);
    }
  }

  Color secondColor(double opacity) {
    try {
      return Color(int.parse(settingRepo.setting.value.secondColor.replaceAll("#", "0xFF"))).withOpacity(opacity);
    } catch (e) {
      return Color(0xFFCCCCCC).withOpacity(opacity);
    }
  }

  Color accentColor(double opacity) {
    try {
      return Color(int.parse(settingRepo.setting.value.accentColor.replaceAll("#", "0xFF"))).withOpacity(opacity);
    } catch (e) {
      return Color(0xFFCCCCCC).withOpacity(opacity);
    }
  }

  Color scaffoldColor(double opacity) {
    // TODO test if brightness is dark or not
    try {
      return Color(int.parse(settingRepo.setting.value.scaffoldColor.replaceAll("#", "0xFF"))).withOpacity(opacity);
    } catch (e) {
      return Color(0xFFCCCCCC).withOpacity(opacity);
    }
  }
}