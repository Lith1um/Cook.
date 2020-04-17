// Libs
import 'dart:io';
import 'package:cook/widgets/inputs/input-tags.dart';
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

  File _imageFile;
  bool _showImageError = false;
  int _prepTime;
  int _cookTime;
  String _cuisines;

  // TODO: move to separate widget
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
        _showImageError = false;
      });
    }
  }

  void _clear() {
    setState(() {
      _imageFile = null;
    });
  }

  void setPrepTime(int timeInMinutes) {
    setState(() {
      _prepTime = timeInMinutes;
    });
  }

  void setCookTime(int timeInMinutes) {
    setState(() {
      _cookTime = timeInMinutes;
    });
  }

  void setCuisines(String tags) {
    setState(() {
      _cuisines = tags;
    });
  }

  bool validateForm() {
    bool valid = true;

    if (_imageFile == null) {
      setState(() {
        _showImageError = true;
      });
      valid = false;
    }
    return _formKey.currentState.validate() && valid;
  }

  void _uploadRecipe(BuildContext context) async {
    String imageUrl = await uploadRecipePhoto(_imageFile);
    String recipeName = _recipeNameController.text;

    Recipe recipe = Recipe(
      name: recipeName,
      imageUrl: imageUrl,
      prepTime: _prepTime,
      cookTime: _cookTime,
      cuisines: _cuisines
    );
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
                Text(
                  'Pick a picture for your recipe:',
                  style: TextStyle(
                    fontSize: 16.0
                  ),
                ),
                SizedBox(height: 20.0),
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
                if (_imageFile == null) ...[
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
                  ),
                  if (_showImageError) ...[
                    SizedBox(height: 10.0),
                    Center(
                      child: Text(
                        'Please select an image',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 12.0
                        )
                      )
                    )
                  ]
                ]
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
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: TextFormField(
                      controller: _recipeNameController,
                      textCapitalization: TextCapitalization.sentences,
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
                  ),
                  InputTime(
                    label: 'Preparation time',
                    onValueChanged: setPrepTime,
                  ),
                  InputTime(
                    label: 'Cooking time',
                    onValueChanged: setCookTime,
                  ),
                  InputTags(
                    label: 'Cuisines',
                    onValueChanged: setCuisines,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Center(
                      child: RaisedButton(
                        onPressed: () {
                          // Validate returns true if the form is valid, or false otherwise
                          if (validateForm()) {
                            // close keyboard if validated
                            FocusScope.of(context).unfocus();
                            // form is valid so start upload
                            _uploadRecipe(context);
                          }
                        },
                        child: Text('Submit'),
                      ),
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
