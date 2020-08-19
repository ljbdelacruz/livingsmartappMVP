





import 'dart:async';
import 'package:clean_data/base/architechture.dart';
import 'package:clean_data/model/transactions.dart';
import 'package:clean_data/usecase/address_use_case.dart';
import 'package:clean_data/usecase/mstore_use_case.dart';
import 'package:clean_data/usecase/unauthenticated_use_case.dart';
import 'package:clean_data/usecase/user_auth_use_case.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:foody_ui/components/buttons/shoppingcart.button.dart';
import 'package:foody_ui/components/drawer/livingsmart.drawer.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:livingsmart_app/config/constants.dart';
import 'package:livingsmart_app/pages/dashboard/subpage/home.subpage.dart';
import 'package:livingsmart_app/services/delivery.service.dart';
import 'package:livingsmart_app/services/firebasedatabase.service.dart';
import 'package:livingsmart_app/services/navigator.service.dart';
import 'package:clean_data/usecase/customer_use_case.dart';
import 'package:clean_data/model/userstore.dart';
import 'package:livingsmart_app/services/snackbar.service.dart';


class DashboardPresenter extends CleanPresenter {
  int currentTab = 2;
  LivingSmartDrawerVM drawerVM;
  CustomerUseCase customerUseCase;
  MStoreUseCase mstoreUseCase;
  AddressUseCase addressUseCase;
  UserAuthUseCase userAuthUseCase;

  UnauthenticatedUseCase unauthUseCase;
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  List<LivingSmartStores> stores = [];

  HomeSubPageVM homeSubpage = new HomeSubPageVM([]);

  bool isDeliveryInProgress=false;
  UserTransaction deliveryInProgressInfo;
  

  double deliveryProgress=0.01;
  DashboardPresenter(CleanPageState<CleanPresenter> cleanPageState)
      : super(cleanPageState);

  @override
  void onViewInit() {
    // TODO: implement onViewInit
    this.customerUseCase=GetIt.I.get<CustomerUseCase>();
    this.unauthUseCase=GetIt.I.get<UnauthenticatedUseCase>();
    this.mstoreUseCase=GetIt.I.get<MStoreUseCase>();
    this.addressUseCase=GetIt.I.get<AddressUseCase>();
    this.userAuthUseCase=GetIt.I.get<UserAuthUseCase>();

    if(Constants.instance.session != null){
      drawerVM = LivingSmartDrawerVM(name: Constants.instance.session.user.name, email: Constants.instance.session.user.email, appVersion: Constants.instance.appVersion, 
      showMStore: false, 
      showMCS: false
      );
      this.fetchDefaultDeliveryAddress();
      this.fetchUserDeliveryAddress();
    }else{
      drawerVM = LivingSmartDrawerVM(appVersion: Constants.instance.appVersion, showMStore: false, showMCS:false);
    }
    this.fetchStoreList();
    if(Constants.instance.session != null){
      this.fetchUserTransactions();
    }
    this.getAddress();
  }

