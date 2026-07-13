import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DefaultTextFormField extends StatelessWidget {
  String? hintText;
  String? Function(String?)? validator;
  TextEditingController? controller;
  void Function(String)? onChange;
  String? prefixIconImageName;
  String? suffixIconImageName;

  DefaultTextFormField({
    super.key,
    required this.hintText,
    this.validator,
    this.controller,
    this.onChange,
    this.prefixIconImageName,
    this.suffixIconImageName,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIconImageName == null
            ? null
            : SvgPicture.asset(
                'assets/icons/$prefixIconImageName.svg',
                width: 24,
                height: 24,
                fit: .scaleDown,
              ),
        suffixIcon: suffixIconImageName == null
            ? null
            : SvgPicture.asset(
                'assets/icons/$suffixIconImageName.svg',
                width: 24,
                height: 24,
                fit: .scaleDown,
              ),
      ),
      onChanged: onChange,
      validator: validator,
      controller: controller,
    );
  }
}
