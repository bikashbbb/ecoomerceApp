import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:herb/palette/colors.dart';
import 'package:herb/palette/dialog.dart';
import 'package:herb/screens/buyNow/models/models.dart';
import 'package:herb/screens/buyNow/page/confirmbuy.dart';
import 'package:herb/screens/myorders/Controller/fireorders.dart';
import 'package:sizer/sizer.dart';

import '../../../palette/decorators.dart';
import '../../Category/models/product.dart';
import '../../mycart/commonwid/emptywid.dart';

class MyOrders extends ConsumerWidget {
  final FireOrders fireOrders = FireOrders();
  MyOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: mainC,
          iconTheme: IconThemeData(color: secC),
          title: Text(
            "Products To Recievie",
            style: productTitleS,
          )),
      body: _MyOrders(fireOrders.orderQUery()),
    );
  }
}

class _MyOrders extends StatelessWidget {
  final Query query;
  const _MyOrders(this.query, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FirestoreQueryBuilder(
        query: query,
        builder: (ctx, snaps, child) {
          /* snaps.docs[index]
          final product = Product.toObj(); */
          if (snaps.docs.isEmpty) {
            return Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: const NoItem("Nothing Ordered", "No Items Ordered Yet."),
            );
          }
          return ListView.builder(
              itemCount: snaps.docs.length,
              itemBuilder: (ctx, index) {
                if (snaps.hasData) {
                  final product = Product.toObj(
                      snaps.docs[0].data()! as Map, snaps.docs[0].id);

                  return InkWell(
                      onTap: () async {
                        showLoaderDialog(context, "Proceding");

                        final orderDetails =
                            await FireOrders.getOrderDetails(product.id);

                        Navigator.pop(context);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (builder) {
                          return ConfirmBuy(
                            orderDetails,
                            product,
                            "Cancel Order?",
                            isOrderPage: true,
                          );
                        }));
                      },
                      child: OrderCart(
                        product,
                        "quantity",
                        hasQuantity: false,
                      ));
                }
                //loader
                else {
                  return SizedBox();
                }
              });
        });
  }
}
// aja yo client side ko sabbai sakaunai parxa broo !