// Libs
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Models
import 'package:cook/models/recipe.dart';

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

  Future<void> addNewRecipe(Recipe recipe) async {
    await Firestore.instance.collection('recipes').add(recipe.toJson());
  }

  Future<String> uploadRecipePhoto(File file) async {
    final FirebaseStorage _storage = FirebaseStorage(storageBucket: 'gs://cook-c911a.appspot.com/');

    // get extension from path
    String fileExtension = path.extension(file.path);

    String filePath = 'recipe_images/recipe_${DateTime.now()}$fileExtension';

    StorageUploadTask uploadTask = _storage.ref().child(filePath).putFile(file);

    var downloadUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
    return downloadUrl.toString();
  }

  Future<void> deleteRecipe(DocumentReference documentReference) async {
    await Firestore.instance.runTransaction((Transaction myTransaction) async {
      await myTransaction.delete(documentReference);
    });
  }

  Future addFavourite(DocumentReference docRef, String uid) async {
    DocumentSnapshot doc = await docRef.get();
    
    List<dynamic> favourites = doc.data['favourites'];
    favourites.add(uid);

    await docRef.updateData({
      'favourites': favourites
    });
  }

  Future removeFavourite(DocumentReference docRef, String uid) async {
    DocumentSnapshot doc = await docRef.get();
    
    List<dynamic> favourites = doc.data['favourites'];
    favourites.removeWhere((value) => value == uid);

    await docRef.updateData({
      'favourites': favourites
    });
  }

  Stream getFavouritesForUser(String uid, [String orderBy = 'timeAdded', bool descending = true]) {
    return _recipeCollection.where('favourites', arrayContains: uid)
      .orderBy(orderBy, descending: descending)
      .snapshots();
  }
}
