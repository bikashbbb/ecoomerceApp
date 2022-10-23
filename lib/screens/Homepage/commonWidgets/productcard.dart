import 'package:flutter/material.dart';
import 'package:herb/palette/colors.dart';
import 'package:herb/palette/decorators.dart';
import 'package:sizer/sizer.dart';
import '../../Category/models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard(this.product, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        width: 200,
        //height: 30.h,
        decoration: BoxDecoration(
            color: mainC,
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: thrdC, width: 0.5)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 1.h,
            ),
            Image.network(
              product.imageUrl,
              width: 281.0,
              height: 191.0,
              fit: BoxFit.contain,
            ),
            Padding(
              padding: const EdgeInsets.all(2),
              child: Text(product.name,
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
                    product.price,
                    style: priceS,
                  ),
                  //const Expanded(child: SizedBox()),
                  Text(product.cutPrice, style: prevPriceS),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Icon(Icons.favorite_border),
              ],
            )
          ],
        ),
      ),
    );
  }
}
// code garnu vanda agadi plan garera gareko ramro 
