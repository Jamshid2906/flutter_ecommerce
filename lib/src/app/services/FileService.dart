import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FileService {
  static Future<UploadTask?> uploadFile(String destination, File file) async {
    try {
      final ref = FirebaseStorage.instance.ref(destination);
    return ref.putFile(file);
    } on FirebaseException catch(e) {
      return null;
    }
  }
}