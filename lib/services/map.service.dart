


import 'package:foody_ui/typdef/mytypedef.dart';
import 'package:geolocator/geolocator.dart';

class MapService{
  static MapService instance = MapService();
  Position currentPosition;
  Geolocator geolocator = Geolocator();
  Position userLocation;
  String currentLocationAddress="";

  getCurrentLocation(NormalCallback fetchedPosition) {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
        currentPosition = position;
        fetchedPosition();
    }).catchError((e) {
      print(e);
    });
  }
  geolocateAddress(String address, GetPlaceMarkList successFetch) async{
    try{
      var placeMarkList = await geolocator.placemarkFromAddress(address);
      successFetch(placeMarkList);
    }catch(e){
      successFetch([]);
    }
  }
  getAddressByPosition(Position position, GetPlaceMark success) async{
    var address = await geolocator.placemarkFromCoordinates(position.latitude, position.longitude);
    success(address.first);
  }
  getAddressStringByPosition(Position position, GetStringData success) async{
    this.getAddressByPosition(position, (address){
      success(address.name+","+address.country+","+address.locality+","+address.subAdministrativeArea+" "+address.subLocality+" "+address.thoroughfare+" "+address.subThoroughfare);
    });
  }

  Future<double> getDistanceMeters(Position startCoordinates, Position destinationCoordinates) async{
    double data = await Geolocator().distanceBetween(
      startCoordinates.latitude,
      startCoordinates.longitude,
      destinationCoordinates.latitude,
      destinationCoordinates.longitude,
    );
    return data;
  }
  String getDistanceKM(Position startCoordinates, Position destinationCoordinates, GetDoubleData response){
    getDistanceMeters(startCoordinates, destinationCoordinates).then((value){
      print("Calculated Meters");
      print(value);
      response(value/1000);
    });
  }

  Position convertToPosition(String lon, String lat){
    return Position(longitude: double.parse(lon), latitude: double.parse(lat));
  }

}

typedef GetPlaceMarkList(List<Placemark> list);
typedef GetPlaceMark(Placemark place);