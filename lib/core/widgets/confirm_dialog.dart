import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xapp/core/const.dart';
import 'package:xapp/core/styles.dart';

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({
    super.key,
    required this.onTap,
    required this.confirmLabel,
    required this.description,
  });

  final Function? onTap;
  final String? confirmLabel;
  final String? description;

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
              AppConst.alertIcon,
              color: Colors.orangeAccent,
              width: 45,
            ),
            Text(
              "Uyarı",
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w700,
                fontSize: 11,
                color: Styles.textColor,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              description!,
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w600,
                fontSize: 11,
                color: Styles.textColor,
              ),
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xffffffff),
                        borderRadius: BorderRadius.circular(7),
                          border: Border.all(color: const Color(0xff454B60),width: 2),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "Vazgeç",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: const Color(0xff454B60),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: GestureDetector(
                    onTap: () => onTap!(),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xff454B60),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        confirmLabel!,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
