import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../app_theme.dart';

class ActionItem extends StatelessWidget {
  String? svgPicture;
  void Function()? onPressed;
  ActionItem({this.onPressed, this.svgPicture, super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed ?? () => Navigator.of(context).pop(),
      icon: Container(
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppTheme.line),
        ),
        child: svgPicture == null
            ? SvgPicture.asset(
                'assets/icons/arrow_back.svg',
                width: 24,
                height: 24,
                fit: .scaleDown,
              )
            : SvgPicture.asset(
                'assets/icons/$svgPicture.svg',
                width: 24,
                height: 24,
                fit: .scaleDown,
              ),
      ),
    );
  }
}
