import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xapp/core/styles.dart';
import 'package:xapp/core/widgets/app_button.dart';
import 'package:xapp/core/widgets/custom_textfield.dart';
import 'package:xapp/features/auth/presentation/model_view/login_model_view.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final LoginModelView _loginModelView = Get.put(LoginModelView());

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
          child: Column(
            children: [
              const SizedBox(
                height: 120,
              ),
              Text(
                "Yeni Parola Edin",
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    color: Styles.textColor),
              ),
              const SizedBox(height: 16),
              Text(
                "Hesabına tanımlı e-posta\nadresini girdiğinde sana bir\n doğrulama kodu göndereceğiz.",
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w400, color: Styles.textColor),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Column(
                  children: [
                    CustomTextfield(
                      labelText: "E-Posta Adresi",
                      onChanged: _loginModelView.onChangeForgotPassword,
                    )
                  ],
                ),
              ),
              const SizedBox(height: 28),
              SizedBox(height: Get.height * 0.06),
              Obx(
                () => !_loginModelView.isLoadingForgotButton.value
                    ? AppButton(
                        buttonText: "         Kodu Gönder         ",
                        onTap: () => _loginModelView.forgotPassword(),
                      )
                    : SizedBox(
                        height: 50,
                        width: 50,
                        child: CircularProgressIndicator(
                          color: Colors.white.withOpacity(0.5),
                          strokeWidth: 5,
                        ),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
