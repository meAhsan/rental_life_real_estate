import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:realestate/model/AdInfo.dart';
import 'package:realestate/model/user.dart';
import 'package:realestate/model/userInfo.dart';

class AdsFirestoreService {
  final String uid;

  AdsFirestoreService({this.uid});

  //Collection reference
  final CollectionReference userCollection =
  Firestore.instance.collection('ads_documents');

  //create a new ad document with uid
  Future updateAdData(String title, String description, String username) async {
    return await userCollection
        .document(uid)
        .setData(
        {'title': title, 'description': description, 'username': username});
  }

  //UserInfo list from snapshot
  List<AdData> _adsInfoListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return AdData(
          title: doc.data['title'] ?? '',
          description: doc.data['description'] ?? '',
          uid: doc.data['username'] ?? '');
    }).toList();
  }

  //Get user stream
  Stream<List<AdData>> get adsDocumentsStream {
    return userCollection.snapshots().map(_adsInfoListFromSnapshot);
  }
}