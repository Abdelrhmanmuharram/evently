import 'package:evently/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DefaultTextFormField extends StatefulWidget {
  final String? hintText;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final void Function(String)? onChange;
  final String? prefixIconImageName;
  final String? suffixIconImageName;
  final bool isPassword;
  final int maxLine;

  const DefaultTextFormField({
    super.key,
    required this.hintText,
    this.validator,
    this.controller,
    this.onChange,
    this.prefixIconImageName,
    this.suffixIconImageName,
    this.isPassword = false,
    this.maxLine = 1,
  });

  @override
  State<DefaultTextFormField> createState() => _DefaultTextFormFieldState();
}

class _DefaultTextFormFieldState extends State<DefaultTextFormField> {
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: widget.prefixIconImageName == null
            ? null
            : SvgPicture.asset(
                'assets/icons/${widget.prefixIconImageName}.svg',
                width: 24,
                height: 24,
                fit: .scaleDown,
              ),
        suffixIcon: widget.isPassword
            ? InkWell(
                onTap: () {
                  isObscure = !isObscure;
                  setState(() {});
                },
                child: isObscure
                    ? Icon(Icons.visibility_outlined, color: AppTheme.grey)
                    : Icon(Icons.visibility_off_outlined, color: AppTheme.grey),
              )
            : widget.suffixIconImageName == null
            ? null
            : SvgPicture.asset(
                'assets/icons/${widget.suffixIconImageName}.svg',
                width: 24,
                height: 24,
                fit: .scaleDown,
              ),
      ),
      onChanged: widget.onChange,
      validator: widget.validator,
      controller: widget.controller,
      obscureText: widget.isPassword && isObscure,
      autovalidateMode: .onUserInteraction,
      cursorColor: Theme.of(context).primaryColor,
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
      maxLines: widget.maxLine,
    );
  }
}
