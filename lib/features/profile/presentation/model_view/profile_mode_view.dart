import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xapp/core/dtos/user_dto.dart';
import 'package:xapp/core/services/auth_services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ProfileModelView extends GetxController {
  final AuthServices authServices = AuthServices();
  Rx<UserDTO> userDTO = UserDTO().obs;
  final user = FirebaseAuth.instance.currentUser;

  Rx<String> nameSurname = "".obs;
  Rx<String> email = "".obs;
  Rx<String> phone = "".obs;
  Rx<String> birthday = "".obs;
  Rx<String> meslek = "".obs;
  Rx<String> gender = "".obs;

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
  onChangedPhone(val) => phone.value = val;
  onChangedBirthday(val) => birthday.value = val;
  onChangedMeslek(val) => meslek.value = val;
  onChangedGender(val) => gender.value = val;

  getUserInfo() async {
    userDTO.value = await authServices.getUserInfo();
    nameSurname.value = userDTO.value.nameUsername!;
    email.value = userDTO.value.eMail!;
    phone.value = userDTO.value.phone!;
    birthday.value = userDTO.value.birthday!;
    meslek.value = userDTO.value.meslek!;
    gender.value = userDTO.value.gender!;
  }

  updateUserInFirebase() async {
    try {

      final userRef =
          FirebaseFirestore.instance.collection('users').doc(user!.uid);

      String nameSurnameValue = nameSurname.value;
      String emailValue = email.value;
      String phoneValue = phone.value;
      String birthdayValue = birthday.value;
      String meslekValue = meslek.value;
      String genderValue = gender.value;
      
      Map<String, dynamic> userData = {
        'name_username': nameSurnameValue,
        'e_mail': emailValue,
        'phone': phoneValue,
        'birthday': birthdayValue,
        'Meslek': meslekValue,
        'gender': genderValue,
      };

      await userRef.update(userData);
      Get.snackbar(
        backgroundColor: Colors.green,
        colorText: Colors.white,
        'Başarılı',
        'Kullanıcı bilgileriniz başarılı bir şekilde güncellenmiştir.',
      );
      print('Kullanıcı bilgileri başarıyla güncellendi.');
    } catch (e) {
      print('Kullanıcı bilgileri güncelleme hatası: $e');
    }
  }


  /*updateUserInFirebase() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        firebase_storage.Reference ref = firebase_storage
            .FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child('${user!.uid}.jpg');

        await ref.putFile(File(pickedFile.path));

        String imageUrl = await ref.getDownloadURL()

        final userRef =
            FirebaseFirestore.instance.collection('users').doc(user!.uid);

        String nameSurnameValue = nameSurname.value;
        String emailValue = email.value;
        String phoneValue = phone.value;
        String birthdayValue = birthday.value;
        String meslekValue = meslek.value;
        String genderValue = gender.value;

        Map<String, dynamic> userData = {
          'name_username': nameSurnameValue,
          'e_mail': emailValue,
          'phone': phoneValue,
          'birthday': birthdayValue,
          'Meslek': meslekValue,
          'gender': genderValue,
          'profile_picture':
              imageUrl,
        };

        await userRef.update(userData);

        Get.snackbar(
          backgroundColor: Colors.green.shade700,
          colorText: Colors.white,
          'Başarılı',
          'Kullanıcı bilgileriniz başarılı bir şekilde güncellenmiştir.',
        );

        print('Kullanıcı bilgileri başarıyla güncellendi.');
      } else {
        print('Resim seçilmedi.');
      }
    } catch (e) {
      print('Kullanıcı bilgileri güncelleme hatası: $e');
    }
  }*/
}
