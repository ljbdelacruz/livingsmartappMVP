


import 'dart:async';

import 'package:clean_data/base/architechture.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MStoreProductPresenter extends CleanPresenter {

 GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
 MStoreProductPresenter(CleanPageState<CleanPresenter> cleanPageState)
      : super(cleanPageState);
  @override
  void onViewInit() {
  }

  @override
  // TODO: implement streamControllers
  List<StreamController> get streamControllers => null;

}