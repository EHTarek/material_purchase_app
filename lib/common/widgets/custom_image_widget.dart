import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_purchase_app/core/theme/Images.dart';

class CustomImage extends StatelessWidget {
  final String image;
  final double? height;
  final double? width;
  final BoxFit fit;
  final bool isNotification;
  final String? placeholder;

  const CustomImage({
    super.key,
    required this.image,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
    this.isNotification = false,
    this.placeholder,
  });

  bool get isSvg => image.toLowerCase().endsWith('.svg');
  bool get isNetworkImage => image.startsWith('http');

  @override
  Widget build(BuildContext context) {
    final placeholderWidget = Image.asset(
      placeholder ?? Images.placeholder,
      height: height,
      width: width,
      fit: fit,
    );

    // SVG handling
    if (isSvg) {
      final svgFit = fit == BoxFit.cover ? BoxFit.contain : fit;

      return isNetworkImage ? SvgPicture.network(
        image,
        height: height,
        width: width,
        fit: svgFit,
        placeholderBuilder: (_) => placeholderWidget,
      ) : SvgPicture.asset(
        image,
        height: height,
        width: width,
        fit: svgFit,
      );
    }

    // Network image handling
    if (isNetworkImage) {
      return CachedNetworkImage(
        imageUrl: image,
        height: height,
        width: width,
        fit: fit,
        placeholder: (_, __) => placeholderWidget,
        errorWidget: (_, __, ___) => placeholderWidget,
      );
    }

    // Local asset image handling
    return Image.asset(
      image,
      height: height,
      width: width,
      fit: fit,
      errorBuilder: (_, __, ___) => placeholderWidget,
    );
  }
}