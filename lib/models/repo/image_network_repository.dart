import 'dart:io';

import 'package:costagram/models/repo/helper/image_helper.dart';
import 'package:flutter/foundation.dart';

class ImageNetworkRepository {
  // 네트워크에서 사이즈 줄여가지고 가져옴 속도 개선
  Future<void> uploadImageNCreateNewPost(File originImage) async {
    try{
      final File resized = await compute(getResizedImage, originImage);
      await Future.delayed(Duration(seconds: 3)); // 3초 딜레이 시켜봄
    } catch(e) {

    }
  }
}

ImageNetworkRepository imageNetworkRepository = ImageNetworkRepository();