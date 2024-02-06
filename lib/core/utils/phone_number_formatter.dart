import 'dart:math';

import 'package:flutter/services.dart';

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final String digitsOnly = newValue.text.replaceAll(RegExp(r'[^\d]'), '');
    String formattedText = '';

    if (digitsOnly.isNotEmpty) {
      formattedText += digitsOnly.substring(0, min(3, digitsOnly.length));
      if (digitsOnly.length > 3) {
        formattedText +=
            ' ${digitsOnly.substring(3, min(6, digitsOnly.length))}';
      }
      if (digitsOnly.length > 6) {
        formattedText +=
            ' ${digitsOnly.substring(6, min(8, digitsOnly.length))}';
      }
      if (digitsOnly.length > 8) {
        formattedText +=
            ' ${digitsOnly.substring(8, min(10, digitsOnly.length))}';
      }
      if (digitsOnly.length > 10) {
        formattedText +=
            ' ${digitsOnly.substring(10, min(12, digitsOnly.length))}';
      }
    }

    return newValue.copyWith(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
