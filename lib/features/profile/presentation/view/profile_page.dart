import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xapp/core/dtos/user_dto.dart';
import 'package:xapp/core/services/auth_services.dart';
import 'package:xapp/core/styles.dart';
import 'package:xapp/core/utils/date_formatter.dart';
import 'package:xapp/core/widgets/app_button.dart';
import 'package:xapp/core/widgets/custom_textfield.dart';
import 'package:xapp/core/widgets/phone_number_textfield.dart';
import 'package:xapp/features/auth/presentation/view/welcome_page.dart';
import 'package:xapp/features/profile/presentation/model_view/profile_mode_view.dart';
import 'package:xapp/core/const.dart';
import 'package:flutter_svg/svg.dart';
import 'package:xapp/features/profile/presentation/view/gender_dropdown_button.dart';
import 'package:xapp/features/profile/presentation/view/meslek_dropdown_button.dart';
import 'package:xapp/features/profile/presentation/view/profile_phone_number_textfield.dart';
import 'package:xapp/features/profile/presentation/view/update_button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
                          padding: const EdgeInsets.all(25),
                          child: profileModelView.userDTO.value.nameUsername !=
                                  null
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                            top: 6.0, bottom: 6),
                                        margin: EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Text(
                                          "KULLANICI BİLGİLERİ",
                                          style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                            color: Styles.textColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: Get.width * 0.5,
                                      child: CustomTextfield(
                                        labelStyle: 1,
                                        initialValue: profileModelView
                                            .userDTO.value.nameUsername!,
                                        onChanged: profileModelView
                                            .onChangedNameSurname,
                                        labelText: "*Ad Soyad",
                                      ),
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    Container(
                                      width: Get.width * 0.5,
                                      child: CustomTextfield(
                                        labelStyle: 1,
                                        initialValue: profileModelView
                                            .userDTO.value.eMail!,
                                        onChanged:
                                            profileModelView.onChangedEmail,
                                        labelText: "*E-Posta",
                                      ),
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          width: Get.width * 0.4,
                                          child: ProfilePhonenNumberTextfield(
                                                      onChanged:
                                            profileModelView.onChangedPhone,
                                            phone: profileModelView
                                                .userDTO.value.phone,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 25,
                                        ),
                                        Container(
                                          width: Get.width * 0.4,
                                          child: CustomTextfield(
                                            labelStyle: 1,
                                            format: DateTextFormatter(),
                                            onChanged: profileModelView
                                                .onChangedBirthday,
                                            initialValue: profileModelView
                                                .userDTO.value.birthday,
                                            labelText:
                                                "*Doğum Tarihi (GG/AA/YYYY)",
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          width: Get.width * 0.4,
                                          child: ProfileMeslekDropdownButton(
                                            onChanged: profileModelView
                                                .onChangedMeslek,
                                            initialValue: profileModelView
                                                .userDTO.value.meslek!,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 25,
                                        ),
                                        Container(
                                          width: Get.width * 0.4,
                                          child: ProfileGenderDropdownButton(
                                            selectedGender: profileModelView
                                                 .userDTO.value.gender!,
                                            onChanged: profileModelView
                                                .onChangedGender,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    Center(
                                      child: ProfileUpdateButton(),
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          AppConst.unlem,
                                          color: Colors.orange.shade700,
                                          cacheColorFilter: true,
                                        ),
                                        SizedBox(width: 5,),
                                        Text(
                                          "Gerçeği yansıtmayan miktarda, türde ve sıklıkta \nvarlıklar eklenmesinin tespiti halinde hesabı \naskıya alma hakkımızı saklı tutarız.",
                                          style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 11,
                                            color: Styles.textColor,
                                          ),
                                        ),
                                      ],
                                    )
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
