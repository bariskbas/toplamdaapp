import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xapp/core/const.dart';
import 'package:flutter_svg/svg.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield(
      {super.key,
      this.labelText,
      this.onChanged,
      this.format,
      this.initialValue,
      this.labelStyle = 0});

  final String? labelText;
  final onChanged;
  final format;
  final String? initialValue;
  final int? labelStyle;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged!,
      style: (labelStyle == 0
          ? GoogleFonts.montserrat(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: 13,
            )
          : GoogleFonts.montserrat(
              fontWeight: FontWeight.w600,
              color: Color(0xff454b60),
              fontSize: 13,
            )),
      initialValue: initialValue,
      inputFormatters: format != null ? [format] : [],
      decoration: InputDecoration(
        labelText: labelText!,
        labelStyle: (labelStyle == 0
            ? TextStyle(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.w200)
            : TextStyle(
                color: Color(0xff454b60),
                fontSize: 14,
                fontWeight: FontWeight.w500)),
        enabledBorder:  UnderlineInputBorder(
          borderSide: BorderSide(color: (labelStyle == 0 ? Colors.white54 : Color(0xff454b60))),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}
