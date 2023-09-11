import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  RxBool isLoading = false.obs;

  static final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  TextEditingController messageController = TextEditingController();

  void loading() {
    isLoading.value = !isLoading.value;
  }

  void sendMessage(String? sender, String? receiver, String message) async {
    loading();

    QuerySnapshot<Map<String, dynamic>> fetchData =
        await firebaseFirestore.collection('chats').get();

    List<QueryDocumentSnapshot<Map<String, dynamic>>> fetchChatId =
        fetchData.docs;

    print(fetchChatId);

    int i = 0;

    // firebaseFirestore
    //     .collection('chats')
    //     .doc(chatRoomId)
    //     .collection('messages')
    //     .doc('message${++i}')
    //     .set({
    //   'sender': sender,
    //   'receiver': receiver,
    //   'message': message,
    // }).then((value) {
    //   messageController.clear();
    //   loading();
    // });

    // DocumentSnapshot<Map<String, dynamic>> chat =
    //     await firebaseFirestore.collection('chats').doc('chatRoomId').get();
    //
    // chat['sender']
  }
}
