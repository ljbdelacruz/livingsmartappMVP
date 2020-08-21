




import 'dart:async';

import 'package:clean_data/base/architechture.dart';
import 'package:clean_data/model/product.dart';
import 'package:clean_data/model/userstore.dart';
import 'package:clean_data/usecase/customer_use_case.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:livingsmart_app/config/constants.dart';
import 'package:clean_data/usecase/unauthenticated_use_case.dart';
import 'package:livingsmart_app/services/navigator.service.dart';

class ProductInfoPresenter extends CleanPresenter {
 Product selectedProd;
 LivingSmartStoreInfo selectedStore;
 UnauthenticatedUseCase unauthenticatedUseCase;
 CustomerUseCase customerUseCase;
 int quantity = 1;



 GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
 ProductInfoPresenter(CleanPageState<CleanPresenter> cleanPageState)
      : super(cleanPageState);

  @override
  void onViewInit() {
    // TODO: implement onViewInit
    this.customerUseCase = GetIt.I.get<CustomerUseCase>();
    this.unauthenticatedUseCase = GetIt.I.get<UnauthenticatedUseCase>();
    // this.selectedProd=Constants.instance.globalItems.where((element) => element.id == Constants.instance.selectedProdId).first;
    this.fetchStoreInfo();
    this.fetchProductInfo();
  }

  fetchStoreInfo() async{
    try{
      this.selectedStore = await unauthenticatedUseCase.getListAllStoresProduct(Constants.instance.selectedStoreId);
      cleanPageState.setState(() { });
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
  fetchProductInfo() async{
    try{
      this.selectedProd = await unauthenticatedUseCase.fetchProductInfoByID(Constants.instance.selectedProdId);
      cleanPageState.setState(() { });
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
  void increment(){
    cleanPageState.setState(() { 
      print(this.selectedProd.stock_count);
      if(this.quantity < this.selectedProd.stock_count){
        this.quantity++;
      }
    });
  }
  void decrement(){
    cleanPageState.setState(() { 
      if(this.quantity > 1){
        this.quantity--;
      }
    });
  }

  addToCart() async{
    if(Constants.instance.session != null){
      try{
        var response = await customerUseCase.addProductToCart(this.selectedStore.store_info.id, this.selectedProd.id, quantity);
        scaffoldKey.currentState.showSnackBar(
              SnackBar(
                content: Text("Item Added to cart"),
                action:SnackBarAction(
                  label: 'View Cart',
                  onPressed: () {
                    NavigatorService.instance.toCartPR(context);
                  },
                )
              ),
        );
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
                content: Text("Unable to add to cart"),
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
    }else{
      NavigatorService.instance.toLoginPagePR(context);
    }
  }
  refresh(){

  }

  @override
  // TODO: implement streamControllers
  List<StreamController> get streamControllers => null;


}