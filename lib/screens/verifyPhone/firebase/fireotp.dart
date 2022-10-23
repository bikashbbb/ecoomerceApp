import 'package:firebase_auth/firebase_auth.dart';

class FireLogin {
  var firebaseauth = FirebaseAuth.instance;

  Future<void> sendOtp(String countryCode, String phoneNum) async {
    
    //firebaseauth.
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+977 9884065421',
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) async {
        // have a doialog shit !
        print(e.message);
        print("object");
      },
      codeSent: (String verificationId, int? resendToken) async {
        // next page ma jane
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}
