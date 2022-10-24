import 'package:flutter/material.dart';
import 'package:herb/palette/colors.dart';
import 'package:herb/palette/decorators.dart';

showLoaderDialog(BuildContext context,String msg) {
  AlertDialog alert = AlertDialog(
    content: Row(
      children: [
        const CircularProgressIndicator(),
        Container(margin: EdgeInsets.only(left: 7), child: Text("$msg")),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showErrorDialog(BuildContext context, String msg) {
  final alert = AlertDialog(
    content: InkWell(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Text(
        "CLose?",
        style: TextStyle(color: thrdC),
      ),
    ),
    title: Text(
      msg,
      style: productTitleS,
    ),
  );
  showDialog(
      context: context,
      builder: (builder) {
        return alert;
      });
}
