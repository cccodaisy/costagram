import 'package:costagram/models/repo/user_network_repository.dart';
import 'package:costagram/utils/simple_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FirebaseAuthState extends ChangeNotifier {
  FirebaseAuthStatus _firebaseAuthStatus = FirebaseAuthStatus.signin;
  FirebaseAuth _firebaseAuth =  FirebaseAuth.instance;
  FirebaseUser _firebaseUser;
  // FacebookLogin _facebookLogin;

  void watchAuthChange() {
    _firebaseAuth.onAuthStateChanged.listen((firebaseUser) {
      if(firebaseUser == null && _firebaseUser == null) {
        changeFirebaseAuthStatus();
      } else if(firebaseUser != _firebaseUser) {
        _firebaseUser = firebaseUser;
        changeFirebaseAuthStatus();
      }
    });
  }

  void registerUser(BuildContext context, {
    @required String email,
    @required String password
  }) async {
    changeFirebaseAuthStatus(FirebaseAuthStatus.progress);
    AuthResult authResult = await _firebaseAuth
      .createUserWithEmailAndPassword(email: email.trim(), password: password.trim())
      .catchError((error) {
        print(error);
        String _message = "";
        switch(error.code){
          case 'ERROR_WEAK_PASSWORD':
            _message = '패스워드가 다릅니다.';
            break;
          case 'ERROR_INVALID_EMAIL':
            _message = '올바른 이메일 형식이 아닙니다.';
            break;
          case 'ERROR_EMAIL_ALREADY_IN_USE':
            _message = '이미 가입된 이메일입니다.';
            break;
        }

      SnackBar snackBar = SnackBar(content: Text(_message));
      Scaffold.of(context).showSnackBar(snackBar);
    });

    _firebaseUser = authResult.user;
    if(_firebaseUser == null){
      SnackBar snackBar = SnackBar(content: Text("Please try again later."));
      Scaffold.of(context).showSnackBar(snackBar);
    } else {
      await userNetworkRepository.attemptCreateUser(
          userKey: _firebaseUser.uid, email: _firebaseUser.email
      );
    }
  }

  void login(
    BuildContext context, {
    @required String email,
    @required String password
  }){
    changeFirebaseAuthStatus(FirebaseAuthStatus.progress);

    _firebaseAuth
      .signInWithEmailAndPassword(email: email.trim(), password: password.trim())
      .catchError((error) {
      print(error);

      String _message = "";
      switch (error.code) {
        case 'ERROR_INVALID_EMAIL':
          _message = '올바른 이메일 형식이 아닙니다.';
          break;
        case 'ERROR_WRONG_PASSWORD':
          _message = '잘못된 패스워드입니다.';
          break;
        case 'ERROR_USER_NOT_FOUND':
          _message = '가입된 유저가 없습니다. 회원가입을 해주세요.';
          break;
        case 'ERROR_USER_DISABLED':
          _message = '해당유저 접근이 불가합니다.';
          break;
        case 'ERROR_TOO_MANY_REQUESTS':
          _message = '너무 많은 접근하셨습니다. 잠시 후에 시도해주세요.';
          break;
        case 'ERROR_OPERATION_NOT_ALLOWED':
          _message = '해당 동작은 허용되지 않습니다.';
          break;
      }

      SnackBar snackBar = SnackBar(content: Text(_message));
      Scaffold.of(context).showSnackBar(snackBar);
    });
  }

  void signOut() async {
    changeFirebaseAuthStatus(FirebaseAuthStatus.progress);
    _firebaseAuthStatus = FirebaseAuthStatus.signout;
    if(_firebaseUser != null) {
      _firebaseUser = null;
      await _firebaseAuth.signOut();
      // if(await _facebookLogin.isLoggedIn){
      //   await _facebookLogin.logOut();
      // }
    }
    notifyListeners();
  }

  void changeFirebaseAuthStatus([FirebaseAuthStatus firebaseAuthStatus]){
    if(firebaseAuthStatus != null){
      _firebaseAuthStatus = firebaseAuthStatus;
    } else {
      if(_firebaseUser != null) {
        _firebaseAuthStatus = FirebaseAuthStatus.signin;
      } else {
        _firebaseAuthStatus = FirebaseAuthStatus.signout;
      }
    }

    notifyListeners();
  }

  // void loginWithFacebook(BuildContext context) async {
  //   if(_facebookLogin == null)
  //   final _facebookLogin = FacebookLogin();
  //   final result = await _facebookLogin.logIn(['email']);
  //
  //   switch(result.status) {
  //     case FacebookLoginStatus.loggedIn:
  //       _handleFacebookTokenWithFirebase(context, result.accessToken.token);
  //       break;
  //     case FacebookLoginStatus.cnacelledByUser:
  //       simpleSnackbar(context, 'User cancel facebook sign in');
  //       break;
  //     case FacebookLoginStatus.error:
  //       simpleSnackbar(context, 'facebook login error');
  //       _facebookLogin.logOut();
  //       break;
  //   }
  // }
  //
  // void _handleFacebookTokenWithFirebase(BuildContext context, String token) async {
  //   final AuthCredential credential = FacebookAuthProvider.getCredential(accessToken: token);
  //
  //   final AuthResult authResult = await _firebaseAuth.signInWithCredential(credential);
  //   final FirebaseUser user = authResult.user;
  //
  //   if(user == null) {
  //     simpleSnackbar(context, "페북 로그인이 실패. 나중에 시도해주세요.");
  //   } else {
  //     _firebaseUser = user;
  //   }
  //   notifyListeners();
  // }

  FirebaseAuthStatus get firebaseAuthStatus=>_firebaseAuthStatus;
  FirebaseUser get firebaseUser=>_firebaseUser;
}

enum FirebaseAuthStatus {
  signout,
  progress,
  signin
}