import 'package:get/get.dart';

class SignUpController extends GetxController {
  RxBool showPassword = false.obs;
  RxBool showConfirmPassword = false.obs;

  void passwordVisible() {
    showPassword.value = !showPassword.value;
  }

  void confirmPasswordVisible() {
    showConfirmPassword.value = !showConfirmPassword.value;
  }
}
