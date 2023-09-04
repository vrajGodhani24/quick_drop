import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:quick_drop/firebase_options.dart';
import 'package:quick_drop/views/homepage.dart';
import 'package:quick_drop/views/login.dart';
import 'package:quick_drop/views/signUp_signIn.dart';
import 'package:quick_drop/views/signup.dart';
import 'package:quick_drop/views/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      initialRoute: 'splash',
      getPages: [
        GetPage(name: '/', page: () => const HomePage()),
        GetPage(name: '/splash', page: () => const SplashScreen()),
        GetPage(name: '/signUpSignIn', page: () => const SignUpSignIn()),
        GetPage(name: '/login', page: () => const LogIn()),
        GetPage(name: '/signup', page: () => const SignUp()),
      ],
    ),
  );
}
