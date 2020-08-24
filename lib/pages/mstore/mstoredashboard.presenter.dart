




import 'dart:async';

import 'package:clean_data/base/architechture.dart';
import 'package:clean_data/model/transactions.dart';
import 'package:clean_data/model/userstore.dart';
import 'package:clean_data/usecase/transaction_use_case.dart';
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
 MStoreTransactionUseCase mstoreTransUseCase;
 String storeName;
 LivingSmartStoreInfo storeInfo;
  List<MStoreTransaction> transactions = [];
 int pending=0;
 int processing=0;
 int delivered=0;
 int cancelled=0;

 MStoreDashboardPresenter(CleanPageState<CleanPresenter> cleanPageState)
      : super(cleanPageState);
  @override
  void onViewInit() {
    this.mstoreUseCase=GetIt.I.get<MStoreUseCase>();
    this.mstoreTransUseCase = GetIt.I.get<MStoreTransactionUseCase>();
    this.fetchGlobalProductItem();
    this.fetchMStoreData();
    fetchTransactions();
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

  filterTransactions(){
   this.pending=this.transactions.where((element) => element.status == "pending").length;
   this.processing=this.transactions.where((element) => element.status == "processing").length;
   this.delivered=this.transactions.where((element) => element.status == "delivered").length;
   this.cancelled = this.transactions.where((element) => element.status == "cancelled").length;
   cleanPageState.setState(() { });
  }
  fetchTransactions() async{
    try{
      this.transactions = await mstoreTransUseCase.getTransactions();
      this.filterTransactions();
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


  @override
  // TODO: implement streamControllers
  List<StreamController> get streamControllers => null;

}