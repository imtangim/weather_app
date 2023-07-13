import 'package:location/location.dart';

class LocationManager {
  late Location location;
  double? lat;
  double? long;
  bool serviceEnabled = false;
  PermissionStatus permissionGranted = PermissionStatus.denied;
  late LocationData locationData;

  LocationManager() {
    location = Location();
  }

  Future<void> fetchLocationData() async {
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    location.enableBackgroundMode(enable: false);

    locationData = await location.getLocation();
    lat = locationData.latitude;
    long = locationData.longitude;
  }
}
