import 'dart:async';

import 'package:get/get.dart';
import 'package:quick_drop/controllers/loginController.dart';

class SplashController extends GetxController {
  LoginController loginController = Get.put(LoginController());

  @override
  void onInit() {
    super.onInit();
    Timer(const Duration(seconds: 3), () {
      (loginController.isLogin == true)
          ? Get.offNamed('/')
          : Get.offNamed('signUpSignIn');
    });
  }
}
