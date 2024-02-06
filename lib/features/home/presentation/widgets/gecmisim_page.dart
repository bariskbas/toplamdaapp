import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xapp/core/styles.dart';
import 'package:flutter_svg/svg.dart';
import 'package:xapp/core/const.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(
          gradient: Styles.appLinear,
        ),
        child: Column(
          children: [
            AppBar(
              leading: IconButton(
                icon: SvgPicture.asset(AppConst.backsolIcon, color: Colors.white, width: 35),
                onPressed: () => Navigator.of(context).pop(),
              ),
              elevation: 0,
              centerTitle: true,
              backgroundColor: Colors.transparent,
              title: Text(
                "Geçmişim",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
