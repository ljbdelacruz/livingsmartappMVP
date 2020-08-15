





import 'package:clean_data/base/architechture.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:foody_ui/components/progress/circularloading.progress.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:livingsmart_app/pages/driver/driver.presenter.dart';

class DriverDirectionPage extends CleanPage {

  @override
  DriverDirectionPageState createState() => DriverDirectionPageState();
}

class DriverDirectionPageState extends CleanPageState<DriverPresenter> {
  @override
  DriverPresenter createPresenter() {
    return DriverPresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(child: Scaffold(
      key:presenter.scaffoldKey,
      body:Container(child:Column(children:[
        Container(
          width:MediaQuery.of(context).size.width,
          height:MediaQuery.of(context).size.height/2,
          child:myMap(),
        ),
        Container(child:deliveryInfo())
      ]))
    ));
  }

  Widget myMap(){
    return presenter.cameraPosition == null
              ? CircularLoadingWidget(height: 0)
              : GoogleMap(
                  mapToolbarEnabled: false,
                  mapType: MapType.normal,
                  initialCameraPosition: presenter.cameraPosition,
                  markers: Set.from(presenter.allMarkers),
                  onMapCreated: (GoogleMapController controller) {
                    presenter.mapController.complete(controller);
                  },
                  onCameraMove: (CameraPosition cameraPosition) {
                    presenter.cameraPosition = cameraPosition;
                  },
                  onCameraIdle: (){
                    // _con.getRestaurantsOfArea();
                  },
                  polylines: presenter.polylines,
                );
  }
  Widget deliveryInfo(){
    return SingleChildScrollView(child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:[

      Text("Pick up:"),
      Row(children:[
        Text(presenter.currentDeliveryInfo.details.store_name),
        Text(presenter.currentDeliveryInfo.details.store_phone)
      ]),
      Text(presenter.currentDeliveryInfo.details.customer_address),
      SizedBox(height:10),
      Text("Drop off:"),
      Row(children:[
        Text(presenter.currentDeliveryInfo.details.customer_name),
        Text(presenter.currentDeliveryInfo.details.customer_mobile)
      ]),
      Text(presenter.currentDeliveryInfo.details.customer_address),
    ]));
  }

  
  
}