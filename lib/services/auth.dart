// Libs
import 'package:firebase_auth/firebase_auth.dart';

// Models
import 'package:cook/models/user.dart';

class AuthService {

  // firebase auth instance
  final FirebaseAuth _auth =  FirebaseAuth.instance;

  // create user based on firebase user
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
      .map(_userFromFirebaseUser);
  }

  // sing in anon
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch(err) {
      print(err.toString());
      return null;
    }
  }

  // sign in with email/password

  // register with email/password

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch(err) {
      print(err.toString());
      return null;
    }
  }

}
