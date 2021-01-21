import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media_app/screens/home/activities.dart';
import 'package:social_media_app/screens/home/explore.dart';
import 'package:social_media_app/screens/home/following.dart';
import 'package:social_media_app/screens/home/profile.dart';
import 'package:social_media_app/screens/home/upload.dart';
import 'package:social_media_app/screens/home/widgets/home/home_drawer.dart';
import 'package:social_media_app/screens/route_builder.dart';
import 'package:social_media_app/services/database_service.dart';
import 'package:social_media_app/widgets/loading_placeholder.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final imagePicker = ImagePicker();
  final db = DatabaseService(uid: FirebaseAuth.instance.currentUser.uid);
  PageController controller;
  int currentPage = 0;

  @override
  void initState() {
    controller = PageController(keepPage: true);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void askForImageSource() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: <Widget>[
            ListTile(
              onTap: () => getImage(source: ImageSource.camera),
              leading: const Icon(
                Icons.camera_alt_outlined,
                color: Colors.black,
                size: 24.0,
              ),
              title: const Text(
                'Slikaj novu fotografiju',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                ),
              ),
            ),
            ListTile(
              onTap: () => getImage(source: ImageSource.gallery),
              leading: const Icon(
                Icons.photo_library_outlined,
                color: Colors.black,
                size: 24.0,
              ),
              title: const Text(
                'Upotrijebi fotografiju iz galerije',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void getImage({ImageSource source}) async {
    final PickedFile pickedFile = await imagePicker.getImage(
      maxHeight: 500,
      maxWidth: 500,
      source: source ?? ImageSource.camera,
      imageQuality: 50,
    );

    if (pickedFile != null) {
      await Navigator.push(
        context,
        buildRoute(
          Upload(pickedFile: pickedFile),
        ),
      );
    }

    Navigator.pop(context);
  }

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
        child: StreamBuilder(
          stream: db.userDataSnaphots,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            final Map<String, dynamic> userData = snapshot.data.data();
            if (userData == null) {
              db.addUser(FirebaseAuth.instance.currentUser);

              return LoadingPlaceholder(
                title: 'Podešavamo vaš profil',
                subtitle:
                    'U toku je podešavanje vašeg profila. Ovo neće trajati dugo, molimo vas da sačekate.',
                showProgressIndicator: true,
              );
            }

            return PageView(
              physics: ScrollPhysics(),
              onPageChanged: (int page) => setState(() => currentPage = page),
              controller: controller,
              children: [
                Following(),
                Explore(),
                Activities(),
                Profile(),
              ],
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).accentColor,
        tooltip: 'Objavi',
        onPressed: askForImageSource,
        elevation: 0.0,
        hoverElevation: 4.0,
        highlightElevation: 4.0,
        child: Icon(
          Icons.add,
        ),
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          fontFamily: 'Poppins-Regular',
        ),
        child: BottomNavigationBar(
          currentIndex: currentPage,
          onTap: (int page) {
            setState(() => currentPage = page);
            controller.animateToPage(
              page,
              duration: Duration(milliseconds: 200),
              curve: Curves.easeInOut,
            );
          },
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedLabelStyle: const TextStyle(fontSize: 0.0),
          unselectedLabelStyle: const TextStyle(fontSize: 0.0),
          unselectedIconTheme: IconThemeData(color: Colors.black, size: 24.0),
          selectedIconTheme:
              IconThemeData(color: Theme.of(context).accentColor, size: 30.0),
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            const BottomNavigationBarItem(
              label: 'Praćenja',
              icon: Icon(Icons.people_alt_outlined),
            ),
            BottomNavigationBarItem(
              label: 'Istraži',
              icon: Container(
                margin: const EdgeInsets.only(right: 44.0),
                child: const Icon(Icons.explore_outlined),
              ),
            ),
            BottomNavigationBarItem(
              label: 'Aktivnosti',
              icon: Container(
                margin: const EdgeInsets.only(left: 44.0),
                child: const Icon(Icons.favorite_border),
              ),
            ),
            BottomNavigationBarItem(
              label: 'Moj profil',
              icon: Icon(Icons.settings_outlined),
            ),
          ],
        ),
      ),
    );
  }
}
