import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:xapp/core/styles.dart';

class VerificationCodePage extends StatefulWidget {
  const VerificationCodePage({super.key});

  @override
  State<VerificationCodePage> createState() => _VerificationCodePageState();
}

class _VerificationCodePageState extends State<VerificationCodePage> {
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
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 120,
                ),
                Text(
                  "Doğrulama kodunu gir",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      color: Styles.textColor),
                ),
                const SizedBox(height: 16),
                Text(
                  "+90 xxx xxx xx numaralı telefona\nxxxxxx referans koduyla ilettiğimiz\nSMS doğrulama kodunu girmelisin.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Styles.textColor),
                ),
                const SizedBox(height: 60),
                OTPTextField(
                    length: 5,
                    width: MediaQuery.of(context).size.width,
                    textFieldAlignment: MainAxisAlignment.spaceAround,
                    fieldWidth: 45,
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
                    }),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Kalan süre:",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                                color: Styles.textColor,
                                fontSize: 12),
                          ),
                          TextSpan(
                            text: " 2:34",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold,
                                color: Styles.textColor,
                                fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Get.height * 0.1),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
