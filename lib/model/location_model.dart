import 'package:latlong2/latlong.dart';

class LocationModel {
  String ipAddress;
  String location;
  String timeZone;
  String isp;
  LatLng latLng;

  LocationModel(
      {required this.ipAddress,
      required this.location,
      required this.timeZone,
      required this.isp,
      required this.latLng});
}
