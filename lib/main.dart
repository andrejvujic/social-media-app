import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/screens/home/home.dart';
import 'package:social_media_app/screens/login/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Socialgram',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.blue[900],
        ),
        fontFamily: 'Poppins-Regular',
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue[900],
        accentColor: Colors.yellowAccent[700],
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.light,
        highlightColor: Colors.blue[900].withOpacity(0.1),
        splashColor: Colors.blue[900].withOpacity(0.2),
      ),
      home: Auth(),
    );
  }
}

class Auth extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider(
      create: (BuildContext context) =>
          FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, Widget _) {
        final User user = context.watch<User>();

        return (user == null) ? Login() : Home();
      },
    );
  }
}
