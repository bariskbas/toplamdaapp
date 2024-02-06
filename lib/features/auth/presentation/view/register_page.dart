import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xapp/core/styles.dart';
import 'package:xapp/core/widgets/app_button.dart';
import 'package:xapp/core/widgets/phone_number_textfield.dart';
import 'package:xapp/features/auth/presentation/model_view/register_model_view.dart';
import 'package:xapp/features/auth/presentation/view/user_form_register_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final RegisterModelView _registerModelView = Get.put(RegisterModelView());
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
                "Hoş Geldin!",
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    color: Styles.textColor),
              ),
              const SizedBox(height: 16),
              Text(
                "Varlıklarını güvenle tek yerde\nhesaplamana çok az kaldı.",
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w500, color: Styles.textColor),
              ),
              const SizedBox(height: 16),
              Text(
                "Telefon numarana bir\n doğrulama kodu gelecek.",
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w500, color: Styles.textColor),
              ),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Column(
                  children: [
                    const PhonenNumberTextfield(),
                    Row(
                      children: [
                        Obx(
                          () => Checkbox(
                            value: _registerModelView.isSelected.value,
                            onChanged: (value) =>
                                _registerModelView.onChangedCheckBox(value),
                          ),
                        ),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      "Müşteri Açık Rıza Beyan Formu ve Ticari Elektronik İleti Beyan Formu'na onay veriyorum.",
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.blueAccent,
                                      fontSize: 10),
                                ),

                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: Get.height * 0.3),
              AppButton(
                onTap: () => Get.to(const UserFormRegisterPage()),
                buttonText: "Devam",
              ),
              const SizedBox(height: 10),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Aydınlatma Metinleri (KVKK)",
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500,
                          color: Colors.blueAccent,
                          fontSize: 10),
                    ),
                    TextSpan(
                      text:
                          " burada.\nTüm sözleşmelerini uygulamada Profil kısmında bulabilirsin.",
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: 10),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
