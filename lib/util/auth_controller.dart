import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:textspeech/auth/verify_email.dart';
import 'package:textspeech/interface/homepage.dart';
import 'package:textspeech/interface/introduction_screen.dart';
import 'package:textspeech/interface/splash_screen.dart';
import 'package:textspeech/util/exceptions/firebase_auth_exceptions.dart';
import 'package:textspeech/util/exceptions/firebase_exceptions.dart';
import 'package:textspeech/util/exceptions/format_exceptions.dart';
import 'package:textspeech/util/exceptions/platform_exceptions.dart';

class AuthController extends GetxController {
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  @override
  void onReady() {
    navigateToIntroduction();
    super.onReady();
  }

  // void navigateToIntroduction() async {
  //   final user = _auth.currentUser;
  //   if (user != null) {
  //     if (user.emailVerified) {
  //       Get.offAll(() => const HomePage());
  //       print('NAVIGATE KE HOMEPAGE');
  //     } else {
  //       Get.offAll(() => VerifyEmailScreen(
  //             email: _auth.currentUser?.email,
  //           ));
  //       print('NAVIGATE KE VerifyEmailScreen');
  //     }
  //   } else {
  //     deviceStorage.writeIfNull('IsFirstTime', true);

  //     deviceStorage.read('IsFirstTime') != true
  //         ? Get.offAll(() => const IntroductionScreen())
  //         : Get.offAll(const SplashScreen());
  //   }
  // }

  void navigateToIntroduction() async {
    final user = _auth.currentUser;
    if (user != null) {
      await user.reload(); // Perbarui status autentikasi
      if (user.emailVerified) {
        Get.offAll(() => const HomePage());
      } else {
        Get.offAll(() => VerifyEmailScreen(email: user.email));
      }
    } else {
      deviceStorage.writeIfNull('IsFirstTime', true);
      final isFirstTime = deviceStorage.read('IsFirstTime') ?? true;
      isFirstTime
          ? Get.offAll(() => const IntroductionScreen())
          : Get.offAll(const SplashScreen());
    }
  }

  // EmailAuth - SignIn
  Future<UserCredential> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code);
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code);
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code);
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // EmailAuth - REGISTER
  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code);
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code);
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code);
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // Email Verification
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code);
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code);
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code);
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // logOut user for any authentication
  Future<void> logOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAllNamed('/introduction');
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code);
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code);
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code);
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
