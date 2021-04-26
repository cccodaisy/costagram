import 'package:costagram/constants/auth_input_decor.dart';
import 'package:costagram/constants/common_size.dart';
import 'package:costagram/models/firebase_auth_state.dart';
import 'package:costagram/widgets/or_divider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                decoration: textInputDecor("Email"),
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
                decoration: textInputDecor("Password"),
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
                decoration: textInputDecor("Confirm Password"),
                validator: (text){
                  if(text.isNotEmpty && _pwController.text == text){
                    return null;
                  } else {
                    return "Please Check your password.";
                  }
                },
              ),
              SizedBox(
                height: common_xs_gap,
              ),
              _submitButton(context),
              SizedBox(
                height: common_s_gap
              ),
              OrDivider(),
              FlatButton.icon(
                onPressed: (){},
                textColor: Colors.blue,
                icon: ImageIcon(
                  AssetImage('assets/images/facebook.png')
                ),
                label: Text('Login With Facebook')
              )
            ],
          )
        ),
      ),
    );
  }

  FlatButton _submitButton(BuildContext context) {
    return FlatButton(
      color: Colors.blue,
      onPressed: () {
        if(_formKey.currentState.validate()){
          print('Validation success!');
          Provider
            .of<FirebaseAuthState>(context, listen: false)
            .registerUser(email: _emailController.text, password: _pwController.text);
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
    );
  }
}
