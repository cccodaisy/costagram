import 'package:costagram/constants/common_size.dart';
import 'package:flutter/material.dart';

import '../home_page.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _pwController = TextEditingController();
  TextEditingController _cpwController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(common_gap),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: common_l_gap,
              ),
              Image.asset("assets/images/insta_text_logo.png"),
              TextFormField(
                controller: _emailController,
                cursorColor: Colors.black54,
                decoration: _textInputDecor("Email"),
                validator: (text){
                  if(text.isNotEmpty && text.contains("@")){
                    return null;
                  } else {
                    return "Please Check your email address.";
                  }
                },
              ),
              SizedBox(
                height: common_xs_gap,
              ),
              TextFormField(
                controller: _pwController,
                cursorColor: Colors.black54,
                obscureText: true,
                decoration: _textInputDecor("Password"),
                validator: (text){
                  if(text.isNotEmpty && text.length > 5){
                    return null;
                  } else {
                    return "Password should be more than 5.";
                  }
                },
              ),
              SizedBox(
                height: common_xs_gap,
              ),
              TextFormField(
                controller: _cpwController,
                cursorColor: Colors.black54,
                obscureText: true,
                decoration: _textInputDecor("Confirm Password"),
                validator: (text){
                  if(text.isNotEmpty && _pwController.text == text){
                    return null;
                  } else {
                    return "Please Check your password.";
                  }
                },
              ),
              FlatButton(
                color: Colors.blue,
                onPressed: () {
                  if(_formKey.currentState.validate()){
                    print('Validation success!');
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => HomePage()
                      )
                    );
                  }
                },
                child: Text(
                  'Join',
                  style: TextStyle(
                    color: Colors.white,
                  )
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              )
            ],
          )
        ),
      ),
    );
  }

  InputDecoration _textInputDecor(String hint) {
    return InputDecoration(
        hintText: hint,
        enabledBorder: _activeInputBorder(),
        focusedBorder: _activeInputBorder(),
        errorBorder: _errorInputBorder(),
        focusedErrorBorder: _errorInputBorder(),
        filled: true,
        fillColor: Colors.grey[100]
    );
  }

  OutlineInputBorder _errorInputBorder() {
    return OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.redAccent,
        ),
        borderRadius: BorderRadius.circular(common_s_gap),
      );
  }

  OutlineInputBorder _activeInputBorder() {
    return OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.grey[300]
          ),
          borderRadius: BorderRadius.circular(common_s_gap)
      );
  }

}
