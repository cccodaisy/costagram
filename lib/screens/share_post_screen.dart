import 'package:flutter/material.dart';
import 'dart:io';

class SharePostScreen extends StatelessWidget {

  final File imageFile;

  const SharePostScreen(this.imageFile, {Key key}) : super (key: key);

  @override
  Widget build(BuildContext context) {
    return Image.file(imageFile);
  }
}
