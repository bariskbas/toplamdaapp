import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xapp/core/utils/phone_number_formatter.dart';

class ProfilePhonenNumberTextfield extends StatelessWidget {
  final String? phone;
  final onChanged;

  const ProfilePhonenNumberTextfield({
    super.key,
    this.phone,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged!,
      initialValue: phone,
      style: GoogleFonts.montserrat(
        fontWeight: FontWeight.w600,
        color: Color(0xff454b60),
        fontSize: 13,
      ),
      keyboardType: TextInputType.phone,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(10),
        PhoneNumberFormatter(),
      ],
      decoration: InputDecoration(
        labelText: "Telefon Numarası",
        labelStyle: const TextStyle(
            color: Color(0xff454b60),
            fontSize: 14,
            fontWeight: FontWeight.w500),
        prefixText: "+90 ",
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xff454b60)),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        prefixStyle: GoogleFonts.montserrat(
          fontWeight: FontWeight.bold,
          color: Color(0xff454b60),
          fontSize: 13,
        ),
      ),
    );
  }
}
