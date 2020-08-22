



import 'dart:async';

import 'package:clean_data/base/architechture.dart';
import 'package:clean_data/model/product.dart';
import 'package:clean_data/model/userstore.dart';
import 'package:clean_data/usecase/customer_use_case.dart';
import 'package:clean_data/usecase/unauthenticated_use_case.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:livingsmart_app/config/constants.dart';
import 'package:livingsmart_app/services/navigator.service.dart';
import 'package:livingsmart_app/services/snackbar.service.dart';

class ProductSearchPresenter extends CleanPresenter {

 GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
 List<Product> products = [];
 UnauthenticatedUseCase unauthUseCase;
 CustomerUseCase customerUseCase;
 bool autoFocusTF=true;
 LivingSmartStoreInfo selectedStore;

  
 ProductSearchPresenter(CleanPageState<CleanPresenter> cleanPageState)
      : super(cleanPageState);
  @override
  void onViewInit() {
    this.unauthUseCase = GetIt.I.get<UnauthenticatedUseCase>();

    if(Constants.instance.selectedCategory != "all"){
      this.autoFocusTF=false;
    }
    fetchProducts("all");
  }

  fetchProducts(String text) async{
    try{
      var categoryFilter="all";
      if(text == "all"){
        categoryFilter=Constants.instance.selectedCategory;
      }else{
        Constants.instance.selectedCategory="all";
      }
      this.products = await unauthUseCase.searchProductsAllStoreCategory(categoryFilter, text);
      cleanPageState.setState(() { });
    }on DioError catch (e) {
       switch (e.type) {
        case DioErrorType.CONNECT_TIMEOUT:
          SnackBarService.textSnack(scaffoldKey, "No Internet Connection available");
          break;
        case DioErrorType.RESPONSE:
          SnackBarService.textSnack(scaffoldKey, "Unable to fetch Product list");
          break;
        default:
          SnackBarService.textSnack(scaffoldKey, "Unable to process this request at this time");
          break;
      }
    }
  }
  viewProductInfo(Product item){
    Constants.instance.selectedProdId=item.id;
    Constants.instance.selectedStoreId=item.store_id;
    NavigatorService.instance.toProductInfo(context);
  }

  @override
  // TODO: implement streamControllers
  List<StreamController> get streamControllers => null;


}