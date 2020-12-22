import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:realestate/ModelClasses/UserModelClasses/RentalLifeUser.dart';
// import 'package:location/location.dart';

// import 'package:location/location.dart';
import 'package:realestate/screens/ads/set_Location.dart';
import 'package:search_map_place/search_map_place.dart';
import 'dart:math' as Math;

class HomeAdDescriptionPage extends StatefulWidget {
  final GlobalKey<FormState> _formKey;
  final _rentalLifeUser;

  HomeAdDescriptionPage(this._formKey, this._rentalLifeUser);

  @override
  _HomeAdDescriptionPageState createState() => _HomeAdDescriptionPageState();
}

String description;
double latitude;
double longitude;
String locationDescription;
Position _currentPosition;

class _HomeAdDescriptionPageState extends State<HomeAdDescriptionPage>
    with AutomaticKeepAliveClientMixin<HomeAdDescriptionPage> {
  @override
  bool get wantKeepAlive => true;

  // Location location = new Location();
  LatLng latLng;

  // LocationData _locationData;
  bool _formChanged = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Form(
          onChanged: _onFormChange,
          onWillPop: _onWillPop,
          key: widget._formKey,
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(16.0),
            children: <Widget>[
              TextFormField(
                // initialValue: widget._rentalLifeUser.bio,
                maxLines: 10,
                decoration: InputDecoration(
                  suffixIcon: Icon(
                    Icons.info,
                    color: Colors.blueGrey,
                  ),
                  labelText: "Enter Ad Description ",
                  hintText: "Required",
                  border: OutlineInputBorder(),
                ),
                validator: ((val) {
                  if (val.length <= 28 || val.length >= 250)
                    return 'Description should be within 28 and 250 characters.';
                  if (latitude == null ||
                      longitude == null ||
                      locationDescription == null) {
                    return 'Please select the location below from search bar \n(Recommended)';
                  } else {
                    return null;
                  }
                }),
                onChanged: (val) {
                  setState(() {
                    description = val;
                  });
                },
                onSaved: (newValue) async {
                  await storeAdDescriptionDataToDocument();
                },
              ),
              Divider(
                height: 32.0,
              ),
              SizedBox(
                height: 10,
              ),
              RaisedButton.icon(
                color: Colors.deepOrangeAccent,
                label: Text("Use my current location"),
                icon: Icon(Icons.location_on_outlined),
                onPressed: () {
                  // _getCurrentLocation();
                  if (_currentPosition != null)
                    print(
                        "LAT: ${_currentPosition.latitude}, LNG: ${_currentPosition.longitude}");
                  // location.getLocation();
                  // bool _serviceEnabled;
                  // PermissionStatus _permissionGranted;
                  //
                  // _serviceEnabled = await location.serviceEnabled();
                  // if (!_serviceEnabled) {
                  //   _serviceEnabled = await location.requestService();
                  //   if (!_serviceEnabled) {
                  //     return;
                  //   }
                  // }
                  //
                  // _permissionGranted = await location.hasPermission();
                  // if (_permissionGranted == PermissionStatus.denied) {
                  //   _permissionGranted = await location.requestPermission();
                  //   if (_permissionGranted != PermissionStatus.granted) {
                  //     return;
                  //   }
                  // }
                  // print("In location method");
                  // _locationData = await location.getLocation();
                  // latitude = _locationData.latitude;
                  // longitude = _locationData.longitude;
                  // print(_locationData.latitude);
                  // print(_locationData);
                  // print(_locationData.longitude);
                  // print(_locationData.toString());
                  //
                  // // Position position = await Geolocator()
                  // //     .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
                  // // print(position);
                  //
                  // distance(_locationData.latitude, _locationData.longitude,
                  //     latLng.latitude, latLng.longitude);
                },
              ),
              SizedBox(
                height: 10,
              ),
              SearchMapPlaceWidget(
                  apiKey: 'AIzaSyBUILBxCa5yyQZawAAOpD6HII48R3haimM',
                  iconColor: Colors.deepOrangeAccent,
                  // The language of the autocompletion
                  //icon: Icons.add_location,
                  language: 'en',
                  // The position used to give better recomendations. In this case we are using the user position
                  // location: userPosition.coordinates,
                  // radius: 30000,
                  // darkMode: true,
                  onSelected: (Place place) async {
                    try {
                      final geolocation = await place.geolocation;
                      latLng = geolocation.coordinates;
                      latitude = latLng.latitude;
                      longitude = latLng.longitude;
                      locationDescription = place.description;
                      print(latLng.latitude);
                      print(latLng.longitude);
                      print(place.description);
                      //newAd.location = geolocation;
                      //   newAd.location = geolocation.coordinates;

                    } catch (e) {
                      print(e);
                    }
                  }),
              SizedBox(
                height: 20,
              ),
              Visibility(
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                // visible: widgetVisible,
                child: SizedBox(
                    height: 300,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                        color: Colors.redAccent,
                      )),
                      //child: LocationWidget(),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future storeAdDescriptionDataToDocument() async {
    return await Firestore.instance
        .collection('AdsDocument')
        .document(getDocumentName())
        .updateData({
      'description': description,
      'locationDescription': locationDescription,
      'latitude': latitude,
      'longitude': longitude
    });
  }


  String getDocumentName() {
    print("In getDocument Name of Description page");
    String adDocumentName = widget._rentalLifeUser.uid;
    print(adDocumentName);
    String numberOfAds = widget._rentalLifeUser.totalAdsPosted.toString();
    print(numberOfAds);
    adDocumentName = adDocumentName + numberOfAds;
    print("adDocumentName $adDocumentName");
    return adDocumentName;
  }

  void distance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295; // Math.PI / 180
    var c = Math.cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    print("DISTANCE: ");
    print(12742 * Math.asin(Math.sqrt(a))); // 2 * R; R = 6371 km
  }

  void _onFormChange() {
    setState(() {
      _formChanged = true;
    });
  }

  Future<bool> _onWillPop() {
    if (!_formChanged) return Future<bool>.value(true);
    return showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
                content: Text(
                    "Are you sure you want to abandon the form? Any changes will be lost."),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Cancel"),
                    onPressed: () => Navigator.of(context).pop(false),
                    textColor: Colors.black,
                  ),
                  FlatButton(
                    child: Text("Abandon"),
                    textColor: Colors.red,
                    onPressed: () => Navigator.pop(context, true),
                  ),
                ],
              ) ??
              false;
        });
  }

// _getCurrentLocation() {
//   final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
//
//   geolocator
//       .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
//       .then((Position position) {
//     setState(() {
//       _currentPosition = position;
//     });
//   }).catchError((e) {
//     print(e);
//   });
// }
}
