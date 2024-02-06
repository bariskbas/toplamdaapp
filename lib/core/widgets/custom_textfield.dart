import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xapp/core/const.dart';
import 'package:flutter_svg/svg.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield(
      {super.key, this.labelText, this.onChanged, this.format});


  final String? labelText;
  final onChanged;
  final format;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged!,
      style: GoogleFonts.montserrat(
        fontWeight: FontWeight.w500,
        color: Colors.white,
        fontSize: 13,
      ),
      inputFormatters: format != null ? [format] : [],
      decoration: InputDecoration(
        labelText: labelText!,
        labelStyle: const TextStyle(
            color: Colors.white, fontSize: 14, fontWeight: FontWeight.w200),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white54),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}
