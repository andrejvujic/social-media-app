import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Upload extends StatefulWidget {
  @override
  _UploadState createState() => _UploadState();

  final PickedFile pickedFile;
  Upload({
    this.pickedFile,
  });
}

class _UploadState extends State<Upload> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Objavi fotografiju',
        ),
      ),
    );
  }
}
