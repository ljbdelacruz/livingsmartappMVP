



import 'package:flutter/widgets.dart';
import 'package:livingsmart_app/services/color.service.dart';

ValueNotifier<Setting> setting = new ValueNotifier(new Setting());

Future<Setting> initSettings() async {
  Setting _setting = Setting();

  return _setting;
}


class Setting {
  String mainColor;
  String secondColor;
  String accentColor;
  String scaffoldColor;

  Setting(){
      mainColor = "052A60";
      secondColor = "ffffff";
      accentColor = "ffffff";
      scaffoldColor = "0xff052A60";
  }

}