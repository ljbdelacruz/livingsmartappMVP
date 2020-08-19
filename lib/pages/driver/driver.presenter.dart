





import 'dart:async';

import 'package:clean_data/base/architechture.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:clean_data/usecase/mcsrider_use_case.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:clean_data/model/delivery.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:livingsmart_app/config/constants.dart';
import 'package:livingsmart_app/services/url.service.dart';


class DriverPresenter extends CleanPresenter {

 GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
 int selectedTab=1;
 MCSRiderUseCase mcsRiderUseCase;
 List<RiderDelivery> jobList = [];
 List<RiderDelivery> completedDeliveries = [];
 RiderCurrentDelivery currentActiveDelivery;
 RiderCurrentDeliveryInfo currentDeliveryInfo;

 //TODO: maps
  CameraPosition cameraPosition;
  List<Marker> allMarkers = <Marker>[];
  Set<Polyline> polylines = new Set();
  Completer<GoogleMapController> mapController = Completer();
  Position selectedPosition;
  String selectedJobTransCode=Constants.instance.selectedJobTransCode;


 DriverPresenter(CleanPageState<CleanPresenter> cleanPageState)
      : super(cleanPageState);

  @override
  void onViewInit() {
    // TODO: implement onViewInit
    this.mcsRiderUseCase = GetIt.I.get<MCSRiderUseCase>();
    this.fetchAvailableJobs();
    this.fetchCompleteDeliveries();
    this.fetchMyLocation();
    if(this.selectedJobTransCode.length > 0){
      this.fetchDeliveryDetails(this.selectedJobTransCode);
    }
  }
  fetchMyLocation(){
    this.assignCamPosition(Constants.instance.mapService.currentPosition);
  }
  assignCamPosition(Position location){
    this.selectedPosition=location;
    cameraPosition = CameraPosition(
            target: LatLng(location.latitude, location.longitude),
            zoom: 14.4746,
    );
  }



  assignUserAddressMarker(Position pickup, Position delivery){
    this.allMarkers = [];
    this.allMarkers.add(Marker(
            markerId: MarkerId("mypickup"),
            position: LatLng(pickup.latitude, pickup.longitude),
    ));
    this.allMarkers.add(Marker(
            markerId: MarkerId("mydelivery"),
            position: LatLng(delivery.latitude, delivery.longitude),
    ));
  }

  selectTab(int tab){
    cleanPageState.setState(() { 
      this.selectedTab=tab;
    });
  }
  fetchAvailableJobs() async{
    try{
      this.jobList = await mcsRiderUseCase.listAvailableDeliveries();
      print("Jobs count");
      print(this.jobList.length.toString());
      if(this.jobList.length <= 0){
        this.fetchCurrentDelivery();
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
              content: Text("Unable to fetch available jobs"),
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
  fetchCompleteDeliveries() async{
    try{
      this.completedDeliveries = await mcsRiderUseCase.listCompletedDeliveries();
      print("Fetching completed jobs");
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
              content: Text("Unable to fetch available jobs"),
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

  fetchCurrentDelivery() async{
    try{
      this.currentActiveDelivery = await mcsRiderUseCase.listCurrentDelivery();
      fetchDeliveryDetails(this.currentActiveDelivery.transaction_code);
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
              content: Text("Unable to fetch available jobs"),
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

  fetchDeliveryDetails(String transCode) async{
    try{
      this.currentDeliveryInfo = await mcsRiderUseCase.getRiderDeliveryDetails(transCode);
      this.assignUserAddressMarker(Position(latitude:double.parse(this.currentDeliveryInfo.details.store_latitude), longitude:double.parse(this.currentDeliveryInfo.details.store_longitude)), Position(latitude:double.parse(this.currentDeliveryInfo.details.customer_latitude), longitude:double.parse(this.currentDeliveryInfo.details.customer_longitude)));
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
              content: Text("Unable to fetch available jobs"),
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

  acceptDelivery(String transCode) async{
    try{
      print("Accepting delivery "+transCode);
      var response = await mcsRiderUseCase.riderAcceptDelivery(transCode, 0, 0);
      print(response.data.toString());
      if(response != null){
        scaffoldKey.currentState.showSnackBar(
              SnackBar(
                content: Text("Job Accepted!"),
              ),
        );
        this.fetchAvailableJobs();
      }else{
        scaffoldKey.currentState.showSnackBar(
              SnackBar(
                content: Text("Unable to process job request"),
              ),
        );
        this.fetchAvailableJobs();
      }
      // cleanPageState.setState(() {});
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
              content: Text("Unable to accept job"),
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

  deliveredJob(String transCode) async{
    try{
      var response = await mcsRiderUseCase.triggerDelivered(transCode);
      if(response.data != null){
        this.currentDeliveryInfo=null;
        scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: Text("Job Delivery Complete!"),
            ),
        );
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
              content: Text("Unable to mark job as completed"),
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
  showDirectionStore(String transCode){
      var pos = Constants.instance.mapService.currentPosition;
      URLService.launchMapsUrl(pos.latitude, pos.longitude, this.currentDeliveryInfo.details.store_latitude, this.currentDeliveryInfo.details.store_longitude);
  }
  showDirectionCustomer(String transCode){
      var pos = Constants.instance.mapService.currentPosition;
      URLService.launchMapsUrl(pos.latitude, pos.longitude, this.currentDeliveryInfo.details.customer_latitude, this.currentDeliveryInfo.details.customer_longitude);
  }






  @override
  // TODO: implement streamControllers
  List<StreamController> get streamControllers => null;

}