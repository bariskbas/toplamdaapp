import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xapp/core/const.dart';
import 'package:xapp/core/dtos/currencies.dart';
import 'package:xapp/core/styles.dart';
import 'package:xapp/core/widgets/app_button.dart';
import 'package:xapp/features/auth/presentation/view/welcome_page.dart';
import 'package:xapp/features/home/presentation/model_view/add_assets_model_view.dart';
import 'package:xapp/features/home/presentation/model_view/current_prices_model_view.dart';
import 'package:xapp/features/home/presentation/widgets/generic_altin_modal_price.dart';

class GenericAltinModal extends StatelessWidget {
  GenericAltinModal({
    super.key,
    this.currentAssets,
  });

  AddAssetsModelView addAssetsModelView = Get.put(AddAssetsModelView());
  CurrentPricesModelView currentPricesModelView = Get.find();

  User? user = FirebaseAuth.instance.currentUser;

  final CurrentAssets? currentAssets;
  @override
  Widget build(BuildContext context) {
    addAssetsModelView.setCurrentAssets(currentAssets!);
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      backgroundColor: Colors.transparent,
      child: Container(
        height: Get.height * 0.9,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xffEDEDED),
          borderRadius: BorderRadius.circular(10),
        ),
        child: FormBuilder(
          key: currentPricesModelView.formkey.value,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: SvgPicture.asset(
                      AppConst.solYonIcon,
                      color: Styles.textColor,
                    ),
                  ),
                  Text(
                    "Türü ve adedini seç",
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Styles.textColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: SvgPicture.asset(
                      AppConst.hataIcon,
                      color: Styles.textColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  height: Get.height * 0.9,
                  child: Stack(
                    children: [
                      Container(
                        height: Get.height * 0.9,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: SvgPicture.asset(
                          currentAssets!.svgPath!,
                          color: Styles.textColor.withOpacity(0.07),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 20),
                        height: Get.height * 0.9,
                        width: double.infinity,
                        child: Column(
                          children: [
                            Container(
                              height: Get.height * 0.7,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: currentAssets!.currencies!.length,
                                itemBuilder: (context, index) {
                                  final currency =
                                      currentAssets!.currencies![index];
                                  return GetBuilder<AddAssetsModelView>(
                                      id: 'updatePrice$index',
                                      builder: (context) {
                                        return GestureDetector(
                                          onTap: () {
                                            addAssetsModelView
                                                .onChangeAssetType(currency);
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 16),
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  AppConst.btcLogo,
                                                  width: 25,
                                                  height: 25,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    currency.name!,
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      color: Styles.textColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 25,
                                                ),
                                                GestureDetector(
                                                    onTap: () {
                                                      addAssetsModelView
                                                          .bitcoinEkleCikar(
                                                              currency
                                                                  .sellingPrice!,
                                                              index,
                                                              1);
                                                    },
                                                    child:
                                                        Icon(Icons.arrow_back)),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                GenericAltinModalPrice(
                                                  price: currentPricesModelView
                                                      .formkey
                                                      .value
                                                      .currentState!
                                                      .fields[
                                                          'bitcoinValueText$index']
                                                      ?.value,
                                                  index: index,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    addAssetsModelView
                                                        .bitcoinEkleCikar(
                                                            currency
                                                                .sellingPrice!,
                                                            index,
                                                            2);
                                                  },
                                                  child:
                                                      Icon(Icons.arrow_forward),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                },
                              ),
                            ),
                            const SizedBox(height: 10),
                            user != null
                                ? Obx(
                                    () => !addAssetsModelView.isLoading.value
                                        ? GestureDetector(
                                            onTap: () {
                                              Get.snackbar(
                                                backgroundColor: Colors.red,
                                                colorText: Colors.white,
                                                'Hata',
                                                'Toplu veri ekleme sırasında chart kısmı güncellenemedi.',
                                              );
                                              //addAssetsModelView.saveAssets();
                                            },
                                            child: Container(
                                              width: 200,
                                              height: 45,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Styles.neutralsBlue,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "Kaydet",
                                                  style: GoogleFonts.montserrat(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        : SizedBox(
                                            height: 30,
                                            width: 30,
                                            child: CircularProgressIndicator(
                                              color: Styles.primaryColor,
                                              strokeWidth: 5,
                                            ),
                                          ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: AppButton(
                                      onTap: () =>
                                          Get.offAll(const WelcomePage()),
                                      buttonText: "Hemen Üye Ol",
                                    ),
                                  ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String getSymbol(assetTitle) {
    if (assetTitle == "GOLD" ||
        assetTitle == "HİSSE SENEDİ" ||
        assetTitle == "DÖVİZ") {
      return "₺";
    } else {
      return "\$";
    }
  }
}
