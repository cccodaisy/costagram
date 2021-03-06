import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:costagram/data.dart';
import 'package:costagram/models/user_model_state.dart';
import 'package:costagram/screens/camera_screen.dart';
import 'package:costagram/screens/profile_screen.dart';
import 'package:costagram/screens/feed_screen.dart';
import 'package:costagram/constants/screen_size.dart';
import 'package:costagram/screens/search_screen.dart';
import 'package:costagram/widgets/my_progress_indicator.dart';
import 'package:costagram/screens/story_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({
    Key key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BottomNavigationBarItem> btmNavItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
    BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
    BottomNavigationBarItem(icon: Icon(Icons.add), label: ''),
    BottomNavigationBarItem(icon: Icon(Icons.healing), label: ''),
    BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: ''),
  ];

  int _selectedIndex = 0;
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  List<Widget> _screens = <Widget>[
    Consumer<UserModelState>(
      builder: (BuildContext contex, UserModelState userModelState, Widget child) {
        if(userModelState == null
        || userModelState.userModel == null
        || userModelState.userModel.followings == null
        || userModelState.userModel.followings.isEmpty)
          return MyProgressIndicator();
        else
          return FeedScreen(userModelState.userModel.followings);
    }),
    SearchScreen(),
    Container(
      color: Colors.greenAccent,
    ),
    StoryScreen(stories: stories),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    if (size == null) size = MediaQuery
        .of(context)
        .size;
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return Scaffold(
      key: _key,
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: btmNavItems,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.black87,
        currentIndex: _selectedIndex,
        onTap: _onBtmItemClick,
      ),
    );
  }

  void _onBtmItemClick(int index) {
    switch(index){
      case 2:
        _openCamera();
      break;
      default: {
        print(index);
        setState(() {
          _selectedIndex = index;
        });
      }
    }
  }

  void _openCamera() async {
    if(await checkIfPermissionGranted(context))
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CameraScreen()
      )
    );
    else {
      SnackBar snackBar = SnackBar(
        content: Text('??????, ??????, ????????? ?????? ?????? ???????????? ????????? ?????? ???????????????!'),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {
            _key.currentState.hideCurrentSnackBar();
            AppSettings.openAppSettings();
          },
        ),
      );
      _key.currentState.showSnackBar(snackBar);
    }
  }

  Future<bool> checkIfPermissionGranted(BuildContext context) async{
    Map<Permission, PermissionStatus> statuses =
    await [
      Permission.camera,
      Permission.microphone,
      Platform.isIOS ?
      Permission.photos : Permission.storage
    ].request();
    bool permitted = true;

    statuses.forEach((permission, permissionStatus) {
      if(!permissionStatus.isGranted){
        permitted = false;
      }
    });

    return permitted;

  }
}
