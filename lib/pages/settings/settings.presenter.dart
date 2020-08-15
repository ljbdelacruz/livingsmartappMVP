





import 'dart:async';

import 'package:clean_data/base/architechture.dart';
import 'package:clean_data/model/user_session.dart';
import 'package:flutter/material.dart';
import 'package:livingsmart_app/config/constants.dart';

class SettingsPresenter extends CleanPresenter {
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  SettingsPresenter(CleanPageState<CleanPresenter> cleanPageState) : super(cleanPageState);
  @override
  void onViewInit() {
    // TODO: implement onViewInit
  }

  @override
  // TODO: implement streamControllers
  List<StreamController> get streamControllers => null;


  
}