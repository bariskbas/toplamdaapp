import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
import 'package:xapp/features/home/presentation/widgets/expansion_tile_fixed_total.dart';
import 'package:xapp/features/home/presentation/widgets/new_tile_asset.dart';

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
          Container(
            padding: const EdgeInsets.only(top: 6.0,bottom: 6),
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Text(
              //"Mevcut varlığı silmek için basılı tutun.",
              "Varlıkları toplu silmek için lütfen çöp kutusuna basılı tutun.",
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w400,
                fontSize: 11,
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
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        '',
                                        textAlign: TextAlign.end,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        'Adet',
                                        style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                          color: Styles.textColor,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        'Fiyat (₺)',
                                        style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                          color: Styles.textColor,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                        child: Row(
                                      children: [
                                        SvgPicture.asset(
                                          AppConst.duzenleForm,
                                          color: Color(0xff454b61),
                                          width: 16,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        GestureDetector(
                                          onLongPress: () async {
                                            var deleteData =
                                                currentPricesModelView
                                                    .userCurrency
                                                    .toList();
                                            for (var datas in deleteData) {
                                              if (datas.assets?.length != 0) {
                                                var firebaseData = await datas
                                                    .assets!
                                                    .where((element) =>
                                                        element
                                                            .deleteIconActive ==
                                                        1);

                                                for (var firebase
                                                    in firebaseData) {
                                                  print(firebase);
                                                  await currentPricesModelView
                                                      .firebaseServices
                                                      .deleteAssets(
                                                          datas.assetsTitle,
                                                          firebase);
                                                }

                                                datas.assets!.removeWhere(
                                                    (element) =>
                                                        element
                                                            .deleteIconActive ==
                                                        1);

                                                currentPricesModelView
                                                    .userCurrency
                                                    .refresh();
                                                currentPricesModelView
                                                    .calculateTotalAssets();
                                              }
                                            }
                                          },
                                          onTap: () {
                                            if (currentPricesModelView
                                                    .allDeteleIcon.value ==
                                                1) {
                                              currentPricesModelView
                                                  .allDeteleIcon.value = 0;
                                            } else {
                                              currentPricesModelView
                                                  .allDeteleIcon.value = 1;
                                            }
                                          },
                                          child: SvgPicture.asset(
                                            AppConst.copKutusuForm,
                                            color: Color(0xff454b61),
                                            width: 16,
                                          ),
                                        ),
                                      ],
                                    )),
                                  ],
                                ),
                                Column(
                                  children: List.generate(
                                    currentPricesModelView
                                        .userCurrency.value.length,
                                    (index) {
                                      return currentPricesModelView.userCurrency
                                              .value[index].assets!.isNotEmpty
                                          ? NewTileAsset(
                                              userCurrency:
                                                  currentPricesModelView
                                                      .userCurrency
                                                      .value[index],
                                            )
                                          : Container();
                                    },
                                  ),
                                ),
                                ExpansionTileFixedTotal()
                              ],
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
