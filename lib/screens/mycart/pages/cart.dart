import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:herb/palette/colors.dart';
import 'package:herb/palette/decorators.dart';
import 'package:herb/screens/Category/pages/entry.dart';
import 'package:herb/screens/Homepage/commonWidgets/productcard.dart';
import 'package:herb/screens/Homepage/page/home.dart';
import 'package:herb/screens/mycart/commonwid/emptywid.dart';
import 'package:herb/screens/mycart/controller/cartcontroller.dart';
import 'package:herb/screens/mycart/firebase/firecart.dart';
import 'package:sizer/sizer.dart';

class CartPage extends ConsumerWidget {
  CartPage({Key? key}) : super(key: key);

  final FireCart fireCart = FireCart();

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainC,
        iconTheme: IconThemeData(color: secC),
        title: Text(
          "My Cart",
          style: productTitleS,
        ),
      ),
      body: Column(
        children: [
          FutureBuilder<bool>(
              future: fireCart.isCartEmpty(),
              builder: (builder, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  default:
                    if (snapshot.hasError)
                      return Text('Error: ${snapshot.error}');
                    else {
                      if (!snapshot.data!) {
                        // load the product bitch
                        return ProductLoader(fireCart);
                      }
                      return Padding(
                        padding: EdgeInsets.only(top: 10.h),
                        child: const NoItem(
                            "Cart is Empty", "No Items Available Yet."),
                      );
                    }
                }
              })
        ],
      ),
    );
  }
}

/* final counterProvider = StateNotifierProvider((ref) {
  return CartItems();
}); */

class ProductLoader extends ConsumerWidget {
  // yesma product haru fetch hudai load hunxa !
  const ProductLoader(this.fireCart, {Key? key}) : super(key: key);

  final FireCart fireCart;

  @override
  Widget build(BuildContext context, ref) {
    return ProductForYou(fireCart.getAllProducts(),isInCart: true,);
  }
}
