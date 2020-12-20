import 'package:flutter/foundation.dart';

abstract class  Ads {
  String _adTitle;
  String _adDescription;
  String _adOwnerId;
  int _adNumberByOwner;
  int _numberOfAdImagesUploaded;
  String _adLocation;
  String _adPostDate;
  int _adRent;
  bool _isAdDeactivated;
  int _totalThumbsUp;
  int _totalRating;
  String _adType;

  Ads(
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
        // String adType
      }) {
    this._adTitle = adTitle;
    this._adDescription = adDescription;
    this._adOwnerId = adOwnerId;
    this._adNumberByOwner = adNumberByOwner;
    this._numberOfAdImagesUploaded = numberOfAdImagesUploaded;
    this._adLocation = adLocation;
    this._adPostDate = adPostDate;
    this._adRent = adRent;
    this._isAdDeactivated = isAdDeactivated;
    this._totalThumbsUp = totalThumbsUp;
    this._totalRating = totalRating;
    this._adType = adType;
  }

  int get totalRating => _totalRating;

  set totalRating(int value) {
    _totalRating = value;
  }

  int get totalThumbsUp => _totalThumbsUp;

  set totalThumbsUp(int value) {
    _totalThumbsUp = value;
  }

  bool get isAdDeactivated => _isAdDeactivated;

  set isAdDeactivated(bool value) {
    _isAdDeactivated = value;
  }

  int get adRent => _adRent;

  set adRent(int value) {
    _adRent = value;
  }

  String get adPostDate => _adPostDate;

  set adPostDate(String value) {
    _adPostDate = value;
  }

  String get adLocation => _adLocation;

  set adLocation(String value) {
    _adLocation = value;
  }

  int get numberOfAdImagesUploaded => _numberOfAdImagesUploaded;

  set numberOfAdImagesUploaded(int value) {
    _numberOfAdImagesUploaded = value;
  }

  int get adNumberByOwner => _adNumberByOwner;

  set adNumberByOwner(int value) {
    _adNumberByOwner = value;
  }

  String get adOwnerId => _adOwnerId;

  set adOwnerId(String value) {
    _adOwnerId = value;
  }

  String get adDescription => _adDescription;

  set adDescription(String value) {
    _adDescription = value;
  }

  String get adTitle => _adTitle;

  set adTitle(String value) {
    _adTitle = value;
  }

  String get adType => _adType;

  set adType(String value) {
    _adType = value;
  }
}
