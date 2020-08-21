
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{

  final String uid;

  DatabaseService({this.uid});

  //Collection reference
  final CollectionReference userCollection = Firestore.instance.collection('user');

  Future updateUserData(String phoneNum, String name, String email) async{
    return await userCollection.document(uid).setData({
      'phoneNum' : phoneNum,
      'name' : name,
      'email' : email
    });
  }

  Stream<QuerySnapshot> get userDocumentsStream{
    return  userCollection.snapshots();
  }
}
