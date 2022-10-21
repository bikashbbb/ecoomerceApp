import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:herb/palette/colors.dart';
import 'package:herb/palette/icons.dart';
import 'package:herb/palette/sizes.dart';
import 'package:herb/screens/Homepage/controller/navbarcontroller.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

final navController =
    ChangeNotifierProvider<NavController>(((ref) => NavController()));

class BottomNav extends ConsumerWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final con = ref.watch(navController);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: BottomNavigationBar(
          onTap: (index) {
            //controller.
            con.chnageNavIndex(index);
          },
          selectedItemColor: thrdC,
          currentIndex: con.navIndex,
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
