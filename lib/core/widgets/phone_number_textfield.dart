import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xapp/core/utils/phone_number_formatter.dart';

class PhonenNumberTextfield extends StatelessWidget {
  const PhonenNumberTextfield({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: GoogleFonts.montserrat(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 20,
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
            color: Colors.white, fontSize: 12, fontWeight: FontWeight.w100),
        prefixText: "+90",
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white54),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        prefixStyle: GoogleFonts.montserrat(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    );
  }
}
