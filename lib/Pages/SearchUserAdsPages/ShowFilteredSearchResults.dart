import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:realestate/ModelClasses/SearchModelClasses/SearchHomeAds.dart';
import 'package:realestate/Pages/AdsPages/DisplayAdPages/HomeAdDetailedDisplayPage.dart';

class ShowFilteredSearchResults extends StatefulWidget {
  SearchHomeAds _searchHomeAds;

  ShowFilteredSearchResults(this._searchHomeAds);

  @override
  _ShowFilteredSearchResultsState createState() => _ShowFilteredSearchResultsState();

}


String categorySelected = "";
Color firstColor = Colors.deepOrangeAccent;
Color secondColor = Colors.white;
Color thirdColor = Colors.deepPurple;
Color fourthColor = Colors.grey;

class _ShowFilteredSearchResultsState extends State<ShowFilteredSearchResults> {

  String sortingparameter = "dateTime";
  String currentSortingOrder = "Sort by Time";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: firstColor,
        title: Text('Search Results'),

      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Padding(
            //   padding: const EdgeInsets.only(left: 16.0, top: 16.0),
            //   child: Text(
            //     "Categories",
            //     style: Theme.of(context).textTheme.subhead,
            //   ),
            // ),
            // CategoryChooser(),
            // const SizedBox(height: 10.0),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
            //   child: Card(
            //     child: Container(
            //       height: 150,
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(4.0),
            //         color: firstColor,
            //       ),
            //       child: Swiper(
            //         itemCount: 2,
            //         itemBuilder: (context, index) {
            //           return Row(
            //             children: <Widget>[
            //               const SizedBox(width: 20.0),
            //               Expanded(
            //                 child: Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   mainAxisAlignment: MainAxisAlignment.center,
            //                   children: <Widget>[
            //                     Text(
            //                       "Post Your Property For Rent",
            //                       style: TextStyle(
            //                         color: Colors.white,
            //                         fontWeight: FontWeight.bold,
            //                         fontSize: 20.0,
            //                       ),
            //                     ),
            //                     Text(
            //                       "Or Rent one with comfort",
            //                       style: TextStyle(
            //                         color: Colors.white70,
            //                         fontWeight: FontWeight.w500,
            //                         fontSize: 18.0,
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //               const SizedBox(width: 10.0),
            //               CircleAvatar(
            //                 backgroundColor: thirdColor,
            //                 radius: 50,
            //                 child: Icon(
            //
            //                   Icons.camera_alt_outlined,
            //                   size: 30,
            //                 ),
            //               ),
            //               const SizedBox(width: 20.0),
            //             ],
            //           );
            //         },
            //       ),
            //     ),
            //   ),
            // ),
            // const SizedBox(height: 16.0),
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
