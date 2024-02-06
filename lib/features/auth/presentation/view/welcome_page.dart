import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xapp/core/const.dart';
import 'package:xapp/core/styles.dart';
import 'package:xapp/core/widgets/app_button.dart';
import 'package:xapp/features/auth/presentation/view/login_page.dart';
import 'package:xapp/features/auth/presentation/view/user_form_register_page.dart';
import 'package:xapp/features/home/presentation/view/home_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(
          gradient: Styles.appLinear,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SizedBox(height: 60),
              Image.asset(
                AppConst.man,
                width: double.infinity,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      "Hoş Geldin!",
                      style: GoogleFonts.montserrat(
                        //fontWeight: FontWeight.w700,
                          fontSize: 20,
                          color: Styles.textColor),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Haydi tüm varlıklarını",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        color: Styles.textColor,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "hesaplayalım!",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        color: Styles.textColor,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              AppButton(
                onTap: () => Get.to(const UserFormRegisterPage()),
                buttonText: "    Toplamda+'ya Katıl    ",
              ),
              const SizedBox(height: 28),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hesabın varsa ",
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w400, color: Styles.textColor),
                  ),
                  GestureDetector(
                    onTap: () => Get.to(const LoginPage()),
                    child: Container(
                      padding: const EdgeInsets.only(
                        bottom: 2, // Space between underline and text
                      ),
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                color: Colors.white,
                                width: 1.0, // Underline thickness
                              ))),
                      child: Text(
                        "Giriş Yap!",
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "veya  ",
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w400, color: Styles.textColor),
                  ),
                  GestureDetector(
                    onTap: () => Get.to(const HomePage()),
                    child: Container(
                      padding: const EdgeInsets.only(
                        bottom: 2, // Space between underline and text
                      ),
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                color: Colors.white,
                                width: 1.0, // Underline thickness
                              ))),
                      child: Text(
                        "Üye Olmadan Dene",
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
