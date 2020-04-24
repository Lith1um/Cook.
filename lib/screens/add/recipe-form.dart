// Libs
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

// Services
import 'package:cook/services/auth.dart';
import 'package:cook/services/recipes.dart';

// Widgets
import 'package:cook/shared/inputs/input-list.dart';
import 'package:cook/shared/inputs/input-tags.dart';
import 'package:cook/shared/inputs/input-time.dart';
import 'package:cook/shared/inputs/input-select.dart';

// Models
import 'package:cook/models/recipe.dart';
import 'package:cook/models/user.dart';

class RecipeForm extends StatefulWidget {
  @override
  _RecipeFormState createState() => _RecipeFormState();
}

class _RecipeFormState extends State<RecipeForm> {

  final AuthService _auth = AuthService();
  final RecipesService _recipesService = RecipesService();

  final _formKey = GlobalKey<FormState>();
  final _recipeNameController = TextEditingController();
  final _recipeDescriptionController = TextEditingController();

  File _imageFile;
  bool _showImageError = false;

  final _difficultyKey = GlobalKey<InputSelectState>();
  String _difficulty;

  final _ingredientsKey = GlobalKey<InputListState>();
  List<String> _ingredients;

  final _stepsKey = GlobalKey<InputListState>();
  List<String> _steps;

  final _prepTimeKey = GlobalKey<InputTimeState>();
  int _prepTime;

  final _cookTimeKey = GlobalKey<InputTimeState>();
  int _cookTime;

  final _tagsKey = GlobalKey<InputTagsState>();
  String _tags;

  Future<void> _pickImage(ImageSource source) async {
    File _selected = await ImagePicker.pickImage(source: source);

    if (_selected != null) {
      File cropped = await ImageCropper.cropImage(
        sourcePath: _selected.path,
        aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
        compressQuality: 50,
        androidUiSettings: AndroidUiSettings(
          toolbarColor: Colors.blue[800],
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
    setState(() => _imageFile = null);
  }

  void _resetForm() {
    setState(() {
      _recipeNameController.text = '';
      _recipeDescriptionController.text = '';
      _imageFile = null;
      _difficultyKey.currentState.reset();
      _ingredientsKey.currentState.reset();
      _stepsKey.currentState.reset();
      _prepTimeKey.currentState.reset();
      _cookTimeKey.currentState.reset();
      _tagsKey.currentState.reset();
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
    // Display dialog
    _showLoadingDialog(context);

    User currentUser = await _auth.getCurrentUser();
    String imageUrl = await _recipesService.uploadRecipePhoto(_imageFile);
    String recipeName = _recipeNameController.text;
    String description = _recipeDescriptionController.text;

    Recipe recipe = Recipe(
      name: recipeName,
      description: description,
      imageUrl: imageUrl,
      difficulty: _difficulty,
      ingredients: _ingredients,
      steps: _steps,
      prepTime: _prepTime,
      cookTime: _cookTime,
      tags: _tags,
      timeAdded: DateTime.now().millisecondsSinceEpoch,
      creator: currentUser.uid,
      favourites: []
    );
    await _recipesService.addNewRecipe(recipe);

    // reset form and close dialog
    _resetForm();
    Navigator.of(context).pop();

    // add snackbar confirming upload
    final snackBar = SnackBar(
      content: Text('Upload successful!'),
    );

    Scaffold.of(context).showSnackBar(snackBar);
  }

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        content: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 18.0),
            Expanded(child: Text('Uploading recipe...'))
          ]
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
              child: Text(
                'Upload a new recipe',
                style: TextStyle(fontSize: 24.0),
              )
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
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
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        controller: _recipeNameController,
                        maxLines: null,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          labelText: 'What are you making?'
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter a recipe name';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        controller: _recipeDescriptionController,
                        maxLines: null,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          labelText: 'Tell us a bit about this recipe'
                        ),
                      ),
                    ),
                    InputTime(
                      key: _prepTimeKey,
                      label: 'Preparation time',
                      onValueChanged: (int minutes) =>
                        setState(() => _prepTime = minutes),
                    ),
                    InputTime(
                      key: _cookTimeKey,
                      label: 'Cooking time',
                      onValueChanged: (int minutes) =>
                        setState(() => _cookTime = minutes),
                    ),
                    InputSelect(
                      label: 'How difficult is this recipe',
                      options: [
                        SelectOption('Easy', 'Easy'),
                        SelectOption('Medium', 'Medium'),
                        SelectOption('Hard', 'Hard'),
                      ],
                      onValueChanged: (String difficulty) =>
                        setState(() => _difficulty = difficulty),
                    ),
                    InputList(
                      key: _ingredientsKey,
                      label: 'Ingredients',
                      onValueChanged: (List<String> list) =>
                        setState(() => _ingredients = list)
                    ),
                    InputList(
                      key: _stepsKey,
                      label: 'Steps',
                      numberedList: true,
                      onValueChanged: (List<String> list) =>
                        setState(() => _steps = list)
                    ),
                    InputTags(
                      key: _tagsKey,
                      label: 'Tags',
                      onValueChanged: (String tags) =>
                        setState(() => _tags = tags),
                    ),
                    SizedBox(height: 20.0),
                    Center(
                      child: RaisedButton(
                        onPressed: () {
                          // close keyboard
                          FocusScope.of(context).unfocus();
                          // Validate returns true if the form is valid, or false otherwise
                          if (validateForm()) {
                            // form is valid so start upload
                            _uploadRecipe(context);
                          }
                        },
                        child: Text('Upload'),
                      ),
                    ),
                    SizedBox(height: 40.0),
                  ]
                ),
              ),
            )
          ]
        )
      )
    );
  }
}
