import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xapp/core/styles.dart';
import 'package:xapp/features/home/presentation/model_view/current_prices_model_view.dart';
import 'package:xapp/features/home/presentation/widgets/current_prices_expansiontile.dart';

class GuncelFiyatlar extends StatelessWidget {
  GuncelFiyatlar({
    super.key,
  });

  final varlikList = [
    'ALTIN',
    'TÜRK LİRASI',
    'DÖVİZ',
    'HİSSE SENETLERİ',
    'KRİPTO PARA',
    'EMTİALAR',
    'METALLER',
  ];
  CurrentPricesModelView currentPricesModelView =
      Get.put(CurrentPricesModelView());

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      width: Get.width,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        gradient: Styles.boxLinear,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            "Güncel Fiyatlar",
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: Styles.textColor,
            ),
          ),
          Obx(
            () => SizedBox(
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(
                    currentPricesModelView.filterCurrentAsets.value.length,
                    (index) => CurrentPriceExpansionTile(
                        isVisibleSearch: true,
                        currentAssets:
                            currentPricesModelView.filterCurrentAsets[index]),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}
