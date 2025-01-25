import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:horus_travels_bloc/authentication/screens/fav_page.dart';
import 'package:horus_travels_bloc/authentication/screens/gov_screen.dart';
import 'package:horus_travels_bloc/authentication/screens/home_page.dart';
import 'widgets/main_widgets/profile_page.dart';
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const HomePage(),
    GovernmentsPage(),
    const FavoritesPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: GNav(
          gap: 8,
          activeColor: Colors.white,
          color: const Color.fromARGB(255, 67, 158, 188),
          iconSize: 24,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          duration: const Duration(milliseconds: 400),
          tabBackgroundColor: const Color.fromARGB(255, 67, 158, 188),
          tabs: const [
            GButton(icon: Icons.home, text: 'Home'),
            GButton(icon: Icons.location_city, text: 'Governments'),
            GButton(icon: Icons.favorite, text: 'Favorites'),
            GButton(icon: Icons.person, text: 'Profile'),
          ],
          selectedIndex: _currentIndex,
          onTabChange: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
