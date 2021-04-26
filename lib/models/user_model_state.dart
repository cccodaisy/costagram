import 'package:costagram/models/firestore/user_model.dart';
import 'package:flutter/foundation.dart';

class UserModelState extends ChangeNotifier {
  UserModel _userModel;

  UserModel get userModel=>_userModel;

  set userModel(UserModel userModel){
    _userModel = userModel;
    notifyListeners();
  }
}