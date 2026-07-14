import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../app_theme.dart';

class DefaultElevatedButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final String? icon;

  const DefaultElevatedButton({
    required this.onPressed,
    required this.label,
    this.foregroundColor,
    this.backgroundColor,
    this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? primaryColor,
        foregroundColor: foregroundColor ?? AppTheme.white,
        fixedSize: Size(MediaQuery.sizeOf(context).width, 48),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon == null
              ? SizedBox()
              : SvgPicture.asset(
                  'assets/icons/$icon.svg',
                  width: 24,
                  height: 24,
                  fit: .scaleDown,
                ),
          const SizedBox(width: 8),
          Text(label),
        ],
      ),
    );
  }
}
