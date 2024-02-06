import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xapp/core/const.dart';
import 'package:xapp/features/auth/presentation/model_view/register_model_view.dart';

class DogumyeriDropdownButton extends StatelessWidget {
  DogumyeriDropdownButton({
    super.key,
    required this.selectedGender,
    this.onChanged,
  });

  final RegisterModelView _registerModelView = Get.put(RegisterModelView());

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
          width: 16,
        ),
        dropdownColor: const Color(0xFFFFAC75),
        decoration: InputDecoration(
          labelText: "Doğum Yerin*",
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
        items: (_registerModelView.iller != []
            ? _registerModelView.iller
                .map((value) => DropdownMenuItem(
                      value: value,
                      child: Text(
                        value.toString(),
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          fontSize: 11,
                        ),
                      ),
                    ))
                .toList()
            : []));
  }
}
