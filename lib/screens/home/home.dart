import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/screens/home/explore.dart';
import 'package:social_media_app/screens/home/following.dart';
import 'package:social_media_app/screens/home/widgets/home_drawer.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController controller;
  int currentPage = 0;

  @override
  void initState() {
    controller = PageController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
        child: Center(
          child: PageView(
            physics: ScrollPhysics(),
            onPageChanged: (int page) => setState(() => currentPage = page),
            controller: controller,
            children: [
              Following(),
              Explore(),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => null,
        elevation: 0.0,
        child: Icon(
          Icons.add,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.people_alt_outlined,
              size: 30.0,
            ),
          ),
          const BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.explore_outlined,
              size: 30.0,
            ),
          ),
        ],
      ),
    );
  }
}
