import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:quick_drop/controllers/loginController.dart';
import 'package:quick_drop/utils/global.dart';

class SplashController extends GetxController {
  LoginController loginController = Get.put(LoginController());

  @override
  void onInit() async {
    super.onInit();

    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    DocumentSnapshot<Map<String, dynamic>> fetchData =
        await firebaseFirestore.collection('recodes').doc('counter').get();

    Map<String, dynamic>? data = fetchData.data();

    if (data != null) {
      Global.id = data['id'];
      Global.length = data['length'];
    }
    Timer(const Duration(seconds: 3), () {
      (loginController.isLogin == true)
          ? Get.offNamed('/')
          : Get.offNamed('signUpSignIn');
    });
  }
}
