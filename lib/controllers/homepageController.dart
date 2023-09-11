import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quick_drop/models/users.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageController extends GetxController {
  RxBool isLoading = false.obs;
  bool isLogin = false;
  RxList allUsers = [].obs;

  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static final GoogleSignIn googleSignIn = GoogleSignIn();
  late final SharedPreferences sharedPreferences;

  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  void onInit() async {
    super.onInit();
    sharedPreferences = await SharedPreferences.getInstance();

    isLogin = sharedPreferences.getBool('login')!;

    List<QueryDocumentSnapshot<Map<String, dynamic>>> data =
        await fetchAllUser();

    for (var e in data) {
      allUsers.add(UsersDetail.fromMap(e));
    }
  }

  void buttonLoading() {
    isLoading.value = !isLoading.value;
  }

  Future<void> logOut() async {
    await firebaseAuth.signOut();
    await googleSignIn.signOut();
    Get.offAllNamed('signUpSignIn');
    sharedPreferences.setBool('login', false);
  }

  User? fetchCurrentUser() {
    return firebaseAuth.currentUser;
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      fetchAllUser() async {
    QuerySnapshot<Map<String, dynamic>> fetchData =
        await firebaseFirestore.collection('users').get();

    List<QueryDocumentSnapshot<Map<String, dynamic>>> fetchedUsers =
        fetchData.docs;

    return fetchedUsers;
  }
}
