import 'package:cached_network_image/cached_network_image.dart';
import 'package:costagram/constants/common_size.dart';
import 'package:costagram/constants/screen_size.dart';
import 'package:costagram/models/firestore/post_model.dart';
import 'package:costagram/models/repo/image_network_repository.dart';
import 'package:costagram/screens/comment_screen.dart';
import 'package:costagram/widgets/comment.dart';
import 'package:costagram/widgets/my_progress_indicator.dart';
import 'package:costagram/widgets/rounded_avatar.dart';
import 'package:flutter/material.dart';

class Post extends StatelessWidget {
  final PostModel postModel;

  Post(this.postModel, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (size == null) size = MediaQuery
        .of(context)
        .size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _postHeader(),
        _postImage(),
        _postActions(context),
        _postLikes(),
        _postCaption(),
        _lastComment(),
      ],
    );
  }

  Widget _lastComment() {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: common_gap,
          vertical: common_xxs_gap
      ),
      child: Comment(
        showImage: false,
        username: postModel.lastCommentor,
        text: postModel.lastComment,
      ),
    );
  }

  Widget _postCaption() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: common_gap,
        vertical: common_xxs_gap
      ),
      child: Comment(
        showImage: false,
        username: postModel.username,
        text: postModel.caption,
      ),
    );
  }

  Padding _postLikes() {
    return Padding(
      padding: const EdgeInsets.only(left: common_gap),
      child: Text(
        '${postModel.numofLikes == null ? 0 : postModel.numofLikes.length} likes',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Row _postActions(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: ImageIcon(AssetImage('assets/images/bookmark.png')),
          onPressed: null,
          color: Colors.black87,
        ),
        IconButton(
          icon: ImageIcon(AssetImage('assets/images/comment.png')),
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext build) {
                  return CommentScreen(postModel.postKey);
                }
            ));
          },
          color: Colors.black87,
        ),
        IconButton(
          icon: ImageIcon(AssetImage('assets/images/direct_message.png')),
          onPressed: null,
          color: Colors.black87,
        ),
        Spacer(),
        IconButton(
          icon: ImageIcon(AssetImage('assets/images/heart_selected.png')),
          onPressed: null,
          color: Colors.black87,
        ),
      ],
    );
  }

  Widget _postHeader() {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(common_xxs_gap),
          child: RoundedAvatar(),
        ),
        Expanded(child: Text(postModel.username)),
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

  Widget _postImage() {

    Widget progress = MyProgressIndicator(
      containerSize: size.width,
    );

    return CachedNetworkImage(
      imageUrl: postModel.postImg,
      placeholder: (BuildContext context, String url) {
        return progress;
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


