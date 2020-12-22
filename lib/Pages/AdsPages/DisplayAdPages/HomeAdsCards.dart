import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:realestate/Pages/MenuPages/AppMenuDrawerOvalRight.dart';

import 'HomeAdDetailedDisplayPage.dart';

// FirebaseFirestore rootRef = FirebaseFirestore.getInstance();
// CollectionReference idsRef = rootRef.collection("ids");
// Query query = idsRef.orderBy("idNumber", Query.Direction.ASCENDING);

String categorySelected = "";
Color firstColor = Colors.deepOrangeAccent;
Color secondColor = Colors.white;
Color thirdColor = Colors.deepPurple;
Color fourthColor = Colors.grey;
// DocumentSnapshot docSnapshot;

class HomeAdsCardsPage extends StatefulWidget {
  //final DocumentSnapshot docSnapshots;

  //HomeAdsCardsPage(this.docSnapshots);

  @override
  _HomeAdsCardsPageState createState() => _HomeAdsCardsPageState();
}

class _HomeAdsCardsPageState extends State<HomeAdsCardsPage> {
  String sortingparameter = "dateTime";
  String currentSortingOrder = "Sort by Time";
  int minimumNumberOfRooms = 0;
  @override
  Widget build(BuildContext context) {
    //docSnapshot = widget.docSnapshots;
    // print(docSnapshot.data['adTitle']);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: firstColor,
        title: Text('Real Estate Properties'),

      ),

      drawer: AppMenuDrawerOvalRight(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 16.0),
              child: Text(
                "Categories",
                style: Theme.of(context).textTheme.subhead,
              ),
            ),
            CategoryChooser(),
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Card(
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    color: firstColor,
                  ),
                  child: Swiper(
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return Row(
                        children: <Widget>[
                          const SizedBox(width: 20.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Post Your Property For Rent",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                  ),
                                ),
                                Text(
                                  "Or Rent one with comfort",
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          CircleAvatar(
                            backgroundColor: thirdColor,
                            radius: 50,
                            child: Icon(

                              Icons.camera_alt_outlined,
                              size: 30,
                            ),
                          ),
                          const SizedBox(width: 20.0),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: <Widget>[
                  // Text(
                  //   "Recent Posts",
                  //   style: Theme.of(context).textTheme.subhead,
                  // ),
                  FlatButton(
                    child: Text(currentSortingOrder),
                    onPressed: () {
                      setState(() {
                        if(currentSortingOrder.compareTo("Sort by Time")==0){
                          currentSortingOrder = "Sort by price";
                          sortingparameter = "adRent";
                        }else{
                          currentSortingOrder = "Sort by Time";
                          sortingparameter = "dateTime";
                        }
                      });
                    },
                  ),
                  //Spacer(),
                  // SizedBox(
                  //   width: 10,
                  //   height: 10,
                    // child: TextFormField(
                    //   keyboardType: TextInputType.number,
                    //   decoration: InputDecoration(
                    //
                    //     suffixIcon: Icon(
                    //       Icons.search,
                    //       color: Colors.blueGrey,
                    //     ),
                    //     labelText: "Min # of Rooms",
                    //     border: OutlineInputBorder(),
                    //   ),
                    //   // validator: ((val) => (val.length <= 10 ||
                    //   //     val.length >= 180)
                    //   //     ? 'Bio should be minimum 10 and maximum 180 characters long.'
                    //   //     : null),
                    //   onChanged: (val) {
                    //     setState(() {
                    //       minimumNumberOfRooms = int.parse(val);
                    //     });
                    //   },
                    // ),
                  // ),
                  Spacer(),
                  FlatButton(
                    child: Text("Viewing all"),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            // HomeAdsListItem(docSnapshot),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),

              child: StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance
                      .collection('AdsDocument').orderBy(sortingparameter ,descending: true)//.limit(50)
                      .snapshots(),

                  // stream: Firestore.instance.collection('AdsDocument').snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                Container(
                                  //padding: const EdgeInsets.fromLTRB(16,0,16,0),
                                  child: HomeAdsListItem(
                                      snapshot.data.documents[index]),
                                ),
                                //SizedBox(height: 10,)
                              ],
                            );
                            //_listOfImages = [];
                            // for (int i = 0;
                            // i <
                            //     snapshot.data.documents[index].data['urls']
                            //         .length;
                            // i++) {
                            //   _listOfImages.add(NetworkImage(snapshot
                            //       .data.documents[index].data['urls'][i]));
                            // }
                            // return Column(
                            //   children: <Widget>[
                            //     Container(
                            //       margin: EdgeInsets.all(10.0),
                            //       height: 200,
                            //       decoration: BoxDecoration(
                            //         color: Colors.white,
                            //       ),
                            //       width: MediaQuery.of(context).size.width,
                            //       child: Carousel(
                            //           boxFit: BoxFit.cover,
                            //           images: _listOfImages,
                            //           autoplay: false,
                            //           indicatorBgPadding: 5.0,
                            //           dotPosition: DotPosition.bottomCenter,
                            //           animationCurve: Curves.fastOutSlowIn,
                            //           animationDuration:
                            //           Duration(milliseconds: 2000)),
                            //     ),
                            //     Container(
                            //       height: 1,
                            //       width: MediaQuery.of(context).size.width,
                            //       color: Colors.red,
                            //     )
                            //   ],
                            // );
                          });
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}

