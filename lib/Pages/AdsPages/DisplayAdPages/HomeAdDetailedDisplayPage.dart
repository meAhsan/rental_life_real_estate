import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

// import 'package:flutter_ui_challenges/core/presentation/res/assets.dart';
// import 'package:flutter_ui_challenges/src/widgets/network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
Color firstColor = Colors.deepOrangeAccent;
Color secondColor = Colors.white;
Color thirdColor = Colors.deepPurple;
Color fourthColor = Colors.grey;

DocumentSnapshot docSnapshotForAD;

class HomeAdDetailedDisplayPage extends StatelessWidget {
  final DocumentSnapshot _docSnapshot;

  HomeAdDetailedDisplayPage(this._docSnapshot);

  final TextStyle bold = TextStyle(fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    docSnapshotForAD = _docSnapshot;
    final String title = "Home For Rent";
    List<String> _listOfImages = <String>[];
    _listOfImages = [];
    for (int i = 0; i < _docSnapshot.data['ImagesURL'].length; i++) {
      _listOfImages.add(_docSnapshot.data['ImagesURL'][i]);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: firstColor,
        title: Text(title),
        elevation: 0,
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      height: 500,
                      width: double.infinity,
                      child: ViewImages(),//SlidersPage(_listOfImages),
                    ),
                    Positioned(
                      left: 10.0,
                      bottom: 10.0,
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 10.0,
                      bottom: 0,
                      child: Chip(

                        elevation: 0,
                        labelStyle: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                        backgroundColor: firstColor,
                        label: Text("Rs. ${_docSnapshot.data['adRent']}"),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 6.0, bottom: 4.0),
                        child: Text(
                          "Key Specs",
                          style: Theme.of(context).textTheme.title,
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: <Widget>[
                            SpecsBlock(
                              label: "Rooms",
                              value: "${_docSnapshot.data['numberOfRooms']}",
                              icon: Icon(
                                Icons.apps,
                              ),
                            ),
                            SpecsBlock(
                              label: "Bath",
                              value: "${_docSnapshot.data['numberOfBaths']}",
                              icon: Icon(
                                Icons.apps,
                              ),
                            ),
                            SpecsBlock(
                              label: "Building Height",
                              value:
                                  "${_docSnapshot.data['totalNumberOfFloors']} floors",
                              icon: Icon(
                                Icons.apps,
                              ),
                            ),
                            SpecsBlock(
                              label: "Floor for Rent",
                              value:
                                  "${_docSnapshot.data['floorNumber']} floor",
                              icon: Icon(
                                Icons.apps,
                              ),
                            ),
                            SpecsBlock(
                              label: "Size",
                              value:
                                  "${_docSnapshot.data['sizeInMarlas']} Marlas",
                              icon: Icon(
                                Icons.apps,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 6.0, bottom: 4.0),
                        child: Text(
                          "Description:",
                          style: Theme.of(context).textTheme.subhead,
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 6.0, bottom: 4.0),
                        child: Text("${_docSnapshot.data['description']}"),
                      ),
                      const SizedBox(height: 10.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 6.0, bottom: 4.0),
                        child: Text(
                          "Further Details",
                          style: Theme.of(context).textTheme.title,
                        ),
                      ),
                      BorderedContainer(
                        padding: const EdgeInsets.all(0),
                        margin: const EdgeInsets.symmetric(vertical: 4.0),
                        child: ListTile(
                          title: Text("Owner Name"),
                          trailing: Text(
                            "${_docSnapshot.data['adOwnerName']}",
                            style: bold,
                          ),
                        ),
                      ),
                      BorderedContainer(
                        padding: const EdgeInsets.all(0),
                        margin: const EdgeInsets.symmetric(vertical: 4.0),
                        child: ListTile(
                          title: Text("Phone No."),
                          trailing: Text(
                            "${_docSnapshot.data['phoneNumber']}",
                            style: bold,
                          ),
                        ),
                      ),
                      BorderedContainer(
                        padding: const EdgeInsets.all(0),
                        margin: const EdgeInsets.symmetric(vertical: 4.0),
                        child: ListTile(
                          // title: Text("Location"),
                          trailing: Text(
                            "Location: ${_docSnapshot.data['locationDescription']}",
                            style: bold,
                          ),
                        ),
                      ),
                      BorderedContainer(
                        margin: const EdgeInsets.symmetric(vertical: 4.0),
                        padding: const EdgeInsets.all(0),
                        child: ListTile(
                          title: Text("Ad Date/Time"),
                          trailing: Text(
                            "${_docSnapshot.data['dateTime'].toDate()}.",
                            style: bold,
                          ),
                        ),
                      ),
                      // BorderedContainer(
                      //   margin: const EdgeInsets.symmetric(
                      //     vertical: 4.0,
                      //   ),
                      //   padding: const EdgeInsets.all(0),
                      //   child: ListTile(
                      //     title: Text("Ground Clearance"),
                      //     trailing: Text(
                      //       "150 mm",
                      //       style: bold,
                      //     ),
                      //   ),
                      // ),
                      // BorderedContainer(
                      //   margin: const EdgeInsets.symmetric(
                      //     vertical: 4.0,
                      //   ),
                      //   padding: const EdgeInsets.all(0),
                      //   child: ListTile(
                      //     title: Text("Seat height"),
                      //     trailing: Text(
                      //       "700 mm",
                      //       style: bold,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                const SizedBox(height: 30.0),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: RaisedButton.icon(
              color: firstColor,
              textColor: Colors.white,
              icon: Icon(Icons.message),
              label: Text("Message Seller"),
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }
}


class ViewImages extends StatelessWidget {
  List<NetworkImage> _listOfImages = <NetworkImage>[];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 0,
        ),
        Flexible(
          child: ListView.builder(
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) {
                _listOfImages = [];
                for (int i = 0;
                i < docSnapshotForAD.data['ImagesURL'].length;
                i++) {
                  _listOfImages
                      .add(NetworkImage(docSnapshotForAD.data['ImagesURL'][i]));
                }
                return Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(0),
                      height: 500,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: Carousel(
                          boxFit: BoxFit.cover,
                          images: _listOfImages,
                          autoplay: false,
                          indicatorBgPadding: 5.0,
                          dotPosition: DotPosition.bottomCenter,
                          animationCurve: Curves.fastOutSlowIn,
                          animationDuration: Duration(milliseconds: 2000)),
                    ),
                    Container(
                      height: 1,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.red,
                    )
                  ],
                );
              }),

          // child: StreamBuilder<QuerySnapshot>(
          //     stream: Firestore.instance.collection('ImagesURL').snapshots(),
          //     builder: (context, snapshot) {
          //       if (snapshot.hasData) {
          //
          //       } else {
          //         return Center(
          //           child: CircularProgressIndicator(),
          //         );
          //       }
          //     })
        )
      ],
    );
  }
}



