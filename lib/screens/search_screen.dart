import 'package:costagram/constants/common_size.dart';
import 'package:costagram/models/firestore/user_model.dart';
import 'package:costagram/models/repo/user_network_repository.dart';
import 'package:costagram/models/user_model_state.dart';
import 'package:costagram/widgets/my_progress_indicator.dart';
import 'package:costagram/widgets/rounded_avatar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                  child: Consumer<UserModelState>(
                    builder: (BuildContext context, UserModelState myUserModelState, Widget child) {
                      return ListView.separated(
                          itemBuilder: (context, index) {
                            UserModel otherUser = snapshot.data[index];
                            bool amIFollowing = Provider.of<UserModelState>(context, listen: false).amIFollowingThisUser(otherUser.userKey);
                            return ListTile(
                              onTap: () {
                                setState(() {
                                  amIFollowing
                                    ? userNetworkRepository.unFollowUser(
                                      myUserKey: myUserModelState.userModel.userKey,
                                        otherUserKey: otherUser.userKey
                                    ) :  userNetworkRepository.followUser(
                                      myUserKey: myUserModelState.userModel.userKey,
                                      otherUserKey: otherUser.userKey
                                    );
                                });
                              },
                              leading: RoundedAvatar(),
                              title: Text(otherUser.username),
                              subtitle: Text('user bio of ${otherUser.username}'),
                              trailing: Container(
                                height: 30,
                                width: 80,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: amIFollowing
                                      ? Colors.blue[50]
                                      : Colors.red[50],
                                  border: Border.all(
                                      color: amIFollowing
                                          ? Colors.blue
                                          : Colors.red,
                                      width: 0.5),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  amIFollowing ? 'following' : 'unfollow',
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
                          itemCount: snapshot.data.length
                      );
                    }
                  )
              );
            } else {
              return MyProgressIndicator();
            }
          }
      ),
    );
  }
}
