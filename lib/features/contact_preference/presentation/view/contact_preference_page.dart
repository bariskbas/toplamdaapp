import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xapp/core/styles.dart';
import 'package:xapp/core/utils/date_formatter.dart';
import 'package:xapp/core/widgets/app_button.dart';
import 'package:xapp/core/widgets/custom_textfield.dart';
import 'package:xapp/features/auth/presentation/view/welcome_page.dart';
import 'package:xapp/features/contact_preference/presentation/model_view/contact_preference_view.dart';
import 'package:xapp/core/const.dart';
import 'package:flutter_svg/svg.dart';
import 'package:xapp/features/profile/presentation/view/gender_dropdown_button.dart';
import 'package:xapp/features/profile/presentation/view/meslek_dropdown_button.dart';
import 'package:xapp/features/profile/presentation/view/profile_phone_number_textfield.dart';
import 'package:xapp/features/profile/presentation/view/update_button.dart';

class ContactPreferencePage extends StatefulWidget {
  const ContactPreferencePage({super.key});

  @override
  State<ContactPreferencePage> createState() => _ContactPreferencePageState();
}

class _ContactPreferencePageState extends State<ContactPreferencePage> {
  final user = FirebaseAuth.instance.currentUser;

  ContactPreferenceModelView contactPreferenceModelView =
      Get.put(ContactPreferenceModelView());

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
                "İletişim Tercihleri",
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
                          child: contactPreferenceModelView
                                      .userDTO.value.nameUsername !=
                                  null
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                            top: 6.0, bottom: 6),
                                        margin: EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Text(
                                          "Sana nasıl ulaşalım?",
                                          style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                            color: Styles.textColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 50,
                                    ),
                                    Center(
                                      child: Container(
                                        width: 200,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                if (contactPreferenceModelView
                                                        .mobilBildirim.value ==
                                                    true) {
                                                  contactPreferenceModelView
                                                      .mobilBildirim
                                                      .value = false;
                                                } else {
                                                  contactPreferenceModelView
                                                      .mobilBildirim.value = true;
                                                }
                                      
                                                contactPreferenceModelView
                                                    .updateUserInFirebase();
                                              },
                                              child: Container(
                                                width: 35,
                                                height: 35,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                      width: 1,
                                                      color: Colors.white),
                                                  color: contactPreferenceModelView
                                                              .mobilBildirim ==
                                                          true
                                                      ? Color(0xff454b60)
                                                      : Colors.transparent,
                                                ),
                                                child: contactPreferenceModelView
                                                            .mobilBildirim ==
                                                        true
                                                    ? Icon(
                                                        Icons.check,
                                                        color: Colors.white,
                                                        size: 30,
                                                      )
                                                    : null,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Text(
                                              "Mobil Bildirim",
                                              style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18,
                                                color: Styles.textColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    Center(
                                      child: Container(
                                        width: 200,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                if (contactPreferenceModelView
                                                        .sms.value ==
                                                    true) {
                                                  contactPreferenceModelView
                                                      .sms.value = false;
                                                } else {
                                                  contactPreferenceModelView
                                                      .sms.value = true;
                                                }
                                      
                                                contactPreferenceModelView
                                                    .updateUserInFirebase();
                                              },
                                              child: Container(
                                                width: 35,
                                                height: 35,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                      width: 1,
                                                      color: Colors.white),
                                                  color:
                                                      contactPreferenceModelView
                                                                  .sms ==
                                                              true
                                                          ? Color(0xff454b60)
                                                          : Colors.transparent,
                                                ),
                                                child: contactPreferenceModelView
                                                            .sms ==
                                                        true
                                                    ? Icon(
                                                        Icons.check,
                                                        color: Colors.white,
                                                        size: 30,
                                                      )
                                                    : null,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Text(
                                              "SMS",
                                              style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18,
                                                color: Styles.textColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    Center(
                                      child: Container(
                                        width: 200,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                if (contactPreferenceModelView
                                                        .email.value ==
                                                    true) {
                                                  contactPreferenceModelView
                                                      .email.value = false;
                                                } else {
                                                  contactPreferenceModelView
                                                      .email.value = true;
                                                }
                                      
                                                contactPreferenceModelView
                                                    .updateUserInFirebase();
                                              },
                                              child: Container(
                                                width: 35,
                                                height: 35,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                      width: 1,
                                                      color: Colors.white),
                                                  color:
                                                      contactPreferenceModelView
                                                                  .email ==
                                                              true
                                                          ? Color(0xff454b60)
                                                          : Colors.transparent,
                                                ),
                                                child: contactPreferenceModelView
                                                            .email ==
                                                        true
                                                    ? Icon(
                                                        Icons.check,
                                                        color: Colors.white,
                                                        size: 30,
                                                      )
                                                    : null,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Text(
                                              "E-Posta",
                                              style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18,
                                                color: Styles.textColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
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
