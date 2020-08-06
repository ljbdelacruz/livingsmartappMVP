




import 'dart:async';

import 'package:clean_data/base/architechture.dart';
import 'package:clean_data/model/userstore.dart';
import 'package:clean_data/usecase/unauthenticated_use_case.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:livingsmart_app/config/constants.dart';

class StoreInfoPresenter extends CleanPresenter {
  LivingSmartStoreInfo storeInfo;
  UnauthenticatedUseCase unauthUseCase;
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  TabController tabController;

  StoreInfoPresenter(CleanPageState<CleanPresenter> cleanPageState)
      : super(cleanPageState);


  @override
  void onViewInit() {
    tabController = TabController(vsync: cleanPageState, length: 2);
    this.unauthUseCase = GetIt.I.get<UnauthenticatedUseCase>();
    this.fetchStoreInfo();
  }
  fetchStoreInfo() async{
    try{
      this.storeInfo = await unauthUseCase.getListAllStoresProduct(Constants.instance.selectedStoreId);
      print("Store info data");
      print(storeInfo.store_info.name);
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
              content: Text("Unable to fetch store data"),
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