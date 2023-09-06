import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:quick_drop/utils/global.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpController extends GetxController {
  RxBool showPassword = false.obs;
  RxBool showConfirmPassword = false.obs;
  RxBool isLoading = false.obs;

  bool isLogin = false;

  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  // TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
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
    newPasswordController.clear();
    confirmPasswordController.clear();
  }

  void passwordVisible() {
    showPassword.value = !showPassword.value;
  }

  void confirmPasswordVisible() {
    showConfirmPassword.value = !showConfirmPassword.value;
  }

  void buttonLoading() {
    isLoading.value = !isLoading.value;
  }

  Future<User?> createAccountWithUserPassword(
      {required String email, required String password}) async {
    try {
      UserCredential createUser = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      User? user = createUser.user;

      Global.countUserForEmailPasswordUser(email: email, password: password);

      return user;
    } on FirebaseAuthException catch (error) {
      Global.snackMassage(
          error.code, 'Sign Up failed', Colors.redAccent.withOpacity(0.25));
      buttonLoading();
    }
    return null;
    // ListTile(
    //   leading: const Icon(Icons.perm_contact_cal),
    //   title: TextFormField(
    //     controller: signUpController.usernameController,
    //     validator: (val) {
    //       if (val!.isEmpty) {
    //         return "Enter username first";
    //       }
    //       return null;
    //     },
    //     decoration: const InputDecoration(
    //       hintText: "Username",
    //     ),
    //   ),
    // ),
  }
}
