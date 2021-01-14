import 'package:google_maps_flutter/google_maps_flutter.dart';

class SearchHomeAds{
  int radius;
  int minRoomNumber;
  int maxRoomNumber;
  int minHouseSize;
  int maxHouseSize;
  int buildingHeight;
  int floorAtRent;
  double centerLatitude;
  double centerLongitude;
  String centerLocationDescription;
  LatLng centerLatLng;

  SearchHomeAds(
      {this.radius,
      this.minRoomNumber,
      this.maxRoomNumber,
      this.minHouseSize,
      this.maxHouseSize,
      this.buildingHeight,
      this.floorAtRent,
      this.centerLatitude,
      this.centerLongitude,
      this.centerLocationDescription,
      this.centerLatLng});
}