





import 'package:clean_data/base/architechture.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:foody_ui/components/buttons/block.button.dart';
import 'package:livingsmart_app/pages/register/forgot.presenter.dart';
import 'package:foody_ui/services/appconfig.service.dart' as config;
import 'package:livingsmart_app/services/color.service.dart';
import 'package:livingsmart_app/services/navigator.service.dart';

class ForgotPage extends CleanPage {
  @override
  ForgotPageState createState() => ForgotPageState();
}

class ForgotPageState extends CleanPageState<ForgotPresenter> with SingleTickerProviderStateMixin {
  @override
  ForgotPresenter createPresenter() {
    return ForgotPresenter(this);
  }


  Widget bodyContent(){
    return SafeArea(child:Scaffold(
          // appBar:PreferredSize(preferredSize: Size.fromHeight(64), child: header()),
          body:DefaultTabController(
      length: 2,
      child:TabBarView(
        controller:presenter.tabController,
        physics: NeverScrollableScrollPhysics(),
        children:[
          enterEmailRest(),
          confirmResetPassword()
      ]) // Complete this code in the next step.
      ))
    );
  }
  Widget header(){
    return Container();
  }
  Widget confirmResetPassword(){
    return SingleChildScrollView(child: Container(
      padding:EdgeInsets.only(left:20, right:20, top:50),
      child:Column(children:[
      this.textField(presenter.passwordT, TextInputType.visiblePassword, hint:"XXXXXX", label:"Password"),
      SizedBox(height:10),
      this.textField(presenter.rpasswordT, TextInputType.visiblePassword, hint:"XXXXXX", label:"Retype Password"),
      SizedBox(height:10),
      this.textField(presenter.pinT, TextInputType.number, hint:"XXXXXX", label:"Confirmation Code"),
      SizedBox(height:30),
      BlockButtonWidget(
                        text: Text(
                          "Confirm Reset",
                          style: TextStyle(color: Theme.of(context).primaryColor),
                        ),
                        color: ColorService.primaryColor(),
                        onPressed: () {
                          // presenter.restPasswordPre();
                        },
      ),
      SizedBox(height:MediaQuery.of(context).size.height-530),
      buttons()
    ])));
  }
  Widget textField(TextEditingController controller, TextInputType keyboard, {String label="", String hint=""}){
    return TextFormField(
                        keyboardType: keyboard,
                        // onSaved: (input) => _con.user.email = input,
                        // validator: (input) => !input.contains('@') ? "Please enter a valid email" : null,
                        controller: controller,
                        decoration: InputDecoration(
                          labelText: label,
                          labelStyle: TextStyle(color: Theme.of(context).accentColor),
                          contentPadding: EdgeInsets.all(12),
                          hintText: hint,
                          hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
                          prefixIcon: Icon(Icons.alternate_email, color: Theme.of(context).accentColor),
                          border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                        ),
    );
  }

  Widget enterEmailRest(){
    return SingleChildScrollView(child: Container(
      padding:EdgeInsets.only(left:20, right:20, top:50),
      child: Column(children:[
      textField(presenter.emailT, TextInputType.emailAddress, hint:"ldelacruz@livingsmart.com", label:"Email"),
      SizedBox(height:30),
      BlockButtonWidget(
                        text: Text(
                          "Send link",
                          style: TextStyle(color: Theme.of(context).primaryColor),
                        ),
                        color: ColorService.primaryColor(),
                        onPressed: () {
                          presenter.restPasswordPre();
                        },
      ),
      SizedBox(height:MediaQuery.of(context).size.height-400),
      buttons()
    ])));
  }

  Widget buttons(){
    return Column(children:[
                        FlatButton(
                    onPressed: () {
                      // Navigator.of(context).pushReplacementNamed('/Login');
                      NavigatorService.instance.toLoginPagePR(context);
                    },
                    textColor: Theme.of(context).hintColor,
                    child: Text("Return to Login"),
                  ),
                  FlatButton(
                    onPressed: () {
                      // Navigator.of(context).pushReplacementNamed('/SignUp');
                      NavigatorService.instance.toRegisterPR(context);
                    },
                    textColor: Theme.of(context).hintColor,
                    child: Text("I Don't Have an account"),
                  ),
    ]);
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // throw UnimplementedError();
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: presenter.scaffoldKey,
        resizeToAvoidBottomPadding: false,
        body: bodyContent(),
      ),
    );
  }
  
}