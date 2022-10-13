// this will be our starting point of the app
// app name: Herbs sells center

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:herb/palette/colors.dart';
import 'package:herb/palette/decorators.dart';
import 'package:herb/palette/icons.dart';
import 'package:herb/palette/sizes.dart';
import 'package:herb/screens/Homepage/page/bottomnav.dart';
import 'package:sizer/sizer.dart';

// lets build the fucking app first !
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(height: 60, child: const BottomNav()),
      backgroundColor: mainC,
      body: DefaultTabController(
          length: 1,
          child: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    pinned: true,
                    snap: true,
                    bottom: TabBar(
                      indicatorColor: mainC,
                      tabs: [
                        Tab(
                          // textfield
                          child: Padding(
                            padding: EdgeInsets.only(left: 12.w, right: 12.w),
                            child: TextField(
                              decoration: InputDecoration(
                                prefixIcon: Padding(
                                  padding: EdgeInsets.only(bottom: 1.h),
                                  child:
                                      iconMaker(Icons.search, iconFont, secC),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: secC, width: 1),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: secC, width: 1.0),
                                ),
                                hintText: 'Search by Keyword',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    floating: true,
                    systemOverlayStyle: SystemUiOverlayStyle(
                      // Status bar color
                      statusBarColor: mainC,
                      statusBarIconBrightness: Brightness.dark,
                      statusBarBrightness: Brightness.light,
                    ),
                    backgroundColor: mainC,
                    leadingWidth: 25.sp,
                    leading:
                        iconMaker(myAccIcon, 30.sp, secC),
                    title: Text(
                      "User",
                      style: secheader,
                    ),
                    actions: [
                      iconMaker(Icons.favorite_border, iconFont, secC),
                      SizedBox(
                        width: 3.w,
                      ),
                      iconMaker(Icons.shopping_basket, iconFont, secC),
                      SizedBox(
                        width: 5.w,
                      )
                    ],
                  ),
                ];
              },
              body: TabBarView(
                children: [_categoryStore()],
              ))),
    );
  }

  Widget _categoryStore() {
    // this will be a grid view 3 ta wala .. data from firebase
    return Column(
      children: [
        // mathi chai euta logo janxa pasal ko !
        Row(
          children: [
            Expanded(child: banner()),
          ],
        ),
        // we will have a fucking grid view here cat ko lagi 3 taaaa
      ],
    );
  }
}
