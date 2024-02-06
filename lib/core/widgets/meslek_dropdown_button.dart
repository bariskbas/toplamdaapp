import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xapp/core/const.dart';

class MeslekDropdownButton extends StatelessWidget {
  const MeslekDropdownButton({
    super.key,
    required this.selectedGender,
    this.onChanged,
  });

  final String selectedGender;
  final onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      menuMaxHeight: 200,
      borderRadius: BorderRadius.circular(15),
      icon: SvgPicture.asset(
        AppConst.dropdownIcon,
        color: Colors.white,
        width: 15,
      ),
      dropdownColor: const Color(0xFFFFAC75),

      decoration: InputDecoration(
        labelText: "Mesleğin*",
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
          value: 'Doktor',
          child: Text(
            'Doktor',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: 10,
            ),
          ),
        ),
        DropdownMenuItem(
          value: 'Mühendis',
          child: Text(
            'Mühendis',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: 10,
            ),
          ),
        ),
        DropdownMenuItem(
          value: 'Avukat',
          child: Text(
            'Avukat',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: 10,
            ),
          ),
        ),
        DropdownMenuItem(
          value: 'Satış elemanı',
          child: Text(
            'Satış elemanı',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: 10,
            ),
          ),
        ),
        DropdownMenuItem(
          value: 'Özel Şirket',
          child: Text(
            'Özel Şirket',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: 10,
            ),
          ),
        ),
        DropdownMenuItem(
          value: 'Memur',
          child: Text(
            'Memur',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: 10,
            ),
          ),
        ),
        DropdownMenuItem(
          value: 'Yatırımcı',
          child: Text(
            'Yatırımcı',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: 10,
            ),
          ),
        ),
        DropdownMenuItem(
          value: 'Hemşire',
          child: Text(
            'Hemşire',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: 10,
            ),
          ),
        ),
        DropdownMenuItem(
          value: 'Pilot',
          child: Text(
            'Pilot',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: 10,
            ),
          ),
        ),
        DropdownMenuItem(
          value: 'Öğretmen',
          child: Text(
            'Öğretmen',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: 10,
            ),
          ),
        ),
        DropdownMenuItem(
          value: 'Noter',
          child: Text(
            'Noter',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: 10,
            ),
          ),
        ),
        DropdownMenuItem(
          value: 'Diş Hekim',
          child: Text(
            'Diş Hekim',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: 10,
            ),
          ),
        ),
        DropdownMenuItem(
          value: 'Dijital Pazarlama',
          child: Text(
            'Dijital Pazarlama',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: 10,
            ),
          ),
        ),
        DropdownMenuItem(
          value: 'Polis',
          child: Text(
            'Polis',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: 10,
            ),
          ),
        ),
        DropdownMenuItem(
          value: 'Asker',
          child: Text(
            'Asker',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: 10,
            ),
          ),
        ),
        DropdownMenuItem(
          value: 'Psikolog',
          child: Text(
            'Psikolog',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: 10,
            ),
          ),
        ),
        DropdownMenuItem(
          value: 'Eczacı',
          child: Text(
            'Eczacı',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: 10,
            ),
          ),
        ),
        DropdownMenuItem(
          value: 'Savcı',
          child: Text(
            'Savcı',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: 10,
            ),
          ),
        ),
        DropdownMenuItem(
          value: 'Aktüer',
          child: Text(
            'Aktüer',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: 10,
            ),
          ),
        ),
        DropdownMenuItem(
          value: 'Mimar',
          child: Text(
            'Mimar',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: 10,
            ),
          ),
        ),
      ],
    );
  }
}
