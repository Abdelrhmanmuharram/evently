import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DefaultTextFormField extends StatelessWidget {
  final String? hintText;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final void Function(String)? onChange;
  final String? prefixIconImageName;
  final String? suffixIconImageName;

  const DefaultTextFormField({
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
