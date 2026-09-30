import 'package:flutter/material.dart';

import 'package:parkingapp/Core/Theme/ColorManager.dart';

class Bottomnav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> ontap;

  const Bottomnav({super.key, required this.currentIndex, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: ontap,
      type: BottomNavigationBarType.fixed,
      backgroundColor: ColorManager.primaryBG,
      selectedItemColor: ColorManager.buttonColor,
      unselectedItemColor: ColorManager.subtitleColor,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.map_outlined),
          activeIcon: Icon(Icons.map),
          label: 'Map',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.book_outlined),
          activeIcon: Icon(Icons.book),
          label: 'Booking',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          activeIcon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}
