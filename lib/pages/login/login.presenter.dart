


import 'dart:async';

import 'package:clean_data/base/architechture.dart';
import 'package:clean_data/services/logger.service.dart';
import 'package:clean_data/usecase/user_auth_use_case.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:livingsmart_app/config/constants.dart';
import 'package:livingsmart_app/services/navigator.service.dart';

class LoginPresenter extends CleanPresenter {
 TextEditingController email =  TextEditingController();
 TextEditingController password =  TextEditingController();
 UserAuthUseCase userAuthUseCase;
 bool isHidePass = true;
 GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

 LoginPresenter(CleanPageState<CleanPresenter> cleanPageState)
      : super(cleanPageState);

  @override
  void onViewInit() {
    // TODO: implement onViewInit
    this.userAuthUseCase=GetIt.I.get<UserAuthUseCase>();
    //MStore
    // this.email.text="00000000002";
    // this.password.text="12345678";

    //Driver
    this.email.text="00000000003";
    this.password.text="12345678";

    //User
    // this.email.text="09493169481";
    // this.password.text="12345678";
  }
  void mobileLogin() async{
    try {
      Constants.instance.session = await userAuthUseCase.mobileLogin(email.text, password.text, true, Constants.instance.fcmToken);
      if(Constants.instance.session != null){
        if(Constants.instance.session.user.role == "mstore"){
          NavigatorService.instance.toMStore(context);
        }else if(Constants.instance.session.user.role == "rider"){
          NavigatorService.instance.toDriverDashboard(context);
        }else{
          NavigatorService.instance.toDashboardPR(context);
        }
      }
    }on DioError catch (e) {
       switch (e.type) {
        case DioErrorType.CONNECT_TIMEOUT:
          scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: Text("No Internet Connection available"),
            ),
          );
          break;
        case DioErrorType.RESPONSE:
          scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: Text("Authentication Failed"),
            ),
          );
          break;
        default:
          scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: Text("Unable to process this request at this time"),
            ),
          );
          break;
      }
    }
  }

  void login()async{
    try {
      Constants.instance.session = await userAuthUseCase.login(email.text, password.text, true);
      if(Constants.instance.session != null){
        NavigatorService.instance.toDashboardPR(context);
      }
    }on DioError catch (e) {
       switch (e.type) {
        case DioErrorType.CONNECT_TIMEOUT:
          scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: Text("No Internet Connection available"),
            ),
          );
          break;
        case DioErrorType.RESPONSE:
          scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: Text("Authentication Failed"),
            ),
          );
          break;
        default:
          scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: Text("Unable to process this request at this time"),
            ),
          );
          break;
      }
    }
  }


  @override
  // TODO: implement streamControllers
  List<StreamController> get streamControllers => null;
}





