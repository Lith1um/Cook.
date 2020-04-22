// Libs
import 'package:cloud_firestore/cloud_firestore.dart';

class RecipesService {

  final CollectionReference _recipeCollection = Firestore.instance.collection('recipes');

  Stream getAllRecipes([String orderBy = 'name']) {
    return _recipeCollection.orderBy(orderBy).snapshots();
  }

  Stream getRecipesForUser(String uid, [String orderBy = 'timeAdded']) {
    return _recipeCollection.where('creator', isEqualTo: uid).orderBy(orderBy).snapshots();
  }

}
