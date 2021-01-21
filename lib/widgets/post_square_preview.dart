import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/screens/route_builder.dart';
import 'package:social_media_app/services/database_service.dart';
import 'package:social_media_app/widgets/post_full_preview.dart';
import 'package:social_media_app/widgets/yes_no_alert.dart';

class PostSquarePreview extends StatefulWidget {
  @override
  _PostSquarePreviewState createState() => _PostSquarePreviewState();

  final Map<String, dynamic> postData;
  PostSquarePreview({
    @required this.postData,
  });
}

class _PostSquarePreviewState extends State<PostSquarePreview> {
  final db = DatabaseService(uid: FirebaseAuth.instance.currentUser.uid);

  Future<void> deletePost() async => YesNoAlert.show(
        context,
        title: 'Upozorenje',
        text:
            'Da li ste sigurni da želite da obrišete ovu objavu? Nećete je moći vratiti.',
        onYesPressed: () async =>
            await db.deletePost(id: widget.postData['id']),
      );

  Future<void> showPost() async => await Navigator.push(
        context,
        buildRoute(
          PostFullPreview(postData: widget.postData),
          begin: Offset(0.0, 1.0),
        ),
      );

  void handleMenuValueSelect(String selectedValue) {
    switch (selectedValue) {
      case 'delete-post':
        deletePost();
        break;
      case 'show-post':
        showPost();
        break;
      default:
        break;
    }
  }

  void onLongPressStart(LongPressStartDetails details) {
    final double x = details.globalPosition.dx, y = details.globalPosition.dy;

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(x, y, x, y),
      items: [
        PopupMenuItem(
          value: 'show-post',
          child: Text(
            'Prikaži...',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.0,
            ),
          ),
        ),
        (widget.postData['authorId'] == FirebaseAuth.instance.currentUser.uid)
            ? PopupMenuItem(
                value: 'delete-post',
                child: Text(
                  'Obriši...',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
              )
            : PopupMenuItem(
                value: 'null',
                enabled: false,
                height: 0.0,
                child: Container(),
              ),
        PopupMenuItem(
          value: 'null',
          enabled: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: 100.0,
                child: Text(
                  '${widget.postData['likes']?.length ?? 0}',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20.0,
                  ),
                ),
              ),
              Icon(Icons.thumb_up_outlined),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'null',
          enabled: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: 100.0,
                child: Text(
                  '${widget.postData['comments']?.length ?? 0}',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20.0,
                  ),
                ),
              ),
              Icon(Icons.comment_outlined),
            ],
          ),
        ),
      ],
    ).then(
      (String selectedValue) => handleMenuValueSelect(selectedValue),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: onLongPressStart,
      onTap: showPost,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 0.25),
        ),
        margin: EdgeInsets.all(2.5),
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: widget.postData['downloadUrl'],
          placeholder: (BuildContext context, String _) => Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
