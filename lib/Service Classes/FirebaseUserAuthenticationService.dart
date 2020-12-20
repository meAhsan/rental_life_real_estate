import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:realestate/ModelClasses/UserModelClasses/RentalLifeUser.dart';
import 'package:realestate/model/user.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'FirestoreDatabaseServicesForUser.dart';

class FirebaseUserAuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  //Register with email & password
  Future<RentalLifeUser> registerWithEmail(
      String email, String password) async {
    try {
      AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser userFromFirebase = result.user;

      // //create new document for the userFromFirebase with the uid
      // await FirestoreDatabaseServicesForUser(
      //         rentalLifeUserID: userFromFirebase.uid)
      //     .createRentalLifeUserFirestoreDocument(
      //   name: name,
      //   email: email,
      // );

      // return await _getFirebaseUserAsRentalLifeUserAfterRegistration(userFromFirebase);
      return _getFirebaseUserAsRentalLifeUser(userFromFirebase);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Sign out
  Future signOut() async {
    try {
      return await _firebaseAuth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Create user object based on FirebaseUser after registering with email and password
  Future<RentalLifeUser> _getFirebaseUserAsRentalLifeUserAfterRegistration(FirebaseUser firebaseUser) async {
    if (firebaseUser != null) {
      RentalLifeUser rentalLifeUser = RentalLifeUser(
          userID: firebaseUser.uid, emailAddress: firebaseUser.email);
      rentalLifeUser =  await _updateRentalLifeUserFromFirestoreDoc(rentalLifeUser);
      return rentalLifeUser;
    } else {
      return null;
    }
  }

  //Update RentalLifeUser object's instance variables from firestore document.
  Future<RentalLifeUser> _updateRentalLifeUserFromFirestoreDoc(
      RentalLifeUser rentalLifeUser) async {
    DocumentSnapshot userFireStoreDocument = await Firestore.instance.collection('user').document(rentalLifeUser.uid).get();
    rentalLifeUser.name = userFireStoreDocument.data['name'];
    print(rentalLifeUser.name);
    print(userFireStoreDocument.data['name']);
    return rentalLifeUser;
  }


  //Create user object based on FirebaseUser

  RentalLifeUser _getFirebaseUserAsRentalLifeUser(FirebaseUser firebaseUser) {
    if (firebaseUser != null) {
      RentalLifeUser rentalLifeUser = RentalLifeUser(
          userID: firebaseUser.uid, emailAddress: firebaseUser.email, name: firebaseUser.displayName);
      return rentalLifeUser;
    } else {
      return null;
    }
  }


  //Auth change user stream
  Stream<RentalLifeUser> get rentalLifeUserFromAuthService {
    return _firebaseAuth.onAuthStateChanged
        //.map((FirebaseUser user) => _userFromFireBaseUser(user));
        // .map(_getFirebaseUserAsRentalLifeUser);
        .map(_getFirebaseUserAsRentalLifeUser);
  }

  //Sign in anonymously
  Future signinAnon() async {
    try {
      AuthResult result = await _firebaseAuth.signInAnonymously();
      return _getFirebaseUserAsRentalLifeUser(result.user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Sign in with email and password
  Future signInWithEmail(String email, String password) async {
    try {
      AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _getFirebaseUserAsRentalLifeUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Sign in with Google
  Future signInWithGoogle() async {
    print("SIGN IN WITH GOOGE MOETHOD");
    try {
      print("IN TRY BLOCK");
      GoogleSignInAccount result = await _googleSignIn.signIn();
      print("First statement executed");

      final GoogleSignInAuthentication googleSignInAuthentication =
          await result.authentication;
      print("Second statement executed");

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      print("Third statement executed");

      final AuthResult authResult =
          await _firebaseAuth.signInWithCredential(credential);
      print("Fourth statement executed");

      final FirebaseUser firebaseUser = authResult.user;
      print("Fifth statement executed");

      print("Printing firebaseUser.displayName: ${firebaseUser.displayName}");
      // var name = user.displayName;
      // name.split(" ");
      // String firstName = name[0];
      // String lastName = name[1];
      //create new document for the user with the uid
      // await FirestoreDatabaseServicesForUser(rentalLifeUserID: firebaseUser.uid)
      //     .updateRentalLifeUserData();
      return _getFirebaseUserAsRentalLifeUser(firebaseUser);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

/*
  //Sign in with Facebook
  Future<User> signInWithFacebook()async{
    try {
      final FacebookLogin facebookSignIn = new FacebookLogin();
      final FacebookLoginResult result =
      await facebookSignIn.logIn(['email']);

      switch (result.status) {
        case FacebookLoginStatus.loggedIn:
          final FacebookAccessToken accessToken = result.accessToken;
          print('''
         Logged in!

         Token: ${accessToken.token}
         User id: ${accessToken.userId}
         Expires: ${accessToken.expires}
         Permissions: ${accessToken.permissions}
         Declined permissions: ${accessToken.declinedPermissions}
         ''');


          final AuthCredential credential = FacebookAuthProvider.getCredential(accessToken: accessToken.toString());

          final AuthResult authResult = await _firebaseAuth.signInWithCredential(credential);
          final FirebaseUser user = authResult.user;
          return _userFromFireBaseUser(user);


          break;
        case FacebookLoginStatus.cancelledByUser:
          print('Login cancelled by the user.');
          break;
        case FacebookLoginStatus.error:
          print('Something went wrong with the login process.\n'
              'Here\'s the error Facebook gave us: ${result.errorMessage}');
          break;
      }
    }catch(e){
      print(e.toString());
      return null;
    }
  }*/

/*void _showMessage(String message) {
    setState(() {
      _message = message;
    });
  }*/

/*Future<Null> _logOut() async {
    await facebookSignIn.logOut();
    _showMessage('Logged out.');
  }*/

}
