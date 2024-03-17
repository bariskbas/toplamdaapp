import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:xapp/core/dtos/user_dto.dart';
import 'package:xapp/core/services/auth_services.dart';

class ProfileModelView extends GetxController {
  final AuthServices authServices = AuthServices();
  Rx<UserDTO> userDTO = UserDTO().obs;
  final user = FirebaseAuth.instance.currentUser;

  Rx<String> nameSurname = "".obs;
  Rx<String> email = "".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    if (user != null) {
      getUserInfo();
    }
    super.onInit();
  }

  onChangedNameSurname(val) => nameSurname.value = val;
  onChangedEmail(val) => email.value = val;

  getUserInfo() async {
    userDTO.value = await authServices.getUserInfo();
  }
}
