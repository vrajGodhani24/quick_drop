import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Global {
  static int id = 0;
  static int length = 0;

  static void snackMassage(String title, String message, Color color) {
    Get.snackbar(title, message, backgroundColor: color);
  }

  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  static void countUserForEmailPasswordUser(
      {required String email, required String password}) async {
    DocumentSnapshot<Map<String, dynamic>> snapShot =
        await firebaseFirestore.collection('records').doc('counter').get();

    Map<String, dynamic>? data = snapShot.data();

    id = data!['id'];
    length = data['length'];

    id++;
    String name = email.split('@')[0];

    firebaseFirestore.collection('users').doc('$id').set(
      {'id': Global.id, 'email': email, 'password': password, 'name': name},
    );
    length++;
    firebaseFirestore.collection('records').doc('counter').set({
      'id': id,
      'length': length,
    });
  }

  static void countUserForGoogleUser({required String email}) async {
    DocumentSnapshot<Map<String, dynamic>> snapShot =
        await firebaseFirestore.collection('records').doc('counter').get();

    Map<String, dynamic>? data = snapShot.data();

    id = data!['id'];
    length = data['length'];

    id++;
    String name = email.split('@')[0];
    firebaseFirestore.collection('users').doc('$id').set(
      {'id': Global.id, 'email': email, 'name': name},
    );
    length++;
    firebaseFirestore.collection('records').doc('counter').set({
      'id': id,
      'length': length,
    });
  }
}
