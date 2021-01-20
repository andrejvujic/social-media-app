import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(0.0),
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.grey,
                backgroundImage: CachedNetworkImageProvider(
                  FirebaseAuth.instance.currentUser.photoURL,
                ),
              ),
              title: Text(
                FirebaseAuth.instance.currentUser.displayName,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
              subtitle: Text(
                FirebaseAuth.instance.currentUser.email,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.white70,
                ),
              ),
            ),
          ),
          Column(
            children: <Widget>[
              ListTile(
                onTap: () => FirebaseAuth.instance.signOut(),
                leading: const Icon(
                  Icons.logout,
                  color: Colors.black,
                  size: 24.0,
                ),
                title: const Text(
                  'Odjavi me',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
