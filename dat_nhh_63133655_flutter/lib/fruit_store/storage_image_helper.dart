import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

Future<String> uploadImage({required String imgPath, required List<String> folders, required String fileName}) async{
  String downloadUrl;
  // tao doi tuong firebase storage
  FirebaseStorage _storage = FirebaseStorage.instance;

  //1. Thiết lập đường dẫn trên firebase storage
  Reference reference = _storage.ref();
  for(String f in folders)
    reference = reference.child(f);
  reference = reference.child(fileName);

  //2. Thiết lập Metadata
  final metadata = SettableMetadata(
    contentType: 'image/jpeg',
    customMetadata: {'picked-file-path': imgPath},
  );

  //3. Upload ảnh lên firebase storage và trả về đường dẫn
  try{
    if(kIsWeb)
      await reference.putData(await XFile(imgPath).readAsBytes(), metadata);
    else
      await reference.putFile(File(imgPath), metadata);
    downloadUrl = await reference.getDownloadURL();
    return downloadUrl;
  }on FirebaseException catch (e){
    print("Lỗi upload ảnh lên firebase ${e.toString()}");
    return Future.error("Lỗi upload file");
  }
}

Future<void> deleteImage({ required List<String> folders, required String fileName}) async {
  FirebaseStorage _storage = FirebaseStorage.instance;
  Reference reference = _storage.ref();
  for (String f in folders)
    reference = reference.child(f);
  reference = reference.child(fileName);
  return reference.delete();
}