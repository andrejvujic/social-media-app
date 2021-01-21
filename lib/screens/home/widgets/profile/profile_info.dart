import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/screens/home/widgets/profile/profile_follow.dart';
import 'package:social_media_app/services/database_service.dart';
import 'package:social_media_app/widgets/loading_placeholder.dart';
import 'package:social_media_app/widgets/solid_button.dart';

class ProfileInfo extends StatefulWidget {
  final String uid;
  Function reset = () => null;

  ProfileInfo({
    @required this.uid,
  });

  @override
  _ProfileInfoState createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  DatabaseService db;
  Map<String, dynamic> userData;

  @override
  void initState() {
    db = DatabaseService(uid: widget.uid);
    widget.reset = () => setState(() => userData = null);
    super.initState();
  }

  Future<void> getUserData() async {
    final Map<String, dynamic> data =
        await db.users.doc(widget.uid).get().then((value) => value.data());

    setState(() => userData = data ?? {});
  }

  void editProfile() {
    /// TODO: implement edit profile
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (userData == null) {
        getUserData();
      }
    });

    return ((userData?.length ?? 0) > 0)
        ? Container(
            margin: EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 40.0,
                      backgroundImage: CachedNetworkImageProvider(
                        userData['photoUrl'],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              /*
                              Column(
                                children: <Widget>[
                                  Text('Objave'),
                                  Text(
                                    '0',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontFamily: 'Poppins-Bold',
                                    ),
                                  ),
                                ],
                              ),
                              */
                              Column(
                                children: <Widget>[
                                  Text('Pratioci'),
                                  Text(
                                    '${userData['followers']?.length ?? 0}',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontFamily: 'Poppins-Bold',
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Text('Prati'),
                                  Text(
                                    '${userData['following']?.length ?? 0}',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontFamily: 'Poppins-Bold',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          (widget.uid == FirebaseAuth.instance.currentUser.uid)
                              ? Container()
                              : ProfileFollow(),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
                Container(
                  margin: EdgeInsets.only(left: 4.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '${userData['name'] ?? ''}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'Poppins-Bold',
                        ),
                      ),
                      Text(
                        '${userData['about'] ?? ''}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 5,
                      ),
                      (widget.uid == FirebaseAuth.instance.currentUser.uid)
                          ? SolidButton(
                              onPressed: editProfile,
                              margin: EdgeInsets.symmetric(vertical: 8.0),
                              showBorder: true,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.edit),
                                  SizedBox(width: 4.0),
                                  Text(
                                    'Izmijeni profil',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                    ),
                                  )
                                ],
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ],
            ),
          )
        : LoadingPlaceholder(
            title: 'Učitavamo vaš profil',
            subtitle:
                'Vaš profil se trenutno učitava, molimo vas da sačekate. Ovo ne bi trebalo da potraje dugo.',
            showProgressIndicator: true,
          );
  }
}
