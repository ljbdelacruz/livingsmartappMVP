



import 'dart:async';

import 'package:clean_data/base/architechture.dart';
import 'package:clean_data/model/transactions.dart';
import 'package:clean_data/usecase/customer_use_case.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:livingsmart_app/config/constants.dart';
import 'package:livingsmart_app/services/snackbar.service.dart';

class TransactionInfoPresenter extends CleanPresenter {
  MStoreTransactionContent transactionInfo;
  String transactionCode;
  TransactionInfoPresenter(CleanPageState<CleanPresenter> cleanPageState) : super(cleanPageState);
  CustomerUseCase customerUseCase;
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  double subtotal = 0;

  @override
  void onViewInit() {
    this.customerUseCase= GetIt.I.get<CustomerUseCase>();
    this.transactionCode=Constants.instance.selectedUserTransaction;
    this.fetchTransactionInfo();
  }


  fetchTransactionInfo() async{
    try{
      this.transactionInfo= await customerUseCase.getTransactionContent(this.transactionCode);
      calculateSubTotal();
      cleanPageState.setState(() {});
      // Constants.instance.defaultAddress = await addressUseCase.getCustomerDefaultAddress();
    }on DioError catch (e) {
       switch (e.type) {
        case DioErrorType.CONNECT_TIMEOUT:
          SnackBarService.textSnack(scaffoldKey, "No Internet Connection available");
          break;
        case DioErrorType.RESPONSE:
          SnackBarService.textSnack(scaffoldKey, "Unable to get transaction info");
          break;
        default:
          SnackBarService.textSnack(scaffoldKey, "Unable to process this request at this time");
          break;
      }
    }
  }

  calculateSubTotal(){
    this.subtotal=0;
    this.transactionInfo.products.forEach((element) { 
        subtotal+=double.parse(element.price);
    });
    cleanPageState.setState(() {});
  }

  double calculateBill(){
    double billing = 0;
    if(this.transactionInfo != null){
      billing+=subtotal;
      billing+=double.parse(this.transactionInfo.details.delivery_fee);
      return billing;
    }else{
      return 0;
    }
  }

  @override
  // TODO: implement streamControllers
  List<StreamController> get streamControllers => null;
}
