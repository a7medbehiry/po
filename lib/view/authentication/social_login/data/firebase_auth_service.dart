import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pet_app/view/authentication/social_login/manager/cubit/social_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';
// import 'dart:math';

// import 'package:crypto/crypto.dart';
// import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class FirebaseAuthServicee {
  Future<User> signInWithGoogle(BuildContext context) async {
    await GoogleSignIn().signOut();

    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    context.read<SocialCubit>().social(
          name: googleUser?.displayName,
          email: googleUser?.email,
        );
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('googleSignIn', true);
    return (await FirebaseAuth.instance.signInWithCredential(credential)).user!;
  }

  Future<User> signInWithFacebook() async {
    final LoginResult loginResult = await FacebookAuth.instance.login();

    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);

    return (await FirebaseAuth.instance
            .signInWithCredential(facebookAuthCredential))
        .user!;
  }

  Future deleteUser() async {
    await FirebaseAuth.instance.currentUser!.delete();
  }

  // /// Generates a cryptographically secure random nonce, to be included in a
  // /// credential request.
  // String generateNonce([int length = 32]) {
  //   final charset =
  //       '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
  //   final random = Random.secure();
  //   return List.generate(length, (_) => charset[random.nextInt(charset.length)])
  //       .join();
  // }

  // /// Returns the sha256 hash of [input] in hex notation.
  // String sha256ofString(String input) {
  //   final bytes = utf8.encode(input);
  //   final digest = sha256.convert(bytes);
  //   return digest.toString();
  // }

  // Future<User> signInWithApple() async {
  //   // To prevent replay attacks with the credential returned from Apple, we
  //   // include a nonce in the credential request. When signing in with
  //   // Firebase, the nonce in the id token returned by Apple, is expected to
  //   // match the sha256 hash of `rawNonce`.
  //   final rawNonce = generateNonce();
  //   final nonce = sha256ofString(rawNonce);

  //   // Request credential for the currently signed in Apple account.
  //   final appleCredential = await SignInWithApple.getAppleIDCredential(
  //     scopes: [
  //       AppleIDAuthorizationScopes.email,
  //       AppleIDAuthorizationScopes.fullName,
  //     ],
  //     nonce: nonce,
  //   );

  //   // Create an `OAuthCredential` from the credential returned by Apple.
  //   final oauthCredential = OAuthProvider("apple.com").credential(
  //     idToken: appleCredential.identityToken,
  //     rawNonce: rawNonce,
  //   );

  //   // Sign in the user with Firebase. If the nonce we generated earlier does
  //   // not match the nonce in `appleCredential.identityToken`, sign in will fail.
  //   return (await FirebaseAuth.instance.signInWithCredential(oauthCredential)).user!;
  // }
}
