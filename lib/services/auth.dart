import 'package:firebase_auth/firebase_auth.dart';
import 'package:realestate/model/user.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:realestate/services/database.dart';

class AuthService {
  final FirebaseAuth _firebaseAuthentication = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  //Create user object based on FirebaseUser
  User _userFromFireBaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  //Auth change user stream
  Stream<User> get user {
    return _firebaseAuthentication.onAuthStateChanged
        //.map((FirebaseUser user) => _userFromFireBaseUser(user));
        .map(_userFromFireBaseUser);
  }

  //Sign in anonymously
  Future signinAnon() async {
    try {
      AuthResult result = await _firebaseAuthentication.signInAnonymously();
      return _userFromFireBaseUser(result.user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Sign in with email and password
  Future signInWithEmail(String email, String password) async {
    try {
      AuthResult result = await _firebaseAuthentication.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFireBaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Register with email & password
  Future registerWithEmail(String email, String password, String firstName, String lastName) async {
    try {
      AuthResult result = await _firebaseAuthentication.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;


      //create new document for the user with the uid
      await DatabaseService(uid: user.uid)
          .updateUserData(firstName, lastName, user.email, 0);
      return _userFromFireBaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Sign in with Google
  Future signInWithGoogle() async {
    try {
      GoogleSignInAccount result = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await result.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final AuthResult authResult =
          await _firebaseAuthentication.signInWithCredential(credential);
      final FirebaseUser user = authResult.user;

      var name = user.displayName;
      name.split(" ");
      String firstName = name[0];
      String lastName = name[1];
      //create new document for the user with the uid
      await DatabaseService(uid: user.uid)
          .updateUserData(firstName, lastName, user.email, 0);
      return _userFromFireBaseUser(user);
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

          final AuthResult authResult = await _firebaseAuthentication.signInWithCredential(credential);
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

  //Sign out
  Future signOut() async {
    try {
      return await _firebaseAuthentication.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
