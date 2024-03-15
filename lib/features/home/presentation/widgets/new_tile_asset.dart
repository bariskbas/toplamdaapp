import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:xapp/core/const.dart';
import 'package:xapp/core/dtos/user_currency.dart';
import 'package:xapp/core/styles.dart';
import 'package:xapp/core/widgets/confirm_dialog.dart';
import 'package:xapp/features/home/presentation/model_view/current_prices_model_view.dart';

class NewTileAsset extends StatelessWidget {
  NewTileAsset({
    super.key,
    required this.userCurrency,
  });

  final UserCurrency? userCurrency;
  CurrentPricesModelView currentPricesModelView = Get.find();

  final oCcy = new NumberFormat("#,##0.00", "tr_TR");

  @override
  Widget build(BuildContext context) {
    getSumAssets(userCurrency!);

    return Obx(() => Column(
          children: [
            Container(
              width: Get.width,
              decoration: BoxDecoration(
                gradient: new LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.white.withOpacity(0.4),
                    Colors.white.withOpacity(0.4),
                    Colors.white.withOpacity(0.1),
                  ],
                ),
              ),
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
              child: Text(
                userCurrency!.assetsTitle!,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w900,
                  fontSize: 11,
                  color: Styles.textColor,
                ),
              ),
            ),
            Column(
              children: List.generate(
                userCurrency!.assets!.length + 1,
                (index) => GestureDetector(
                  onLongPress: () {
                    userCurrency!.assets!.length != index
                        ? showDialog(
                            context: context,
                            builder: (context) => ConfirmDialog(
                              onTap: () {
                                currentPricesModelView.deleteAssets(
                                    userCurrency!.assetsTitle!,
                                    userCurrency!.assets![index]);
                              },
                              confirmLabel: "Onaylıyorum",
                              description:
                                  "${userCurrency!.assets![index].amount}  adet ${userCurrency!.assets![index].assetType}\n tipinde varlık silinecek onaylıyor musunuz?",
                            ),
                          )
                        : null;
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: userCurrency!.assets!.length != index
                          ? [
                              const SizedBox(width: 10),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  userCurrency!.assets![index].assetType!,
                                  overflow: TextOverflow.fade,
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                    color: Styles.textColor,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  userCurrency!.assets![index].amount
                                      .toString(),
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                    color: Styles.textColor,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 50,
                                      child: Text(
                                        (userCurrency!.assetsTitle.toString() ==
                                                "KRİPTO"
                                            ? oCcy.format(int.parse(
                                                userCurrency!
                                                    .assets![index].price!
                                                    .replaceAll(".", "")
                                                    .substring(0, 4)))
                                            : oCcy.format(int.parse(
                                                userCurrency!
                                                    .assets![index].price!
                                                    .replaceAll(".", "")
                                                    .substring(0, 4)))),
                                        style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 10,
                                          color: Styles.textColor,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 25,
                                    ),
                                    SvgPicture.asset(
                                      currentPricesModelView.varlikArtisHesapla(
                                          userCurrency!.assetsTitle.toString(),
                                          userCurrency!
                                              .assets![index].assetType!,
                                          userCurrency!.assets![index].price!),
                                      color: (currentPricesModelView
                                                  .varlikArtisHesapla(
                                                      userCurrency!.assetsTitle
                                                          .toString(),
                                                      userCurrency!
                                                          .assets![index]
                                                          .assetType!,
                                                      userCurrency!
                                                          .assets![index]
                                                          .price!) ==
                                              AppConst.yukariPiyasaIcon
                                          ? Colors.green
                                          : Colors.red),
                                      width: 16,
                                    ),
                                  ],
                                ),
                              ),
                              (currentPricesModelView.allDeteleIcon.value == 1
                                  ? Expanded(
                                      flex: 0,
                                      child: GetBuilder<CurrentPricesModelView>(
                                          id: 'deleteAllIcon$index',
                                          builder: (context) {
                                            return GestureDetector(
                                              onTap: () {
                                                if (userCurrency!.assets![index]
                                                        .deleteIconActive ==
                                                    0) {
                                                  userCurrency!.assets![index]
                                                      .deleteIconActive = 1;
                                                } else {
                                                  userCurrency!.assets![index]
                                                      .deleteIconActive = 0;
                                                }
                                                currentPricesModelView.update(
                                                    ['deleteAllIcon$index']);
                                              },
                                              child: Container(
                                                margin:
                                                    EdgeInsets.only(right: 2),
                                                decoration: BoxDecoration(
                                                    color: (userCurrency!
                                                                .assets![index]
                                                                .deleteIconActive ==
                                                            1
                                                        ? Color(0xff454b61)
                                                        : Colors.transparent),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    border: Border.all(
                                                        width: 2,
                                                        color:
                                                            Color(0xff454b61))),
                                                width: 15,
                                                height: 15,
                                              ),
                                            );
                                          }),
                                    )
                                  : SizedBox())
                            ]
                          : [
                              /* Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                "Toplam",
                                textAlign: TextAlign.left,
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                  color: Styles.textColor,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "${getSumAssets(userCurrency!)} ${userCurrency!.currencyType!}",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500,
                                fontSize: 10,
                                color: Styles.textColor,
                              ),
                            ),
                          ),*/
                            ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  String getSumAssets(UserCurrency userCurrency) {
    final CurrentPricesModelView currentPricesModelView = Get.find();

    return currentPricesModelView.getTotalAssets(userCurrency);
  }
}
