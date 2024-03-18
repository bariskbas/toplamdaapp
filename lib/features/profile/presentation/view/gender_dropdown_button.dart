import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xapp/core/const.dart';

class ProfileGenderDropdownButton extends StatelessWidget {
  const ProfileGenderDropdownButton({
    super.key,
    required this.selectedGender,
    this.onChanged,
  });

  final String selectedGender;
  final onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      borderRadius: BorderRadius.circular(15),
      icon: SvgPicture.asset(
        AppConst.dropdownIcon,
        color: Color(0xff454b60),
        width: 15,
      ),
      dropdownColor: Colors.white,
      decoration: InputDecoration(
        labelText: "*Cinsiyet",
        labelStyle: GoogleFonts.montserrat(
          fontWeight: FontWeight.w600,
          color: Color(0xff454b60),
          fontSize: 13,
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xff454b60)),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
      value: selectedGender,
      onChanged: onChanged!,
      items: [
        DropdownMenuItem(
          value: 'Erkek',
          child: Text(
            'Erkek',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600,
              color: Color(0xff454b60),
              fontSize: 12,
            ),
          ),
        ),
        DropdownMenuItem(
          value: 'Kadın',
          child: Text(
            'Kadın',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600,
              color: Color(0xff454b60),
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}
