import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/services/database_service.dart';
import 'package:social_media_app/widgets/loading_placeholder.dart';
import 'package:social_media_app/widgets/posts_grid.dart';
import 'package:social_media_app/widgets/solid_button.dart';

class ProfilePosts extends StatefulWidget {
  @override
  _ProfilePostsState createState() => _ProfilePostsState();

  final String uid;
  ProfilePosts({
    this.uid,
  });
}

class _ProfilePostsState extends State<ProfilePosts> {
  DatabaseService db;
  List<QueryDocumentSnapshot> userPosts;

  @override
  void initState() {
    db = DatabaseService(uid: widget.uid);
    super.initState();
  }

  Future<void> getUserPosts() async {
    final List<QueryDocumentSnapshot> posts = await db.posts
        .orderBy('postedOn', descending: true)
        .where('authorId', isEqualTo: widget.uid)
        .get()
        .then((value) => value.docs);

    print(posts);

    setState(() => userPosts = posts ?? []);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (userPosts == null) {
        getUserPosts();
      }
    });

    return (userPosts == null)
        ? LoadingPlaceholder(
            title: 'Učitavamo vaše objave',
            subtitle:
                'Vaše objave se trenutno učitavaju, molimo vas da sačekate. Ovo ne bi trebalo da potraje dugo.',
            showProgressIndicator: true,
          )
        : (userPosts.length > 0)
            ? Expanded(child: PostsGrid(posts: userPosts))
            : LoadingPlaceholder(
                title: 'Nema objava',
                subtitle:
                    'Trenutno nema objava za prikazivanje, jer nijedna objava nije dodana. Kada ih bude bilo sve objave će biti prikazane ovdje.',
                child: (widget.uid == FirebaseAuth.instance.currentUser.uid)
                    ? SolidButton(
                        margin: EdgeInsets.symmetric(horizontal: 8.0),
                        color: Theme.of(context).primaryColor,
                        splashColor: Colors.white,
                        highlightColor: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            SizedBox(width: 4.0),
                            Text(
                              'Dodaj svoju prvu objavu',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(),
              );
  }
}
