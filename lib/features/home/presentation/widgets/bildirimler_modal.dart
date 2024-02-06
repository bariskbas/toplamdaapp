import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xapp/core/const.dart';
import 'package:xapp/core/styles.dart';

class BildirimlerModal extends StatelessWidget {
  const BildirimlerModal({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      backgroundColor: Colors.transparent,
      child: Container(
        height: Get.height * 0.5,
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
                  "Bildirimler",
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
                child: ListView.builder(
              shrinkWrap: true,
              itemCount: 0,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        "20.06.2023 Salı / 00.28",
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500,
                          fontSize: 10,
                          color: Styles.textColor,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.only(top: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Babalar Gününüz Kutlu Olsun",
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w700,
                              fontSize: 10,
                              color: Styles.textColor,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 6),
                            decoration: BoxDecoration(
                              color: const Color(0xffEDEDED),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              "Görüntüle",
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                                fontSize: 10,
                                color: Styles.textColor,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
