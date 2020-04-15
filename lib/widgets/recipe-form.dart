// Libs
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

// Services
import 'package:cook/services/recipe-upload.dart';
import 'package:cook/services/recipe-picture-upload.dart';

// Widgets
import 'package:cook/widgets/inputs/input-time.dart';

// Models
import 'package:cook/models/recipe.dart';

class RecipeForm extends StatefulWidget {
  @override
  _RecipeFormState createState() => _RecipeFormState();
}

class _RecipeFormState extends State<RecipeForm> {
  final _formKey = GlobalKey<FormState>();
  final _recipeNameController = TextEditingController();
  final _prepTimeController = TextEditingController(text: '0');

  File _imageFile;

  Future<void> _pickImage(ImageSource source) async {
    File _selected = await ImagePicker.pickImage(source: source);

    if (_selected != null) {
      File cropped = await ImageCropper.cropImage(
        sourcePath: _selected.path,
        aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
        compressQuality: 50,
        androidUiSettings: AndroidUiSettings(
          toolbarColor: Colors.blue,
          toolbarTitle: 'Edit image',
          toolbarWidgetColor: Colors.white
        )
      );

      setState(() {
        _imageFile = cropped;
      });
    }
  }

  void _clear() {
    setState(() => _imageFile = null);
  }

  void _uploadRecipe(BuildContext context) async {
    String imageUrl = await uploadRecipePhoto(_imageFile);
    String recipeName = _recipeNameController.text;

    Recipe recipe = Recipe(name: recipeName, imageUrl: imageUrl);
    await addNewRecipe(recipe);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Pick a picture for your recipe:'),
                SizedBox(height: 10.0),
                if (_imageFile != null)
                  Row(
                    children: <Widget>[
                      Container(
                        width: 150.0,
                        child: Image.file(_imageFile, fit: BoxFit.fitWidth),
                      ),
                      Expanded(
                        child: Center(
                          child: FlatButton(
                            textColor: Colors.red,
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 5.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.delete),
                                  Text('Delete')
                                ],
                              ),
                            ),
                            onPressed: () => _clear(),
                          )
                        ),
                      )
                    ]
                  ),
                if (_imageFile == null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      FlatButton(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.photo_camera),
                              Text('Camera')
                            ],
                          ),
                        ),
                        onPressed: () => _pickImage(ImageSource.camera),
                      ),
                      FlatButton(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.photo_library),
                              Text('Gallery')
                            ],
                          ),
                        ),
                        onPressed: () => _pickImage(ImageSource.gallery),
                      ),
                    ],
                  )
              ]
            )
          ),
          Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    controller: _recipeNameController,
                    decoration: InputDecoration(
                      labelText: 'What is the name of your recipe?'
                    ),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter a recipe name';
                      }
                      return null;
                    },
                  ),
                  InputTime(
                    controller: _prepTimeController,
                    label: 'Preparation time (mins)',
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: RaisedButton(
                      onPressed: () {
                        // Validate returns true if the form is valid, or false
                        // otherwise.
                        if (_formKey.currentState.validate()) {
                          // close keyboard if validated
                          FocusScope.of(context).unfocus();
                          
                          // form is valid so start upload
                          _uploadRecipe(context);
                        }
                      },
                      child: Text('Submit'),
                    ),
                  ),
                ]
              ),
            ),
          )
        ]
      )
    );
  }
}