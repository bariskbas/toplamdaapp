import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xapp/core/const.dart';

class GenderDropdownButton extends StatelessWidget {
  const GenderDropdownButton({
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
        color: Colors.white,
        width: 16,
      ),
      dropdownColor: const Color(0xFFFFAC75),

      decoration: InputDecoration(
        labelText: "Cinsiyet*",
        labelStyle: GoogleFonts.montserrat(
          fontWeight: FontWeight.w200,
          color: Colors.white,
          fontSize: 12,
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
      onChanged: onChanged!,
      items: [
        DropdownMenuItem(
          value: 'Erkek',
          child: Text(
            'Erkek',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ),
        DropdownMenuItem(
          value: 'Kadın',
          child: Text(
            'Kadın',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}
