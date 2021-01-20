import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final storage = FirebaseStorage.instance;

  Future<String> uploadFile({String filePath, String uploadPath}) async =>
      await storage
          .ref(uploadPath)
          .putFile(
            File(filePath),
          )
          .then((value) async =>
              await value.storage.ref(uploadPath).getDownloadURL());

  Future<String> getFileUrl({String uploadPath}) async =>
      await storage.ref(uploadPath).getDownloadURL();
}
