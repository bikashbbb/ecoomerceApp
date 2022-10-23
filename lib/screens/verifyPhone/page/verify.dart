import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:herb/palette/colors.dart';
import 'package:herb/palette/decorators.dart';
import 'package:herb/screens/Homepage/commonWidgets/category.dart';
import 'package:herb/screens/verifyPhone/firebase/fireotp.dart';
import 'package:sizer/sizer.dart';

class SignUp {
  TextEditingController phoneNum = TextEditingController();

  Future<dynamic> signup(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              color: mainC,
              height: 20.h,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Sign Up To Continue",
                        style: productTitleS,
                      ),
                      const Icon(
                        Icons.login,
                        color: Colors.red,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CountryPick(),
                      SizedBox(
                        width: 3.w,
                      ),
                      SizedBox(
                          height: 8.h,
                          width: 50.w,
                          child: textFieldMaker("", phoneNum, noIcon: false)),
                      Padding(
                        padding: EdgeInsets.only(left: 8.w),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                              onTap: () async{
                              await  FireLogin().sendOtp(
                                    CountryPick.countryCode, phoneNum.text);
                              },
                              child: MainButton()),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}

class CountryPick extends StatefulWidget {
  static String countryCode = "977";
  const CountryPick({Key? key}) : super(key: key);

  @override
  State<CountryPick> createState() => _CountryPickState();
}

class _CountryPickState extends State<CountryPick> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //
        showCountryPicker(
          context: context,
          showPhoneCode:
              true, // optional. Shows phone code before the country name.
          onSelect: (Country country) {
            setState(() {
              CountryPick.countryCode = country.phoneCode;
            });
          },
        );
      },
      child: Text(
        "+" + CountryPick.countryCode,
        style: productTitleS,
      ),
    );
  }
}
