import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/widgets/post_square_preview.dart';

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
        (int index) => PostSquarePreview(
          postData: widget.posts[index].data(),
        ),
      ),
    );
  }
}
