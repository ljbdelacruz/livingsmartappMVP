




import 'package:flutter/material.dart';
import 'package:livingsmart_app/config/constants.dart';
import 'package:livingsmart_app/pages/cart/cart.page.dart';
import 'package:livingsmart_app/pages/cart/cartitems.page.dart';
import 'package:livingsmart_app/pages/dashboard/dashboard.page.dart';
import 'package:livingsmart_app/pages/login/login.page.dart';
import 'package:livingsmart_app/pages/mstore/mstoredashboard.page.dart';
import 'package:livingsmart_app/pages/mstore/mstoreproducts.page.dart';
import 'package:livingsmart_app/pages/product/productinfo.page.dart';
import 'package:livingsmart_app/pages/product/storeinfo.page.dart';
import 'package:livingsmart_app/pages/register/forgot.page.dart';
import 'package:livingsmart_app/pages/register/register.page.dart';

class NavigatorService{

  static NavigatorService instance = new NavigatorService();

  toLoginPage(BuildContext context){
     Navigator.push(context,MaterialPageRoute(builder: (context) => LoginPage()));
  }
  toLoginPagePR(BuildContext context){
     Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst);
     Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => LoginPage()));
  }
  toDashboard(BuildContext context){
     Navigator.push(context,MaterialPageRoute(builder: (context) => DashboardPage()));
  }
  toDashboardPR(BuildContext context){
     Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => DashboardPage()));
  }
  toRegisterPR(BuildContext context){
     Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => RegisterPage()));
  }
  toForgotPR(BuildContext context){
     Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => ForgotPage()));
  }
  toMStore(BuildContext context){
     Navigator.push(context,MaterialPageRoute(builder: (context) => MStoreDashboardPage()));
  }
  toMStorePR(BuildContext context){
     Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => MStoreDashboardPage()));
  }
  
  toMStoreProducts(BuildContext context){
     Navigator.push(context,MaterialPageRoute(builder: (context) => MStoreProductsPage()));
  }
  toMStoreProductsPR(BuildContext context){
     Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => MStoreProductsPage()));
  }

  //Cart
  toCart(BuildContext context){
     if(Constants.instance.session == null){
       this.toLoginPagePR(context);
     }else{
       Navigator.push(context,MaterialPageRoute(builder: (context) => CartPage()));
     }
  }
  toCartPR(BuildContext context){
     if(Constants.instance.session == null){
       this.toLoginPagePR(context);
     }else{
       Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => CartPage()));
     }
  }
  
  toCartItem(BuildContext context){
     if(Constants.instance.session == null){
       this.toLoginPagePR(context);
     }else{
       Navigator.push(context,MaterialPageRoute(builder: (context) => CartItemPage()));
     }
  }

  //Product Info
  toProductInfo(BuildContext context){
    Navigator.push(context,MaterialPageRoute(builder: (context) => ProductInfoPage()));
  }
  toProductInfoPR(BuildContext context){
    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => ProductInfoPage()));
  }

  toStoreInfo(BuildContext context){
    Navigator.push(context,MaterialPageRoute(builder: (context) => StoreInfoPage()));
  }
  toStoreInfoPR(BuildContext context){
    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => StoreInfoPage()));
  }


}