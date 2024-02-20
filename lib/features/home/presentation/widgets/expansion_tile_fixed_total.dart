import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xapp/core/dtos/user_currency.dart';
import 'package:xapp/core/styles.dart';
import 'package:xapp/core/widgets/confirm_dialog.dart';
import 'package:xapp/features/home/presentation/model_view/current_prices_model_view.dart';

class ExpansionTileFixedTotal extends StatelessWidget {
  CurrentPricesModelView currentPricesModelView = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
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
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "TOPLAM",
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w900,
              fontSize: 11,
                color: Styles.textColor,
              ),
            ),
          ),
          Expanded(
            child: SizedBox(),
          ),
          Expanded(
            child: Text(
              currentPricesModelView.totalPriceStr.toString() + " ₺",
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w500,
                fontSize: 10,
                color: Styles.textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String getSumAssets(UserCurrency userCurrency) {
    final CurrentPricesModelView currentPricesModelView = Get.find();

    return currentPricesModelView.getTotalAssets(userCurrency);
  }
}
