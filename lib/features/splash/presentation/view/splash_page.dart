import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:xapp/core/const.dart';
import 'package:xapp/core/styles.dart';
import 'package:xapp/features/auth/presentation/view/welcome_page.dart';
import 'package:xapp/features/home/presentation/model_view/current_prices_model_view.dart';
import 'package:xapp/features/home/presentation/view/home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), // 3 saniye sonra yönlendirme yapılacak
        () {
      authCheck();
    } // Yönlendirilecek sayfanın Widget'ını burada belirt
        );
  }

  authCheck() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Get.off(const HomePage());
    } else {
      Get.off(const WelcomePage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(
          gradient: Styles.appLinear,
        ),
        child: Column(
          children: [
            AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
            SizedBox(
              height: Get.height * 0.25,
            ),
            Center(
              child: SvgPicture.asset(
                AppConst.logoPathSvg,
                color: Colors.white,
                width: 200,
              ),
            ),
            const Spacer(),
            SizedBox(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(
                color: Colors.white.withOpacity(0.5),
                strokeWidth: 5,
              ),
            ),
            SizedBox(
              height: Get.height * 0.15,
            ),
          ],
        ),
      ),
    );
  }
}
