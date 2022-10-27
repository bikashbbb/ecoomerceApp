import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:herb/palette/colors.dart';
import 'package:herb/palette/decorators.dart';
import 'package:herb/palette/dialog.dart';
import 'package:herb/palette/icons.dart';
import 'package:herb/palette/sizes.dart';
import 'package:herb/screens/Category/controller/dropdownc.dart';
import 'package:herb/screens/Category/pages/entry.dart';
import 'package:herb/screens/Homepage/firebase/firebase.dart';
import 'package:herb/screens/Homepage/models/models.dart';
import 'package:herb/screens/Homepage/page/bottomnav.dart';
import 'package:sizer/sizer.dart';
import 'package:flutterfire_ui/firestore.dart';

// what next ? category page garne ava ....
class HomeCategory extends ConsumerWidget {
  HomeCategory({Key? key}) : super(key: key);

  final FireCategories obj = FireCategories();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // home ma vako category as in gridview gets data from firebase ani grid ma 3X3
    final navCon = ref.watch(navController);
    final catCon = ref.watch(catref);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: SizedBox(
          // color: secC,
          width: MediaQuery.of(context).size.width,
          // yeha stream builder use garera firebase stream hanna parcha !
          child: FirestoreQueryBuilder(
              query: obj.Query,
              builder: (ctx, snaps, child) {
                return GridView.builder(
                    key: const PageStorageKey(1),
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: 9,
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 1.5, crossAxisCount: 3),
                    itemBuilder: (ctx, index) {
                      // - category sakkaune ani ! admin panel sakkaune )
                      if (snaps.hasData) {
                        String catname = snaps.docs[index].get('name');
                        return InkWell(
                            onTap: () async {
                              print("collection clicked");
                              // change the page index !
                              showLoaderDialog(context, "Loading");
                              // firest ma

                              final indx = await obj.getCatIndex(catname);

                              catCon.changeIndex(indx!);
                              catCon.setCatSelected = catname;
                              Navigator.pop(context);
                              navCon.chnageNavIndex(1);
                            },
                            child: CatCard(catname, ""));
                      }
                      return const SizedBox();
                    });
              })),
    );
  }
}

class CatCard extends StatelessWidget {
  final String name;
  final String downloadUrl;
  CatCard(this.name, this.downloadUrl, {Key? key}) : super(key: key);

  final FireImages fireImages = FireImages();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: GridTile(
        child: CachedNetworkImage(
            placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(
                  color: secC,
                )),
            errorWidget: (context, url, error) => Icon(
                  Icons.error,
                  color: mainC,
                ),
            imageUrl:
                "https://firebasestorage.googleapis.com/v0/b/herbs-sell-center.appspot.com/o/laptop.jpg?alt=media&token=430255de-e914-4f40-914e-afce371a0ef4" //  "https://docs.flutter.dev/assets/images/dash/dash-fainting.gif",
            ), //'https://firebasestorage.googleapis.com/v0/b/herbs-sell-center.appspot.com/o/category%20photos%2Fpexels-mareefe-1638280.jpg?alt=media&token=83a2360c-1e95-47d8-95f4-4243712ed941'),
        footer: Container(
          decoration: fotterBoxDec,
          child: Padding(
            padding: const EdgeInsets.only(left: 2),
            child: Text(
              name,
              style: cardFotterStyle,
            ),
          ),
        ),
      ),
    );
  }
}

Widget favouriteS() {
  return iconMaker(Icons.favorite_border, iconFont, secC);
}

Widget shop() {
  return iconMaker(Icons.shopping_basket, iconFont, secC);
}

Widget categoryCard(CategoryCard data) {
  return ListTile(
    onTap: () {
      data.ontap();
    },
    minLeadingWidth: 0,
    contentPadding: const EdgeInsets.only(left: 0.0, right: 0.0),
    tileColor: data.isTapped ? Color.fromARGB(255, 129, 127, 126) : secC,
    leading: Text(
      data.catname,
      style: catHeaderStyle,
    ),
    trailing: Icon(
      Icons.arrow_right,
      color: thrdC,
    ),
  );
}

// today finish the category shit !
// boru muji khatey code lekham tara chado chado
// ava yooo products for you ko kaam paxi hamro user ko kaam suru hunxa

final sortButtonref = ChangeNotifierProvider<SortProductsControlls>(
    ((ref) => SortProductsControlls()));

class SortButton extends ConsumerWidget {
  const SortButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final con = ref.watch(sortButtonref);
    return Padding(
      padding: EdgeInsets.only(left: 3.w),
      child: SizedBox(
        // color: Colors.red,
        width: 30.w,
        height: 4.5.h,
        child: DropdownButton<String>(
            items: con.dropItems.map((String val) {
              return DropdownMenuItem<String>(
                value: val,
                child: Text(val),
              );
            }).toList(),
            hint: Text(con.hintName),
            onChanged: (name) {
              con.onDropItemTapped(name!);
            }),
      ),
    );
  }
}

Widget textFieldMaker(String hint, TextEditingController con,
    {bool noIcon = true}) {
  return TextField(
    controller: con,
    keyboardType: noIcon ? TextInputType.text : TextInputType.number,
    decoration: InputDecoration(
      prefixIcon: noIcon
          ? Padding(
              padding: EdgeInsets.only(bottom: 1.h),
              child: iconMaker(Icons.search, iconFont, secC),
            )
          : const SizedBox(),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: secC, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: secC, width: 1.0),
      ),
      hintText: hint,
    ),
  );
}

Widget textFieldMaker2(String hint, TextEditingController con, IconData email) {
  return TextField(
    controller: con,
    keyboardType: TextInputType.text,
    decoration: InputDecoration(
      prefixIcon: Padding(
        padding: EdgeInsets.only(bottom: 1.h),
        child: iconMaker(email, iconFont, secC),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: secC, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: secC, width: 1.0),
      ),
      hintText: hint,
    ),
  );
}

class MainButton extends StatelessWidget {
  const MainButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 30,
      backgroundColor: secC,
      child: SizedBox(
          child: Icon(
        Icons.done_all,
        color: thrdC,
      )),
    );
  }
}
