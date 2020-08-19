


import 'package:url_launcher/url_launcher.dart';

class URLService{

  static void launchMapsUrl(
      sourceLatitude,
      sourceLongitude,
      destinationLatitude,
      destinationLongitude) async {
    String mapOptions = [
      'saddr=$sourceLatitude,$sourceLongitude',
      'daddr=$destinationLatitude,$destinationLongitude',
      'dir_action=navigate'
    ].join('&');

    final url = 'https://www.google.com/maps?$mapOptions';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }  
  }
  static void launchWazeDirection(
      destinationLatitude,
      destinationLongitude) async{

    final url = 'https://www.waze.com/ul?ll=$destinationLatitude%2C$destinationLongitude&navigate=yes&zoom=17';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }  
  }

}