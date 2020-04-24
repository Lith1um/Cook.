// Libs
import 'package:cloud_firestore/cloud_firestore.dart';

// Models
import 'package:cook/models/user.dart';

class UserService {

  final String uid;
  UserService({this.uid});

  final CollectionReference _userCollection = Firestore.instance.collection('users');

  Future createUserData(String email, String displayName) async {
    return await _userCollection.document(uid).setData({
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'isVerified': false
    });
  }

  Future<User> getUser() async {
    DocumentSnapshot doc = await _userCollection.document(uid).get();
    return User.fromJson(doc.data);
  }

}
