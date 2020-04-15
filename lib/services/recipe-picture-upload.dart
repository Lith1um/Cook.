// Libs
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:firebase_storage/firebase_storage.dart';

Future<String> uploadRecipePhoto(File file) async {
  final FirebaseStorage _storage = FirebaseStorage(storageBucket: 'gs://cook-c911a.appspot.com/');

  // get extension from path
  String fileExtension = path.extension(file.path);

  String filePath = 'recipe_images/recipe_${DateTime.now()}$fileExtension';

  StorageUploadTask uploadTask = _storage.ref().child(filePath).putFile(file);

  var downloadUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
  return downloadUrl.toString();
}
