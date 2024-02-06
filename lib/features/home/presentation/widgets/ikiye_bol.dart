import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xapp/core/styles.dart';
import 'package:xapp/core/widgets/app_button.dart';
import 'package:xapp/features/auth/presentation/view/welcome_page.dart';
import 'package:xapp/features/home/presentation/model_view/current_prices_model_view.dart';
import 'package:xapp/features/home/presentation/widgets/current_prices_expansiontile.dart';
import 'package:xapp/features/home/presentation/widgets/duzenle_modal.dart';
import 'package:xapp/features/home/presentation/widgets/expansion_tile_asset.dart';

class IkiyeBol extends StatelessWidget {
  IkiyeBol({
    super.key,
  });
  CurrentPricesModelView currentPricesModelView =
      Get.put(CurrentPricesModelView());

  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            alignment: Alignment.bottomCenter,
            height: Get.height * 0.4,
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: Styles.boxLinear,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Text(
                  "Tüm Varlıkların",
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Styles.textColor,
                  ),
                ),
                user != null
                    ? Obx(
                        () => checkAssets()
                            ? SizedBox(
                                height: Get.height * 0.3,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: List.generate(
                                      currentPricesModelView
                                          .userCurrency.value.length,
                                      (index) => currentPricesModelView
                                              .userCurrency
                                              .value[index]
                                              .assets!
                                              .isNotEmpty
                                          ? ExpansionTileAsset(
                                              userCurrency:
                                                  currentPricesModelView
                                                      .userCurrency
                                                      .value[index],
                                            )
                                          : Container(),
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
                                    margin: const EdgeInsets.only(top: 16),
                                    padding: const EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(
                                            width: 1.2,
                                            color: Styles.textColor)),
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
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.bottomCenter,
            height: Get.height * 0.4,
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: Styles.boxLinear,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Text(
                  "Güncel Fiyatlar",
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Styles.textColor,
                  ),
                ),
                Obx(() => SizedBox(
                      height: Get.height * 0.3,
                      child: SingleChildScrollView(
                        child: Column(
                          children: List.generate(
                            currentPricesModelView.currentAssets.value.length,
                            (index) => CurrentPriceExpansionTile(
                                isVisibleSearch: false,
                                currentAssets: currentPricesModelView
                                    .currentAssets[index]),
                          ),
                        ),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ],
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
