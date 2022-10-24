import 'dart:math';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:herb/palette/colors.dart';
import 'package:herb/palette/decorators.dart';
import 'package:herb/palette/dialog.dart';
import 'package:herb/palette/icons.dart';
import 'package:herb/screens/Homepage/commonWidgets/category.dart';
import 'package:herb/screens/Homepage/page/home.dart';
import 'package:herb/screens/verifyPhone/firebase/fireotp.dart';
import 'package:sizer/sizer.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class SignUp {
  TextEditingController phoneNum = TextEditingController();
  late FireLogin fireLogin;

  Future<dynamic> signup(BuildContext context) {
    fireLogin = FireLogin(context);
    // return otpRecievePage(context);
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
                              onTap: () {
                                // check if number is 10 digits
                                if (phoneNum.text.length == 10) {
                                  _onSendOtp();
                                  showLoaderDialog(context, "Loading...");
                                  // loader
                                } else {
                                  // error dialog
                                  showErrorDialog(
                                      context, "Invalid Phone Number");
                                }
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

  void _onSendOtp() async {
    await fireLogin.sendOtp(CountryPick.countryCode, phoneNum.text);
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

Future otpRecievePage(BuildContext context, FireLogin fireLogin) {
  return showModalBottomSheet(
    context: context,
    builder: (context) => Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SizedBox(
        height: 20.h,
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              "Enter The Otp Code",
              style: productTitleS,
            ),
            //9884065421
            const SizedBox(
              height: 20,
            ),
            _OtpSec(fireLogin)
          ],
        ),
      ),
    ),
  );
}

class _OtpSec extends ConsumerWidget {
  final FireLogin fireLogin;

  const _OtpSec(this.fireLogin, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final con = ref.watch(homeRef);
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: OTPTextField(
        length: 6,
        //width: MediaQuery.of(context).size.width,
        fieldWidth: 30,
        style: productTitleS,
        onChanged: (t) {},
        textFieldAlignment: MainAxisAlignment.spaceAround,
        fieldStyle: FieldStyle.box,
        onCompleted: (pin) {
          showLoaderDialog(context, "Loggin In ");
          // try signing in ! with a loading dialog
          fireLogin.signUpUser(pin,con.changeUser);
          print("Completed: " + pin);
        },
      ),
    );
  }
}
