import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:herb/palette/dialog.dart';
import 'package:herb/screens/Category/models/product.dart';
import 'package:herb/screens/Homepage/page/home.dart';
import 'package:herb/screens/buyNow/firebase/buyfire.dart';
import 'package:herb/screens/buyNow/models/models.dart';
import 'package:herb/screens/buyNow/page/confirmbuy.dart';

class BuyControlls {
  void onBuyNowCLicked(TextEditingController quantity, BuildContext context,
      String pid, OrderDetails orderDetails, Product product) async {
    // check for the quantity shit if its zero also min order should match quantity!
    if (int.parse(quantity.text) == 0) {
      showErrorDialog(context, "Quantity cannot be zero");
    } // else if quanity != req min quantity also
    else {
      orderDetails.quantity = quantity.text;
      Navigator.of(context).push(MaterialPageRoute(builder: (builder) {
        return ConfirmBuy(orderDetails, product, "Confirm Order");
      }));
      /* bool isCreated = await _buyFirebase.onBuyNow(pid, orderDetails);
      if (isCreated) {
        // back jani nav bata !
        // bought sucesfully lekhne
      } else {
        showErrorDialog(context, "Cnnot Perfrom The action");
      } */
    }
  }
}

class ConfirmBuyControlls {
  final BuyFirebase _buyFirebase = BuyFirebase();

  void onConfirmClicked(
      OrderDetails orderDetails, Product product, BuildContext context) async {
    showLoaderDialog(context, "Creating Order");
    bool result = await _buyFirebase.onBuyNow(orderDetails);
    if (result) {
      // goto homepage and a snackbar !
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (builder) {
        return HomePage();
      }));
      globalkey2.currentState
          ?.showSnackBar(SnackBar(content: Text("Order Created Sucessfully")));
    } else {
      // show error msg
      showErrorDialog(context, "Unable to succeed");
    }
  }
}
