import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:herb/palette/colors.dart';
import 'package:herb/palette/decorators.dart';
import 'package:herb/palette/dialog.dart';
import 'package:herb/screens/Category/models/product.dart';
import 'package:herb/screens/buyNow/controller/buycon.dart';
import 'package:herb/screens/buyNow/models/models.dart';
import 'package:sizer/sizer.dart';

import '../../Homepage/commonWidgets/category.dart';

class ConfirmBuy extends ConsumerWidget {
  ValueNotifier<bool> locEmpty = ValueNotifier(false);

  final OrderDetails orderDetails;
  final Product product;
  ConfirmBuy(this.orderDetails, this.product, {Key? key}) : super(key: key);

  final _adress = TextEditingController();
  final _email = TextEditingController(); // location ,
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 8.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                onPrimary: Colors.white,
                shadowColor: Colors.greenAccent,
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
              onPressed: () {
                if (_adress.text.isEmpty) {
                  locEmpty.value = true;
                } else {
                  locEmpty.value = false;
                  // loader will come in the
                  orderDetails.location = _adress.text;
                  orderDetails.email = _email.text;
                  ConfirmBuyControlls().onConfirmClicked(orderDetails, product,context);
                  
                }
              },
              child: Text(
                'Confirm Order',
                style: buyNowStyle,
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: mainC,
        iconTheme: IconThemeData(color: secC),
        title: Text(
          "Checkout",
          style: productTitleS,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // adress and email
            _adressEmail(),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                "Item",
                style: buyDesStyle,
              ),
            ),
            OrderCart(product, orderDetails.quantity),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                "Order Summary",
                style: buyDesStyle,
              ),
            ),
            _orderSum()
          ],
        ),
      ),
    );
  }

  Widget _orderSum() {
    return SizedBox(
      height: 15.h,
      width: 100.w,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Items Total",
                    style: subtitleStyle,
                  ),
                  Row(
                    children: [
                      Text(
                        "Nrs.",
                        style: subtitleStyle,
                      ),
                      Text(
                        product.price,
                        style: priceS,
                      )
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Payment",
                    style: subtitleStyle,
                  ),
                  Text(
                    orderDetails.quantity + '*' + product.price,
                    style: subtitleStyle,
                  )
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Price Without Delievery fee',
                    style: subtitleStyle,
                  ),
                  Row(
                    children: [
                      Text(
                        "Nrs. ",
                        style: subtitleStyle,
                      ),
                      Text(
                        getTotalAmount(),
                        style: priceS,
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  String getTotalAmount() {
    return (int.parse(orderDetails.quantity) * int.parse(product.price))
        .toString();
  }

  Widget _adressEmail() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 30.h,
        width: 100.w,
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Delivery to",
                    style: buyNowStyle,
                  ),
                  ValueListenableBuilder(
                      valueListenable: locEmpty,
                      builder: (builder, val, child) {
                        return locEmpty.value
                            ? Text(
                                "  *required",
                                style: priceS,
                              )
                            : const SizedBox();
                      })
                ],
              ),
              textFieldMaker("Input your location", _adress),
              const SizedBox(
                height: 5,
              ),
              Text(
                "Email for contact",
                style: buyNowStyle,
              ),
              textFieldMaker2("optional", _email, Icons.email),
            ],
          ),
        ),
      ),
    );
  }
}

class OrderCart extends StatelessWidget {
  final Product product;
  final String quantity;
  const OrderCart(this.product, this.quantity, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 17.h,
        width: 100.w,
        child: Card(
            child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 16.h,
              child: CachedNetworkImage(
                imageUrl: product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    product.name,
                    style: orderTitleStyle,
                    maxLines: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        "Nrs. ",
                        style: subtitleStyle,
                      ),
                      Text(
                        product.price,
                        style: priceS,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Quantity: $quantity",
                    style: subtitleStyle,
                  ),
                )
              ],
            ),
          ],
        )),
      ),
    );
  }
}