class CategoryChooser extends StatelessWidget {
  final Function(String) onTap;

  const CategoryChooser({
    Key key,
    this.onTap,
  }) : super(key: key);
  final List<String> types = const [
    "House",
    "Apartments",
    "Hostels",
    "Shops",
    "Offices",
    "Banquets",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 16.0,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: types.length,
        itemBuilder: (context, index) {
          String type = types[index];
          return GestureDetector(
            onTap: () => categorySelected = type,
            child: Column(
              children: <Widget>[
                Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage("" //bike
                            ),
                        fit: BoxFit.cover),
                    color: secondColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(height: 5.0),
                Text(
                  type,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) => SizedBox(
          width: 10.0,
        ),
      ),
    );
  }
}

class HomeAdsListItem extends StatelessWidget {
  final DocumentSnapshot _docSnapshot;

  HomeAdsListItem(this._docSnapshot);

  final elevation = 0.5;

  @override
  Widget build(BuildContext context) {
    final String title = _docSnapshot.data['adTitle'];
    return Card(
      elevation: elevation,
      child: InkWell(
        borderRadius: BorderRadius.circular(4.0),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomeAdDetailedDisplayPage(_docSnapshot)),
          );
        },
        child: Row(
          children: <Widget>[
            _buildThumbnail(_docSnapshot.data['ImagesURL'][0]),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14.0),
                            softWrap: true,
                          ),
                        ),
                        _buildTag(context)
                      ],
                    ),
                    const SizedBox(height: 5.0),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "${_docSnapshot.data['sizeInMarlas']} Marlas",
                          ),
                        ],
                      ),
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                    const SizedBox(height: 5.0),
                    Row(
                      children: <Widget>[
                        Text("Rating"),
                        const SizedBox(width: 10.0),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildThumbnail(String thumbnailImageURL) {
    return Container(
      height: 120,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: false
            ? BorderRadius.only(
                topRight: Radius.circular(4.0),
                bottomRight: Radius.circular(4.0),
              )
            : BorderRadius.only(
                topLeft: Radius.circular(4.0),
                bottomLeft: Radius.circular(4.0),
              ),
        image: DecorationImage(
          image: NetworkImage(thumbnailImageURL //null //bike
              ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Container _buildTag(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 8.0,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: thirdColor//Theme.of(context).primaryColor
      ),
      child: Text(
        "Rs. ${_docSnapshot.data['adRent']}",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
