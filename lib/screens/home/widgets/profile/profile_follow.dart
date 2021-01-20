import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/widgets/solid_button.dart';

class ProfileFollow extends StatefulWidget {
  final List<dynamic> followers;
  ProfileFollow({
    this.followers = const <String>[],
  });

  @override
  _ProfileFollowState createState() => _ProfileFollowState();
}

class _ProfileFollowState extends State<ProfileFollow> {
  bool isFollowedByUser = false;

  @override
  void initState() {
    isFollowedByUser =
        (widget.followers.contains(FirebaseAuth.instance.currentUser.uid))
            ? true
            : false;
    super.initState();
  }

  Future<void> onPressed() async {
    setState(() => isFollowedByUser = !isFollowedByUser);

    /// TODO: add user to other user's followers
  }

  @override
  Widget build(BuildContext context) {
    return SolidButton(
      onPressed: onPressed,
      showBorder: true,
      childWidth: MediaQuery.of(context).size.width * 0.40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            (isFollowedByUser) ? Icons.remove : Icons.add,
          ),
          SizedBox(width: 4.0),
          Text(
            (isFollowedByUser) ? 'Otprati' : 'Zaprati',
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }
}
