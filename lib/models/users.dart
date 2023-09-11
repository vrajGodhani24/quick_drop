import 'package:cloud_firestore/cloud_firestore.dart';

class UsersDetail {
  int id;
  String name;
  String email;

  UsersDetail({required this.id, required this.name, required this.email});

  factory UsersDetail.fromMap(
      QueryDocumentSnapshot<Map<String, dynamic>> data) {
    return UsersDetail(
        id: data['id'], name: data['name'], email: data['email']);
  }
}
