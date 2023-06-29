import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final commonFirebaseStorageRepositoriesProvider = Provider(
  (ref) => CommonFirebaseStorageRepositories(
      firebaseStorage: FirebaseStorage.instance),
);

class CommonFirebaseStorageRepositories {
  final FirebaseStorage firebaseStorage;

  CommonFirebaseStorageRepositories({required this.firebaseStorage});

  Future<String> storeFileToFirebase(String ref, File file) async {
    UploadTask uploadTask = firebaseStorage.ref().child(ref).putFile(file);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}
