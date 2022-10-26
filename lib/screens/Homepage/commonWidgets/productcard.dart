import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_shake_animated/flutter_shake_animated.dart';
import 'package:herb/palette/colors.dart';
import 'package:herb/palette/decorators.dart';
import 'package:herb/screens/Homepage/controller/appbar.dart';
import 'package:sizer/sizer.dart';
import '../../Category/models/product.dart';

final productControlls =
    ChangeNotifierProvider<ProductControlls>(((ref) => ProductControlls()));

class ProductCard extends StatefulWidget {
  final Product product;
  final Function ontap;
  final bool isCartPage;
  int? index;

  ProductCard(
    this.product,
    this.ontap, {
    this.index,
    this.isCartPage = false,
    Key? key,
  }) : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        // width: 200.h,
        //height: 30.h,
        decoration: BoxDecoration(
            color: mainC,
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: thrdC, width: 0.5)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: CachedNetworkImage(
                imageUrl: widget.product.imageUrl,
                fit: BoxFit.cover,
                
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2),
              child: Text(widget.product.name,
                  style: productTitleS,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis),
            ),
            Padding(
              padding: EdgeInsets.only(left: 1.0.w),
              child: Row(
                children: [
                  const Text("Nrs. "),
                  Text(
                    widget.product.price,
                    style: priceS,
                  ),
                  //const Expanded(child: SizedBox()),
                  Text(widget.product.cutPrice, style: prevPriceS),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                    onTap: () async {
                      widget.ontap();
                      if (!widget.isCartPage) {
                        setState(() {
                          _clickedIndex = widget.index;
                        });
                        Future.delayed(const Duration(milliseconds: 500), () {
                          setState(() {
                            _clickedIndex = null;
                          });
                        });
                      }
                    },
                    child: widget.isCartPage
                        ? const Icon(
                            Icons.delete,
                            color: Colors.red,
                          )
                        : ShakeWidget(
                            autoPlay:
                                _clickedIndex == widget.index ? true : false,
                            shakeConstant: ShakeHorizontalConstant1(),
                            duration: const Duration(milliseconds: 3),
                            child: const Icon(Icons.add_shopping_cart))),
              ],
            )
          ],
        ),
      ),
    );
  }
}
// code garnu vanda agadi plan garera gareko ramro

num? _clickedIndex;
