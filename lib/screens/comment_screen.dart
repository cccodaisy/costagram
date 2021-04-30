import 'package:costagram/constants/common_size.dart';
import 'package:costagram/models/firestore/comment_model.dart';
import 'package:costagram/models/firestore/user_model.dart';
import 'package:costagram/models/repo/comment_network_repository.dart';
import 'package:costagram/models/user_model_state.dart';
import 'package:costagram/widgets/comment.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommentScreen extends StatefulWidget {

  final String postKey;

  const CommentScreen(this.postKey, {Key key,}) : super(key: key);

  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {

  TextEditingController _textEditingController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Comments"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Expanded(child: StreamProvider<List<CommentModel>>.value(
              value: commentNetworkRepository.fetchAllComments(widget.postKey),
              child: Consumer<List<CommentModel>>(
                builder: (BuildContext context, List<CommentModel> comments, Widget child) {
                  return ListView.separated(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(common_xxs_gap),
                        child: Comment(
                          username: comments[index].username,
                          text: comments[index].comment,
                          dateTime: comments[index].commentTime,
                          showImage: true,
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: common_xxs_gap,
                      );
                    },
                    itemCount: comments == null ? 0 : comments.length,
                  );
                },
              ),
            )),
            Divider(
              height: 1,
              thickness: 1,
              color: Colors.grey[300],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: common_gap),
                    child: TextFormField(
                      autofocus: true,
                      controller: _textEditingController,
                      cursorColor: Colors.black54,
                      decoration: InputDecoration(
                        hintText: 'Add a comment...',
                        border: InputBorder.none,
                      ),
                      validator: (String value) {
                        if(value.isEmpty)
                          return 'Input something';
                        else
                          return null;
                      },
                    ),
                  )
                ),
                FlatButton(
                  onPressed: () async {
                    if(_formKey.currentState.validate()){
                      UserModel usermodel = Provider.of<UserModelState>(context, listen: false).userModel;
                      Map<String, dynamic> newComment = CommentModel.getMapForNewComment(
                        usermodel.userKey,
                        usermodel.username,
                        _textEditingController.text
                      );
                      await commentNetworkRepository.createNewComment(
                        widget.postKey,
                        newComment
                      );
                      _textEditingController.clear();
                    }
                  },
                    child: Text("Post")
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
