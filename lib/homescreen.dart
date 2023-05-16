import 'package:flutter/material.dart';
import 'package:tentativa_1/app_theme.dart';
import 'package:tentativa_1/bottom_nav_bar.dart';
import 'package:tentativa_1/login_page.dart';
import 'package:tentativa_1/profile_page.dart';
import 'package:tentativa_1/feed.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  bool _loggedIn = false;

  @override
  void initState() {
    super.initState();

    // Check if user is already logged in
    checkLoggedIn();
  }

  void checkLoggedIn() async {
    
    bool loggedIn = await Future.delayed(Duration(seconds: 2), () => false);

    setState(() {
      _loggedIn = loggedIn;
    });
  }

  void onLoginSuccess() {
    setState(() {
      _loggedIn = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_loggedIn) {
      return LoginPage(onLoginSuccess: onLoginSuccess);
    }

    return MaterialApp(
      title: 'DRESSME',
      home: Scaffold(
   
        body: FeedPage(),
        bottomNavigationBar: BottomNavBar(),
      ),
    );
  }
}
