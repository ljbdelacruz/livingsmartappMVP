



import 'dart:async';

import 'package:clean_data/base/architechture.dart';
import 'package:clean_data/model/userstore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:livingsmart_app/config/constants.dart';

class MapDirectionPresenter extends CleanPresenter {
  CameraPosition cameraPosition;
  List<Marker> allMarkers = <Marker>[];
  Completer<GoogleMapController> mapController;
  Set<Polyline> polylines;
  LivingSmartStores storeDirectionSelected;
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  MapDirectionPresenter(CleanPageState<CleanPresenter> cleanPageState)
      : super(cleanPageState);

  @override
  void onViewInit() {
    this.storeDirectionSelected=Constants.instance.storeDirectionSelected;
    this.assignUserAddressMarker(Constants.instance.mapService.currentPosition, Position(longitude:
    double.parse(Constants.instance.storeDirectionSelected.longitude), latitude: double.parse(Constants.instance.storeDirectionSelected.latitude)));
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
    this.assignCamPosition(mylocation);
    this.allMarkers.add(Marker(
            markerId: MarkerId("mylocation"),
            position: LatLng(mylocation.latitude, mylocation.longitude),
            infoWindow: InfoWindow(title:"My Location"),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
    ));
    this.allMarkers.add(Marker(
            markerId: MarkerId("storelocation"),
            position: LatLng(storeLocation.latitude, storeLocation.longitude),
            infoWindow: InfoWindow(title:this.storeDirectionSelected.name, snippet: this.storeDirectionSelected.address)
    ));
  }





  @override
  // TODO: implement streamControllers
  List<StreamController> get streamControllers => null;
}