import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_drop/controllers/loginController.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    LoginController loginController = Get.find();

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        actions: [
          Obx(
            () => (loginController.isLoading.value)
                ? const CircularProgressIndicator()
                : IconButton(
                    onPressed: () async {
                      loginController.buttonLoading();
                      await loginController.logOut();
                    },
                    icon: const Icon(Icons.power_settings_new),
                  ),
          ),
        ],
      ),
      body: Center(
        child: Text("Home Page"),
      ),
    );
  }
}
