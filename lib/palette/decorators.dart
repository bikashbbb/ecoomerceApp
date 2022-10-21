import 'package:flutter/material.dart';
import 'package:herb/palette/colors.dart';
import 'package:herb/palette/sizes.dart';
import 'package:sizer/sizer.dart';

TextStyle secheader = TextStyle(
  color: secC,
  fontSize: secheaderSize,
);

TextStyle secheaderBold = TextStyle(
  color: secC,
  fontWeight: FontWeight.bold,
  fontSize: secheaderSize,
);
TextStyle bannerStyle =
    TextStyle(color: mainC, fontSize: banneFont, fontWeight: FontWeight.bold);

TextStyle cardFotterStyle =
    TextStyle(color: secC, fontSize: cardFotter, fontWeight: FontWeight.bold);

TextStyle catHeaderStyle = TextStyle(
  color: mainC,
  fontWeight: FontWeight.bold,
  fontSize: catHeaderSize,
);

BoxDecoration fotterBoxDec = BoxDecoration(
    color: thrdC,
    border: Border.all(),
    borderRadius: const BorderRadius.all(Radius.circular(20)));

TextStyle productTitleS = TextStyle(
    color: Colors.black54,
    fontSize: prdctTitleSize,
    fontWeight: FontWeight.bold);

TextStyle priceS = TextStyle(
  color: Colors.red,
  fontWeight: FontWeight.bold,
  fontSize: prdctTitleSize,
);

TextStyle prevPriceS =
    TextStyle(decoration: TextDecoration.lineThrough, fontSize: 9.sp);
