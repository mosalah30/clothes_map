import 'package:geolocator/geolocator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:app_settings/app_settings.dart';
import 'package:location_permissions/location_permissions.dart';

import 'package:clothes_map/utils/values.dart';

class Location {
  static double userLatitude = defaultLocation.latitude;
  static double userLongitude = defaultLocation.longitude;

  Future<void> getUserPermission() async {
    final permission = await LocationPermissions().checkPermissionStatus();
    if (permission != PermissionStatus.granted)
      await LocationPermissions().requestPermissions();
  }

  Future<void> checkGpsStatus() async {
    final gpsStatues = await LocationPermissions().checkServiceStatus();
    if (gpsStatues != ServiceStatus.enabled) {
      AppSettings.openLocationSettings();
      Fluttertoast.showToast(msg: 'برجاء تمكين الموقع الجغرافي');
    }
  }

  Future<void> findUserLocation() async {
    await getUserPermission();
    await checkGpsStatus();
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    Position lastKnownPosition = await Geolocator().getLastKnownPosition();
    userLatitude = position.latitude ?? lastKnownPosition.latitude;
    userLongitude = position.longitude ?? lastKnownPosition.longitude;
  }
}
