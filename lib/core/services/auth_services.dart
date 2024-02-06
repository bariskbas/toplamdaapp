import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xapp/core/const.dart';
import 'package:xapp/core/dtos/user_dto.dart';
import 'package:xapp/core/styles.dart';
import 'package:xapp/features/auth/presentation/view/login_page.dart';
import 'package:xapp/features/auth/presentation/view/welcome_page.dart';

class AuthServices {
  final user = FirebaseFirestore.instance.collection("users");
  final assets = FirebaseFirestore.instance.collection("assets");

  final firebaseAuth = FirebaseAuth.instance;
  Future<void> _registerUser(String nameUsername, String email, String dyeri, String meslek, String gender,
      String birthday, String userUID) async {
    await saveAssets();
    await user.doc(userUID).set({
      "name_username": nameUsername,
      "birthday": birthday,
      "Dogum_yeri": dyeri,
      "Meslek": meslek,
      "e_mail": email,
      "gender": gender,
    });
  }

  Future<void> saveAssets() async {
    assets.doc(firebaseAuth.currentUser!.uid).collection("DÖVİZ").add(
      {
        "assetsTitle": "DÖVİZ",
        "assetsSvgPath": AppConst.dovizIcon,
        "currencyType": "₺",
        "assets": []
      },
    );
    assets.doc(firebaseAuth.currentUser!.uid).collection("KRİPTO").add(
      {
        "assetsTitle": "KRİPTO",
        "assetsSvgPath": AppConst.bitcoinIcon,
        "currencyType": "\$",
        "assets": []
      },
    );
    assets.doc(firebaseAuth.currentUser!.uid).collection("EMTİA").add(
      {
        "assetsTitle": "EMTİA",
        "assetsSvgPath": AppConst.emtiaIcon,
        "currencyType": "\$",
        "assets": []
      },
    );
    assets.doc(firebaseAuth.currentUser!.uid).collection("GOLD").add(
      {
        "assetsTitle": "GOLD",
        "assetsSvgPath": AppConst.altinIcon,
        "currencyType": "₺",
        "assets": []
      },
    );
    assets.doc(firebaseAuth.currentUser!.uid).collection("HİSSE SENEDİ").add(
      {
        "assetsTitle": "HİSSE SENEDİ",
        "assetsSvgPath": AppConst.hisseIcon,
        "currencyType": "₺",
        "assets": []
      },
    );
  }

  Future<void> signUp(String nameUsername, String email, String dyeri, String meslek, String gender,
      String birthday, String password) async {
    try {
      await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        if (value.user != null) {
          _showSnackBar("Kullanıcı başarıyla oluşturuldu.", Styles.greenColor);
          _registerUser(nameUsername, email, dyeri, meslek, gender, birthday, value.user!.uid);
          Get.to(const LoginPage());
        } else {
          print(value);
          _showSnackBar("İşlem tamamlanamadı. Lütfen bilgileri kontrol ediniz.",
              Styles.warningRedColor);
        }
      });
    } on FirebaseAuthException {
      _showSnackBar("İşlem tamamlanamadı. Lütfen bilgileri kontrol ediniz.",
          Styles.warningRedColor);
    }
  }

  Future<bool> signIn(email, password) async {
    try {
      await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        if (value.user != null) {
          return true;
        } else {
          return false;
        }
      });

      return true;
    } catch (e) {
      // print('hata'+e.toString());

      return false;
    }
  }

  Future<void> logout() async {
    firebaseAuth.signOut().then((value) => Get.off(const WelcomePage()));
  }

  Future<UserDTO> getUserInfo() async {
    final data = await user.doc(firebaseAuth.currentUser!.uid).get();
    return UserDTO.fromJson(data.data()!);
  }

  Future<void> verifyEmail() async {
    try {
      firebaseAuth.currentUser!.sendEmailVerification();
      _showSnackBar(
          "Email doğrulama linki gönderildi, malinizi kontrol ediniz.",
          Styles.greenColor);
    } catch (e) {
      _showSnackBar("Bir şeyler yanlış gitti, lütfen tekrar deneyiniz.",
          Styles.warningRedColor);
    }
  }

  Future<bool> forgotPassword(email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      _showSnackBar(
          "Parola resetleme linki gönderildi,mailiniz kontrol ediniz.",
          Styles.greenColor);
      return true;
    } catch (e) {
      _showSnackBar("Hatalı işlem yaptınz lütfen tekrar deneyiniz.",
          Styles.warningRedColor);
      return false;
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
