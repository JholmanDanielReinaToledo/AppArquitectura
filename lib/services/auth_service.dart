import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:proyecto_prquitectura/pages/home.dart';
import 'package:proyecto_prquitectura/pages/login_page.dart';

class AuthService {
  handleAuthState() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return Home();
        } else {
          return LoginPage();
        }
      },
    );
  }

  singInWithGoogle() async {
    if (FirebaseAuth.instance.currentUser == null) {
      final GoogleSignInAccount? googleUser =
          await GoogleSignIn(scopes: <String>['email']).signIn();

      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } else {
      print(FirebaseAuth.instance.currentUser);
      return FirebaseAuth.instance.currentUser;
    }
  }

  signOut() {
    FirebaseAuth.instance.signOut();
  }
}
