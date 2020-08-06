



import 'package:clean_data/model/cart.dart';
import 'package:clean_data/model/product.dart';
import 'package:clean_data/model/user_session.dart';
import 'package:clean_data/model/userstore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Constants{
  String baseURL = "http://ec2-54-254-243-70.ap-southeast-1.compute.amazonaws.com:8000";
  String noImageDefault = "https://nerdreactor.com/wp-content/uploads/2017/09/490bcbdfb730adb3dbcf33cd9301622e-thor-avengers-loki-thor.jpg";
  GlobalKey<ScaffoldState> parentScaffoldKey;
  String appVersion = "1.0.0";
  static Constants instance=new Constants();
  UserSessionData session;
  List<Product> globalItems = [];
  List<LivingSmartStores> allStoreList = [];
  List<CartStore> cartStores = [];

  String cartItemHeader="";
  int cartStoreId = 0;
  int selectedProdId = 0;
  int selectedStoreId = 0;
  String currency = "PHP";

}