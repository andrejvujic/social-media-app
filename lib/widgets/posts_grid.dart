import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PostsGrid extends StatefulWidget {
  @override
  _PostsGridState createState() => _PostsGridState();

  final List<QueryDocumentSnapshot> posts;
  PostsGrid({
    @required this.posts,
  });
}

class _PostsGridState extends State<PostsGrid> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(
        widget.posts.length,
        (int index) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(width: 0.25),
            ),
            margin: EdgeInsets.all(2.5),
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: widget.posts[index].data()['downloadUrl'],
              placeholder: (BuildContext context, String _) => Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        },
      ),
    );
  }
}
