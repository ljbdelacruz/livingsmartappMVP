



import 'package:clean_data/base/architechture.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:livingsmart_app/pages/splash/splash.presenter.dart';

class SplashPage extends CleanPage {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends CleanPageState<SplashPresenter> {
  @override
  SplashPresenter createPresenter() {
    return SplashPresenter(this);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(child: _buildLogo()),
    );
  }
  Widget _buildLogo() {
    return Container(
      margin: EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 30),
            child: Image.asset(
              "assets/images/others/logo.png",
            ),
          ),
        ],
      ),
    );
  }
}