// Libs
import 'package:cloud_firestore/cloud_firestore.dart';

class RecipesService {

  final CollectionReference _recipeCollection = Firestore.instance.collection('recipes');

  Stream getAllRecipes([String orderBy = 'timeAdded', bool descending = true]) {
    return _recipeCollection.orderBy(orderBy, descending: descending)
      .snapshots();
  }

  Stream getRecipesForUser(String uid, [String orderBy = 'timeAdded', bool descending = true]) {
    return _recipeCollection.where('creator', isEqualTo: uid)
      .orderBy(orderBy, descending: descending)
      .snapshots();
  }

}
