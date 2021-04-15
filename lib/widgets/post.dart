import 'package:cached_network_image/cached_network_image.dart';
import 'package:costagram/widgets/my_progress_indicator.dart';
import 'package:flutter/material.dart';

class Post extends StatelessWidget {
  final int index;
  Size size;

  Post(
    this.index, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (size == null) size = MediaQuery.of(context).size;

    return Column(
      children: [
        _postHeader(),
        _postImage(),
      ],
    );
  }

  Widget _postHeader(){
    return Row(
      children: <Widget>[
        CachedNetworkImage(
          imageUrl: 'https://picsum.photos/100',
          width: 30,
          height: 30,
        ),
        Text('username'),
        IconButton(
          onPressed: null,
            icon: Icon(
              Icons.more_horiz,
              color: Colors.black87,
            ),
        )
      ],
    );
  }

  CachedNetworkImage _postImage() {
    return CachedNetworkImage(
        imageUrl: 'https://picsum.photos/id/$index/200/200',
        placeholder: (BuildContext context, String url) {
          return MyProgressIndicator(
              containerSize: size.width
          );
        },
        imageBuilder: (BuildContext context, ImageProvider imageProvider) {
          return AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover)),
            ),
          );
        },
      );
  }
}

