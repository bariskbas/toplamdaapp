import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:xapp/core/const.dart';
import 'package:xapp/core/styles.dart';
import 'package:xapp/core/widgets/app_button.dart';
import 'package:xapp/features/auth/presentation/model_view/register_model_view.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final RegisterModelView _registerModelView = Get.put(RegisterModelView());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SvgPicture.asset(
              AppConst.hataIcon,
              color: Styles.textColor,
              width: 20,
            ),
          ),
        ),
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
                "Parolanı Sıfırla",
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    color: Styles.textColor),
              ),
              const SizedBox(height: 16),
              Text(
                "Zor tahmin edilebilir ve\n özgün bir parola olsun.",
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w500, color: Styles.textColor),
              ),
              const SizedBox(height: 25),
              Row(
                children: [
                  Expanded(
                      flex: 5,
                      child: Obx(
                        () => OTPTextField(
                          length: 5,
                          width: MediaQuery.of(context).size.width,
                          textFieldAlignment: MainAxisAlignment.spaceAround,
                          fieldWidth: 45,
                          obscureText: _registerModelView.isObscureReset.value,
                          otpFieldStyle: OtpFieldStyle(
                            borderColor: Colors.white,
                            enabledBorderColor: Colors.white,
                            focusBorderColor: Colors.white,
                          ),
                          fieldStyle: FieldStyle.underline,
                          outlineBorderRadius: 15,
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                            color: Colors.white,
                          ),
                          onChanged: (pin) {
                            print("Changed: $pin");
                          },
                          onCompleted: (pin) {
                            print("Completed: $pin");
                          },
                        ),
                      )),
                  Expanded(
                      child: GestureDetector(
                          onTap: () =>
                              _registerModelView.onChangedObscureTextReset(),
                          child: SvgPicture.asset(AppConst.goruntuleIcon)))
                ],
              ),
              const SizedBox(height: 56),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "+ Aynı rakamı en fazla 3 kere kullanabilirsin.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w500,
                      color: Styles.textColor,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    "+ Aynı rakamı arka arkaya en çok 2 kere kullanabilirsin.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w500,
                      color: Styles.textColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),
              SizedBox(height: Get.height * 0.3),
              const AppButton(
                buttonText: "Parola Oluştur",
              )
            ],
          ),
        ),
      ),
    );
  }
}
