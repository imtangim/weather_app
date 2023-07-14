import 'package:location/location.dart';

class LocationManager {
  late Location location;
  double? lat;
  double? long;
  bool serviceEnabled = false;
  PermissionStatus permissionGranted = PermissionStatus.denied;
  late LocationData locationData;
  bool service = true;
  LocationManager() {
    location = Location();
  }

  Future<void> fetchLocationData() async {
    try {
      serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          throw "Please turn on location and restart";
        }
      }

      permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.deniedForever) {
        throw "Please Give Permission to use location and restart";
      }
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          throw "Please Give Permission to use location and restart";
        }
      }

      location.enableBackgroundMode(enable: false);

      locationData = await location.getLocation();
      lat = locationData.latitude;
      long = locationData.longitude;
    } catch (e) {
      throw e.toString();
    }
  }
}
