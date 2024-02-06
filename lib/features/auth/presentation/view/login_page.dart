import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xapp/core/const.dart';
import 'package:xapp/core/styles.dart';
import 'package:xapp/core/widgets/app_button.dart';
import 'package:xapp/core/widgets/custom_textfield.dart';
import 'package:xapp/features/auth/presentation/model_view/login_model_view.dart';
import 'package:xapp/features/auth/presentation/view/forgot_password_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginModelView _loginModelView = Get.put(LoginModelView());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        width: Get.width,
        decoration: BoxDecoration(
          gradient: Styles.appLinear,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppBar(
                leading: IconButton(
                  icon: SvgPicture.asset(AppConst.backsolIcon, color: Colors.white, width: 35),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                elevation: 0,
                backgroundColor: Colors.transparent,
              ),
              const SizedBox(height: 35),
              Text(
                "Giriş için:",
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                  color: Styles.textColor,
                ),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Column(
                  children: [
                    CustomTextfield(
                      onChanged: _loginModelView.onChangedEmail,
                      labelText: "E-Posta Adresi",
                    ),
                    Obx(
                      () => TextFormField(
                        onChanged: _loginModelView.onChangedPassword,
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        obscureText: _loginModelView.isObscureText.value,
                        decoration: InputDecoration(
                          labelText: "Parolan",
                          suffixIcon: GestureDetector(
                            onTap: () => _loginModelView.onChangedObscureText(),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: SvgPicture.asset(
                                _loginModelView.isObscureText.value
                                    ? AppConst.gizleIcon
                                    : AppConst.goruntuleIcon,
                                color: Styles.neutralsBlue,
                              ),
                            ),
                          ),
                          labelStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w100),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white54),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 28),
              GestureDetector(
                onTap: () => Get.to(const ForgotPasswordPage()),
                child: Text(
                  "Parolamı Unuttum!",
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: Styles.textColor,
                  ),
                ),
              ),
              SizedBox(height: Get.height * 0.1),
              Obx(
                () => !_loginModelView.isLoading.value
                    ? AppButton(
                        onTap: () => _loginModelView.signIn(context),
                        buttonText: "   Giriş   ",
                      )
                    : SizedBox(
                        height: 50,
                        width: 50,
                        child: CircularProgressIndicator(
                          color: Colors.white.withOpacity(0.5),
                          strokeWidth: 5,
                        ),
                      ),
              ),
              SizedBox(height: Get.height * 0.4),
              const SizedBox(height: 140),
            ],
          ),
        ),
      ),
    );
  }
}
