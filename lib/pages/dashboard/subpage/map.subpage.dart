



import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:foody_ui/components/progress/circularloading.progress.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSubPage extends StatelessWidget {
  final MapSubPageVM vm;
  MapSubPage(this.vm);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(children:[
      Positioned(child:Container(
          width:MediaQuery.of(context).size.width,
          height:(MediaQuery.of(context).size.height-90),
          child:myMap(),
      )),
    ]);
  }


  Widget myMap(){
    return vm.camPos == null && vm.allMarkers != null && vm.mapController != null
              ? CircularLoadingWidget(height: 0)
              : GoogleMap(
                  mapToolbarEnabled: false,
                  mapType: MapType.normal,
                  initialCameraPosition: vm.camPos,
                  markers: Set.from(vm.allMarkers),
                  onMapCreated: (GoogleMapController controller) {
                    vm.mapController.complete(controller);
                  },
                  onCameraMove: (CameraPosition cameraPosition) {
                    vm.camPos = cameraPosition;
                  },
                  onCameraIdle: (){
                    // _con.getRestaurantsOfArea();
                  },
                  polylines: vm.polylines,
                );
  }
}

class MapSubPageVM{
  CameraPosition camPos;
  List<Marker> allMarkers = <Marker>[];
  Completer<GoogleMapController> mapController;
  Set<Polyline> polylines;
  MapSubPageVM(this.camPos, this.allMarkers, this.mapController, this.polylines);
}