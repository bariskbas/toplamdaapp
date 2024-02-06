import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xapp/core/styles.dart';
import 'package:xapp/core/widgets/app_button.dart';
import 'package:xapp/core/widgets/custom_textfield.dart';
import 'package:xapp/features/auth/presentation/view/verification_code_page.dart';

class VerificationMailPage extends StatefulWidget {
  const VerificationMailPage({super.key});

  @override
  State<VerificationMailPage> createState() => _VerificationMailPageState();
}

class _VerificationMailPageState extends State<VerificationMailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(
          gradient: Styles.appLinear,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 45.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 120,
                ),
                Text(
                  "E-postanı Doğrula",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      color: Styles.textColor),
                ),
                const SizedBox(height: 16),
                Text(
                  "E-Posta hesabına bir\n doğrulama kodu gönderdik.\nKodu girince devam edebilirsin.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Styles.textColor),
                ),
                const SizedBox(height: 20),
                const CustomTextfield(labelText: "Doğrulama Kodu"),
                const SizedBox(height: 16),
                SizedBox(height: Get.height * 0.35),
                AppButton(
                  buttonText: "Gönder",
                  onTap: () => Get.to(const VerificationCodePage()),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
