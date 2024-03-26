// ignore_for_file: must_be_immutable, use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class GlobalFormTextField extends StatelessWidget {
  String? name;
  String? initialValue;
  bool enableInteractiveSelection;
  InputDecoration decoration;
  void Function(String?)? onChanged;
  String? Function(String?)? validator;
  void Function()? onTap;
  void Function(String?)? onSubmitted;
  dynamic Function(String?)? valueTransformer;
  bool expands;
  bool enabled;
  TextAlign? textAlign;
  bool readOnly;
  int ColorType;
  bool obscureText;
  TextInputType? keyboardType;
  List<TextInputFormatter>? inputFormatters;
  GlobalFormTextField({
    this.name,
    this.textAlign = TextAlign.start,
    this.initialValue,
    this.enableInteractiveSelection = true,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.decoration = const InputDecoration(),
    this.onTap,
    this.valueTransformer,
    this.expands = false,
    this.enabled = true,
    this.readOnly = false,
    this.ColorType = 1,
    this.obscureText = false,
    this.keyboardType,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      maxLines: expands ? null : 1,
      minLines: expands ? null : 1,
      expands: expands,
      style: TextStyle(
          color: Colors.black, fontWeight: FontWeight.w400, fontSize: 16),
      name: name!,
      enabled: enabled,
      readOnly: readOnly,
      obscureText: obscureText,
      textAlign: textAlign!,
      initialValue: initialValue,
      onChanged: onChanged,
      validator: validator,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      decoration: decoration.copyWith(
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      onTap: onTap,
      onSubmitted: onSubmitted,
      valueTransformer: valueTransformer,
    );
  }
}
