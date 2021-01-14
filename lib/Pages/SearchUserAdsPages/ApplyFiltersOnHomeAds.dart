import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:realestate/ModelClasses/SearchModelClasses/SearchHomeAds.dart';
import 'package:realestate/Pages/SearchUserAdsPages/ShowFilteredSearchResults.dart';
import 'package:search_map_place/search_map_place.dart';

class ApplyFiltersOnHomeAds extends StatefulWidget {
  @override
  _ApplyFiltersOnHomeAdsState createState() => _ApplyFiltersOnHomeAdsState();
}

class _ApplyFiltersOnHomeAdsState extends State<ApplyFiltersOnHomeAds> {
  Color firstColor = Colors.deepOrangeAccent;
  Color secondColor = Colors.white;
  Color thirdColor = Colors.deepPurple;
  Color fourthColor = Colors.grey;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  bool _formChanged = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool loading = false;

  String radius;
  bool isRadiusEnabled = false;
  String minRoomNumber = null;
  String maxRoomNumber;
  String minHouseSize = null;
  String maxHouseSize;
  String buildingHeight;
  String FloorAtRent;

  double latitude;
  double longitude;
  String locationDescription;
  Position _currentPosition;

  // Location location = new Location();
  LatLng latLng;

  // LocationData _locationData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: firstColor,
          title: Text("Apply Filters For Home Ads"),
        ),
        body: SingleChildScrollView(
            child: Container(
                margin: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Form(
                  onChanged: _onFormChange,
                  onWillPop: _onWillPop,
                  key: _formKey,
                  child: ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(16.0),
                    children: <Widget>[
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.number,
                        autofocus: true,
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            FontAwesomeIcons.questionCircle,
                            color: Colors.blueGrey,
                          ),
                          labelText: "Radius in meters",
                          hintText: "Optional",
                          border: OutlineInputBorder(),
                        ),
                        validator: ((val) {
                          if (val == null) {
                            setState(() {
                              isRadiusEnabled = false;
                              print("Radius disabled");
                            });
                          } else {
                            try {
                              if (val.length == 0) {
                                return null;
                              }
                              // if (val.length == 1 || val.length > 6) {
                              //   setState(() {
                              //     isRadiusEnabled = false;
                              //   });
                              //   return ("Radius is not in the range");
                              // }
                              if (int.parse(val) < 10) {
                                setState(() {
                                  isRadiusEnabled = false;
                                });
                                return 'Radius should be more than 10 meters';
                              } else if (int.parse(val) > 100000) {
                                setState(() {
                                  isRadiusEnabled = false;
                                });
                                return 'Radius shouldn\'t be more than 100 kilometers';
                              } else {
                                setState(() {
                                  isRadiusEnabled = true;
                                  print("Radius Enabled");
                                });
                                return null;
                              }
                            } catch (e) {
                              if(val.length>0 || val.length<7){
                                return null;
                              }
                              return "Invalid input";
                              print("Error $e");
                            }
                          }

                          return null;
                        }),
                        onChanged: (val) {
                          setState(() {
                            radius = val;
                          });
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      if (isRadiusEnabled) Text("Enter your center Location"),
                      if (isRadiusEnabled)
                        SizedBox(
                          height: 10,
                        ),
                      if (isRadiusEnabled)
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
                      if (isRadiusEnabled)
                        SizedBox(
                          height: 20,
                        ),
                      if (!isRadiusEnabled)
                        Text(
                          "Radius disabled",
                          style: TextStyle(color: thirdColor),
                        ),
                      // if (!isRadiusEnabled)
                      //   SizedBox(
                      //     height: 20,
                      //   ),

                      Divider(
                        height: 32.0,
                      ),

                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            FontAwesomeIcons.restroom,
                            color: Colors.blueGrey,
                          ),
                          labelText: "Min No. of Rooms",
                          hintText: "Optional",
                          border: OutlineInputBorder(),
                        ),
                        validator: ((val) {
                          if (val.length == 0) {
                            return null;
                          }
                          if (val == null) {
                            return null;
                          }
                          try {
                            if (int.parse(val) < 0) {
                              return "Min Rooms can't be negative";
                            }
                            return null;
                          } catch (e) {
                            return "Invalid input";
                          }
                        }),
                        onChanged: (val) {
                          setState(() {
                            minRoomNumber = val;
                          });
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            FontAwesomeIcons.restroom,
                            color: Colors.blueGrey,
                          ),
                          labelText: "Max No. of Rooms",
                          hintText: "Optional",
                          border: OutlineInputBorder(),
                        ),
                        validator: ((val) {
                          if (val.length == 0) {
                            return null;
                          }
                          try {
                            if (int.parse(val) < 0) {
                              return "Max no. of Rooms can't be negative";
                            }
                            if (minRoomNumber.length != 0) {
                              if (int.parse(maxRoomNumber) <
                                  int.parse(minRoomNumber)) {
                                return "Invalid no. of min and max rooms.";
                              }
                            }

                            return null;
                          } catch (e) {
                            return "Invalid input";
                          }
                        }),
                        onChanged: (val) {
                          setState(() {
                            maxRoomNumber = val;
                          });
                        },
                      ),

                      // SizedBox(
                      //   height: 20,
                      // ),
                      //

                      Divider(
                        height: 32.0,
                      ),

                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            FontAwesomeIcons.home,
                            color: Colors.blueGrey,
                          ),
                          labelText: "Min House Size",
                          hintText: "Optional",
                          border: OutlineInputBorder(),
                        ),
                        validator: ((val) {
                          if (val.length == 0) {
                            return null;
                          }
                          if (val == null) {
                            return null;
                          } else {
                            try {
                              if (int.parse(val) < 0) {
                                return "Min House Size can't be negative";
                              }
                              return null;
                            } catch (e) {
                              return "Invalid input";
                            }
                          }
                        }),
                        onChanged: (val) {
                          setState(() {
                            minHouseSize = val;
                          });
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            FontAwesomeIcons.home,
                            color: Colors.blueGrey,
                          ),
                          labelText: "Max House Size",
                          hintText: "Optional",
                          border: OutlineInputBorder(),
                        ),
                        validator: ((val) {
                          if (val.length == 0) {
                            return null;
                          }
                          try {
                            if (int.parse(val) < 0) {
                              return "Max House Size can't be negative";
                            }
                            if (minHouseSize.length != 0) if (int.parse(
                                    maxHouseSize) <
                                int.parse(minHouseSize)) {
                              return "Invalid no. of min and max house sizes.";
                            }
                            return null;
                          } catch (e) {
                            return "Invalid input";
                          }
                        }),
                        onChanged: (val) {
                          setState(() {
                            maxHouseSize = val;
                          });
                        },
                      ),
                      Divider(
                        height: 32.0,
                      ),

                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.apartment,
                            color: Colors.blueGrey,
                          ),
                          labelText: "Total Floors in building",
                          hintText: "Optional",
                          border: OutlineInputBorder(),
                        ),
                        validator: ((val) {
                          if (val.length == 0) {
                            return null;
                          }
                          try {
                            if (int.parse(val) < 0) {
                              return "Building Height can't be negative";
                            }
                            return null;
                          } catch (e) {
                            return "Invalid input";
                          }
                        }),
                        onChanged: (val) {
                          setState(() {
                            buildingHeight = val;
                          });
                        },
                      ),

                      SizedBox(
                        height: 20,
                      ),

                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.apartment,
                            color: Colors.blueGrey,
                          ),
                          labelText: "Floors At Rent",
                          hintText: "Optional",
                          border: OutlineInputBorder(),
                        ),
                        validator: ((val) {
                          if (val.length == 0) {
                            return null;
                          }
                          try {
                            if (int.parse(val) < 0) {
                              return "Building Height can't be negative";
                            }
                            return null;
                          } catch (e) {
                            return "Invalid input";
                          }
                        }),
                        onChanged: (val) {
                          setState(() {
                            FloorAtRent = val;
                          });
                        },
                      ),

                      Divider(
                        height: 32.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FlatButton(
                              textColor: Colors.red[400],
                              child: Text("Cancel"),
                              onPressed: () async {
                                bool toCancel = await _onWillPop();
                                if (toCancel) {
                                  //Navigator.pop(context);
                                  // _firebaseUserAuthenticationService.signOut();
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RaisedButton(
                                color: Colors.red,
                                textColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Text("Apply"),
                                onPressed: (() {
                                  applySearchFilters();
                                })),
                          )
                        ],
                      ),
                    ],
                  ),
                ))));
    // );
  }

  void applySearchFilters(){

    int rad;
    int minRoomNum = null;
    int maxRoomNum;
    int minHouseSiz = null;
    int maxHouseSiz;
    int buildingH;
    int FloorAtR;

    if(radius!=null){
      rad = int.parse(radius);
    }if(minRoomNumber!=null){
      minRoomNum = int.parse(minRoomNumber);
    }if(maxRoomNumber!=null){
      maxRoomNum = int.parse(maxRoomNumber);
    }if(minHouseSize!=null){
      minHouseSiz = int.parse(minHouseSize);
    }if(maxHouseSize!=null){
      maxHouseSiz = int.parse(maxHouseSize);
    }if(buildingHeight!=null){
      buildingH = int.parse(buildingHeight);
    }if(FloorAtRent!=null){
      FloorAtR = int.parse(FloorAtRent);
    }


    SearchHomeAds searchHomeAds = new SearchHomeAds(
      radius: rad,
      minRoomNumber: minRoomNum,
      maxRoomNumber: maxRoomNum,
      minHouseSize: minHouseSiz,
      maxHouseSize: maxHouseSiz,
      buildingHeight: buildingH,
      floorAtRent: FloorAtR,
      centerLatitude: latitude,
      centerLongitude: longitude,
      centerLatLng: latLng,
      centerLocationDescription: locationDescription,
    );

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ShowFilteredSearchResults(searchHomeAds)));
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
}
