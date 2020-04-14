// Libs
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class RecipeImageUpload extends StatefulWidget {
  @override
  _RecipeImageUploadState createState() => _RecipeImageUploadState();
}

class _RecipeImageUploadState extends State<RecipeImageUpload> {
  File _imageFile;

  Future<void> _pickimage(ImageSource source) async {
    File _selected = await ImagePicker.pickImage(source: source, maxWidth: 1000.0, maxHeight: 1000);

    File cropped = await ImageCropper.cropImage(
      sourcePath: _selected.path,
      aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
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

  void _clear() {
    setState(() => _imageFile = null);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        if (_imageFile != null) ...[
          Image.file(_imageFile),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FlatButton(
                child: Icon(Icons.refresh),
                onPressed: () => _clear(),
              ),
            ]
          )
        ],
        if (_imageFile == null)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.photo_camera),
                onPressed: () => _pickimage(ImageSource.camera),
              ),
              IconButton(
                icon: Icon(Icons.photo_library),
                onPressed: () => _pickimage(ImageSource.gallery),
              ),
            ],
          )
      ]
    );
  }
}