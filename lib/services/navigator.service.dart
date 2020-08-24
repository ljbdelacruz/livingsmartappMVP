




import 'package:flutter/material.dart';
import 'package:foody_ui/typdef/mytypedef.dart';
import 'package:geolocator/geolocator.dart';
import 'package:livingsmart_app/config/constants.dart';
import 'package:livingsmart_app/pages/address/addaddress.page.dart';
import 'package:livingsmart_app/pages/address/deliveryaddress.page.dart';
import 'package:livingsmart_app/pages/address/selectaddress.page.dart';
import 'package:livingsmart_app/pages/cart/cart.page.dart';
import 'package:livingsmart_app/pages/cart/cartitems.page.dart';
import 'package:livingsmart_app/pages/cart/confirmcheckout.page.dart';
import 'package:livingsmart_app/pages/dashboard/dashboard.page.dart';
import 'package:livingsmart_app/pages/delivery/deliveryactivity.page.dart';
import 'package:livingsmart_app/pages/direction/mapdirection.page.dart';
import 'package:livingsmart_app/pages/driver/driverdashboard.page.dart';
import 'package:livingsmart_app/pages/driver/driverdirection.page.dart';
import 'package:livingsmart_app/pages/login/login.page.dart';
import 'package:livingsmart_app/pages/mstore/cancelorder.page.dart';
import 'package:livingsmart_app/pages/mstore/mstoreTransactionInfo.page.dart';
import 'package:livingsmart_app/pages/mstore/mstoredashboard.page.dart';
import 'package:livingsmart_app/pages/mstore/mstoreproducts.page.dart';
import 'package:livingsmart_app/pages/mstore/mstoretransactions.page.dart';
import 'package:livingsmart_app/pages/product/productinfo.page.dart';
import 'package:livingsmart_app/pages/product/storeinfo.page.dart';
import 'package:livingsmart_app/pages/productsearch/productsearch.page.dart';
import 'package:livingsmart_app/pages/productsearch/productsearchstore.page.dart';
import 'package:livingsmart_app/pages/register/forgot.page.dart';
import 'package:livingsmart_app/pages/register/register.page.dart';
import 'package:livingsmart_app/pages/settings/settings.page.dart';
import 'package:livingsmart_app/pages/transaction/transactioninfo.page.dart';

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
     Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst);
     Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => DashboardPage()));
  }

  toSearchProduct(BuildContext context){
     Navigator.push(context,MaterialPageRoute(builder: (context) => ProductSearchPage()));
  }
  toSearchProductStore(BuildContext context){
     Navigator.push(context,MaterialPageRoute(builder: (context) => ProductSearchStorePage()));
  }

  //Map Direction
  toMapDirection(BuildContext context){
    Navigator.push(context,MaterialPageRoute(builder: (context) => MapDirectionPage()));
  }
  toTransactionInfo(BuildContext context){
    Navigator.push(context,MaterialPageRoute(builder: (context) => TransactionInfoPage()));
  }


  toRegisterPR(BuildContext context){
     Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => RegisterPage()));
  }
  toForgotPR(BuildContext context){
     Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => ForgotPage()));
  }
  //MStore
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
  toMStoreTransactions(BuildContext context){
     Navigator.push(context,MaterialPageRoute(builder: (context) => MStoreTransactionsPage()));
  }
  toMStoreTransactionsPR(BuildContext context){
     Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => MStoreTransactionsPage()));
  }
  toMStoreTransactionInfo(BuildContext context){
     Navigator.push(context,MaterialPageRoute(builder: (context) => MStoreTransactionInfoPage()));
  }
  toMStoreTransactionInfoPR(BuildContext context){
     Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => MStoreTransactionInfoPage()));
  }
  toMStoreCancelOrderPR(BuildContext context, GetStringData cancel){
     Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => CancelOrderPage(cancel)));
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

  toConfirmCheckout(BuildContext context){
    Navigator.push(context,MaterialPageRoute(builder: (context) => ConfirmCheckoutPage()));
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

  //Settings 
  toSettings(BuildContext context){
     if(Constants.instance.session == null){
       this.toLoginPagePR(context);
     }else{
    Navigator.push(context,MaterialPageRoute(builder: (context) => SettingsPage()));
     }
  }
  toSettingsPR(BuildContext context){
    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => SettingsPage()));
  }

  //Addresses
  toDeliveryAddress(BuildContext context){
    Navigator.push(context,MaterialPageRoute(builder: (context) => DeliveryAddressPage()));
  }
  toAddAddress(BuildContext context){
    Navigator.push(context,MaterialPageRoute(builder: (context) => AddAddressPage()));
  }
  toSelectAddress(BuildContext context, List<Placemark> address, GetIntData selected){
    Navigator.push(context,MaterialPageRoute(builder: (context) => SelectAddressPage(address, selected)));
  }

  //Delivery
  toDeliveryInfo(BuildContext context){
    Navigator.push(context,MaterialPageRoute(builder: (context) => DeliveryActivityPage()));
  }


  //Driver 
  toDriverDashboard(BuildContext context){
    Navigator.push(context,MaterialPageRoute(builder: (context) => DriverDashboardPage()));
  }
  toDriverDirection(BuildContext context){
    Navigator.push(context,MaterialPageRoute(builder: (context) => DriverDirectionPage()));
  }
  


}