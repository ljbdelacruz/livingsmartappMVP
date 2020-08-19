import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:clean_data/base/architechture.dart';
import 'package:livingsmart_app/config/constants.dart';
import 'package:livingsmart_app/services/navigator.service.dart';

class SplashPresenter extends CleanPresenter {

  SplashPresenter(CleanPageState<CleanPresenter> cleanPageState)
      : super(cleanPageState);

  @override
  List<StreamController> get streamControllers => null;

  @override
  void onViewInit() {
      this.fetchUserLocation();
      Timer(Duration(milliseconds: 2550), () {
            Timer(Duration(milliseconds: 2000),(){
              // Navigator.pushReplacementNamed(context, "test1");
              NavigatorService.instance.toDashboardPR(context);
            });
      });
  }

  fetchUserLocation(){
    Constants.instance.mapService.getCurrentLocation((){
      this.getAddress();
    });
  }
  getAddress(){
    if(Constants.instance.mapService.currentPosition != null){
      Constants.instance.mapService.getAddressStringByPosition(Constants.instance.mapService.currentPosition, (address){
        cleanPageState.setState(() {});
      });
    }
  }
}
