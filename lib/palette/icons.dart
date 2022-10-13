import 'package:flutter/material.dart';
import 'package:herb/palette/colors.dart';
import 'package:herb/palette/decorators.dart';
import 'package:sizer/sizer.dart';

Widget iconMaker(IconData icon, double size, Color color) {
  return Icon(
    icon,
    color: color,
    size: size,
  );
}

Widget banner() {
  return Container(
    height: 10.h,
    color: bannerColor,
    child: Center(
      child: Text("Himalayan Herbs & Organic Center", style: bannerStyle),
    ),
  );
}

IconData homeIcon = Icons.h_mobiledata;
IconData catIcon = Icons.category_rounded;
IconData myOrdersIcon = Icons.shopping_bag_outlined;
IconData myAccIcon = Icons.account_circle_outlined;
