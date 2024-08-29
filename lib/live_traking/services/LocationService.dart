import 'dart:async';
import 'package:location/location.dart';
import 'dart:io' as platform;

class LocationService {

  var location = Location();
  bool isTry = true;

  LocationService() {

    location.hasPermission().then((value){

      if(value == PermissionStatus.granted){
        if(platform.Platform.isAndroid) location.changeSettings(interval: 10000,distanceFilter: 5);
        location.enableBackgroundMode(enable: true);
        location.onLocationChanged.listen((locationData) {
          if (locationData != null) {
            _locationController.add(locationData);
          }
        });
      }
    });
  }

  //continuously emit location updates
  final StreamController<LocationData> _locationController = StreamController<LocationData>.broadcast();

  Stream<LocationData> get locationStream => _locationController.stream;

  Future<LocationData?> getLocation() async {
    try {
      var userLocation = await location.getLocation();
      return userLocation;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

}
