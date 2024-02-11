import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: Get.width,
          color: Colors.white.withOpacity(0.4),
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
          child: Text(
            userCurrency!.assetsTitle!,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.bold,
              fontSize: 10,
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
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
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
                            flex: 2,
                            child: Text(
                              userCurrency!.assets![index].amount.toString(),
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: Styles.textColor,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              userCurrency!.assets![index].price!,
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500,
                                fontSize: 10,
                                color: Styles.textColor,
                              ),
                            ),
                          ),
                        ]
                      : [
                          Expanded(
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
                          ),
                        ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  String getSumAssets(UserCurrency userCurrency) {
    final CurrentPricesModelView currentPricesModelView = Get.find();

    return currentPricesModelView.getTotalAssets(userCurrency);
  }
}
