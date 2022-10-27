import 'package:flutter/material.dart';
import 'package:herb/palette/colors.dart';
import 'package:herb/palette/decorators.dart';
import 'package:herb/screens/Homepage/firebase/firebase.dart';
import 'package:herb/screens/myorders/Controller/fireorders.dart';

showLoaderDialog(BuildContext context, String msg) {
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

showYesNoDialog(BuildContext context, String msg, Function ontap) {
  final dialog = AlertDialog(
    content: InkWell(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            onTap: () {
              ontap();
            },
            child: Text(
              "Yes",
              style: priceS,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Text(
              "No",
              style: subtitleStyle,
            ),
          )
        ],
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
        return dialog;
      });
}
// aja raat vari code garera vaye pani sakauna parcha ! yes fuck yes