  fetchDefaultDeliveryAddress() async{
    try{
      Constants.instance.defaultAddress = await addressUseCase.getCustomerDefaultAddress();
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
              content: Text("Unable to fetch Addresses"),
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

  fetchUserDeliveryAddress() async{
    try{
      Constants.instance.userAddresses = await addressUseCase.listCustomerAddresses();
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
              content: Text("Unable to fetch Addresses"),
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
  getAddress(){
      Constants.instance.mapService.getAddressStringByPosition(Constants.instance.mapService.currentPosition, (address){
        homeSubpage.address=address;
        cleanPageState.setState(() {});
      });
  }

  getMstoreData() async{
    try{
      Constants.instance.mstoreData = await mstoreUseCase.getStoreInfo();
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
        Navigator.pop(context);
        cleanPageState.setState(() {
          currentTab=3;
        });
        break;
      case 3:
        break;
      case 4:
        break;
      case 5:
        //settings
        NavigatorService.instance.toSettings(context);
        break;
      case 6:
        NavigatorService.instance.toMStore(context);
        break;
      case 7:
        //Driver 
        NavigatorService.instance.toDriverDashboard(context);
        break;
      case 8:
        if(Constants.instance.session != null){
          this.logout();
        }else{
          NavigatorService.instance.toLoginPagePR(context);
        }
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

  fetchUserTransactions() async{
    try{
      Constants.instance.userTransactions = await customerUseCase.getTransactions();
      //TODO: extract in progress order
      Constants.instance.inProgressTransaction = Constants.instance.userTransactions.where((element) => element.status != "completed").first;
      if(Constants.instance.inProgressTransaction != null){
        this.isDeliveryInProgress=true;
        Constants.instance.isDeliveryInProgress=true;
        this.deliveryInProgressInfo = Constants.instance.inProgressTransaction;
        this.deliveryProgress=DeliveryService.instance.getProgressStatus(deliveryInProgressInfo.status);
        FirebaseDatabaseService.instance.listenDeliveryStatus(Constants.instance.inProgressTransaction.transaction_code, (data) { 
          Constants.instance.inProgressTransaction.status=data;
          this.deliveryInProgressInfo.status=data;
          this.deliveryProgress=DeliveryService.instance.getProgressStatus(data);
          if(data == "delivered"){
            this.fetchUserTransactions();
          }
          cleanPageState.setState(() {});
        });
      }else{
        this.isDeliveryInProgress=false;
        Constants.instance.isDeliveryInProgress=false;
      }
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
              content: Text("Unable to fetch transactions"),
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

  fetchTransactionInfo(String transCode) async{
    Constants.instance.selectedUserTransaction = transCode;
    NavigatorService.instance.toTransactionInfo(context);
    // try{
    //   var data = await customerUseCase.getTransactionContent(transCode);
    //   //view transaction info data
    // }on DioError catch (e) {
    //    switch (e.type) {
    //     case DioErrorType.CONNECT_TIMEOUT:
    //       scaffoldKey.currentState.showSnackBar(
    //         SnackBar(
    //           content: Text("No Internet Connection available"),
    //         ),
    //       );
    //       break;
    //     case DioErrorType.RESPONSE:
    //       scaffoldKey.currentState.showSnackBar(
    //         SnackBar(
    //           content: Text("Failed transaction info"),
    //         ),
    //       );
    //       break;
    //     default:
    //       scaffoldKey.currentState.showSnackBar(
    //         SnackBar(
    //           content: Text("Unable to process this request at this time"),
    //         ),
    //       );
    //       break;
    //   }
    
  }

  logout() async{
    try{
      // var data = await userAuthUseCase.logout();
      NavigatorService.instance.toLoginPagePR(context);
      //view transaction info data
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
              content: Text("Failed transaction info"),
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

  //TODO: Map data
  CameraPosition cameraPosition;
  List<Marker> allMarkers = <Marker>[];
  Completer<GoogleMapController> mapController = Completer();
  Set<Polyline> polylines;

  initMap(){
    this.fetchMyLocation();
  }

  showDirectionStore(){
    if(Constants.instance.storeDirectionSelected != null){
      NavigatorService.instance.toMapDirection(context);
      // this.assignUserAddressMarker(Constants.instance.mapService.currentPosition, Position(longitude:double.parse(Constants.instance.storeDirectionSelected.longitude), latitude:double.parse(Constants.instance.storeDirectionSelected.latitude)));
      // cleanPageState.setState(() {
      //   this.currentTab=1;
      // });
    }else{
      this.assignUserAddressMarker(Constants.instance.mapService.currentPosition, null);
    }
  }
  fetchMyLocation(){
    this.assignCamPosition(Constants.instance.mapService.currentPosition);
  }
  assignCamPosition(Position location){
    // this.selectedPosition=location;
    cameraPosition = CameraPosition(
            target: LatLng(location.latitude, location.longitude),
            zoom: 14.4746,
    );
  }
  assignUserAddressMarker(Position mylocation, Position storeLocation){
    this.allMarkers = [];
    this.allMarkers.add(Marker(
            markerId: MarkerId("mylocation"),
            position: LatLng(mylocation.latitude, mylocation.longitude),
    ));
    if(storeLocation != null){
      this.allMarkers.add(Marker(
              markerId: MarkerId("storelocation"),
              position: LatLng(storeLocation.latitude, storeLocation.longitude),
      ));
    }
  }






  @override
  // TODO: implement streamControllers
  List<StreamController> get streamControllers => null;
}





