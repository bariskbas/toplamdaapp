import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xapp/core/const.dart';
import 'package:xapp/core/styles.dart';
import 'package:xapp/features/home/presentation/model_view/current_prices_model_view.dart';
import 'package:xapp/features/home/presentation/model_view/home_model_view.dart';

class HesapBilgiAlani extends StatelessWidget {
  HesapBilgiAlani({
    super.key,
  });
  final HomeModelView homeModelView = Get.put(HomeModelView());
  CurrentPricesModelView currentPricesModelView =
      Get.put(CurrentPricesModelView());
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => currentPricesModelView.calculateTotalAssets(),
                child: SvgPicture.asset(
                  AppConst.dovizIcon,
                  color: Styles.textColor,
                  width: 33,
                ),
              ),
              const Spacer(),
              Obx(
                () => Text(
                  homeModelView.infoIsVisible.value
                      ? currentPricesModelView.usersTotalAssets.value
                      : " ₺ *****",
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                    color: Styles.textColor,
                  ),
                ),
              ),
              const Spacer(),
              Obx(
                () => GestureDetector(
                  onTap: () => homeModelView.onChangeVisible(),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SvgPicture.asset(
                      homeModelView.infoIsVisible.value
                          ? AppConst.goruntuleIcon
                          : AppConst.gizleIcon,
                      color: Styles.neutralsBlue,
                      width: 32,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Obx(
          () => RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text:
                      "₺${currentPricesModelView.tlGain.value.toStringAsFixed(2)} (%${currentPricesModelView.percentageGain.value.toStringAsFixed(2)})",
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold,
                      color: currentPricesModelView.tlGain.value
                              .toString()
                              .contains("-")
                          ? Styles.warningRedColor
                          : Styles.greenColor,
                      fontSize: 12),
                ),
                TextSpan(
                  text: " Bugün",
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600,
                      color: Styles.textColor,
                      fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
