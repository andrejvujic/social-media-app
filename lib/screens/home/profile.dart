import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/screens/home/widgets/profile/profile_info.dart';
import 'package:social_media_app/screens/home/widgets/profile/profile_posts.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with AutomaticKeepAliveClientMixin {
  final User user = FirebaseAuth.instance.currentUser;

  ProfileInfo profileInfo = ProfileInfo(
    uid: FirebaseAuth.instance.currentUser.uid,
  );
  ProfilePosts profilePosts = ProfilePosts(
    uid: FirebaseAuth.instance.currentUser.uid,
  );

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          profileInfo.reset?.call();
          profilePosts.reset?.call();
        },
        child: Column(
          children: <Widget>[
            profileInfo,
            profilePosts,
          ],
        ),
      ),
    );
  }
}
