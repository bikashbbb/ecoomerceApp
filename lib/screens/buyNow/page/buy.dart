import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_shake_animated/flutter_shake_animated.dart';
import 'package:herb/screens/Category/models/product.dart';
import 'package:herb/screens/Homepage/firebase/firebase.dart';
import 'package:herb/screens/buyNow/controller/buycon.dart';
import 'package:herb/screens/buyNow/models/models.dart';
import 'package:sizer/sizer.dart';
import 'package:quantity_input/quantity_input.dart';
import '../../../palette/colors.dart';
import '../../../palette/decorators.dart';
import '../../Homepage/commonWidgets/productcard.dart';

class BuyPage extends ConsumerWidget {
  final Product product;
  BuyPage(this.product, {Key? key}) : super(key: key);
  final _buynow = BuyControlls();
  final _quanityController = TextEditingController(text: 1.toString());

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartCon = ref.watch(productControlls);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainC,
        iconTheme: IconThemeData(color: secC),
        title: Text(
          "Buy Products",
          style: productTitleS,
        ),
        actions: [
          ShakeCart(() {
            cartCon.addToCart(product);
          }),
          const SizedBox(
            width: 12,
          )
        ],
      ),
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
                minimumSize: Size(50.w, 6.h), //////// HERE
              ),
              onPressed: () {
                // show quantity selec wala button !
                final OrderDetails orderDetails = OrderDetails(
                    product.id,
                    product.price,
                    "",
                    false,
                    DateTime.now(),
                    null,
                    0,
                    int.parse(LoginDetails.phoneNum));
                _buynow.onBuyNowCLicked(
                    _quanityController, context, product.id, orderDetails,
                    product
                    );
              },
              child: Text(
                'Buy Now !',
                style: buyNowStyle,
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 45.h,
              width: 100.h,
              color: mainC,
              child: CachedNetworkImage(
                imageUrl: product.imageUrl,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 2.w, bottom: 1.h),
              child: Text(
                product.name,
                style: productTitleS,
              ),
            ),
            Divider(
              color: secC,
              height: 0.5,
            ),
            Padding(
              padding: EdgeInsets.only(left: 2.w, bottom: 1.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "NRP. ${product.price}",
                    style: priceS,
                  ),
                  Row(
                    children: [
                      Text(
                        "Quantity ",
                        style: buyDesStyle,
                      ),
                      SizedBox(
                        width: 15.w,
                        height: 5.h,
                        child: TextField(
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          keyboardType: TextInputType.number,
                          controller: _quanityController,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Product Description",
                    style: buyDesStyle,
                  ),
                  Text(
                    product.description,
                    style: subtitleStyle,
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  _rowMaker("Brand : ", product.brand),
                  _rowMaker("Seller : ", "Himalayan Herbs & Organic Center"),
                  _rowMaker("Phone Number : ", "9779863995870")
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _rowMaker(String title, String subtitle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title,
          style: buyDesStyle,
        ),
        Text(
          subtitle,
          style: subtitleStyle,
        )
      ],
    );
  }
}

class ShakeCart extends StatefulWidget {
  final void Function() ontap;
  const ShakeCart(this.ontap, {Key? key}) : super(key: key);

  @override
  State<ShakeCart> createState() => _ShakeCartState();
}

class _ShakeCartState extends State<ShakeCart> {
  bool auto = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.ontap();
        setState(() {
          auto = !auto;
        });
        Future.delayed(const Duration(milliseconds: 500), () {
          setState(() {
            auto = !auto;
          });
        });
      },
      child: ShakeWidget(
          autoPlay: auto,
          shakeConstant: ShakeHorizontalConstant1(),
          duration: const Duration(milliseconds: 3),
          child: const Icon(Icons.add_shopping_cart)),
    );
  }
}
