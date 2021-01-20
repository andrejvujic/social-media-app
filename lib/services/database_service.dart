import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final String uid;
  DatabaseService({
    this.uid,
  });

  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference posts =
      FirebaseFirestore.instance.collection('posts');

  Future<void> addUser(User user) async {
    /// Dodaje novog korisnika u bazu podataka
    final Map<String, dynamic> userData = {
      'name': user.displayName,
      'email': user.email,
      'photoUrl': user.photoURL,
      'uid': user.uid,
      'joinedOn': Timestamp.now(),
    };

    await users.doc(uid).set(userData).catchError((e) => print(e.code));
  }

  Future<Map<String, dynamic>> addPost(
      {String id, String photoUrl, String caption = ''}) async {
    /// Dodaje novi post u bazu podataka
    final Map<String, dynamic> postData = {
      'authorUid': uid,
      'caption': caption,
      'id': id,
      'downloadUrl': photoUrl,
      'postedOn': Timestamp.now(),
      'likes': [],
      'comments': [],
    };

    await posts.doc(id).set(postData);
  }

  Future<void> setPostData({String id, Map<String, dynamic> data}) async =>
      await posts.doc(id).set(data);

  Stream<DocumentSnapshot> get userData => users.doc(uid).snapshots();
}
