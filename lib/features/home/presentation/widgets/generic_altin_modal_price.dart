import 'package:flutter/material.dart';
import 'package:xapp/core/widgets/form_textfield_global.dart';

class GenericAltinModalPrice extends StatelessWidget {
  GenericAltinModalPrice({
    super.key,
    this.price,
    this.index,
  });
  final String? price;
  final int? index;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 25,
      alignment: Alignment.center,
      child: GlobalFormTextField(
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          border: InputBorder.none,
        ),
        initialValue: price,
        name: "bitcoinValueText$index",
        ColorType: 2,
        onChanged: (value) {},
        keyboardType: TextInputType.text,
      ),
    );
  }
}
