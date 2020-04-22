// Libs
import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {

  final String uid;
  UserService({this.uid});

  final CollectionReference _userCollection = Firestore.instance.collection('users');

  Future createUserData(String email, String displayName) async {
    return await _userCollection.document(uid).setData({
      'email': email,
      'displayName': displayName
    });
  }

  Future<Map<String, dynamic>> getUser(String uid) async {
    var userDoc = await _userCollection.document(uid).get();
    return userDoc.data;
  }

}
