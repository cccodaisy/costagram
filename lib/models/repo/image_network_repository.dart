import 'dart:io';

import 'package:costagram/models/repo/helper/image_helper.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class ImageNetworkRepository {
  // 네트워크에서 사이즈 줄여가지고 가져옴 속도 개선
  Future<StorageTaskSnapshot> uploadImage(File originImage, {@required String postKey}) async {
    try{
      final File resized = await compute(getResizedImage, originImage);

      final StorageReference storageReference = FirebaseStorage().ref().child(_getImagePathByPostKey(postKey));
      final StorageUploadTask uploadTask = storageReference.putFile(resized);

      return uploadTask.onComplete;

    } catch(e) {
      print("image storage error: " + e);
      return null;
    }
  }

  String _getImagePathByPostKey(String postKey) => 'post/$postKey/post.jpg';

  Future<dynamic> getPostImageUrl(String postKey) {
    return FirebaseStorage().ref().child(_getImagePathByPostKey(postKey)).getDownloadURL();
  }

}

ImageNetworkRepository imageNetworkRepository = ImageNetworkRepository();