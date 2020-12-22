import 'package:flutter/foundation.dart';

abstract class  Ads {
  String adTitle;
  String adDescription;
  String adOwnerId;
  int adNumberByOwner;
  int numberOfAdImagesUploaded;
  String adLocation;
  String adPostDate;
  int adRent;
  bool isAdDeactivated;
  int totalThumbsUp;
  int totalRating;
  String adType;
  double latitude;
  double longitude;
  String locationDescription;
  DateTime dateTime = new DateTime.now();

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
    this.adTitle = adTitle;
    this.adDescription = adDescription;
    this.adOwnerId = adOwnerId;
    this.adNumberByOwner = adNumberByOwner;
    this.numberOfAdImagesUploaded = numberOfAdImagesUploaded;
    this.adLocation = adLocation;
    this.adPostDate = adPostDate;
    this.adRent = adRent;
    this.isAdDeactivated = isAdDeactivated;
    this.totalThumbsUp = totalThumbsUp;
    this.totalRating = totalRating;
    this.adType = adType;
  }

}
