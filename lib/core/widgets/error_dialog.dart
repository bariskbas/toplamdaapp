import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xapp/core/const.dart';
import 'package:xapp/core/styles.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      backgroundColor: Colors.transparent,
      child: Container(
        height: Get.width * 0.5,
        width: Get.width * 0.3,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SvgPicture.asset(
              AppConst.hataIcon,
              color: Styles.warningRedColor,
              width: 50,
            ),
            Text(
              "Hata",
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: Styles.textColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Girdiğin bilgi hatalı.\nTekrar dene.",
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: Styles.textColor,
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                width: Get.width * 0.8,
                decoration: BoxDecoration(
                  color: const Color(0xff454B60),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "Tamam",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
