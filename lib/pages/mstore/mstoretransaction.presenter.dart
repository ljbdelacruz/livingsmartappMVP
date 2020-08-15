import 'dart:async';

import 'package:clean_data/base/architechture.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:clean_data/usecase/transaction_use_case.dart';
import 'package:clean_data/model/transactions.dart';
import 'package:get_it/get_it.dart';
import 'package:livingsmart_app/config/constants.dart';

class MStoreTransactionPresenter extends CleanPresenter {

 List<MStoreTransaction> transactions = [];
 MStoreTransactionContent selectedTransaction;

 MStoreTransactionUseCase mstoreTransUseCase;
 GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
 MStoreTransactionPresenter(CleanPageState<CleanPresenter> cleanPageState)
      : super(cleanPageState);


  @override
  void onViewInit() {
    this.mstoreTransUseCase = GetIt.I.get<MStoreTransactionUseCase>();
    this.fetchTransactions();
    if(Constants.instance.selectedTransaction != null){
      this.getTransactionInfo(Constants.instance.selectedTransaction.transaction_code);
    }
  }

  fetchTransactions() async{
    try{
      this.transactions = await mstoreTransUseCase.getTransactions();
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
              content: Text("Unable to fetch Transactions"),
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
  getTransactionInfo(String transCode) async{
    try{
      this.selectedTransaction = await mstoreTransUseCase.getTransactionContent(transCode);
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
              content: Text("Unable to fetch transaction information"),
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

  cancelTransaction(String transCode, String reason) async{
    try{
      var response = await mstoreTransUseCase.cancelTransaction(transCode, reason);
      this.fetchTransactions();
      scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: Text("Order Cancelled"),
            ),
      );
      Navigator.pop(context);
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
              content: Text("Unable to cancel transaction"),
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

  acceptTransaction(String transCode) async{
    try{
      var response = await mstoreTransUseCase.processTransaction(transCode);
      this.fetchTransactions();
      scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: Text("Processing Order"),
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
              content: Text("Unable to process transaction"),
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

  readyForPickup(String transCode) async{
    try{
      var response = await mstoreTransUseCase.readyForPickupTransaction(transCode);
      this.fetchTransactions();
      scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: Text("Order Ready for Pickup"),
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
              content: Text("Unable to process transaction"),
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



  int getTransactionCount(String status){
    return this.transactions.where((element) => element.status == status).toList().length;
  }
  List<MStoreTransaction> filterByStatus(String status){
    return this.transactions.where((element) => element.status == status).toList();
  }

  @override
  // TODO: implement streamControllers
  List<StreamController> get streamControllers => null;

  
}