


import 'package:url_launcher/url_launcher.dart';

class URLService{

  static void launchMapsUrl(
      sourceLatitude,
      sourceLongitude,
      destinationLatitude,
      destinationLongitude, {dest1Lat, dest2Lon}) async {
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
    }  }
}