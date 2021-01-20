import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/screens/home/widgets/profile/profile_info.dart';
import 'package:social_media_app/screens/home/widgets/profile/profile_posts.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final User user = FirebaseAuth.instance.currentUser;

  Map<String, dynamic> postData = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          ProfileInfo(
            uid: FirebaseAuth.instance.currentUser.uid,
          ),
          ProfilePosts(
            uid: FirebaseAuth.instance.currentUser.uid,
          ),
        ],
      ),
    );
  }
}
