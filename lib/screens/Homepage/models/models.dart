import 'package:flutter/widgets.dart';

class Category {
  //
  String name;

  Category(this.name);
}

class NetworkImage {
  String url;

  NetworkImage(this.url);
}

class CategoryCard {
  String catname;
  String catid;
  IconData icon;
  bool isTapped;
  int index;
  Function ontap;

  CategoryCard(this.catid, this.catname, this.icon, this.index,this.ontap,
      {this.isTapped = false});
}
