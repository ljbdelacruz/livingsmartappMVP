




import 'dart:async';

import 'package:clean_data/base/architechture.dart';
import 'package:clean_data/model/userstore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:clean_data/usecase/mstore_use_case.dart';
import 'package:get_it/get_it.dart';
import 'package:livingsmart_app/config/constants.dart';
import 'package:livingsmart_app/services/snackbar.service.dart';

import 'mstoredashboard.page.dart';

class MStoreDashboardPresenter extends CleanPresenter {
 List<TransactionPerEntry> sucessfulTransactions = [TransactionPerEntry.dumm1(), TransactionPerEntry.dumm2(), TransactionPerEntry.dumm3(), TransactionPerEntry.dumm4(), TransactionPerEntry.dumm5(), TransactionPerEntry.dumm6()];
 List<TransactionPerEntry> failedTransactions = [TransactionPerEntry.fdumm1(), TransactionPerEntry.fdumm2()];
 TextEditingController phoneNumber = new TextEditingController();
 GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
 MStoreUseCase mstoreUseCase;
 String storeName;
 LivingSmartStoreInfo storeInfo;

 MStoreDashboardPresenter(CleanPageState<CleanPresenter> cleanPageState)
      : super(cleanPageState);
  @override
  void onViewInit() {
    this.mstoreUseCase=GetIt.I.get<MStoreUseCase>();
    this.fetchGlobalProductItem();
    this.fetchMStoreData();
  }

  fetchMStoreData() async{
    try{
      this.storeInfo = await mstoreUseCase.getStoreInfo();
      Constants.instance.mstoreData=this.storeInfo;
      if(storeInfo != null){
        this.storeName=storeInfo.store_info.name;
      }
      cleanPageState.setState(() {});
    }on DioError catch (e) {
       switch (e.type) {
        case DioErrorType.CONNECT_TIMEOUT:
          SnackBarService.textSnack(scaffoldKey, "No Internet Connection available");
          break;
        case DioErrorType.RESPONSE:
          SnackBarService.textSnack(scaffoldKey, "Unable to fetch MStore data");
          break;
        default:
          SnackBarService.textSnack(scaffoldKey, "Unable to process this request at this time");
          break;
      }
    }
  }

  fetchGlobalProductItem() async{
    try{
      Constants.instance.globalItems = await mstoreUseCase.getGlobalProducts();
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
              content: Text("Unable to fetch Product list"),
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