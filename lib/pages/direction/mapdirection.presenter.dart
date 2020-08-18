



import 'dart:async';

import 'package:clean_data/base/architechture.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:livingsmart_app/config/constants.dart';

class MapDirectionPresenter extends CleanPresenter {
  CameraPosition cameraPosition;
  List<Marker> allMarkers = <Marker>[];
  Completer<GoogleMapController> mapController;
  Set<Polyline> polylines;



  MapDirectionPresenter(CleanPageState<CleanPresenter> cleanPageState)
      : super(cleanPageState);

  @override
  void onViewInit() {
    
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
    this.allMarkers.add(Marker(
            markerId: MarkerId("storelocation"),
            position: LatLng(storeLocation.latitude, storeLocation.longitude),
    ));
  }





  @override
  // TODO: implement streamControllers
  List<StreamController> get streamControllers => null;
}