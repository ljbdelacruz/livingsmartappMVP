





import 'package:clean_data/base/architechture.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:foody_ui/components/progress/circularloading.progress.dart';
import 'package:foody_ui/util/text_style_util.dart';
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
      appBar:AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Delivery Info",
          style: Theme.of(context).textTheme.headline6.merge(TextStyle(letterSpacing: 1.3)),
        )
      ),
      body:Container(child:Column(children:[
        Container(
          width:MediaQuery.of(context).size.width,
          height:(MediaQuery.of(context).size.height/2)-90,
          child:myMap(),
        ),
        Container(
          padding:EdgeInsets.only(left:20, top:10),
          child:deliveryInfo())
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
    return presenter.currentDeliveryInfo == null ? CircularLoadingWidget(height: 0) : SingleChildScrollView(child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:[

      Text("Pick up:", style:TextStyleUtil.textBold(fontSz:15, tColor: Colors.grey)),
      Row(children:[
        Text(presenter.currentDeliveryInfo.details.store_name),
        Text(presenter.currentDeliveryInfo.details.store_phone)
      ]),
      Text(presenter.currentDeliveryInfo.details.customer_address),
      SizedBox(height:20),
      Text("Drop off:", style:TextStyleUtil.textBold(fontSz:15, tColor: Colors.grey)),
      Row(children:[
        Text(presenter.currentDeliveryInfo.details.customer_name),
        Text(presenter.currentDeliveryInfo.details.customer_mobile)
      ]),
      Text(presenter.currentDeliveryInfo.details.customer_address),
      SizedBox(height:10),
    ]));
  }

  
  
}