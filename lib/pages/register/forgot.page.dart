





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

class ForgotPageState extends CleanPageState<ForgotPresenter> {
  @override
  ForgotPresenter createPresenter() {
    return ForgotPresenter(this);
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
        body: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: <Widget>[
            Positioned(
              top: 0,
              child: Container(
                width: config.App(context).appWidth(100),
                height: config.App(context).appHeight(37),
                decoration: BoxDecoration(color: ColorService.primaryColor()),
              ),
            ),
            Positioned(
              top: config.App(context).appHeight(37) - 120,
              child: Container(
                width: config.App(context).appWidth(84),
                height: config.App(context).appHeight(37),
                child: Text(
                  "Email to reset password",
                  style: Theme.of(context).textTheme.headline2.merge(TextStyle(color: Theme.of(context).primaryColor)),
                ),
              ),
            ),
            Positioned(
              top: config.App(context).appHeight(37) - 50,
              child: Container(
                decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.all(Radius.circular(10)), boxShadow: [
                  BoxShadow(
                    blurRadius: 50,
                    color: Theme.of(context).hintColor.withOpacity(0.2),
                  )
                ]),
                margin: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                padding: EdgeInsets.symmetric(vertical: 50, horizontal: 27),
                width: config.App(context).appWidth(88),
//              height: config.App(context).appHeight(55),
                child: Form(
                  // key: _con.loginFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        // onSaved: (input) => _con.user.email = input,
                        validator: (input) => !input.contains('@') ? "Please enter a valid email" : null,
                        decoration: InputDecoration(
                          labelText: "Email",
                          labelStyle: TextStyle(color: Theme.of(context).accentColor),
                          contentPadding: EdgeInsets.all(12),
                          hintText: 'ldelacruz@gmail.com',
                          hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
                          prefixIcon: Icon(Icons.alternate_email, color: Theme.of(context).accentColor),
                          border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                        ),
                      ),
                      SizedBox(height: 30),
                      BlockButtonWidget(
                        text: Text(
                          "Send link",
                          style: TextStyle(color: Theme.of(context).primaryColor),
                        ),
                        color: ColorService.primaryColor(),
                        onPressed: () {
                          presenter.resetPassword();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              child: Column(
                children: <Widget>[
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
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  
}