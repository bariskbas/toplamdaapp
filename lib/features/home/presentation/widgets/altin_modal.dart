import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xapp/core/const.dart';
import 'package:xapp/core/dtos/currencies.dart';
import 'package:xapp/core/styles.dart';
import 'package:xapp/core/widgets/app_button.dart';
import 'package:xapp/features/auth/presentation/view/welcome_page.dart';
import 'package:xapp/features/home/presentation/model_view/add_assets_model_view.dart';

class AltinModal extends StatelessWidget {
  AltinModal({
    super.key,
    this.currentAssets,
  });

  AddAssetsModelView addAssetsModelView = Get.put(AddAssetsModelView());
  User? user = FirebaseAuth.instance.currentUser;

  final CurrentAssets? currentAssets;
  @override
  Widget build(BuildContext context) {
    addAssetsModelView.setCurrentAssets(currentAssets!);
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      backgroundColor: Colors.transparent,
      child: Container(
        height: Get.height * 0.7,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xffEDEDED),
          borderRadius: BorderRadius.circular(10),
        ),
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
                height: Get.height * 0.7,
                child: Stack(
                  children: [
                    Container(
                      height: Get.height * 0.7,
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
                      height: Get.height * 0.7,
                      width: double.infinity,
                      child: Column(
                        children: [
                          DropdownButtonFormField<Currency>(
                            borderRadius: BorderRadius.circular(10),
                            hint: const Text("Varlık Türü"),
                            onChanged: (onChanged) {
                              addAssetsModelView.onChangeAssetType(onChanged);
                            },
                            items: List.generate(
                              currentAssets!.currencies!.length,
                              (index) => DropdownMenuItem(
                                value: currentAssets!.currencies![index],
                                child: Text(
                                  currentAssets!.currencies![index].name!,
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextField(
                            onChanged: (value) {
                              addAssetsModelView.onChangeAmount(value);
                            },
                            controller:
                                addAssetsModelView.textEditingController,
                            decoration: const InputDecoration(hintText: "Adet"),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                          const SizedBox(height: 20),
                          Obx(
                            () => TextFormField(
                              readOnly: true,
                              controller: TextEditingController(
                                  text: addAssetsModelView.selectedCurrency
                                          .value.sellingPrice ??
                                      ""),
                              decoration: const InputDecoration(
                                hintText: "Fiyat",
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Obx(
                            () => Row(
                              children: [
                                Text(getSymbol(currentAssets!.assetsTitle!)),
                                Expanded(
                                  child: TextFormField(
                                    readOnly: true,
                                    controller: TextEditingController(
                                      text: addAssetsModelView.sumCurrency.value
                                          .toString(),
                                    ),
                                    decoration: const InputDecoration(
                                      hintText: "Toplam",
                                    ),
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          user != null
                              ? Obx(
                                  () => !addAssetsModelView.isLoading.value
                                      ? ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Styles.neutralsBlue),
                                          onPressed: () {
                                            addAssetsModelView.saveAssets();
                                          },
                                          child: const Text("Kaydet"),
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

// class TabbarWidget extends StatelessWidget {
//   TabbarWidget({
//     super.key,
//   });

//   final tabBarTitleList = ["Fiziki", "Dijital"];
//   final HomeModelView homeModelView = Get.put(HomeModelView());

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//             child: Obx(
//           () => Row(
//             children: List.generate(
//               2,
//               (index) => GestureDetector(
//                 onTap: () => homeModelView.onChangeVarlikTab(index),
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(
//                     vertical: 2,
//                     horizontal: 30,
//                   ),
//                   margin: const EdgeInsets.all(10),
//                   decoration: BoxDecoration(
//                       color: Colors.transparent,
//                       border: homeModelView.varlikTabIndex.value == index
//                           ? Border.all(width: 1, color: Styles.textColor)
//                           : null,
//                       borderRadius: BorderRadius.circular(5)),
//                   child: Text(
//                     tabBarTitleList[index],
//                     style: GoogleFonts.montserrat(
//                       fontWeight: FontWeight.w500,
//                       fontSize: 12,
//                       color: Styles.textColor,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         )),
//         SvgPicture.asset(
//           AppConst.ayarlarIcon,
//           width: 20,
//         )
//       ],
//     );
//   }
// }
