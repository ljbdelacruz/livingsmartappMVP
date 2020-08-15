











import 'dart:async';

import 'package:clean_data/base/architechture.dart';
import 'package:clean_data/model/user_session.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:livingsmart_app/config/constants.dart';
import 'package:clean_data/usecase/address_use_case.dart';
import 'package:clean_data/model/address.dart';
import 'package:livingsmart_app/services/map.service.dart';
import 'package:livingsmart_app/services/navigator.service.dart';

class AddressPresenter extends CleanPresenter {
  TextEditingController addressT = new TextEditingController();
  TextEditingController descT = new TextEditingController();
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  AddressUseCase addressUseCase;
  LSAddress selectedAddress;
  List<LSAddress> userAddresses = [];

  CameraPosition cameraPosition;
  List<Marker> allMarkers = <Marker>[];
  Set<Polyline> polylines = new Set();
  Completer<GoogleMapController> mapController = Completer();
  Position selectedPosition;

  AddressPresenter(CleanPageState<CleanPresenter> cleanPageState) : super(cleanPageState);
  @override
  void onViewInit() {
    // TODO: implement onViewInit
    this.addressUseCase = GetIt.I.get<AddressUseCase>();
    this.getCustomerAddresses();
    this.getCurrentLocation();
  }

    void getCurrentLocation() async {
    try {
          this.assignCamPosition(Constants.instance.mapService.currentPosition);
          this.assignUserAddressMarker(Constants.instance.mapService.currentPosition);
          Constants.instance.mapService.getAddressByPosition(Constants.instance.mapService.currentPosition, (address){
            this.addressT.text=address.name+","+address.country+","+address.locality+","+address.subAdministrativeArea+" "+address.subLocality+" "+address.thoroughfare+" "+address.subThoroughfare;
            FocusScope.of(context).requestFocus(new FocusNode());
          });
          cleanPageState.setState(() {});
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        print('Permission denied');
      }
    }
  }
  assignCamPosition(Position location){
    this.selectedPosition=location;
    cameraPosition = CameraPosition(
            target: LatLng(location.latitude, location.longitude),
            zoom: 14.4746,
    );
  }
  assignUserAddressMarker(Position location){
    this.allMarkers = [];
    this.allMarkers.add(Marker(
            markerId: MarkerId("myloc"),
            position: LatLng(location.latitude, location.longitude),
    ));
  }

  submitSearchAddress(){
    Constants.instance.mapService.geolocateAddress(this.addressT.text, (list){
      if(list.length <= 0){
          FocusScope.of(context).requestFocus(new FocusNode());
          scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: Text("Unable to find the address"),
            ),
          );
      }else{
        NavigatorService.instance.toSelectAddress(context, list, (index){
          Navigator.pop(context);
          var address = list[index];
          this.addressT.text=address.name+","+address.country+","+address.locality+","+address.subAdministrativeArea+" "+address.subLocality+" "+address.thoroughfare+" "+address.subThoroughfare;
          this.assignCamPosition(address.position);
          this.assignUserAddressMarker(address.position);
          cleanPageState.setState(() {});
          FocusScope.of(context).requestFocus(new FocusNode());
        });
      }
    });
  }

  saveInput(){
    if(this.addressT.text.length > 0 && this.selectedPosition != null){
      this.addAddress();
    }else{
      FocusScope.of(context).requestFocus(new FocusNode());
      scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: Text("Please fill required fields"),
            ),
      );
    }
  }

  addAddress() async{
    try{
      var response = await addressUseCase.addDeliveryAddress(this.addressT.text, this.selectedPosition.latitude.toString(), selectedPosition.longitude.toString(), descT.text, 0);
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
              content: Text("Unable to add new address"),
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
  updateDeliveryAddress(int addId, String address, String lat, String lon, String desc, int isDefault) async{
    try{
      var response = await addressUseCase.updateDeliveryAddress(addId, address, lat, lon, desc, isDefault);
      scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: Text("Address Updated!"),
            ),
      );
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
              content: Text("Unable to add new address"),
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
  removeAddress(int index) async{
    try{
      var response = await this.addressUseCase.deleteCustomerAddress(this.userAddresses[index].id);
      // print(response.data.toString());
      // this.userAddresses.removeAt(index);
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
              content: Text("Unable to remove address"),
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

  getCustomerAddresses()async{
    try{
      this.userAddresses = await addressUseCase.listCustomerAddresses();
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
              content: Text("Unable to get address list"),
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

  setDefault(LSAddress address){
    address.isDefault=1;
    this.updateDeliveryAddress(address.id, address.address, address.latitude, address.longitude, address.description, address.isDefault);

  }


  @override
  // TODO: implement streamControllers
  List<StreamController> get streamControllers => null;


  
}