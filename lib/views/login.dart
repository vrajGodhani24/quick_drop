import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_drop/controllers/loginController.dart';
import 'package:quick_drop/utils/global.dart';

class LogIn extends StatelessWidget {
  const LogIn({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    LoginController loginController = Get.put(LoginController());

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text("Login"),
      ),
      body: Center(
        child: Container(
          height: size.height / 1.8,
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
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "𐅣 Quick Drop",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Image.asset('assets/images/quickDrop.png'),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Form(
                      key: loginController.loginFormKey,
                      child: Column(
                        children: [
                          ListTile(
                            leading: const Icon(Icons.person),
                            title: TextFormField(
                              controller: loginController.emailController,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Enter email first";
                                }
                                return null;
                              },
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                hintText: "Enter your email",
                              ),
                            ),
                          ),
                          ListTile(
                            leading: Obx(
                              () => GestureDetector(
                                onTap: () {
                                  loginController.passwordVisible();
                                },
                                child: (loginController.showPassword.value)
                                    ? const Icon(Icons.remove_red_eye)
                                    : const Icon(Icons.remove_red_eye_outlined),
                              ),
                            ),
                            title: Obx(
                              () => TextFormField(
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "Enter password first";
                                  }
                                  return null;
                                },
                                controller: loginController.passwordController,
                                obscureText:
                                    (loginController.showPassword.value)
                                        ? false
                                        : true,
                                decoration: const InputDecoration(
                                  hintText: "Enter your password",
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Obx(
                          () => (loginController.isLoading.value)
                              ? const CircularProgressIndicator()
                              : SizedBox(
                                  width: size.width / 1.8,
                                  height: size.height / 18,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Colors.blue.withOpacity(0.5),
                                    ),
                                    onPressed: () async {
                                      if (loginController
                                          .loginFormKey.currentState!
                                          .validate()) {
                                        loginController.buttonLoading();
                                        User? user = await loginController
                                            .loginWithUserPassword(
                                                loginController
                                                    .emailController.text,
                                                loginController
                                                    .passwordController.text);

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
                                      }
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
                        ),
                        const SizedBox(height: 30),
                        const Text("You don't have any account?"),
                        GestureDetector(
                          onTap: () {
                            Get.offNamed('signup');
                          },
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Colors.blue,
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
