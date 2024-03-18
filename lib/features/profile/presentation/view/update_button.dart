import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xapp/features/profile/presentation/model_view/profile_mode_view.dart';

class ProfileUpdateButton extends StatelessWidget {
    ProfileModelView profileModelView = Get.put(ProfileModelView());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        profileModelView.updateUserInFirebase();
      },
      child: Container(
        width: 125,
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              width: 2,
              color: Color(0xff454b60),
            )),
        child: Center(
          child: Text(
            'Güncelle',
            style: GoogleFonts.montserrat(
                color: Color(0xff454b60),
                fontSize: 14,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
