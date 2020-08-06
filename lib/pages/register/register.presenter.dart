








import 'dart:async';
import 'package:clean_data/base/architechture.dart';
import 'package:clean_data/model/user_session.dart';
import 'package:clean_data/usecase/registration_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:livingsmart_app/services/navigator.service.dart';

class RegisterPresenter extends CleanPresenter {
 
 RegistrationUseCase registrationUseCase;
 TextEditingController email = new TextEditingController();
 TextEditingController name = new TextEditingController();
 TextEditingController password = new TextEditingController();
 TextEditingController rpassword = new TextEditingController();
 TextEditingController mobileNumber = new TextEditingController();
 bool isHidePassword = true;
 GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

 RegisterPresenter(CleanPageState<CleanPresenter> cleanPageState)
      : super(cleanPageState);

  @override
  void onViewInit() {
    // TODO: implement onViewInit
    this.registrationUseCase=GetIt.I.get<RegistrationUseCase>();
  }

  registerUser() async{
    if(this.email.text.length > 0 && this.name.text.length > 0 && this.password.text.length > 0 && this.rpassword.text == this.password.text && mobileNumber.text.length > 0){
       UserInfoSession data = await registrationUseCase.register(this.name.text, this.email.text, this.password.text, this.rpassword.text, this.mobileNumber.text);
       if(data != null){
         NavigatorService.instance.toLoginPagePR(context);
       }
    }else{
      scaffoldKey.currentState.showSnackBar(SnackBar(
              content: Text("Please fill required data"),
      ));
    }
  }


  @override
  // TODO: implement streamControllers
  List<StreamController> get streamControllers => null;

}








