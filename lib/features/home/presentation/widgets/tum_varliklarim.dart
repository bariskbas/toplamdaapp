import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xapp/core/const.dart';
import 'package:xapp/core/styles.dart';
import 'package:xapp/core/widgets/app_button.dart';
import 'package:xapp/features/auth/presentation/view/welcome_page.dart';
import 'package:xapp/features/home/presentation/model_view/current_prices_model_view.dart';
import 'package:xapp/features/home/presentation/widgets/duzenle_modal.dart';
import 'package:xapp/features/home/presentation/widgets/expansion_tile_asset.dart';

class TumVarliklarim extends StatelessWidget {
  TumVarliklarim({
    super.key,
  });

  User? user = FirebaseAuth.instance.currentUser;
  CurrentPricesModelView currentPricesModelView =
      Get.put(CurrentPricesModelView());
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      width: Get.width,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        gradient: Styles.boxLinear,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              "Tüm Varlıkların",
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Styles.textColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              "Mevcut varlığı silmek için basılı tutun.",
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: Styles.textColor,
              ),
            ),
          ),
          user != null
              ? Obx(
                  () => (currentPricesModelView.isLoading.value &&
                          checkAssets())
                      ? SizedBox(
                          child: SingleChildScrollView(
                            child: Column(
                              children: List.generate(
                                currentPricesModelView
                                    .userCurrency.value.length,
                                (index) {
                                  return currentPricesModelView.userCurrency
                                          .value[index].assets!.isNotEmpty
                                      ? ExpansionTileAsset(
                                          userCurrency: currentPricesModelView
                                              .userCurrency.value[index],
                                        )
                                      : Container();
                                },
                              ),
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () => showDialog(
                            context: context,
                            builder: (context) => DuzenleModal(),
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              width: Get.width * 0.4,
                              margin: const EdgeInsets.only(top: 16, left: 16),
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                      width: 1.2, color: Styles.textColor)),
                              child: Text(
                                "+Varlık Ekle",
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color: Styles.textColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                )
              : Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: AppButton(
                    onTap: () => Get.offAll(const WelcomePage()),
                    buttonText: "Hemen Üye Ol",
                  ),
                ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  bool checkAssets() {
    bool check = false;
    for (var element in currentPricesModelView.userCurrency.value) {
      if (element.assets!.isNotEmpty) {
        check = true;
      }
    }
    return check;
  }
}

class VarlikItem extends StatelessWidget {
  const VarlikItem({super.key, required this.altin, required this.index});

  final List<String> altin;
  final int? index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 30),
          Expanded(
            child: Text(
              altin[index!],
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: Styles.textColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              "1",
              textAlign: TextAlign.left,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w500,
                fontSize: 10,
                color: Styles.textColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              "₺ 1.122",
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: Styles.textColor,
              ),
            ),
          ),
          SvgPicture.asset(
            index == 0 ? AppConst.asagiPiyasaIcon : AppConst.yukariPiyasaIcon,
            color: index == 0 ? Styles.warningRedColor : Styles.greenColor,
            width: 16,
          )
        ],
      ),
    );
  }
}
