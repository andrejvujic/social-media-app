import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/screens/home/widgets/home_drawer.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Socialgram',
          style: TextStyle(
            fontFamily: 'Poppins-Bold',
            fontSize: 20.0,
          ),
        ),
      ),
      drawer: HomeDrawer(),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                  'Dobrodošao/la, ${FirebaseAuth.instance.currentUser.displayName}'),
            ],
          ),
        ),
      ),
    );
  }
}
