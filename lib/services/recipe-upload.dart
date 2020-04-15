// Libs
import 'package:cloud_firestore/cloud_firestore.dart';

// Models
import 'package:cook/models/recipe.dart';

Future<void> addNewRecipe(Recipe recipe) async {
  await Firestore.instance.collection('recipes').add(recipe.toJson());
}
