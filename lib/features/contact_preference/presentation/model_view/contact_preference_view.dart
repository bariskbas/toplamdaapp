import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xapp/core/dtos/user_dto.dart';
import 'package:xapp/core/services/auth_services.dart';

class ContactPreferenceModelView extends GetxController {
  final AuthServices authServices = AuthServices();
  Rx<UserDTO> userDTO = UserDTO().obs;
  final user = FirebaseAuth.instance.currentUser;

  Rx<bool> mobilBildirim = false.obs;
  Rx<bool> sms = false.obs;
  Rx<bool> email = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    if (user != null) {
      getUserInfo();
    }
    super.onInit();
  }

  onChangedMobilBilidirim(val) => mobilBildirim.value = val;
  onChangedSms(val) => sms.value = val;
  onChangedEmail(val) => email.value = val;

  getUserInfo() async {
    userDTO.value = await authServices.getUserInfo();
    mobilBildirim.value = userDTO.value.mobilBildirim!;
    sms.value = userDTO.value.smsBildirim!;
    email.value = userDTO.value.emailBildirim!;
  }

  updateUserInFirebase() async {
    try {
      final userRef =
          FirebaseFirestore.instance.collection('users').doc(user!.uid);

      bool mobilBildirimValue = mobilBildirim.value;
      bool smsValue = sms.value;
      bool emailValue = email.value;

      Map<String, dynamic> userData = {
        'mobilBildirim': mobilBildirimValue,
        'smsBildirim': smsValue,
        'emailBildirim': emailValue,
      };

      await userRef.update(userData);
      Get.snackbar(
        backgroundColor: Colors.green,
        colorText: Colors.white,
        'Başarılı',
        'İletişim Tercihiniz başarılı bir şekilde güncellenmiştir.',
      );
      print('Kullanıcı bilgileri başarıyla güncellendi.');
    } catch (e) {
      print('Kullanıcı bilgileri güncelleme hatası: $e');
    }
  }
}
