








import 'dart:async';
import 'package:clean_data/base/architechture.dart';
import 'package:clean_data/usecase/user_auth_use_case.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:livingsmart_app/services/navigator.service.dart';

class ForgotPresenter extends CleanPresenter {

 UserAuthUseCase userAuthUseCase;
 TextEditingController emailT = new TextEditingController();
 TextEditingController passwordT = new TextEditingController();
 TextEditingController rpasswordT = new TextEditingController();
 TextEditingController pinT = new TextEditingController();
 TabController tabController;
 int tab = 0;

 GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

 ForgotPresenter(CleanPageState<CleanPresenter> cleanPageState)
      : super(cleanPageState);
  @override
  void onViewInit() {
    this.userAuthUseCase=GetIt.I.get<UserAuthUseCase>();
    tabController = new TabController(vsync: this.cleanPageState, length: 2);
  }
  navigateTab(int tab){
    this.tab=tab;
    tabController.animateTo(tab);
  }

  restPasswordPre(){
    if(this.emailT.text.length > 0){
      this.resetPassword();
    }
  }

  resetPassword() async{
      try {
        var response = await userAuthUseCase.forgotPasswordEmail(this.emailT.text);
        if(response != null){
          this.navigateTab(1);
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
            print(e.response.toString());
            scaffoldKey.currentState.showSnackBar(
              SnackBar(
                content: Text(e.response.data["message"].toString()),
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

  resetPasswordAuth() async{
      try {
        int pin = int.parse(this.pinT.text);
        var response = await userAuthUseCase.restPassword(this.emailT.text, this.passwordT.text, this.rpasswordT.text, pin);
        scaffoldKey.currentState.showSnackBar(
              SnackBar(
                content: Text("Password Changed"),
              ),
        );
        Timer(Duration(milliseconds: 2000),(){
          NavigatorService.instance.toLoginPagePR(context);
        });
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
            print(e.response.toString());
            scaffoldKey.currentState.showSnackBar(
              SnackBar(
                content: Text(e.response.data["message"].toString()),
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
  List<StreamController> get streamControllers => null;

}








