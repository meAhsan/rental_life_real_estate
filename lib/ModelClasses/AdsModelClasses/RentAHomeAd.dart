import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:realestate/ModelClasses/AdsModelClasses/Ads.dart';
import 'package:realestate/ModelClasses/AdsModelClasses/NonCommercialAds.dart';

class RentAHomeAd extends Ads {
  int _numberOfRooms;
  int _numberofBaths;
  int _totalNmberOfFloors;
  int _floorNumber;
  double _sizeInMarlas;
  String _AD_TYPE = "NonCommercial-Home";

  RentAHomeAd(
      {String adTitle,
      String adDescription,
      @required String adOwnerId,
      int adNumberByOwner,
      int numberOfAdImagesUploaded,
      String adLocation,
      String adPostDate,
      int adRent,
      bool isAdDeactivated,
      int totalThumbsUp,
      int totalRating,
      // String adType,
      int numberOfBeds,
      int numberofBaths,
      int totalNmberOfFloors,
      int floorNumber,
      double sizeInMarlas})
      : super(
            adOwnerId: adOwnerId,
            adTitle: adTitle,
            adDescription: adDescription,
            adNumberByOwner: adNumberByOwner,
            adPostDate: adPostDate,
            adRent: adRent,
            isAdDeactivated: isAdDeactivated,
            numberOfAdImagesUploaded: numberOfAdImagesUploaded,
            totalRating: totalRating,
            totalThumbsUp: totalThumbsUp) {
    this._numberOfRooms = numberOfBeds;
    this._numberofBaths = numberofBaths;
    this._totalNmberOfFloors = totalNmberOfFloors;
    this._floorNumber = floorNumber;
    this._sizeInMarlas = sizeInMarlas;
    super.adType = _AD_TYPE;
  }

  double get sizeInMarlas => _sizeInMarlas;

  set sizeInMarlas(double value) {
    _sizeInMarlas = value;
  }

  int get floorNumber => _floorNumber;

  set floorNumber(int value) {
    _floorNumber = value;
  }

  int get totalNmberOfFloors => _totalNmberOfFloors;

  set totalNmberOfFloors(int value) {
    _totalNmberOfFloors = value;
  }

  int get numberofBaths => _numberofBaths;

  set numberofBaths(int value) {
    _numberofBaths = value;
  }

  int get numberOfBeds => _numberOfRooms;

  set numberOfBeds(int value) {
    _numberOfRooms = value;
  }

  String get AD_TYPE => _AD_TYPE;
}