class BorderedContainer extends StatelessWidget {
  final String title;
  final Widget child;
  final double height;
  final double width;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final Color color;
  final double elevation;

  const BorderedContainer({
    Key key,
    this.title,
    this.child,
    this.height,
    this.padding,
    this.margin,
    this.color,
    this.width = double.infinity,
    this.elevation = 0.5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      color: color,
      margin: margin ?? const EdgeInsets.all(0),
      child: Container(
        padding: padding ?? const EdgeInsets.all(16.0),
        width: width,
        height: height,
        child: title == null
            ? child
            : Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 28.0),
                  ),
                  if (child != null) ...[const SizedBox(height: 10.0), child]
                ],
              ),
      ),
    );
  }
}

class SpecsBlock extends StatelessWidget {
  const SpecsBlock({
    Key key,
    this.icon,
    this.label,
    this.value,
  }) : super(key: key);

  final Widget icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            icon,
            const SizedBox(height: 2.0),
            Text(
              label,
              style: TextStyle(
                color: Colors.grey.shade800,
              ),
            ),
            const SizedBox(height: 5.0),
            Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PNetworkImage extends StatelessWidget {
  //final String image;
  final BoxFit fit;
  final double width, height;

  const PNetworkImage({Key key, this.fit, this.height, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      "https://lh3.googleusercontent.com/ogw/ADGmqu_y5fygpa9lyMo25tkCPurKjT0K579xX5UCogHaBw=s83-c-mo",
      // placeholder: (context, url) => Center(child: CircularProgressIndicator()),
      // errorWidget: (context, url, error) => Image.asset('assets/placeholder.jpg',fit: BoxFit.cover,),
      fit: fit,
      width: width,
      height: height,
    );
  }
}

class PNetworkImageForSlider extends StatelessWidget {
  final String image;
  final BoxFit fit;
  final double width, height;

  const PNetworkImageForSlider(this.image,
      {Key key, this.fit, this.height, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      image,
      // placeholder: (context, url) => Center(child: CircularProgressIndicator()),
      // errorWidget: (context, url, error) => Image.asset('assets/placeholder.jpg',fit: BoxFit.cover,),
      fit: fit,
      width: width,
      height: height,
    );
  }
}

class SlidersPage extends StatelessWidget {
  final List<String> images;

  SlidersPage(this.images);

  // final List<String> images = [
  //   avatars[0],
  //   breakfast,
  //   fishtail,
  //   avatars[2],
  //   pancake,
  //   fewalake,
  //   avatars[3],
  //   fries,
  //   kathmandu1,
  //   avatars[1],
  //   burger,
  //   pashupatinath,
  // ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sliders'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              color: Colors.grey.shade800,
              padding: EdgeInsets.all(16.0),
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: PNetworkImageForSlider(
                      images[index],
                      fit: BoxFit.cover,
                    ),
                  );
                },
                itemCount: 10,
                viewportFraction: 0.8,
                scale: 0.9,
                pagination: SwiperPagination(),
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              height: 300,
              color: Colors.grey.shade800,
              padding: EdgeInsets.all(16.0),
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: PNetworkImageForSlider(
                      images[index],
                      fit: BoxFit.cover,
                    ),
                  );
                },
                itemWidth: 300,
                itemCount: 10,
                layout: SwiperLayout.STACK,
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              height: 340,
              color: Colors.grey.shade800,
              padding: EdgeInsets.all(16.0),
              child: Swiper(
                fade: 0.0,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: <Widget>[
                      Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0)),
                            image: DecorationImage(
                                image: NetworkImage(images[index]),
                                fit: BoxFit.cover)),
                      ),
                      Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10.0),
                                  bottomRight: Radius.circular(10.0))),
                          child: ListTile(
                            subtitle: Text("awesome image caption"),
                            title: Text("Awesome image"),
                          ))
                    ],
                  );
                },
                itemCount: 10,
                scale: 0.9,
                pagination: SwiperPagination(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
