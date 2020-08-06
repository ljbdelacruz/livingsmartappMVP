





import 'dart:async';
import 'package:clean_data/base/architechture.dart';
import 'package:clean_data/usecase/unauthenticated_use_case.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:foody_ui/components/buttons/shoppingcart.button.dart';
import 'package:foody_ui/components/drawer/livingsmart.drawer.dart';
import 'package:get_it/get_it.dart';
import 'package:livingsmart_app/config/constants.dart';
import 'package:livingsmart_app/pages/dashboard/subpage/home.subpage.dart';
import 'package:livingsmart_app/services/navigator.service.dart';
import 'package:clean_data/usecase/customer_use_case.dart';
import 'package:clean_data/model/userstore.dart';


class DashboardPresenter extends CleanPresenter {
  int currentTab = 2;
  LivingSmartDrawerVM drawerVM;
  CustomerUseCase customerUseCase;
  UnauthenticatedUseCase unauthUseCase;
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  List<LivingSmartStores> stores = [];
  HomeSubPageVM homeSubpage = new HomeSubPageVM([], ShoppingCartButtonWidgetVM(cartCount: Constants.instance.cartStores.length));

 DashboardPresenter(CleanPageState<CleanPresenter> cleanPageState)
      : super(cleanPageState);

  @override
  void onViewInit() {
    // TODO: implement onViewInit
    this.customerUseCase=GetIt.I.get<CustomerUseCase>();
    this.unauthUseCase=GetIt.I.get<UnauthenticatedUseCase>();
    if(Constants.instance.session != null){
      drawerVM = LivingSmartDrawerVM(name: Constants.instance.session.user.name, email: Constants.instance.session.user.email, appVersion: Constants.instance.appVersion, 
      // showMStore: Constants.instance.session.user.role == "mstore" ? true : false, 
      // showMCS: Constants.instance.session.user.role == "mcs" ? true : false
      );
    }else{
      drawerVM = LivingSmartDrawerVM(appVersion: Constants.instance.appVersion);
    }
    this.fetchStoreList();
  }
  navigateSideMenu(int option){
    switch(option){
      case 0:
        Navigator.pop(context);
        cleanPageState.setState(() {
          currentTab=2;
        });
        break;
      case 1:
        break;
      case 2:
        break;
      case 3:
        break;
      case 4:
        break;
      case 5:
        break;
      case 6:
        if(Constants.instance.session != null){
          NavigatorService.instance.toMStore(context);
        }else{
          NavigatorService.instance.toLoginPagePR(context);
        }
        break;
      case 7:
        break;
      case 8:
        NavigatorService.instance.toLoginPagePR(context);
        break;
      case 9:
        NavigatorService.instance.toRegisterPR(context);
        break;
    }
  }
  fetchStoreList() async{
    try{
      this.stores = await customerUseCase.getStoresList();
      cleanPageState.setState((){
        homeSubpage.stores=this.stores;
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
              content: Text("Unable to fetch stores"),
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





