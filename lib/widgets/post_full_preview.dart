import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:social_media_app/services/database_service.dart';
import 'package:social_media_app/widgets/loading_placeholder.dart';
import 'package:social_media_app/widgets/solid_button.dart';

class PostFullPreview extends StatefulWidget {
  @override
  _PostFullPreviewState createState() => _PostFullPreviewState();

  final Map<String, dynamic> postData;
  PostFullPreview({
    this.postData,
  });
}

class _PostFullPreviewState extends State<PostFullPreview> {
  final db = DatabaseService(uid: FirebaseAuth.instance.currentUser.uid);
  Map<String, dynamic> authorData;
  bool isLikedByUser = false;

  @override
  void initState() {
    super.initState();
    isLikedByUser = (widget.postData['likes']
            .contains(FirebaseAuth.instance.currentUser.uid))
        ? true
        : false;
  }

  Future<void> likePost() async {
    setState(() => isLikedByUser = !isLikedByUser);
  }

  Future<void> getAuthorData() async {
    final Map<String, dynamic> data = await db.users
        .doc(widget.postData['authorId'] ?? '')
        .get()
        .then((value) => value.data());

    setState(() => authorData = data ?? {});
  }

  String getPostDate(Timestamp postedOn) {
    final DateTime date = postedOn.toDate();
    final shortFormat = DateFormat('HH:mm');
    final longFormat = DateFormat('d/M/yyyy');
    if (longFormat.format(date) == longFormat.format(DateTime.now())) {
      return 'danas u ${shortFormat.format(date)}';
    } else {
      return '${longFormat.format(date)}';
    }
  }

  int getPostLikes(List<dynamic> likes, bool isLikedByUser) {
    if (likes.contains(FirebaseAuth.instance.currentUser.uid)) {
      if (isLikedByUser == true) {
        return likes.length;
      } else {
        return likes.length - 1;
      }
    } else if (isLikedByUser == true) {
      return likes.length + 1;
    } else {
      return likes.length;
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (authorData == null) {
        getAuthorData();
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Objava'),
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            CachedNetworkImage(
              imageUrl: widget.postData['downloadUrl'] ?? '',
              height: MediaQuery.of(context).size.height * 0.50,
            ),
            (authorData == null || (authorData?.length ?? 0) == 0)
                ? LoadingPlaceholder(
                    title: 'Učitavanje informacija...',
                    subtitle:
                        'Učitavamo dodatne informacije o objavi. Molimo vas da sačekajte. Ovo ne bi trebalo trajati dugo.',
                    showProgressIndicator: true,
                  )
                : Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            '${getPostLikes(widget.postData['likes'], isLikedByUser)} sviđanja',
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          Text(
                            '${widget.postData['comments'].length} komentara',
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          SolidButton(
                            onPressed: likePost,
                            child: (isLikedByUser)
                                ? Icon(Icons.thumb_up)
                                : Icon(Icons.thumb_up_outlined),
                          ),
                          SolidButton(
                            child: Icon(Icons.comment_outlined),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          CircleAvatar(
                            backgroundColor: Colors.grey,
                            backgroundImage: CachedNetworkImageProvider(
                              authorData['photoUrl'] ?? '',
                            ),
                          ),
                          SizedBox(width: 8.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                ((widget.postData['caption']?.length ?? 0) > 0)
                                    ? Text(
                                        widget.postData['caption'],
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 5,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                        ),
                                      )
                                    : Container(),
                                Text(
                                  'Objavio/la ${authorData['name']}, ${getPostDate(widget.postData['postedOn'])}',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
