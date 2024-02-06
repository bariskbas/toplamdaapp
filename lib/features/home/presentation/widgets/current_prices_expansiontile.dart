import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xapp/core/dtos/currencies.dart';
import 'package:xapp/core/styles.dart';
import 'package:xapp/features/home/presentation/model_view/current_prices_model_view.dart';

import '../../../../core/const.dart';

class CurrentPriceExpansionTile extends StatelessWidget {
  CurrentPriceExpansionTile({
    super.key,
    this.currentAssets,
    this.isVisibleSearch,
  });

  final CurrentAssets? currentAssets;
  final bool? isVisibleSearch;

  CurrentPricesModelView currentPricesModelView =
      Get.put(CurrentPricesModelView());
  @override
  Widget build(BuildContext context) {
    return ListTileTheme(
      dense: true,
      child: ExpansionTile(
          shape: Border.all(color: Colors.transparent),
          tilePadding: EdgeInsets.zero,
          title: Container(
            transform: Matrix4.translationValues(0, 0, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    currentAssets!.assetsTitle!,
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Styles.textColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          children: [
            isVisibleSearch!
                ? Container(
                    color: Colors.white.withOpacity(0.4),
                    child: Container(
                      height: 36,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                          border: Border.all(color: Styles.primaryColor),
                          borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                        initialValue: currentAssets!.searchTerm!,
                        onChanged: (value) {
                          currentPricesModelView.searchAssets(
                              currentAssets!, value);
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.search,
                            color: Styles.textColor,
                          ),
                          suffixIcon: currentAssets!.searchTerm != ""
                              ? GestureDetector(
                                  onTap: () {
                                    currentPricesModelView
                                        .clearSearch(currentAssets!);
                                  },
                                  child: Icon(
                                    Icons.close,
                                    color: Styles.textColor,
                                  ),
                                )
                              : Container(),
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  )
                : Container(),
            Column(
              children:
                  List.generate(currentAssets!.currencies!.length, (index) {
                final Currency currency = currentAssets!.currencies![index];
                return Container(
                  color: Colors.white.withOpacity(0.4),
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(width: 30),
                      Expanded(
                        flex: 2,
                        child: Text(
                          currency.name!,
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Styles.textColor,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          currency.sellingPrice!,
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w500,
                            fontSize: 11,
                            color: Styles.textColor,
                          ),
                        ),
                      ),
                       // Expanded(
                       //   child: SvgPicture.asset(
                       //     currency.direction == "caret-down"
                       //         ? AppConst.asagiPiyasaIcon
                       //         : currency.direction == "caret-up"
                       //             ? AppConst.yukariPiyasaIcon
                       //             : AppConst.minusIcon,
                       //     color: currency.direction == "caret-down"
                       //         ? Styles.warningRedColor
                       //         : currency.direction == "caret-up"
                       //             ? Styles.greenColor
                       //             : Styles.primaryColor,
                       //     width: 16,
                       //   ),
                       // )
                    ],
                  ),
                );
              } // : VarlikItem(
                      //     altin: altin,
                      //     index: index,
                      //   ),
                      ),
            )
          ]),
    );
  }
}
