import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final storage = FirebaseStorage.instance;

  Future<void> uploadFile({String filePath, String uploadPath}) async =>
      await storage
          .ref(uploadPath)
          .putFile(
            File(filePath),
          )
          .catchError((e) => e.code);

  Future<String> getFileUrl({String uploadPath}) async =>
      await storage.ref(uploadPath).getDownloadURL().catchError((e) => e.code);
}
