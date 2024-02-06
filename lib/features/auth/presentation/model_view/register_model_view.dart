import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xapp/core/services/auth_services.dart';
import 'package:xapp/core/styles.dart';

class RegisterModelView extends GetxController {
  final AuthServices authServices = AuthServices();

  Rx<bool> isLoading = false.obs;
  Rx<bool> isSelected = false.obs;
  Rx<bool> isObscureText = true.obs;
  Rx<bool> isObscureReset = true.obs;

  Rx<String> nameUsername = "".obs;
  Rx<String> birthday = "".obs;
  Rx<String> gender = "".obs;
  Rx<String> email = "".obs;
  Rx<String> dyeri = "".obs;
  Rx<String> meslek = "".obs;
  Rx<String> password = "".obs;

  final iller = ["Adana", "Adıyaman", "Afyonkarahisar", "Ağrı", "Amasya", "Ankara", "Antalya", "Artvin", "Aydın", "Balıkesir", "Bilecik", "Bingöl", "Bitlis", "Bolu", "Burdur", "Bursa", "Çanakkale", "Çankırı", "Çorum", "Denizli", "Diyarbakır", "Edirne", "Elazığ", "Erzincan", "Erzurum", "Eskişehir", "Gaziantep", "Giresun", "Gümüşhane", "Hakkâri", "Hatay", "Isparta", "Mersin", "İstanbul", "İzmir", "Kars", "Kastamonu", "Kayseri", "Kırklareli", "Kırşehir", "Kocaeli", "Konya", "Kütahya", "Malatya", "Manisa", "Kahramanmaraş", "Mardin", "Muğla", "Muş", "Nevşehir", "Niğde", "Ordu", "Rize", "Sakarya", "Samsun", "Siirt", "Sinop", "Sivas", "Tekirdağ", "Tokat", "Trabzon", "Tunceli", "Şanlıurfa", "Uşak", "Van", "Yozgat", "Zonguldak", "Aksaray", "Bayburt", "Karaman", "Kırıkkale", "Batman", "Şırnak", "Bartın", "Ardahan", "Iğdır", "Yalova", "Karabük", "Kilis", "Osmaniye", "Düzce"];

  onChangedCheckBox(value) => isSelected.value = value;
  onChangedObscureText() => isObscureText.value = !isObscureText.value;
  onChangedObscureTextReset() => isObscureReset.value = !isObscureReset.value;

  onChangedNameUsername(val) => nameUsername.value = val;
  onChangedBirthday(val) => birthday.value = val;
  onChangedGender(val) => gender.value = val;
  onChangedEmail(val) => email.value = val;
  onChangedDyeri(val) => dyeri.value = val;
  onChangedMeslek(val) => meslek.value = val;
  onChangedPassword(val) => password.value = val;

  registerUser() async {
    isLoading.value = true;

    if (nameUsername.value.isNotEmpty &&
        birthday.value.isNotEmpty &&
        gender.value.isNotEmpty &&
        meslek.value.isNotEmpty &&
        email.value.isNotEmpty &&
        dyeri.value.isNotEmpty &&
        password.isNotEmpty &&
        isSelected.value) {
      await authServices
          .signUp(nameUsername.value, email.value, dyeri.value, meslek.value, gender.value, birthday.value, password.value)
          .then((value) {
        isLoading.value = false;
      });
    } else {
      isLoading.value = false;
      _showSnackBar("Lütfen tüm alanları doldurunuz!", Styles.warningRedColor);
    }
  }

  _showSnackBar(title, Color color) {
    Get.showSnackbar(GetSnackBar(
      backgroundColor: color,
      message: title,
      duration: const Duration(seconds: 3),
    ));
  }
}
