import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:nuenenen/screens/overview/stufen_page.dart';
import 'package:nuenenen/screens/settings/settings_page.dart';
import 'package:nuenenen/theme/colors.dart';
import 'package:nuenenen/screens/overview/home_page.dart';
import 'package:nuenenen/user_info.dart';
import 'package:permission_handler/permission_handler.dart';

class TabBarController extends StatefulWidget {
  @override
  _TabBarControllerState createState() => _TabBarControllerState();
}

class _TabBarControllerState extends State<TabBarController> {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  int _currentTab = 0;
  String _title = "Home";
  Widget _currentWidget = HomePage();
  Color tabBarColor = currBackgroundColor;

  void firebaseCloudMessaging_Listeners() {
    if (Platform.isIOS) iOS_Permission();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('(APP is open) on message $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
      },
    );
  }

  Future iOS_Permission() async {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));

    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });

    await Permission.camera.request();
  }

  void onTabTapped(int index) {
    lastPage = index;
    setState(() {
      tabBarColor = currBackgroundColor;
    });
    _currentTab = index;
    if (index == 0) {
      setState(() {
        _currentWidget = HomePage();
        _title = "Home";
      });
    } else if (index == 1) {
      setState(() {
        _currentWidget = StufenPage();
        _title = "Stufen";
      });
    } else if (index == 2) {
      setState(() {
        _currentWidget = SettingsPage();
        _title = "Einstellungen";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    firebaseCloudMessaging_Listeners();

    setState(() {
      _currentTab = lastPage;
      if (lastPage == 0) {
        setState(() {
          _currentWidget = HomePage();
          _title = "Home";
        });
      } else if (lastPage == 1) {
        setState(() {
          _currentWidget = StufenPage();
          _title = "Stufen";
        });
      } else if (lastPage == 2) {
        setState(() {
          _currentWidget = SettingsPage();
          _title = "Einstellungen";
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentWidget,
      backgroundColor: currBackgroundColor,
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentTab,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        backgroundColor: tabBarColor,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 30.0,
                color: Colors.grey,
              ),
              activeIcon: Icon(Icons.home, size: 30.0, color: mainColor),
              title: Text(
                "Home",
                style: TextStyle(color: Colors.grey),
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.info,
                size: 30.0,
                color: Colors.grey,
              ),
              activeIcon: Icon(Icons.info, size: 30.0, color: mainColor),
              title: Text("Stufen", style: TextStyle(color: Colors.grey))),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                size: 30.0,
                color: Colors.grey,
              ),
              activeIcon: Icon(Icons.settings, size: 30.0, color: mainColor),
              title:
                  Text("Einstellungen", style: TextStyle(color: Colors.grey))),
        ],
      ),
    );
  }
}
