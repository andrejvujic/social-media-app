import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media_app/widgets/info_alert.dart';
import 'package:social_media_app/widgets/loading_placeholder.dart';
import 'package:social_media_app/widgets/solid_button.dart';
import 'package:social_media_app/widgets/text_input.dart';

class Upload extends StatefulWidget {
  @override
  _UploadState createState() => _UploadState();

  final PickedFile pickedFile;
  Upload({
    this.pickedFile,
  });
}

class _UploadState extends State<Upload> {
  final captionController = TextEditingController();
  String imagePath = '';

  @override
  void initState() {
    imagePath = widget.pickedFile.path ?? '';
    super.initState();
  }

  @override
  void dispose() {
    captionController.dispose();
    super.dispose();
  }

  Future<void> uploadImage() async {
    var imagePath = '';

    if ((imagePath?.length ?? 0) > 0) {
    } else {
      InfoAlert.show(context,
          title: 'Greška',
          text:
              'Fotografija koju pokušavate da objavite ne postoji ili je obrisana. Pokušajte ponovo sa nekom drugom fotografijom.');
    }
  }

  Widget errorBuilder(BuildContext context, Object error, StackTrace _) {
    print('Error: $error');

    return LoadingPlaceholder(
      title: 'Došlo je do greške...',
      subtitle:
          'Nažalost je došlo do greške prilikom učitavanja vaše fotografije. Pokušajte ponovo.',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Objavi fotografiju',
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(vertical: 8.0),
                child: Image.file(
                  File(imagePath),
                  height: 320.0,
                  errorBuilder: errorBuilder,
                ),
              ),
              TextInput(
                controller: captionController,
                labelText: 'Opis',
              ),
              SolidButton(
                onPressed: uploadImage,
                width: MediaQuery.of(context).size.width * 0.90,
                color: Colors.blue,
                highlightColor: Colors.white,
                splashColor: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.done,
                      color: Colors.white,
                    ),
                    SizedBox(width: 4.0),
                    Text(
                      'Objavi fotografiju',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
