import 'package:costagram/constants/common_size.dart';
import 'package:flutter/material.dart';

class CommentScreen extends StatefulWidget {
  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {

  TextEditingController _textEditingController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Expanded(child: Container(color: Colors.amber,)),
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: common_gap),
                    child: TextFormField(
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
                  onPressed: () {
                    if(_formKey.currentState.validate()){

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
