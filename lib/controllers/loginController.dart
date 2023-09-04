import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quick_drop/utils/showMessage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  RxBool showPassword = false.obs;
  RxBool isLoading = false.obs;
  bool isLogin = false;
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static final GoogleSignIn googleSignIn = GoogleSignIn();

  late final SharedPreferences sharedPreferences;

  @override
  void onInit() async {
    super.onInit();
    sharedPreferences = await SharedPreferences.getInstance();

    isLogin = sharedPreferences.getBool('login')!;
  }

  @override
  void onClose() {
    super.onClose();
    loginFormKey.currentState!.reset();

    emailController.clear();
    passwordController.clear();
  }

  void passwordVisible() {
    showPassword.value = !showPassword.value;
  }

  void buttonLoading() {
    isLoading.value = !isLoading.value;
  }

  Future<User?> loginWithUserPassword(String email, String password) async {
    try {
      UserCredential createUser = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      User? user = createUser.user;

      return user;
    } on FirebaseAuthException catch (error) {
      Global.snackMassage(
          error.code, 'Login failed', Colors.redAccent.withOpacity(0.25));
      buttonLoading();
    }
    return null;
  }

  Future<User?> loginWithGoogle() async {
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    try {
      UserCredential userCredential =
          await firebaseAuth.signInWithCredential(credential);

      User? user = userCredential.user;

      return user;
    } on FirebaseAuthException catch (error) {
      Global.snackMassage(
          error.code, 'Login failed', Colors.redAccent.withOpacity(0.25));
      buttonLoading();
    }
    return null;
  }

  Future<void> logOut() async {
    await firebaseAuth.signOut();
    await googleSignIn.signOut();
    Get.offAllNamed('signUpSignIn');
    sharedPreferences.setBool('login', false);
  }
}
