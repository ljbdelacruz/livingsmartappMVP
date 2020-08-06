




import 'dart:async';

import 'package:clean_data/base/architechture.dart';
import 'package:clean_data/model/cart.dart';
import 'package:clean_data/usecase/customer_use_case.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:livingsmart_app/config/constants.dart';

class CartPresenter extends CleanPresenter {
 CustomerUseCase customerUseCase;
 GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
 List<CartStore> storeCarts = [];
 int storeIdSelected=0;
 String cartItemHeader;
 int storeCartId = 0;
 List<CartStoreItem> cartStoreItems = []; 

 CartPresenter(CleanPageState<CleanPresenter> cleanPageState)
      : super(cleanPageState);

  @override
  void onViewInit() {
    // TODO: implement onViewInit
    this.customerUseCase = GetIt.I.get<CustomerUseCase>();
    this.storeCarts=Constants.instance.cartStores;
    this.cartItemHeader=Constants.instance.cartItemHeader;
    this.storeCartId=Constants.instance.cartStoreId;
    if(this.cartItemHeader.length > 0){
      this.fetchStoreCartItems();
    }
    this.fetchStoreCart();
  }

  fetchStoreCart() async{
    try{
      Constants.instance.cartStores = await this.customerUseCase.getCartStores();
      cleanPageState.setState(() {
        this.storeCarts=Constants.instance.cartStores;
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
          scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: Text("Unable to fetch data"),
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

  removeStoreCart(int index, int storeId) async{
    try{
      var response = await customerUseCase.deleteCart(storeId);
      print(response.data.toString());
      this.storeCarts.removeAt(index);
      cleanPageState.setState(() {});
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
          scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: Text("Unable to remove cart"),
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

  fetchStoreCartItems() async{
    try{
      this.cartStoreItems = await customerUseCase.getCartStoreProducts(this.storeCartId);
      cleanPageState.setState(() {});
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
          scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: Text("Unable to remove cart"),
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
  increment(CartStoreItem item){
    cleanPageState.setState((){
      if(item.quantity < item.stock_count){
        item.quantity++;
      }
    });
  }
  decrement(CartStoreItem item){
    cleanPageState.setState((){
      if(item.quantity > 1){
        item.quantity--;
      }
    });
  }
  removeCartStoreItem(int prodId, int index) async{
    try{
      var response = await customerUseCase.removeProductFromCart(Constants.instance.cartStoreId, prodId);
      print(response.data.toString());
      cleanPageState.setState(() { 
        this.cartStoreItems.removeAt(index);
        print("Cart items");
        print(this.cartStoreItems.length);
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
          scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: Text("Unable to remove item"),
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


  double calculatePrice(){
    double total = 0;
    cartStoreItems.forEach((element) { 
      if(double.parse(element.discounted_price) != 0){
        total+=(double.parse(element.discounted_price) * element.quantity.toDouble()); 
      }else{
        total+=(double.parse(element.price) * element.quantity.toDouble()); 
      }
    });
    return total;
  }

  @override
  // TODO: implement streamControllers
  List<StreamController> get streamControllers => null;

}