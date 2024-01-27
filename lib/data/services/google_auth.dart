

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // Google Sign In
  Future signInWithGoogle() async {
    // begin interactive sign in process
    try {
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      // obtaiin auth details from request
      final GoogleSignInAuthentication gAuth = await gUser!.authentication;
      // create a new credential for user
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );
      // finally, lets sign in
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on Exception catch (e) {
      print(e.toString());
      // TODO
    }
  }
}
