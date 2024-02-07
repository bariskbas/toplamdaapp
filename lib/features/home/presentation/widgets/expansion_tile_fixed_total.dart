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
    return ListTileTheme(
      dense: true,
      child: ExpansionTile(
        initiallyExpanded: true,
        shape: Border.all(color: Colors.transparent),
        tilePadding: EdgeInsets.zero,
        title: Container(
          width: Get.width,
          color: Colors.white.withOpacity(0.4),
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Toplam",
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                  color: Styles.textColor,
                ),
              ),
              Text(
                  currentPricesModelView.totalPriceStr.toString() + " ₺",
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w500,
                    fontSize: 10,
                    color: Styles.textColor,
                  ),
                ),
            ],
          ),
        ),
        trailing: const SizedBox(),
        children: [
        
        ],
      ),
    );
  }

  String getSumAssets(UserCurrency userCurrency) {
    final CurrentPricesModelView currentPricesModelView = Get.find();

    return currentPricesModelView.getTotalAssets(userCurrency);
  }
}
