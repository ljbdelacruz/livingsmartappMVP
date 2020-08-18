



import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:livingsmart_app/config/constants.dart';

class FirebaseRemoteConfigService{
  static FirebaseRemoteConfigService instance=FirebaseRemoteConfigService();
  RemoteConfig remoteConfig;
  FirebaseRemoteConfigService() {
    RemoteConfig.instance.then((instance){
      this.remoteConfig=instance;      
      this.fetchRemoteConfig();
    });
  }

  fetchRemoteConfig(){
    try {
      Constants.instance.fbconfig=FBRemoteConfigModel.mydefault(this.remoteConfig);
      remoteConfig.fetch(expiration: const Duration(seconds: 0)).then((value){
        remoteConfig.activateFetched().then((fetchValue){
          Constants.instance.fbconfig=FBRemoteConfigModel.mydefault(this.remoteConfig);
        });
      });
    } on Exception catch (e) {
      print(e);
    }
  }
}

class FBRemoteConfigModel{
  String appVersion;
  FBRemoteConfigModel();
  FBRemoteConfigModel.mydefault(RemoteConfig config){
    if(config.getString("ConfigKey").length > 0){
      print("Fetching Remote Config data");
      Map<String, dynamic> fbConfig = jsonDecode(config.getString("ConfigKey"));
      print(fbConfig.toString());
    }

  }
}