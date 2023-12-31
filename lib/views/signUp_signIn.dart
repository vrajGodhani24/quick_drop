import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_drop/controllers/loginController.dart';
import 'package:quick_drop/utils/global.dart';

class SignUpSignIn extends StatelessWidget {
  const SignUpSignIn({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    LoginController loginController = Get.put(LoginController());

    return Scaffold(
      body: Center(
        child: Container(
          height: size.height / 1.6,
          width: size.width / 1.3,
          decoration: BoxDecoration(
            color: Colors.lightBlue.withOpacity(0.1),
            border: Border.all(color: Colors.blue),
            borderRadius: BorderRadius.circular(25),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.blue.withOpacity(0.5),
                blurStyle: BlurStyle.outer,
                blurRadius: 10,
              ),
            ],
          ),
          alignment: Alignment.center,
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              const Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Text(
                      "𐅣 Quick Drop",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 20,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      'assets/images/quickDrop.png',
                      scale: 5,
                    ),
                    const Column(
                      children: [
                        Text(
                          "Hello!",
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "Welcome to Quick Drop. This is the best place to quick chat.",
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(
                          width: size.width / 1.8,
                          height: size.height / 18,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue.withOpacity(0.5),
                            ),
                            onPressed: () {
                              Get.toNamed('login');
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: size.width / 1.8,
                          height: size.height / 18,
                          child: ElevatedButton(
                            onPressed: () {
                              Get.toNamed('signup');
                            },
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.blue.withOpacity(0.75),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Obx(
                          () => (loginController.isLoading.value)
                              ? const CircularProgressIndicator()
                              : SizedBox(
                                  width: size.width / 1.8,
                                  height: size.height / 18,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Colors.red.withOpacity(0.5),
                                    ),
                                    onPressed: () async {
                                      loginController.buttonLoading();
                                      User? user = await loginController
                                          .loginWithGoogle();

                                      if (user != null) {
                                        Global.snackMassage(
                                            'Login',
                                            'Login successfully...',
                                            Colors.green.withOpacity(0.25));
                                        Get.offAllNamed('homepage');
                                        loginController.buttonLoading();
                                        loginController.sharedPreferences
                                            .setBool('login', true);
                                      }
                                    },
                                    child: const Text(
                                      "Google",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
