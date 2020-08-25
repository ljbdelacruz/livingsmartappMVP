import 'package:clean_data/base/architechture.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:foody_ui/components/progress/circularloading.progress.dart';
import 'package:foody_ui/components/textfields/delivery.textfields.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:livingsmart_app/pages/address/address.presenter.dart';

class AddAddressPage extends CleanPage {
  @override
  AddAddressPageState createState() => AddAddressPageState();
}

class AddAddressPageState extends CleanPageState<AddressPresenter> {
  @override
  AddressPresenter createPresenter() {
    return AddressPresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        resizeToAvoidBottomInset: false,
        key:presenter.scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Add Address",
            style: Theme.of(context).textTheme.headline6.merge(TextStyle(letterSpacing: 1.3)),
          ),
          actions: <Widget>[
            GestureDetector(onTap:(){
              //TODO: save content
              presenter.saveInput();
            }, child: Container(
              padding:EdgeInsets.only(right:15),
              child: Icon(Icons.save, size:30, color:Colors.black)))
          // new ShoppingCartButtonWidget(vm.cartButton, (){
          //   NavigatorService.instance.toCart(context);
          // }),
        ],
        ),
        body:bodyContent()
    );
  }
  Widget bodyContent(){
    return Column(children:[
      Container(child:Stack(children:[
        Container(width:MediaQuery.of(context).size.width, 
                height:MediaQuery.of(context).size.height-100,
                child:myMap()
        ),
        Positioned(top:0, child:Container(
          color:Colors.white,
          width:MediaQuery.of(context).size.width,
          padding:EdgeInsets.only(left:20, right:20, top:20, bottom:10),
          child: Column(children:[
             DeliveryTextFields(DeliveryTextFieldsVM(presenter.addressT, "Address Here", icon:Icons.navigation), onEndEdit: (){
                presenter.submitSearchAddress();
             },),
             SizedBox(height:10),
             DeliveryTextFields(DeliveryTextFieldsVM(presenter.descT, "Additional Info", icon:Icons.description), onEndEdit: (){
              FocusScope.of(context).requestFocus(new FocusNode());
             },)
          ]))
        ),

      ])),
    ]);
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
                  onCameraIdle: () {
                    // _con.getRestaurantsOfArea();
                  },
                  polylines: presenter.polylines,
                );
  }

}