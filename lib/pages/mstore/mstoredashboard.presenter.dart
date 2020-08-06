




import 'dart:async';

import 'package:clean_data/base/architechture.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:clean_data/usecase/mstore_use_case.dart';
import 'package:get_it/get_it.dart';
import 'package:livingsmart_app/config/constants.dart';

import 'mstoredashboard.page.dart';

class MStoreDashboardPresenter extends CleanPresenter {
 List<TransactionPerEntry> sucessfulTransactions = [TransactionPerEntry.dumm1(), TransactionPerEntry.dumm2(), TransactionPerEntry.dumm3(), TransactionPerEntry.dumm4(), TransactionPerEntry.dumm5(), TransactionPerEntry.dumm6()];
 List<TransactionPerEntry> failedTransactions = [TransactionPerEntry.fdumm1(), TransactionPerEntry.fdumm2()];
 TextEditingController phoneNumber = new TextEditingController();
 GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
 MStoreUseCase mstoreUseCase;

 MStoreDashboardPresenter(CleanPageState<CleanPresenter> cleanPageState)
      : super(cleanPageState);
  @override
  void onViewInit() {
    this.mstoreUseCase=GetIt.I.get<MStoreUseCase>();
    this.fetchGlobalProductItem();
  }

  fetchGlobalProductItem() async{
    print("Fetching Global products items");
    try{
      Constants.instance.globalItems = await mstoreUseCase.getGlobalProducts();
      print("fetching products item");
      print(Constants.instance.globalItems.length);
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
              content: Text("Authentication Failed"),
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