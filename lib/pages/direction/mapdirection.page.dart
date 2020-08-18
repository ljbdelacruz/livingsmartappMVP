




import 'package:clean_data/base/architechture.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:foody_ui/components/progress/circularloading.progress.dart';
import 'package:foody_ui/util/text_style_util.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:livingsmart_app/pages/direction/mapdirection.presenter.dart';

class MapDirectionPage extends CleanPage {

  @override
  MapDirectionPageState createState() => MapDirectionPageState();
}

class MapDirectionPageState extends CleanPageState<MapDirectionPresenter> {
  @override
  MapDirectionPresenter createPresenter() {
    return MapDirectionPresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(child:Scaffold(
      key:presenter.scaffoldKey,
              appBar:AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          presenter.storeDirectionSelected.name,
          style: TextStyleUtil.textNormal(fontSz:9),
        ),
      ),
      body:Column(children:[
        Container(
          width:MediaQuery.of(context).size.width,
          height:MediaQuery.of(context).size.height-96,
          child:myMap()
        )
      ])));

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
  
}