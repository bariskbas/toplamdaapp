import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xapp/core/services/auth_services.dart';
import 'package:xapp/core/widgets/error_dialog.dart';
import 'package:xapp/features/home/presentation/model_view/current_prices_model_view.dart';
import 'package:xapp/features/home/presentation/view/home_page.dart';

class LoginModelView extends GetxController {
  final AuthServices authServices = AuthServices();

  Rx<bool> isObscureText = true.obs;

  Rx<String> email = "".obs;
  Rx<String> password = "".obs;
  Rx<bool> isLoading = false.obs;
  Rx<bool> isLoadingForgotButton = false.obs;
  Rx<String> forgotPasswordEmail = "".obs;

  onChangedObscureText() => isObscureText.value = !isObscureText.value;
  onChangedEmail(val) => email.value = val;
  onChangedPassword(val) => password.value = val;

  signIn(context) {
    isLoading.value = true;

    authServices.signIn(email.value, password.value).then((value) {
      isLoading.value = false;
      if (value) {
        Get.put(CurrentPricesModelView());
        Get.offAll(const HomePage());
      } else {
        showDialog(
          context: context,
          builder: (context) => const ErrorDialog(),
        );
      }
    });
  }

  onChangeForgotPassword(val) => forgotPasswordEmail.value = val;

  forgotPassword() async {
    isLoadingForgotButton.value = true;
    await authServices.forgotPassword(forgotPasswordEmail.value).then((value) {
      isLoadingForgotButton.value = false;
    });
  }
}
