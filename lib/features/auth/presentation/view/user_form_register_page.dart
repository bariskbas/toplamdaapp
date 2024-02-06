import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:xapp/core/const.dart';
import 'package:xapp/core/styles.dart';
import 'package:xapp/core/utils/date_formatter.dart';
import 'package:xapp/core/widgets/app_button.dart';
import 'package:xapp/core/widgets/custom_textfield.dart';
import 'package:xapp/core/widgets/dogumyeri_dropdown_button.dart';
import 'package:xapp/core/widgets/gender_dropdown_button.dart';
import 'package:xapp/core/widgets/meslek_dropdown_button.dart';
import 'package:xapp/features/auth/presentation/model_view/register_model_view.dart';

class UserFormRegisterPage extends StatefulWidget {
  const UserFormRegisterPage({super.key});

  @override
  State<UserFormRegisterPage> createState() => _UserFormRegisterPageState();
}

class _UserFormRegisterPageState extends State<UserFormRegisterPage> {
  @override
  String selectedGender = "Erkek";
  final RegisterModelView _registerModelView = Get.put(RegisterModelView());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset(AppConst.backsolIcon,
              color: Colors.white, width: 35),
          onPressed: () => Navigator.of(context).pop(),
        ),
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
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 90,
                ),
                Text(
                  "İletişim Bilgilerin",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Styles.textColor),
                ),
                const SizedBox(height: 5),
                Text(
                  "Varlıklarına ait güncel bildirimler\n ve sana özel fırsatlar için\n temel bilgilerini girmelisin.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      color: Styles.textColor),
                ),
                const SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Column(
                    children: [
                      CustomTextfield(
                        onChanged: _registerModelView.onChangedNameUsername,
                        labelText: "Ad Soyad*",
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextfield(
                              format: DateTextFormatter(),
                              onChanged: _registerModelView.onChangedBirthday,
                              labelText: "Doğum Tarihi*(GG/AA/YYYY)",
                            ),
                          ),
                          const SizedBox(width: 40),
                          Expanded(
                            child: DogumyeriDropdownButton(
                                onChanged: _registerModelView.onChangedDyeri,
                                selectedGender:
                                    _registerModelView.gender.value),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: GenderDropdownButton(
                                onChanged: _registerModelView.onChangedGender,
                                selectedGender:
                                    _registerModelView.gender.value),
                          ),
                          const SizedBox(width: 40),
                          Expanded(
                            child: MeslekDropdownButton(
                                onChanged: _registerModelView.onChangedMeslek,
                                selectedGender:
                                    _registerModelView.gender.value),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      GestureDetector(
                        onTap: () async {
                          showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (context) => Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  topRight: Radius.circular(16),
                                ),
                              ),
                              child:
                                  SfPdfViewer.asset("assets/bu-bilgileri.pdf"),
                            ),
                          );
                        },
                        child: Text(
                          "Bu bilgileri neden istiyoruz?",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                              color: Colors.blue),
                        ),
                      ),
                      CustomTextfield(
                        onChanged: _registerModelView.onChangedEmail,
                        labelText: "E-Posta Adresi",
                      ),
                      const SizedBox(height: 10),
                      Obx(
                        () => TextFormField(
                          onChanged: _registerModelView.onChangedPassword,
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontSize: 20,
                          ),
                          obscureText: _registerModelView.isObscureText.value,
                          decoration: InputDecoration(
                            labelText: "Parolan",
                            suffixIcon: GestureDetector(
                              onTap: () =>
                                  _registerModelView.onChangedObscureText(),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: SvgPicture.asset(
                                  _registerModelView.isObscureText.value
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
                      child: GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (context) => Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  topRight: Radius.circular(16),
                                ),
                              ),
                              child: SfPdfViewer.asset("assets/acik-riza.pdf"),
                            ),
                          );
                        },
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
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Obx(
                  () => !_registerModelView.isLoading.value
                      ? AppButton(
                          buttonText: "             Devam             ",
                          onTap: () {
                            _registerModelView.registerUser();
                          },
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
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
