import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final String uid;
  DatabaseService({
    this.uid,
  });

  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

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

  Stream<DocumentSnapshot> get userData => users.doc(uid).snapshots();
}
