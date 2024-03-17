import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xapp/core/services/auth_services.dart';
import 'package:xapp/core/styles.dart';
import 'package:xapp/core/widgets/app_button.dart';
import 'package:xapp/features/auth/presentation/view/welcome_page.dart';
import 'package:xapp/features/profile/presentation/model_view/profile_mode_view.dart';
import 'package:xapp/core/const.dart';
import 'package:flutter_svg/svg.dart';

class ProfilePageOld extends StatefulWidget {
  const ProfilePageOld({super.key});

  @override
  State<ProfilePageOld> createState() => _ProfilePageOldState();
}

class _ProfilePageOldState extends State<ProfilePageOld> {
  final user = FirebaseAuth.instance.currentUser;

  ProfileModelView profileModelView = Get.put(ProfileModelView());

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
              leading: IconButton(
                icon: SvgPicture.asset(AppConst.backsolIcon,
                    color: Colors.white, width: 35),
                onPressed: () => Navigator.of(context).pop(),
              ),
              elevation: 0,
              centerTitle: true,
              backgroundColor: Colors.transparent,
              title: Text(
                "Hesabım",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                  color: Colors.white,
                ),
              ),
            ),
            user != null
                ? Obx(
                    () => Expanded(
                      child: Container(
                          width: Get.width,
                          margin: const EdgeInsets.all(16),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: profileModelView.userDTO.value.nameUsername !=
                                  null
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(
                                          top: 6.0, bottom: 6),
                                      margin:
                                          EdgeInsets.only(left: 10, right: 10),
                                      child: Text(
                                        "KULLANICI BİLGİLERİ",
                                        style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                          color: Styles.textColor,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "İsim Soyisim",
                                      style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: Styles.textColor,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      profileModelView
                                          .userDTO.value.nameUsername!,
                                      style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      "E-mail",
                                      style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: Styles.textColor,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    const SizedBox(height: 4),
                                    Text(
                                      user!.email!,
                                      style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      "Doğum Tarihi",
                                      style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: Styles.textColor,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      profileModelView.userDTO.value.birthday!,
                                      style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      "Cinsiyet",
                                      style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: Styles.textColor,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      profileModelView.userDTO.value.gender!,
                                      style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    !user!.emailVerified
                                        ? Text(
                                            "E-mail adresiniz doğrulanmamış!",
                                            style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 10,
                                              color: Styles.warningRedColor,
                                            ),
                                          )
                                        : Container(),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Styles.primaryColor),
                                      onPressed: () {
                                        AuthServices().verifyEmail();
                                      },
                                      child: const Text(
                                          "Doğrulamak için tıklayın!"),
                                    ),
                                  ],
                                )
                              : Container()),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: AppButton(
                      onTap: () => Get.offAll(
                        const WelcomePage(),
                      ),
                      buttonText: "Hemen Üye Ol",
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
