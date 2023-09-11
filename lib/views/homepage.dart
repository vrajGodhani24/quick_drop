import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_drop/controllers/homepageController.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    HomePageController homepageController = Get.put(HomePageController());
    int index = 0;

    User? currentUser = homepageController.fetchCurrentUser();

    String? currentUserName = homepageController
        .fetchCurrentUser()!
        .email!
        .split('@')[0]
        .capitalizeFirst;

    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        centerTitle: false,
        title: Text(currentUserName!),
        actions: [
          IconButton(
            onPressed: () {
              Get.changeTheme(
                (Get.isDarkMode)
                    ? ThemeData.light(useMaterial3: true)
                    : ThemeData.dark(useMaterial3: true),
              );
            },
            icon: const Icon(Icons.circle),
          ),
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
      body: Container(
        padding: const EdgeInsets.all(8),
        child: Obx(
          () => ListView.builder(
            itemCount: homepageController.allUsers.length,
            itemBuilder: (context, i) {
              return (currentUser!.email ==
                      homepageController.allUsers[i].email)
                  ? Container()
                  : Card(
                      child: ListTile(
                        leading: Text("${++index}"),
                        title: Text(homepageController.allUsers[i].name),
                        subtitle: Text(homepageController.allUsers[i].email),
                        onTap: () {
                          Get.toNamed('chat',
                              arguments: homepageController.allUsers[i]);
                        },
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }
}
