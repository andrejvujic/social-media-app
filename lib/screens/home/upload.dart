import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media_app/services/database_service.dart';
import 'package:social_media_app/services/storage_service.dart';
import 'package:social_media_app/widgets/info_alert.dart';
import 'package:social_media_app/widgets/loading_overlay.dart';
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
  final db = DatabaseService(uid: FirebaseAuth.instance.currentUser.uid);
  final storage = StorageService();
  final captionController = TextEditingController();
  String imagePath = '';
  bool isLoading = false;

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
    if ((imagePath?.length ?? 0) > 0) {
      setState(() => isLoading = true);

      final String id = FirebaseFirestore.instance.collection('posts').doc().id;
      final String photoUrl = await storage.uploadFile(
          filePath: imagePath, uploadPath: 'posts/$id');

      await db.addPost(
          id: id, photoUrl: photoUrl, caption: captionController.text);

      setState(() => isLoading = false);
      Navigator.pop(context);
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
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: !isLoading,
        title: Text(
          'Objavi fotografiju',
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
      ),
      body: LoadingOverlay(
        isLoading: isLoading,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Container(
            width: MediaQuery.of(context).size.width,
            margin: MediaQuery.of(context).viewInsets,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  child: Image.file(
                    File(imagePath),
                    height: 288.0,
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
                  color: Theme.of(context).primaryColor,
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
      ),
    );
  }
}
