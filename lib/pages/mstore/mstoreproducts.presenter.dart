


import 'dart:async';

import 'package:clean_data/base/architechture.dart';
import 'package:clean_data/usecase/mstore_use_case.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:livingsmart_app/config/constants.dart';

class MStoreProductPresenter extends CleanPresenter {

 MStoreUseCase mstoreUseCase;

 GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
 MStoreProductPresenter(CleanPageState<CleanPresenter> cleanPageState)
      : super(cleanPageState);
  @override
  void onViewInit() {
    this.mstoreUseCase=GetIt.I.get<MStoreUseCase>();
  }
  fetchMStoreData() async{
    try{
      Constants.instance.mstoreData = await this.mstoreUseCase.getStoreInfo();
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
              content: Text("Unable to fetch MStoreData"),
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

  requestProductAdd(int prodId) async{
    try{
      var response = await this.mstoreUseCase.addProduct(prodId);
      scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: Text("Product Requested add"),
            ),
      );
      this.fetchMStoreData();
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
              content: Text("Unable to request product"),
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

  @override
  // TODO: implement streamControllers
  List<StreamController> get streamControllers => null;

}