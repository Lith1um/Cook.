// Libs
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> deleteRecipe(DocumentReference documentReference) async {
  await Firestore.instance.runTransaction((Transaction myTransaction) async {
    await myTransaction.delete(documentReference);
  });
}
