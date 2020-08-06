import 'package:clean_data/base/architechture.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:livingsmart_app/pages/login/login.presenter.dart';
import 'package:livingsmart_app/services/color.service.dart';
import 'package:foody_ui/components/buttons/block.button.dart';
import 'package:foody_ui/services/appconfig.service.dart' as config;
import 'package:livingsmart_app/services/navigator.service.dart';

class LoginPage extends CleanPage {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends CleanPageState<LoginPresenter> {
  @override
  LoginPresenter createPresenter() {
    return LoginPresenter(this);
  }

  @override
  void initState() { 
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
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
                "Let\'s Start with Login!",
                style: Theme.of(context).textTheme.headline2.merge(TextStyle(color: Theme.of(context).primaryColor)),
              ),
            ),
          ),
          Positioned(
            top: config.App(context).appHeight(37) - 50,
            child: Container(
              decoration: BoxDecoration(color: ColorService.secondaryColor(), borderRadius: BorderRadius.all(Radius.circular(10)), boxShadow: [
                BoxShadow(
                  blurRadius: 50,
                  color: Theme.of(context).hintColor.withOpacity(0.2),
                )
              ]),
              margin: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              padding: EdgeInsets.only(top: 50, right: 27, left: 27, bottom: 20),
              width: config.App(context).appWidth(88),
//              height: config.App(context).appHeight(55),
              child: Form(
                // key: _con.loginFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      controller: presenter.email,
                      keyboardType: TextInputType.emailAddress,
                      // onSaved: (input) => _con.user.email = input,
                      validator: (input) => !input.contains('@') ? "Enter Valid Email" : null,
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(color: Theme.of(context).accentColor),
                        contentPadding: EdgeInsets.all(12),
                        hintText: 'livingsmart@gmail.com',
                        hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
                        prefixIcon: Icon(Icons.alternate_email, color: Theme.of(context).accentColor),
                        border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                      ),
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      controller:presenter.password,
                      keyboardType: TextInputType.text,
                      // onSaved: (input) => _con.user.password = input,
                      validator: (input) => input.length < 3 ? "Password should be more than 3 length" : null,
                      obscureText: presenter.isHidePass,
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(color: Theme.of(context).accentColor),
                        contentPadding: EdgeInsets.all(12),
                        hintText: '••••••••••••',
                        hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
                        prefixIcon: Icon(Icons.lock_outline, color: Theme.of(context).accentColor),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              presenter.isHidePass = !presenter.isHidePass;
                            });
                          },
                          color: Theme.of(context).focusColor,
                          icon: Icon(presenter.isHidePass ? Icons.visibility : Icons.visibility_off),
                        ),
                        border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                      ),
                    ),
                    SizedBox(height: 30),
                    BlockButtonWidget(
                      text: Text(
                        "LOGIN",
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                      color: ColorService.primaryColor(),
                      onPressed: () {
                        //TODO: Login
                        presenter.login();
                      },
                    ),
                    SizedBox(height: 15),
                    FlatButton(
                      onPressed: () {
                        NavigatorService.instance.toDashboard(context);
                      },
                      shape: StadiumBorder(),
                      textColor: Theme.of(context).hintColor,
                      child: Text("Skip"),
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                    ),
//                      SizedBox(height: 10),
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
                    // Navigator.of(context).pushReplacementNamed('/ForgetPassword');
                    NavigatorService.instance.toForgotPR(context);
                  },
                  textColor: Theme.of(context).hintColor,
                  child: Text("Forgot Password"),
                ),
                FlatButton(
                  onPressed: () {
                    // Navigator.of(context).pushReplacementNamed('/SignUp');
                    NavigatorService.instance.toRegisterPR(context);
                  },
                  textColor: Theme.of(context).hintColor,
                  child: Text("Don't Have an account"),
                ),
              ],
            ),
          )
        ],
      ),
    );
    // return SafeArea(child: Scaffold(body:Container(child:Text("Login Page", style:TextStyle(color:Colors.black)))));
  }


}