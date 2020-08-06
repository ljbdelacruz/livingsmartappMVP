








import 'dart:async';
import 'package:clean_data/base/architechture.dart';
import 'package:clean_data/usecase/user_auth_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

class ForgotPresenter extends CleanPresenter {

 TextEditingController phoneNumber = new TextEditingController();
 GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

 ForgotPresenter(CleanPageState<CleanPresenter> cleanPageState)
      : super(cleanPageState);
  @override
  void onViewInit() {
  }

  resetPassword(){
    
  }

  @override
  // TODO: implement streamControllers
  List<StreamController> get streamControllers => null;

}








