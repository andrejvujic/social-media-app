import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

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
      'about': '',
      'email': user.email,
      'photoUrl': user.photoURL,
      'uid': user.uid,
      'joinedOn': Timestamp.now(),
      'followers': [],
      'following': [],
    };

    await users.doc(uid).set(userData).catchError((e) => print(e.code));
  }

  Future<void> addPost(
      {String id, String photoUrl, String caption = ''}) async {
    /// Dodaje novi post u bazu podataka
    final Map<String, dynamic> postData = {
      'authorId': uid,
      'caption': caption,
      'id': id,
      'downloadUrl': photoUrl,
      'postedOn': Timestamp.now(),
      'likes': [],
      'comments': [],
    };

    await posts.doc(id).set(postData);
  }

  Future<void> deletePost({String id}) async {
    /// Briše objavu iz baze podataka
    await FirebaseStorage.instance.ref('posts/$id').delete();
    await posts.doc(id).delete();
  }

  Future<void> setPostData({String id, Map<String, dynamic> data}) async =>
      await posts.doc(id).set(data);

  Stream<DocumentSnapshot> get userDataSnaphots => users.doc(uid).snapshots();
}
