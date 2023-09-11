import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_drop/controllers/chatController.dart';
import 'package:quick_drop/models/users.dart';
import 'package:quick_drop/utils/global.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    ChatController chatController = Get.put(ChatController());

    UsersDetail usersDetail =
        ModalRoute.of(context)!.settings.arguments as UsersDetail;

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        centerTitle: false,
        title: Text("${usersDetail.name.capitalizeFirst}"),
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
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: size.height / 1.28,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(15),
              child: ListView(),
            ),
            Container(
              height: size.height / 12,
              padding: const EdgeInsets.all(9),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 5,
                    child: TextField(
                      controller: chatController.messageController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          gapPadding: 2,
                        ),
                        hintText: "Enter message here...",
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        if (chatController.messageController.text != '') {
                          chatController.sendMessage(
                              Global.firebaseAuth.currentUser!.email,
                              usersDetail.email,
                              chatController.messageController.text);
                        }
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        alignment: const Alignment(0.1, 0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue.withOpacity(0.8),
                        ),
                        child: Obx(
                          () => (chatController.isLoading.value)
                              ? const CircularProgressIndicator()
                              : const Icon(Icons.send),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
