import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xapp/core/const.dart';
import 'package:xapp/core/styles.dart';
import 'package:xapp/features/home/presentation/model_view/add_assets_model_view.dart';
import 'package:xapp/features/home/presentation/model_view/current_prices_model_view.dart';
import 'package:xapp/features/home/presentation/widgets/altin_modal.dart';
import 'package:xapp/features/home/presentation/widgets/generic_altin_modal.dart';

class DuzenleModal extends StatelessWidget {
  DuzenleModal({
    super.key,
  });

  CurrentPricesModelView currentPricesModelView =
      Get.put(CurrentPricesModelView());

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      insetAnimationDuration: const Duration(milliseconds: 100),
      backgroundColor: Colors.transparent,
      child: Container(
        height: Get.height * 0.7,
        width: 1000,
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
              "Düzenlemek istediğin varlığını seç",
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w500,
                fontSize: 15,
                color: Styles.textColor,
              ),
            ),
            Expanded(
              child: GridView.count(
                padding: EdgeInsets.zero, // set padding to zero
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 3,
                crossAxisSpacing: 3,
                mainAxisSpacing: 0,
                children: List.generate(
                  currentPricesModelView.currentAssets.value.length,
                  (index) => GestureDetector(
                    onTap: () {
                      if (currentPricesModelView.currentAssets.value[index].assetsTitle ==
                          "KRİPTO") {
                        showDialog(
                                context: context,
                                useSafeArea: true,
                                builder: (context) => GenericAltinModal(
                                      currentAssets: currentPricesModelView
                                          .currentAssets.value[index],
                                    ))
                            .then((value) => Get.delete<AddAssetsModelView>());
                      } else {
                        showDialog(
                                context: context,
                                useSafeArea: true,
                                builder: (context) => AltinModal(
                                      currentAssets: currentPricesModelView
                                          .currentAssets.value[index],
                                    ))
                            .then((value) => Get.delete<AddAssetsModelView>());
                      }
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: const EdgeInsets.only(bottom: 4),
                      margin: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: SvgPicture.asset(
                              currentPricesModelView
                                  .currentAssets.value[index].svgPath!,
                              width: 40,
                              color: Styles.textColor,
                            ),
                          ),
                          Text(
                            currentPricesModelView
                                .currentAssets.value[index].assetsTitle!,
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600,
                              fontSize: 9,
                              color: Styles.textColor,
                            ),
                          ),
                          const SizedBox(height: 8),
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
