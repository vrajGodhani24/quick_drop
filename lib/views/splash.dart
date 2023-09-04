import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:quick_drop/controllers/splashController.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SplashController splashController = Get.put(SplashController());

    splashController.onInit();

    return Scaffold(
      body: Center(
        child: Image.asset('assets/images/quickDrop.png', scale: 4),
      ),
    );
  }
}
