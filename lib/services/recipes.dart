// Libs
import 'package:cloud_firestore/cloud_firestore.dart';

class RecipesService {

  final CollectionReference _recipeCollection = Firestore.instance.collection('recipes');

  Stream getRecipes([String orderBy = 'name']) {
    return _recipeCollection.orderBy(orderBy).snapshots();
  }

}
