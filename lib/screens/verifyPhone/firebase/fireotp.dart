import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:herb/palette/dialog.dart';
import 'package:herb/screens/Homepage/page/home.dart';
import 'package:herb/screens/verifyPhone/page/verify.dart';

class FireLogin {
  BuildContext context;
  FireLogin(this.context);
  var firebaseauth = FirebaseAuth.instance;

  late String phoneCode;
  late String _verificationId;

  Future<void> sendOtp(String countryCode, String phoneNum) async {
    phoneCode = '+$countryCode$phoneNum';
    //firebaseauth.
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneCode,
      timeout: const Duration(seconds: 90),
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) async {
        // have a doialog shit !
        Navigator.pop(context);
        showErrorDialog(context, "Unknown error Occured");
        print(e.message);
        print("object");
      },
      codeSent: (String verificationId, int? resendToken) async {
        _verificationId = verificationId;
        // next page ma jane
        Navigator.pop(context);
        Navigator.pop(context);

        // next otp receive page
        otpRecievePage(context, this);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<void> signUpUser(String smsCode, Function changeUsr) async {
    await firebaseauth
        .signInWithCredential(PhoneAuthProvider.credential(
            verificationId: _verificationId, smsCode: smsCode))
        .whenComplete(() {
      Navigator.pop(context);
      changeUsr();
    }).onError(
            (error, stackTrace) => showErrorDialog(context, "Unable to Login"));
  }
}
