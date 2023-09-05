import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_drop/controllers/homepageController.dart';
import 'package:quick_drop/controllers/loginController.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    HomePageController homepageController = Get.put(HomePageController());

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        actions: [
          Obx(
            () => (homepageController.isLoading.value)
                ? const CircularProgressIndicator()
                : IconButton(
                    onPressed: () async {
                      homepageController.buttonLoading();
                      await homepageController.logOut();
                    },
                    icon: const Icon(Icons.power_settings_new),
                  ),
          ),
        ],
      ),
      body: const Center(
        child: Text("Home Page"),
      ),
    );
  }
}
