// Libs
import 'package:firebase_auth/firebase_auth.dart';

// Services
import 'package:cook/services/user.dart';

// Models
import 'package:cook/models/user.dart';

class AuthService {

  // firebase auth instance
  final FirebaseAuth _auth =  FirebaseAuth.instance;

  // create user based on firebase user
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null
      ? User(
        uid: user.uid,
        isVerified: user.isEmailVerified
      )
      : null;
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
  Future signInWithEmailPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch(err) {
      print(err.toString());
      return err.message;
    }
  }

  // register with email/password
  Future registerWithEmailPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      
      // send verification email
      user.sendEmailVerification();

      // create a new doc for the user with the uid
      await UserService(uid: user.uid).createUserData(user.email, '');

      return _userFromFirebaseUser(user);
    } catch(err) {
      print(err.toString());
      return err.message;
    }
  }

  // verfiy email with link
  Future verifyEmailAddress() async {
    try {
      FirebaseUser user = await _auth.currentUser();
      if (user != null && !user.isEmailVerified) {
        await user.sendEmailVerification();
        return true;
      }
    } catch(err) {
      print(err.toString());
      return null;
    }
  }

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
