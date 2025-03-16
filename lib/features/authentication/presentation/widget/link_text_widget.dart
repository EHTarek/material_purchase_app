import 'package:material_purchase_app/core/theme/style.dart';
import 'package:material_purchase_app/core/theme/theme.dart';
import 'package:flutter/material.dart';

class LinkText extends StatelessWidget {
  final VoidCallback? onTap;
  final String text;
  final String linkText;

  const LinkText({
    super.key,
    required this.text,
    required this.linkText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: TextButton(
        onPressed: onTap,
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: text,
            style: fontRegular.copyWith(
          color: context.color.text.secondary, fontSize: 12,
          ),
            children: [
              TextSpan(
                text: linkText,
                style: fontMedium.copyWith(
                  color: context.color.text.primary, fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
