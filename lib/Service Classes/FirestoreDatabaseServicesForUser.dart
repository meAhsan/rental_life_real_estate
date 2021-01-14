import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:realestate/ModelClasses/UserModelClasses/RentalLifeUser.dart';

class FirestoreDatabaseServicesForUser {
  final String rentalLifeUserID;

  FirestoreDatabaseServicesForUser({@required this.rentalLifeUserID});

//Collection reference
  final CollectionReference userCollectionFirestore =
      Firestore.instance.collection('user');

//create a new document with uid
  Future updateUserName(String userName) async {
    return await userCollectionFirestore
        .document(rentalLifeUserID)
        .setData({'user name': userName});
  }

  // //create a new document with uid
  // Future createRentalLifeUserFirestoreDocument(
  //     {String name, String email}) async {
  //   return await userCollectionFirestore.document(rentalLifeUserID).setData({
  //     'name': name,
  //     'email': email,
  //   });
  // }

  //create a new document with uid
  Future createRentalLifeUserFirestoreDocument(
      RentalLifeUser rentalLifeUser) async {
    return await userCollectionFirestore.document(rentalLifeUserID).setData({
      'name': rentalLifeUser.name,
      'email': rentalLifeUser.emailAddress,
      'age': rentalLifeUser.age,
      'phoneNum': rentalLifeUser.phoneNum,
      'bio': rentalLifeUser.bio,
      'userDisplayImageAddress': rentalLifeUser.userDisplayImageAddress,
      'totalAdsPosted': rentalLifeUser.totalAdsPosted,
      'totalTenantsConnected': rentalLifeUser.totalTenantsConnected,
      'totalOwnersConnected': rentalLifeUser.totalOwnersConnected,
      'adsDocumentsId': rentalLifeUser.adsDocumentIdList
    });
  }

  Future<RentalLifeUser> getRentalLifeUserFromFireStoreDocument() async {
    final userFirestoreDocumentReference =
        Firestore.instance.collection('user').document(rentalLifeUserID);
    final DocumentSnapshot docSnapshot =
        await userFirestoreDocumentReference.get();
    // DocumentSnapshot snapshot = userFirestoreDocumentReference.snapshots();
    RentalLifeUser rentalLifeUser = RentalLifeUser(
      userID: rentalLifeUserID,
      name: docSnapshot.data['name'],
      phoneNum: docSnapshot.data['phoneNum'],
      age: docSnapshot.data['age'],
      emailAddress: docSnapshot.data['email'],
      bio: docSnapshot.data['bio'],
      totalAdsPosted: docSnapshot.data['totalAdsPosted'],
      userDisplayImageAddress: docSnapshot.data['userDisplayImageAddress'],
      totalTenantsConnected: docSnapshot.data['totalTenantsConnected'],
      totalOwnersConnected: docSnapshot.data['totalOwnersConnected'],
      // adsDocumentsIdList: (docSnapshot.data["adsDocumentsId"]),
      // adsDocumentsIdList: (List < String>) docSnapshot.data"dungeon_group"];
    );

    bool isAdsIDsExists;
    try {
      isAdsIDsExists = (docSnapshot.data['adDocumentsId'].exists != null);
      isAdsIDsExists = true;
    } catch (e) {
      isAdsIDsExists = false;
      print("ERROR CATCHED1: $e");
    }
    List<String> _adsDocumentsIdList = <String>[];
    if (isAdsIDsExists) {
      for (int i = 0; i < docSnapshot.data['adDocumentsId'].length; i++) {
        _adsDocumentsIdList.add(docSnapshot.data['adDocumentsId'][i]);
      }
    }
    rentalLifeUser.adsDocumentsIdList = _adsDocumentsIdList;
    return rentalLifeUser;
  }

  void updateUserDocumentWithAdDocumentsIDs(String newAdId) {}

  Future<List<String>> getUserAdsDocumentsList() async {
    final userFirestoreDocumentReference =
        Firestore.instance.collection('user').document(rentalLifeUserID);
    final DocumentSnapshot docSnapshot =
        await userFirestoreDocumentReference.get();
    bool isAdsIDsExists;
    try {
      isAdsIDsExists = (docSnapshot.data['adDocumentsId'].exists != null);
      isAdsIDsExists = true;
    } catch (e) {
      isAdsIDsExists = false;
      print("ERROR CATCHED2: $e");
    }
    List<String> _adsDocumentsIdList = <String>[];
    if (isAdsIDsExists) {
      for (int i = 0; i < docSnapshot.data['adDocumentsId'].length; i++) {
        _adsDocumentsIdList.add(docSnapshot.data['adDocumentsId'][i]);
      }
    }
    return _adsDocumentsIdList;
  }

//create a new document with uid
  Future updateRentalLifeUserData({String name, String email, int age}) async {
    return await userCollectionFirestore
        .document(rentalLifeUserID)
        .setData({'name': name, 'email': email, 'age': age});
  }

// //create a new document with uid
// Future updateUserData(String firstName, String lastName, String email, int age) async {
//   return await userCollection
//       .document(uid)
//       .setData({'first name': firstName,'last name': lastName, 'email': email, 'age': age});
// }

//UserInfo list from snapshot
  List<RentalLifeUser> _userInfoListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((firebaseDocument) {
      return RentalLifeUser(
          userID: rentalLifeUserID,
          name: firebaseDocument.data['name'],
          age: firebaseDocument.data['age'],
          emailAddress: firebaseDocument.data['emailAddress'],
          totalAdsPosted: firebaseDocument.data['totalAdsPosted'],
          userDisplayImageAddress:
              firebaseDocument.data['userDisplayImageAddress']);
    }).toList();
  }

//Get user stream
  Stream<List<RentalLifeUser>> get userDocumentsStream {
    return userCollectionFirestore.snapshots().map(_userInfoListFromSnapshot);
  }

//Convert document snapshot into RentalLifeUser object
  RentalLifeUser _userDocumentDataFromSnapshot(DocumentSnapshot snapshot) {
    return RentalLifeUser(
        userID: rentalLifeUserID,
        name: snapshot.data['name'],
        age: snapshot.data['age'],
        emailAddress: snapshot.data['emailAddress'],
        totalAdsPosted: snapshot.data['totalAdsPosted'],
        userDisplayImageAddress: snapshot.data['userDisplayImageAddress']);
  }

//Get user document Stream
  Stream<RentalLifeUser> get userDataDocument {
    return userCollectionFirestore
        .document(rentalLifeUserID)
        .snapshots()
        .map(_userDocumentDataFromSnapshot);
  }


  getUserByName (String username) async {

    return await Firestore.instance.collection('user')
        .where('name',isEqualTo: username).getDocuments();

  }

  createChatRoom(String chatRoomId, chatRoomMap){
    Firestore.instance.collection('ChatRoom')
        .document(chatRoomId).setData(chatRoomMap).catchError((e){
      print(e.toString());
    });
  }

  addConversationMessages(String ChatRoomId, messageMap){
    Firestore.instance.collection("ChatRoom")
        .document(ChatRoomId)
        .collection("chats")
        .add(messageMap).catchError((e){print(e.toString());});

  }

  getConversationMessages(String ChatRoomId) async{
    return await Firestore.instance.collection("ChatRoom")
        .document(ChatRoomId)
        .collection("chats")
        .orderBy("time", descending: false)
        .snapshots();

  }

  getChatRooms(String username) async {
    return await Firestore.instance.collection('ChatRoom')
        .where('users', arrayContains: username)
        .snapshots();

  }

}
