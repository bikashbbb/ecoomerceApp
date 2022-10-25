import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:herb/palette/colors.dart';
import 'package:herb/palette/decorators.dart';
import 'package:herb/screens/Category/controller/con.dart';
import 'package:herb/screens/Category/firebase/fire.dart';
import 'package:herb/screens/Category/models/product.dart';
import 'package:herb/screens/Homepage/commonWidgets/productcard.dart';
import 'package:herb/screens/Homepage/firebase/firebase.dart';
import 'package:herb/screens/Homepage/models/models.dart';
import 'package:sizer/sizer.dart';
import '../../Homepage/commonWidgets/category.dart';

final catref = ChangeNotifierProvider<CatMenuBarCon>((ref) => CatMenuBarCon());

class CategoryPage extends ConsumerWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      drawer: SizedBox(
        width: 30.w,
        child: Drawer(
          backgroundColor: secC,
          child: _catBuilder(ref),
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: secC),
        backgroundColor: mainC,
        title: Text(
          "CATEGORIES",
          style: secheader,
        ),
        actions: [
          favouriteS(),
          SizedBox(
            width: 3.w,
          ),
          shop(),
          SizedBox(
            width: 5.w,
          ),
          // left side ma category header hunxa a listview and right side ma products haru !!
        ],
      ),
      body: _ProductForYou(),
    );
  }

  Widget _catBuilder(WidgetRef ref) {
    final con = ref.watch(catref);
    return FirestoreQueryBuilder(
      query: FireCategories().Query,
      builder: (ctx, snaps, child) {
        if (snaps.hasData) {
          return ListView.builder(
              itemCount: snaps.docs.length,
              itemBuilder: (ctx, index) {
                String name = snaps.docs[index].get("name");

                return categoryCard(CategoryCard(
                  snaps.docs[index].id,
                  name,
                  Icons.abc,
                  index,
                  () {
                    con.onTileTapped(index);
                    con.setCatSelected = name;
                    Navigator.pop(ctx);
                  },
                  isTapped: index == con.clickedIndex ? true : false,
                ));
              });
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

class _ProductForYou extends ConsumerWidget {
  _ProductForYou({Key? key}) : super(key: key);
  final fireobj = ItemsPerCat();

  @override
  Widget build(BuildContext context, ref) {
    final con = ref.watch(catref);
    return Scaffold(
      // firebase use garne tw honi yesma ! simple
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SortButton(),
            /* ProductCard(Product(
                "1000",
                "id",
                "https://firebasestorage.googleapis.com/v0/b/herbs-sell-center.appspot.com/o/laptop.jpg?alt=media&token=430255de-e914-4f40-914e-afce371a0ef4",
                "Tea",
                "800",
                "brand",
                false,
                "0",
                "type",
                "typeOfPackaging",
                "wholeSalePrice",
                'Tea')), */
            // yo query ma watch rakhna tw parxa
            ProductForYou(fireobj.getProduct(con.catSelected)),
          ],
        ),
      ),
    );
  }
}

class ProductForYou extends ConsumerWidget {
  final Query query;

  const ProductForYou(this.query, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final con = ref.watch(productControlls);
    return FirestoreQueryBuilder(
        query: query,
        builder: (ctx, snaps, child) {
          /* snaps.docs[index]
          final product = Product.toObj(); */
          return GridView.builder(
              primary: false, // add this line
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: snaps.docs.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.7, crossAxisCount: 2),
              itemBuilder: (ctx, index) {
                if (snaps.hasData) {
                  final product = Product.toObj(
                      snaps.docs[0].data()! as Map, snaps.docs[0].id);
                  return ProductCard(product, () {
                    con.addToCart(product);
                  }, index: index);
                }
                //loader
                return const SizedBox();
              });
        });
  }
}
