import 'package:costagram/constants/common_size.dart';
import 'package:costagram/models/firestore/user_model.dart';
import 'package:costagram/models/repo/user_network_repository.dart';
import 'package:costagram/widgets/my_progress_indicator.dart';
import 'package:costagram/widgets/rounded_avatar.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Follow/Unfollow')
      ),
      body: StreamBuilder<List<UserModel>>(
        stream: userNetworkRepository.getAllUsersWithoutMe(),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
              return SafeArea(
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        UserModel userModel = snapshot.data[index];
                        return ListTile(
                          onTap: () {
                            setState(() {
                              // followings[index] = !followings[index];
                            });
                          },
                          leading: RoundedAvatar(),
                          title: Text(userModel.username),
                          subtitle: Text('user bio of ${userModel.username}'),
                          trailing: Container(
                            height: 30,
                            width: 80,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color:
                              // followings[index]
                              //     ? Colors.red[50] :
                              Colors.blue[50],
                              border: Border.all(
                                  color:
                                  // followings[index]
                                  //     ? Colors.red[50] :
                                       Colors.blue,
                                  width: 0.5),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              // followings[index] ? 'following' : 'follow',
                              'following',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider(
                          color: Colors.grey,
                        );
                      },
                      itemCount: snapshot.data.length)
              );
            } else {
              return MyProgressIndicator();
            }
          }
      ),
    );
  }
}
