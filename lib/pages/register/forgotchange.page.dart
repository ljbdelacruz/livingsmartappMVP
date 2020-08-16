




import 'package:clean_data/base/architechture.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:livingsmart_app/pages/register/forgot.presenter.dart';

class ForgotChangePage extends CleanPage {
  @override
  ForgotChangePageState createState() => ForgotChangePageState();
}

class ForgotChangePageState extends CleanPageState<ForgotPresenter> {
  @override
  ForgotPresenter createPresenter() {
    return ForgotPresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(child: Scaffold(
      key:presenter.scaffoldKey,
      body:SingleChildScrollView(child:Column(children:[
        this.textField(presenter.emailT, TextInputType.emailAddress),
        this.textField(presenter.emailT, TextInputType.emailAddress)
      ]))
    ));
  }


  Widget textField(TextEditingController controller, TextInputType keyboard, {String label="", String hint=""}){
    return TextFormField(
                        keyboardType: keyboard,
                        // onSaved: (input) => _con.user.email = input,
                        validator: (input) => !input.contains('@') ? "Please enter a valid email" : null,
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
  
}