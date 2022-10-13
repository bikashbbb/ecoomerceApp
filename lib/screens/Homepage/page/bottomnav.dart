import 'package:flutter/material.dart';
import 'package:herb/palette/colors.dart';
import 'package:herb/palette/icons.dart';
import 'package:herb/palette/sizes.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  ValueNotifier activeIndex = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: BottomNavigationBar(
          selectedItemColor: thrdC,
          currentIndex: 0,
          items: [
            BottomNavigationBarItem(
                icon: iconMaker(homeIcon, iconFont, secC),
                activeIcon: iconMaker(homeIcon, iconFont, thrdC),
                label: "Home"),
            BottomNavigationBarItem(
                icon: iconMaker(catIcon, iconFont, secC),
                label: "Category",
                activeIcon: iconMaker(catIcon, iconFont, thrdC)),
            BottomNavigationBarItem(
                icon: iconMaker(myOrdersIcon, iconFont, secC),
                label: "My Orders",
                activeIcon: iconMaker(myOrdersIcon, iconFont, thrdC)),
            BottomNavigationBarItem(
                icon: iconMaker(myAccIcon, iconFont, secC),
                label: "My Account",
                activeIcon: iconMaker(myAccIcon, iconFont, thrdC)),
          ],
        ),
      ),
    );
  }

  void icontapped() {
    // gets to another page and also notifies the
  }
}
