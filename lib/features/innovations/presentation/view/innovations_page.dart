import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xapp/core/dtos/user_dto.dart';
import 'package:xapp/core/services/auth_services.dart';
import 'package:xapp/core/styles.dart';
import 'package:xapp/core/utils/date_formatter.dart';
import 'package:xapp/core/widgets/app_button.dart';
import 'package:xapp/core/widgets/custom_textfield.dart';
import 'package:xapp/core/widgets/phone_number_textfield.dart';
import 'package:xapp/features/auth/presentation/view/welcome_page.dart';
import 'package:xapp/features/innovations/presentation/model_view/innovations_view.dart';
import 'package:xapp/features/profile/presentation/model_view/profile_mode_view.dart';
import 'package:xapp/core/const.dart';
import 'package:flutter_svg/svg.dart';
import 'package:xapp/features/profile/presentation/view/gender_dropdown_button.dart';
import 'package:xapp/features/profile/presentation/view/meslek_dropdown_button.dart';
import 'package:xapp/features/profile/presentation/view/profile_phone_number_textfield.dart';
import 'package:xapp/features/profile/presentation/view/update_button.dart';

class InnovationsPage extends StatefulWidget {
  const InnovationsPage({super.key});

  @override
  State<InnovationsPage> createState() => _InnovationsPageState();
}

class _InnovationsPageState extends State<InnovationsPage> {
  
  InnovationsModelView profileModelView = Get.put(InnovationsModelView());

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
                "İstatistiklerim",
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
