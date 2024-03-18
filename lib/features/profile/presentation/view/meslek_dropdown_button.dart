import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xapp/core/const.dart';

class ProfileMeslekDropdownButton extends StatelessWidget {
  const ProfileMeslekDropdownButton({
    super.key,
    required this.initialValue,
    this.onChanged,
  });

  final String initialValue;
  final onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: initialValue,
      menuMaxHeight: 200,
      borderRadius: BorderRadius.circular(15),
      icon: SvgPicture.asset(
        AppConst.dropdownIcon,
        color: Color(0xff454b60),
        width: 15,
      ),
      dropdownColor: Colors.white,
      decoration: InputDecoration(
        labelText: "Mesleğin*",
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
      onChanged: onChanged!,
      items: [
        DropdownMenuItem(
          value: 'Doktor',
          child: Text(
            'Doktor',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600,
              color: Color(0xff454b60),
              fontSize: 12,
            ),
          ),
        ),
        DropdownMenuItem(
          value: 'Mühendis',
          child: Text(
            'Mühendis',
            style: GoogleFonts.montserrat(
                color: Color(0xff454b60),
                fontSize: 12,
                fontWeight: FontWeight.w600),
          ),
        ),
        DropdownMenuItem(
          value: 'Avukat',
          child: Text(
            'Avukat',
            style: GoogleFonts.montserrat(
                color: Color(0xff454b60),
                fontSize: 14,
                fontWeight: FontWeight.w600),
          ),
        ),
        DropdownMenuItem(
          value: 'Satış elemanı',
          child: Text(
            'Satış elemanı',
            style: GoogleFonts.montserrat(
                color: Color(0xff454b60),
                fontSize: 14,
                fontWeight: FontWeight.w600),
          ),
        ),
        DropdownMenuItem(
          value: 'Özel Şirket',
          child: Text(
            'Özel Şirket',
            style: GoogleFonts.montserrat(
                color: Color(0xff454b60),
                fontSize: 14,
                fontWeight: FontWeight.w600),
          ),
        ),
        DropdownMenuItem(
          value: 'Memur',
          child: Text(
            'Memur',
            style: GoogleFonts.montserrat(
                color: Color(0xff454b60),
                fontSize: 14,
                fontWeight: FontWeight.w600),
          ),
        ),
        DropdownMenuItem(
          value: 'Yatırımcı',
          child: Text(
            'Yatırımcı',
            style: GoogleFonts.montserrat(
                color: Color(0xff454b60),
                fontSize: 14,
                fontWeight: FontWeight.w600),
          ),
        ),
        DropdownMenuItem(
          value: 'Hemşire',
          child: Text(
            'Hemşire',
            style: GoogleFonts.montserrat(
                color: Color(0xff454b60),
                fontSize: 14,
                fontWeight: FontWeight.w600),
          ),
        ),
        DropdownMenuItem(
          value: 'Pilot',
          child: Text(
            'Pilot',
            style: GoogleFonts.montserrat(
                color: Color(0xff454b60),
                fontSize: 14,
                fontWeight: FontWeight.w600),
          ),
        ),
        DropdownMenuItem(
          value: 'Öğretmen',
          child: Text(
            'Öğretmen',
            style: GoogleFonts.montserrat(
                color: Color(0xff454b60),
                fontSize: 14,
                fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
