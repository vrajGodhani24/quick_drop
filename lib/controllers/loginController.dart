import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quick_drop/utils/global.dart';
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

  static final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  late final SharedPreferences sharedPreferences;

  @override
  void onInit() async {
    super.onInit();
    sharedPreferences = await SharedPreferences.getInstance();

    bool? fetchBoolData = sharedPreferences.getBool('login');

    if (fetchBoolData != null) {
      isLogin = fetchBoolData;
    }
  }

  @override
  void onClose() {
    super.onClose();
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

      if (user != null) {
        QuerySnapshot<Map<String, dynamic>> fetchUserData =
            await firebaseFirestore.collection('users').get();
        List<QueryDocumentSnapshot<Map<String, dynamic>>> fetchUserList =
            fetchUserData.docs;

        int bug = 0;
        for (var element in fetchUserList) {
          if (element['email'] == user.email) {
            bug++;
          }
        }
        if (bug == 0) {
          Global.countUserForGoogleUser(email: user.email!);
        }
      }
      return user;
    } on FirebaseAuthException catch (error) {
      Global.snackMassage(
          error.code, 'Login failed', Colors.redAccent.withOpacity(0.25));
      buttonLoading();
    }
    return null;
  }
}
