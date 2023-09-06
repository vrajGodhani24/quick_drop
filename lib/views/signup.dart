import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_drop/controllers/signUpController.dart';
import 'package:quick_drop/utils/global.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    SignUpController signUpController = Get.put(SignUpController());

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text("Sign Up"),
      ),
      body: Container(
        alignment: Alignment.center,
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
                flex: 10,
                child: Form(
                  key: signUpController.signUpFormKey,
                  child: ListView(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.person),
                        title: TextFormField(
                          controller: signUpController.emailController,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Enter email id first";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            hintText: "Email id",
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Obx(
                          () => GestureDetector(
                            onTap: () {
                              signUpController.passwordVisible();
                            },
                            child:
                                (signUpController.showPassword.value == false)
                                    ? const Icon(Icons.remove_red_eye_outlined)
                                    : const Icon(Icons.remove_red_eye),
                          ),
                        ),
                        title: Obx(
                          () => TextFormField(
                            controller: signUpController.newPasswordController,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Enter password first";
                              } else if (signUpController
                                      .confirmPasswordController.text !=
                                  val) {
                                return "Both password are not match";
                              }
                              return null;
                            },
                            obscureText:
                                (signUpController.showPassword.value == true)
                                    ? false
                                    : true,
                            decoration: const InputDecoration(
                              hintText: "New Password",
                            ),
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Obx(
                          () => GestureDetector(
                            onTap: () {
                              signUpController.confirmPasswordVisible();
                            },
                            child:
                                (signUpController.showConfirmPassword.value ==
                                        false)
                                    ? const Icon(Icons.remove_red_eye_outlined)
                                    : const Icon(Icons.remove_red_eye),
                          ),
                        ),
                        title: Obx(
                          () => TextFormField(
                            controller:
                                signUpController.confirmPasswordController,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Enter confirm password first";
                              } else if (signUpController
                                      .newPasswordController.text !=
                                  val) {
                                return "Both password are not match";
                              }
                              return null;
                            },
                            obscureText:
                                (signUpController.showConfirmPassword.value ==
                                        true)
                                    ? false
                                    : true,
                            decoration: const InputDecoration(
                              hintText: "Confirm Password",
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Column(
                        children: [
                          Obx(
                            () => (signUpController.isLoading.value)
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
                                          if (signUpController
                                              .signUpFormKey.currentState!
                                              .validate()) {
                                            signUpController.buttonLoading();
                                            User? user = await signUpController
                                                .createAccountWithUserPassword(
                                              email: signUpController
                                                  .emailController.text,
                                              password: signUpController
                                                  .confirmPasswordController
                                                  .text,
                                            );

                                            if (user != null) {
                                              Global.snackMassage(
                                                  'Sign Up',
                                                  'Sign up successfully',
                                                  Colors.green
                                                      .withOpacity(0.25));

                                              Get.offNamed('signUpSignIn');
                                            }
                                          }
                                        },
                                        child: const Text(
                                          "Sign Up",
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )),
                                  ),
                          ),
                          const SizedBox(height: 30),
                          const Text("Already have an account?"),
                          GestureDetector(
                            onTap: () {
                              Get.offNamed('login');
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
