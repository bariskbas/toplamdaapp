import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xapp/core/const.dart';
import 'package:xapp/core/services/auth_services.dart';
import 'package:xapp/core/styles.dart';
import 'package:xapp/core/widgets/confirm_dialog.dart';
import 'package:xapp/features/contact_preference/presentation/view/contact_preference_page.dart';
import 'package:xapp/features/home/presentation/widgets/faq_page.dart';
import 'package:xapp/features/home/presentation/widgets/gecmisim_page.dart';
import 'package:xapp/features/innovations/presentation/view/innovations_page.dart';
import 'package:xapp/features/profile/presentation/view/profile_page.dart';

class SeceneklerModal extends StatelessWidget {
  SeceneklerModal({
    super.key,
  });

  final List svgList = [
    AppConst.kullaniciIcon,
    AppConst.statisticIcon,
    AppConst.gecmisKayitIcon,
    AppConst.docsIcon,
    AppConst.contactsIcon,
    AppConst.sssIcon,
    AppConst.destekIcon,
    AppConst.cikisIcon,
  ];

  final List svgListUnauthorized = [
    AppConst.sssIcon,
    AppConst.destekIcon,
  ];

  final List labelList = [
    "Hesabım",
    "İstatistiklerim",
    "Geçmişim",
    "Belgelerim",
    "İletişim Tercihleri",
    "S.S.S",
    "Destek",
    "Çıkış",
  ];

  final List labelListUnauthorized = [
    "S.S.S",
    "Destek",
  ];

  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      backgroundColor: Colors.transparent,
      child: Container(
        height: Get.height * 0.6,
        width: Get.width,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xffEDEDED),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () => Get.back(),
                child: SvgPicture.asset(
                  AppConst.hataIcon,
                  color: Styles.textColor,
                ),
              ),
            ),
            Text(
              "Seçenekler",
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Styles.textColor,
              ),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: GridView.count(
                padding: EdgeInsets.zero, // set padding to zero
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 3,
                crossAxisSpacing: 2,
                mainAxisSpacing: 0,
                children: List.generate(
                  user != null ? svgList.length : svgListUnauthorized.length,
                  (index) => GestureDetector(
                    onTap: () {
                      if (index == 0) {
                        Get.to(const ProfilePage());
                      }
                      if (index == 1) {
                        Get.to(const InnovationsPage());
                      }
                      if (index == 2) {
                        Get.to(const HistoryPage());
                      }
                      if (index == 4) {
                        Get.to(const ContactPreferencePage());
                      }
                      if (index == 5) {
                        Get.to(const FaqPage());
                      }
                      if (index == 7) {
                        showDialog(
                          context: context,
                          builder: (context) => ConfirmDialog(
                            onTap: () {
                              AuthServices().logout();
                            },
                            confirmLabel: "Tamam",
                            description: "Çıkmak istediğinden emin misin?",
                          ),
                        );
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      padding: const EdgeInsets.only(bottom: 1),
                      margin: const EdgeInsets.all(6.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Spacer(),
                          SvgPicture.asset(
                            svgList[index],
                            width: 50,
                            color: Styles.textColor,
                          ),
                          const SizedBox(height: 3),
                          Text(
                            labelList[index],
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600,
                              fontSize: 9,
                              color: Styles.textColor,
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
