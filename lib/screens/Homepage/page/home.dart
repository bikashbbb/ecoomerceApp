// this will be our starting point of the app
// app name: Herbs sells center
// todays: work home page finish 2) signup complete
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:herb/palette/colors.dart';
import 'package:herb/palette/decorators.dart';
import 'package:herb/palette/icons.dart';
import 'package:herb/palette/sizes.dart';
import 'package:herb/screens/Category/firebase/fire.dart';
import 'package:herb/screens/Category/pages/entry.dart';
import 'package:herb/screens/Homepage/commonWidgets/category.dart';
import 'package:herb/screens/Homepage/controller/appbar.dart';
import 'package:herb/screens/Homepage/page/bottomnav.dart';
import 'package:herb/screens/mycart/pages/cart.dart';
import 'package:herb/screens/myorders/page/orders.dart';
import 'package:sizer/sizer.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

final homeRef =
    ChangeNotifierProvider<HomeControlls>(((ref) => HomeControlls()));

// lets build the fucking app first !
class HomePage extends ConsumerWidget {
  HomePage({Key? key}) : super(key: key);

  final List _pages = [ProductPage(), CategoryPage(), MyOrders()];

  @override
  Widget build(BuildContext context, ref) {
    final con = ref.watch(navController);
    return Scaffold(
        bottomNavigationBar: const SizedBox(height: 60, child: BottomNav()),
        backgroundColor: mainC,
        body: Builder(builder: (ctx) {
          return _pages[con.navIndex];
        }));
  }
}

class ProductPage extends ConsumerWidget {
  ProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final con = ref.watch(homeRef);
    return Scaffold(
        appBar: AppBar(
          actions: [
            // favouriteS(),
            SizedBox(
              width: 3.w,
            ),
            InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (builder) {
                    return CartPage();
                  }));
                },
                child: shop()),
            SizedBox(
              width: 5.w,
            )
          ],
          systemOverlayStyle: SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: mainC,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
          backgroundColor: mainC,
          leading: iconMaker(myAccIcon, 30.sp, secC),
          title: Padding(
              padding: EdgeInsets.only(left: 10.w, bottom: 10, top: 10),
              child: SizedBox(
                  height: 8.h,
                  child: textFieldMaker(
                      "Search by Keyword", TextEditingController()))),
        ),
        body: _categoryStore(
            context) /*  ProductForYou(ItemsPerCat().getAllProduct(), _homeKey) */);
  }

  Widget _categoryStore(BuildContext ctx) {
    final fire = ItemsPerCat();
    // this will be a grid view 3 ta wala .. data from firebase
    return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          key: const PageStorageKey(3),
          child: Column(
            children: [
              // mathi chai euta logo janxa pasal ko !
              Row(
                children: [
                  Expanded(child: banner()),
                ],
              ),
              // we will have a fucking grid view here cat ko lagi 3 taaaa
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 1.w),
                    child: Text(
                      "Category",
                      style: secheader,
                    ),
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Icon(
                    Icons.double_arrow_outlined,
                    size: iconFont,
                  )
                ],
              ),
              HomeCategory(),
              Container(
                  width: 44.w,
                  alignment: Alignment.center,
                  decoration: pForYou,
                  child: Text(
                    "Products For You",
                    style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp),
                  )),
              ProductForYou(fire.getAllProduct(), _homeKey)
            ],
          ),
        ));
  }
}

PageStorageBucket pageStorageBucket = PageStorageBucket();
final _homeKey = PageStorageKey("homepage");
