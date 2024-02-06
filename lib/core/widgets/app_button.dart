import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xapp/core/styles.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    this.buttonText,
    this.onTap,
  });

  final String? buttonText;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap!(),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 2,
          horizontal: 2,
        ),
        decoration: BoxDecoration(
          color: Color(0xFFFFAC75),
          boxShadow: const [
            BoxShadow(
              color: Color(
                0x695D3F2B,
              ),
              blurRadius: 10,
              spreadRadius: 0.0,
              offset: Offset(8, 10),
            )
          ],
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Colors.white,
              Color(0xFFFFAC75),
            ],
          ),
        ),
        child: FittedBox(
          child: Container(
            padding: const EdgeInsets.all(8),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xFFFFAC75),
                  Colors.white,
                ],
              ),
            ),
            child: Text(
              buttonText!,
              style: GoogleFonts.montserrat(
                fontSize: 16,
                color: Styles.textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
